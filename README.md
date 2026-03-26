# Motion Planner

A MATLAB/Simulink library for motion planning of fully actuated surface vehicles.
This library uses [MPSV](https://github.com/RobertDamerius/MPSV) for the actual motion planning algorithms.


## Prerequisites
> **MATLAB Version**\
> at least R2025b

> **Generic Target**\
> The [Generic Target](https://github.com/RobertDamerius/GenericTarget) toolbox has to be installed for MATLAB. The version must be at least 1.1.0.


## Setup
To use the toolbox, add the `MotionPlanner.prj` project file as reference project to your own simulink project.
This will add the `library` and `packages` directories to your project path automatically.

When using the project for the first time, make sure that all driver blocks are build and the corresponding MEX files are generated.
Open the project and run the following command:
```
motionplanner.BuildDrivers()
```


## Examples
Simulink examples are located in the [examples](examples) directory.

| Example                   | Description                                                |
| :------------------------ | :--------------------------------------------------------- |
| AsynchronousMotionPlanner | Demonstrates the usage of the asynchronous motion planner. |
| CostFunctionTuning        | Use the path planner to tune cost function parameters.     |
