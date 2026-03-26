% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% DESCRIPTION
% This script generates data for the MotionPlanner simulink library.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all;


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% INPUT STRUCTURE
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
structMotionPlannerIn = struct();
structMotionPlannerIn.enablePlanner                                         = false;
structMotionPlannerIn.maxDeviationToReset.position                          = 0.0;
structMotionPlannerIn.maxDeviationToReset.heading                           = 0.0;
structMotionPlannerIn.navigation.positionLLA                                = zeros(3,1);
structMotionPlannerIn.navigation.orientationYaw                             = 0.0;
structMotionPlannerIn.navigation.velocityUVR                                = zeros(3,1);
structMotionPlannerIn.navigation.actualForceXYN                             = zeros(3,1);
structMotionPlannerIn.goal.positionLatitude                                 = 0.0;
structMotionPlannerIn.goal.positionLongitude                                = 0.0;
structMotionPlannerIn.goal.orientationYaw                                   = 0.0;
structMotionPlannerIn.map.vertices                                          = zeros(2,8000,'single');
structMotionPlannerIn.map.originLLA                                         = zeros(3,1);
structMotionPlannerIn.parameter.searchRadius                                = 0.0;
structMotionPlannerIn.parameter.controlEffort                               = 0.0;
structMotionPlannerIn.parameter.geometry.verticesVehicleShape               = zeros(2,100,'single');
structMotionPlannerIn.parameter.geometry.collisionCheckMaxPositionDeviation = 0.0;
structMotionPlannerIn.parameter.geometry.collisionCheckMaxAngleDeviation    = 0.0;
structMotionPlannerIn.parameter.model.matF                                  = zeros(3,12);
structMotionPlannerIn.parameter.model.matB                                  = zeros(3);
structMotionPlannerIn.parameter.model.vecTimeconstantsXYN                   = zeros(3,1);
structMotionPlannerIn.parameter.model.vecTimeconstantsInput                 = zeros(3,1);
structMotionPlannerIn.parameter.model.vecSatXYN                             = zeros(3,1);
structMotionPlannerIn.parameter.timing.trajectorySampletime                 = 0.0;
structMotionPlannerIn.parameter.timing.maxComputationTimePath               = 0.0;
structMotionPlannerIn.parameter.timing.maxComputationTimeMotion             = 0.0;
structMotionPlannerIn.parameter.metric.weightPsi                            = 0.0;
structMotionPlannerIn.parameter.metric.weightSway                           = 0.0;
structMotionPlannerIn.parameter.metric.weightReverseScale                   = 0.0;
structMotionPlannerIn.parameter.metric.weightReverseDecay                   = 0.0;
structMotionPlannerIn.parameter.metric.distanceScale                        = 0.0;
structMotionPlannerIn.parameter.metric.distanceDecay                        = 0.0;


% create simulink bus object
[~] = ave.Struct2Bus(structMotionPlannerIn, 'busMotionPlannerIn');


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% OUTPUT STRUCTURE
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
structMotionPlannerOut = struct();
structMotionPlannerOut.time.timestampUTC                               = 0.0;
structMotionPlannerOut.time.steadyClock                                = 0.0;
structMotionPlannerOut.errorCode                                       = uint8(0);
structMotionPlannerOut.performedReset                                  = false;
structMotionPlannerOut.controlCommand.commandedState.positionLatitude  = 0.0;
structMotionPlannerOut.controlCommand.commandedState.positionLongitude = 0.0;
structMotionPlannerOut.controlCommand.commandedState.orientationYaw    = 0.0;
structMotionPlannerOut.controlCommand.commandedState.velocityU         = 0.0;
structMotionPlannerOut.controlCommand.commandedState.velocityV         = 0.0;
structMotionPlannerOut.controlCommand.commandedState.velocityR         = 0.0;
structMotionPlannerOut.controlCommand.commandedState.tauX              = 0.0;
structMotionPlannerOut.controlCommand.commandedState.tauY              = 0.0;
structMotionPlannerOut.controlCommand.commandedState.tauN              = 0.0;
structMotionPlannerOut.controlCommand.commandedInput.tauX              = 0.0;
structMotionPlannerOut.controlCommand.commandedInput.tauY              = 0.0;
structMotionPlannerOut.controlCommand.commandedInput.tauN              = 0.0;
structMotionPlannerOut.controlCommand.remainingTrajectoryDuration      = 0.0;
structMotionPlannerOut.trajectory.timestampSteadyClock                 = 0.0;
structMotionPlannerOut.trajectory.sampletime                           = 0.0;
structMotionPlannerOut.trajectory.states                               = zeros(12,500); % column format: [lat,lon,psi,u,v,r,X,Y,N,Xc,Yc,Nc]
structMotionPlannerOut.path.poses                                      = zeros(3,100); % column format: [lat,lon,psi]


% create simulink bus object
[~] = ave.Struct2Bus(structMotionPlannerOut, 'busMotionPlannerOut');


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% WRITE ALL BASE WORKSPACE VARIABLES TO DATA DICTIONARY
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
varNames = who();
thisDirectory = extractBefore(mfilename('fullpath'),strlength(mfilename('fullpath')) - strlength(mfilename) + 1);
filenameDataDictionary = fullfile(thisDirectory, 'MotionPlanner_ExternalData.sldd');
ave.CreateDataDictionaryFromBaseWorkspaceVariables(filenameDataDictionary, varNames);

% refresh library
filenameLibrary = fullfile(thisDirectory, 'MotionPlanner_Library.slx');
Simulink.LibraryDictionary.refresh(filenameLibrary);

