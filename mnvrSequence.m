classdef mnvrSequence
    properties
        objName string = "sat"
        dv (1,1) double % total delta-v of the burn [km/s]
        burnType % impulsive or continuous
        thrustDirection % [1,0,0] for along the current velocity direction
        thrustDuration (1,1) double % how long in seconds the thrusters are firing (0 for impulsive mnvrs)
        coastDuration (1,1) double % coast/drift for this many seconds, then execute the burn
    end

    methods
        function obj = mnvrSequence(objName, dv, burnType, thrustDirection, thrustDuration, coastDuration)
            % Constructor function
            obj.objName = objName;
            obj.dv = dv;
            obj.burnType = burnType;
            obj.thrustDirection = thrustDirection;
            obj.thrustDuration = thrustDuration;
            obj.coastDuration = coastDuration;
        end
    end
end