function feature_c = BCT_Feature(x,frequency,window_time,overlap_ratio)
n_max=length(x);
n_window = window_time*frequency;%time window lenth
% Is window size the same with sampling frequency?
overlap_win = overlap_ratio*n_window; %overlap time
n_max=length(x);
max_count = ceil((length(x)-n_window)/(n_window-overlap_win))+1;
n_start=0;
%corrcoef(x)
flag=0;
new_data=[];
feature_c=[];
feature_r=[];
feature_bc=[];
for i=1:max_count
    n_end = n_start + n_window;
    if n_end > n_max
     new_data = x(n_start+1:n_max,:);
    else
      new_data = x(n_start+1:n_end,:);
    end
    n_start = n_end-overlap_win;
    correlation_matrix = corr(new_data,'type','Pearson');
    ind = correlation_matrix>0.1|correlation_matrix<-0.1;%setting threshold
    correlation_matrix(ind) = 1;%二值化
    correlation_matrix(~ind) = 0;
    C = clustering_coef_bu(correlation_matrix);%无向无权网络的聚类系数
    feature_c=[feature_c C];
    CIJ=correlation_matrix;
    r = assortativity_wei(CIJ,flag);
    feature_r=[feature_r,r];
    BC=betweenness_wei(CIJ);%介数
    feature_bc=[feature_bc,BC];
end

end

