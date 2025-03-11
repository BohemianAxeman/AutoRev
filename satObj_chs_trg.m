classdef satObj_chs_trg
    properties
        chs satObj
        trg satObj
    end

    methods
        function obj = satObj_chs_trg()
            obj.chs = satObj();
            obj.trg = satObj();
        end
    end
end