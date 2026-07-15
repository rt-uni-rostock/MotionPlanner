function projectIsOK = CheckProject()
    %CheckProject Check all project requirements
    % 
    % RETURN
    % projectIsOK ... True if project status is OK, false otherwise.
    projectIsOK = CheckGTVersion(1,1,0) && CompiledSFunctionsExistInProject("MPSV");
end

function success = CheckGTVersion(minMajor, minMinor, minPatch)
    success = true;
    v = uint32.empty();
    try v = GT.GetVersion(); catch, end
    try name = currentProject; name = name.Name; catch, name = ''; end
    if(isempty(v) || (3 ~= numel(v)))
        beep();
        warning(strcat('The Generic Target toolbox is not installed or it is a pre-release version! Project "',name,'" requires the Generic Target version to be "',num2str(minMajor),'.',num2str(minMinor),'.',num2str(minPatch),'".'),'Unsupported Generic Target version');
        success = false;
    else
        if(~issorted([[minMajor, minMinor, minPatch]; reshape(v, [1,3])], 'rows'))
            beep();
            warning(strcat('Project "',name,'" requires the Generic Target version to be at least "',num2str(minMajor),'.',num2str(minMinor),'.',num2str(minPatch),'" but the version found is "',num2str(v(1)),'.',num2str(v(2)),'.',num2str(v(3)),'"!'),'Unsupported Generic Target version');
            success = false;
        end
    end
end

function success = CompiledSFunctionsExistInProject(projectName)
    filePattern = '*.mex';
    if(ispc)
        filePattern = '*.mexw64';
    elseif(isunix)
        filePattern = '*.mexa64';
    end

    success = false;
    refs = currentProject().ProjectReferences;
    for i = 1:numel(refs)
        if(strcmp(refs(i).Project.Name, projectName))
            projectPath = refs(i).Project.ProjectPath;
            for p = 1:numel(projectPath)
                if(~isempty(dir(fullfile(projectPath(p).File, filePattern))))
                    success = true;
                    break;
                end
            end
            break;
        end
    end

    if(~success)
        beep();
        warning(strcat('Reference project "', char(projectName), '" is missing MEX files or they are not compatible with your operating system! Run ''motionplanner.BuildDrivers()'' to build all driver blocks and to generate the corresponding MEX files.'), 'Incompatible or missing MEX files');
    end
end
