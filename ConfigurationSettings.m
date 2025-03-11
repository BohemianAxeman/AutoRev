classdef ConfigurationSettings < handle
    properties
        Mnvr_Type mnvrTypeEnum
        prop_settings
        constraints
        sats satObj_chs_trg
    end


    methods
        function obj = ConfigurationSettings()
            % Constructor ensures obj is non-empty
            obj.sats = satObj_chs_trg();
        end

        function loadTestStates(obj, testState)
            arguments
                obj
                testState testStateEnum
            end

            switch testState
                case testStateEnum.LEO2GEO
                    obj.sats.chs.r_ECI_km = [7000, 0, 0];
                    obj.sats.chs.v_ECI_kmps = [0, sqrt(CONST.mu_earth_km/norm(obj.sats.chs.r_ECI_km)), 0];
                    obj.sats.chs.kep_elements = KeplerianElements(7000, 0, 0, 0, 0, 0);
                    obj.sats.trg.r_ECI_km = [-42164, 0, 0];
                    obj.sats.trg.v_ECI_kmps = [0, -sqrt(CONST.mu_earth_km/norm(obj.sats.trg.r_ECI_km)), 0];
                    obj.prop_settings.mu = CONST.mu_earth_km;
                    obj.sats.trg.kep_elements = KeplerianElements(42164, 0, 0, 0, 0, pi);
                otherwise
            end
        end

        

    end

end