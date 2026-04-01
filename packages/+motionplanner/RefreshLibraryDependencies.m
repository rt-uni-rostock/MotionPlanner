function RefreshLibraryDependencies()
    % Refresh the simulink library dictionary dependencies.
    libname = 'MotionPlanner_Library';

    % check all project files, find that file with the libname and refresh
    files = currentProject().Files;
    for i = 1:numel(files)
        [p,n,e] = fileparts(files(i).Path);
        if(strcmp(n,libname) && strcmp(e,'.slx'))
            filenameLibrary = fullfile(p,strcat(n,e));
            Simulink.LibraryDictionary.refresh(filenameLibrary);
            break;
        end
    end
end
