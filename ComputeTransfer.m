%%

%%
function [burnSequence, results] = ComputeTransfer(configs)

arguments
    configs ConfigurationSettings % restricts input to type ConfigurationSettings
end

    chs = configs.sats.chs;
    trg = configs.sats.trg;
    
    switch configs.Mnvr_Type
        case mnvrTypeEnum.Hohmann
            [burnSequence, results] = tx_Hohmann(chs.r_ECI_km, chs.v_ECI_kmps, trg.r_ECI_km, trg.v_ECI_kmps);
            VisualizeHohmannMnvr(burnSequence, results, configs)
        case mnvrTypeEnum.Inc
            results = tx_Inc();
        case mnvrTypeEnum.Lambert
            results = tx_Lambert();
        otherwise
    end

    disp(results)
    disp(burnSequence)

end