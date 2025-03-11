% The main autonomous rendezvous algorithm
function auto_rev(configs)

arguments
    configs ConfigurationSettings % restricts input to type ConfigurationSettings
end

%% Visualize Initial States
VisualizeInitialStates(configs)

%% Run GenerateWapoints()
% Using the initial states and mnvr constraints, pick what desired state(s) we want to target
%GenerateWaypoints(configs)

%% Run ComputeTransfer()
% Based on where we want to go, compute the actual delta-v needed 
burnSequence = ComputeTransfer(configs);

%% Simulate Sequence
% Simulate the motion and maneuvering of the satellites 
%SimulateSequence(configs, burnSequence)

end