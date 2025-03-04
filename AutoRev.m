% Function AutoRev provides a set of optimized maneuvers to move a _chaser satellite to a _target
% satellite.
%
% AutoRev has two main use cases: 1) Move from far away to nearby, 2) Stay nearby the chaser
% for some time.
%
% Inputs:
% _chaser: contains initial state and parameters of the chaser satellite
% _target: contains initial state and parameters of the target satellite
% TODO: Make _chaser and _target objects of the same class, ex. sat_obj

% _configs: contains simulation and algorithm configurations for how AutoRev should run
% (TODO:also a class)

% Functions:
% ComputeTransfer(): computes different types of orbital maneuvers (Hohmann, in-plane,
% out-of-plane, Lambert for general case)
%
% PropagateState(): Propagates the state (pos/vel) of a satellite using either TwoBody (Kepler)
% or prop_perts (other perturbating forces)
%
% GenerateWaypoints(): Generate one or more waypoints to use in ComputeTransfer(), based on the
% current and predicted future states of the satellties

% ComputeCost(): Cost function that applies weights to maneuver options so only the most
% favorable are selected and returned to the Main Flight Software (FSW)

% Design Goals:
% [1] Achieve intercept (flyby) in minimum time (just get there ASAP)
% [2] Achieve intercept (RPO) in minimum time (match its orbit ASAP)
% [2.01] Phase ahead/behind in the same orbit
% [2.02] Hover nearby in a relative halo/corkscrew orbit
% [3] Achieve -1- and -2- with minimum fuel
% [4] Achieve all goals in variable total # of mnvrs (start with 1, 2, and 3)
% [5] Combine -1->4- to create a grid of maneuver options and results to further analyze
% [6] Add a cost function to map over the grid pts and downselect favorable options

%% Setup Configs and Initial Conditions
run_configs = ConfigurationSettings;
run_configs.Mnvr_Type = 'Hohmann';

%% run auto_rev()
auto_rev(run_configs)
