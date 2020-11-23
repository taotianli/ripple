function Fea = VG_Feature(bct_feature)
signal = transpose(bct_feature);
[m,n] = size(signal);
signal_ts = [1:n];
i_epoch = 1;
Fea = [];
for i = 1:m
    x_result = vg(signal(i,:),signal_ts,i_epoch);
    Fea = [Fea, [x_result.AssR,x_result.ClusC,x_result.ClusCstd,x_result.VGDmean,x_result.VGDslope,x_result.VGDstd,x_result.VGmean,x_result.VGslope,x_result.VGstd]];
end
end

