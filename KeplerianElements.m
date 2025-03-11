classdef KeplerianElements
    properties
        SMA double = 7000;
        ECC double = 0;
        INC double = 0;
        RAAN double = 0;
        AOP double = 0;
        TA double = 0;
    end

    methods
        function obj = KeplerianElements(a, e, i, omega, w, theta)
            obj.SMA = a;
            obj.ECC = e;
            obj.INC = i;
            obj.RAAN = omega;
            obj.AOP = w;
            obj.TA = theta;
        end
    end

end