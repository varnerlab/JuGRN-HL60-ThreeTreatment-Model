using PyPlot
using PyCall
time_experimental = collect(0:0.01:120)

# Load the data  from simple ensemble

# simulation at all data points
#=
CD11b_array_scaled = readdlm("./plot_simple/scaled_state_CD11b.dat");
CD38_array_scaled = readdlm("./plot_simple/scaled_state_CD38.dat");
AhR_array_scaled = readdlm("./plot_simple/scaled_state_AhR.dat");
P47Phox_array_scaled = readdlm("./plot_simple/scaled_state_P47Phox.dat");
IRF1_array_scaled = readdlm("./plot_simple/scaled_state_IRF1.dat");
EGR1_array_scaled = readdlm("./plot_simple/scaled_state_EGR1.dat");
PU1_array_scaled = readdlm("./plot_simple/scaled_state_PU1.dat");
GIF1_array_scaled = readdlm("./plot_simple/scaled_state_GIF1.dat");
E2F_array_scaled = readdlm("./plot_simple/scaled_state_E2F.dat");
CEBPa_array_scaled = readdlm("./plot_simple/scaled_state_CEBPa.dat");
OCT4_array_scaled = readdlm("./plot_simple/scaled_state_OCT4.dat");

# interpreated simulation data to match times of data
CD11b_data_scaled = readdlm("./plot_simple/scaled_data_CD11b.dat");
CD38_data_scaled = readdlm("./plot_simple/scaled_data_CD38.dat");
AhR_data_scaled = readdlm("./plot_simple/scaled_data_AhR.dat");
P47Phox_data_scaled = readdlm("./plot_simple/scaled_data_P47Phox.dat");
IRF1_data_scaled = readdlm("./plot_simple/scaled_data_IRF1.dat");
EGR1_data_scaled = readdlm("./plot_simple/scaled_data_EGR1.dat");
PU1_data_scaled = readdlm("./plot_simple/scaled_data_PU1.dat");
GIF1_data_scaled = readdlm("./plot_simple/scaled_data_GIF1.dat");
E2F_data_scaled = readdlm("./plot_simple/scaled_data_E2F.dat");
CEBPa_data_scaled = readdlm("./plot_simple/scaled_data_CEBPa.dat");
OCT4_data_scaled = readdlm("./plot_simple/scaled_data_OCT4.dat");
=#
# load data from best ensemble

CD11b_array_scaled = readdlm("./plot_best/scaled_state_CD11b.dat");
CD38_array_scaled = readdlm("./plot_best/scaled_state_CD38.dat");
AhR_array_scaled = readdlm("./plot_best/scaled_state_AhR.dat");
P47Phox_array_scaled = readdlm("./plot_best/scaled_state_P47Phox.dat");
IRF1_array_scaled = readdlm("./plot_best/scaled_state_IRF1.dat");
EGR1_array_scaled = readdlm("./plot_best/scaled_state_EGR1.dat");
PU1_array_scaled = readdlm("./plot_best/scaled_state_PU1.dat");
GIF1_array_scaled = readdlm("./plot_best/scaled_state_GIF1.dat");
E2F_array_scaled = readdlm("./plot_best/scaled_state_E2F.dat");
CEBPa_array_scaled = readdlm("./plot_best/scaled_state_CEBPa.dat");
OCT4_array_scaled = readdlm("./plot_best/scaled_state_OCT4.dat");

# interpreated simulation data to match times of data
CD11b_data_scaled = readdlm("./plot_best/scaled_data_CD11b.dat");
CD38_data_scaled = readdlm("./plot_best/scaled_data_CD38.dat");
AhR_data_scaled = readdlm("./plot_best/scaled_data_AhR.dat");
P47Phox_data_scaled = readdlm("./plot_best/scaled_data_P47Phox.dat");
IRF1_data_scaled = readdlm("./plot_best/scaled_data_IRF1.dat");
EGR1_data_scaled = readdlm("./plot_best/scaled_data_EGR1.dat");
PU1_data_scaled = readdlm("./plot_best/scaled_data_PU1.dat");
GIF1_data_scaled = readdlm("./plot_best/scaled_data_GIF1.dat");
E2F_data_scaled = readdlm("./plot_best/scaled_data_E2F.dat");
CEBPa_data_scaled = readdlm("./plot_best/scaled_data_CEBPa.dat");
OCT4_data_scaled = readdlm("./plot_best/scaled_data_OCT4.dat");

# Load the measurements -
CD38_EXP = readdlm("./data/CD38-WTHL60.txt");
CD11b_EXP = readdlm("./data/CD11b-WTHL60.txt");
G1G0_EXP = readdlm("./data/G1G0-WTHL60.txt");



# What is the size of the data?
(number_of_time,number_of_samples) = size(CD38_array_scaled);

# calculate mean
CD38_mean_array =  mean(CD38_array_scaled,2)
CD38_std_array = std(CD38_array_scaled,2)
CD11b_mean_array =  mean(CD11b_array_scaled,2)
CD11b_std_array = std(CD11b_array_scaled,2)
AhR_mean_array =  mean(AhR_array_scaled,2)
AhR_std_array = std(AhR_array_scaled,2)
P47Phox_mean_array =  mean(P47Phox_array_scaled,2)
P47Phox_std_array = std(P47Phox_array_scaled,2)
IRF1_mean_array =  mean(IRF1_array_scaled,2)
IRF1_std_array = std(IRF1_array_scaled,2)
PU1_mean_array =  mean(PU1_array_scaled,2)
PU1_std_array = std(PU1_array_scaled,2)
E2F_mean_array =  mean(E2F_array_scaled,2)
E2F_std_array = std(E2F_array_scaled,2)
CEBPa_mean_array =  mean(CEBPa_array_scaled,2)
CEBPa_std_array = std(CEBPa_array_scaled,2)
OCT4_mean_array =  mean(OCT4_array_scaled,2)
OCT4_std_array = std(OCT4_array_scaled,2)
EGR1_mean_array =  mean(EGR1_array_scaled,2)
EGR1_std_array = std(EGR1_array_scaled,2)
GIF1_mean_array =  mean(GIF1_array_scaled,2)
GIF1_std_array = std(GIF1_array_scaled,2)

CD38_mean_data =  mean(CD38_data_scaled,2)
CD38_std_data = std(CD38_data_scaled,2)
CD11b_mean_data =  mean(CD11b_data_scaled,2)
CD11b_std_data = std(CD11b_data_scaled,2)
AhR_mean_data =  mean(AhR_data_scaled,2)
AhR_std_data = std(AhR_data_scaled,2)
P47Phox_mean_data =  mean(P47Phox_data_scaled,2)
P47Phox_std_data = std(P47Phox_data_scaled,2)
IRF1_mean_data =  mean(IRF1_data_scaled,2)
IRF1_std_data = std(IRF1_data_scaled,2)
PU1_mean_data =  mean(PU1_data_scaled,2)
PU1_std_data = std(PU1_data_scaled,2)
E2F_mean_data =  mean(E2F_data_scaled,2)
E2F_std_data = std(E2F_data_scaled,2)
CEBPa_mean_data =  mean(CEBPa_data_scaled,2)
CEBPa_std_data = std(CEBPa_data_scaled,2)
OCT4_mean_data =  mean(OCT4_data_scaled,2)
OCT4_std_data = std(OCT4_data_scaled,2)
EGR1_mean_data =  mean(EGR1_data_scaled,2)
EGR1_std_data = std(EGR1_data_scaled,2)
GIF1_mean_data =  mean(GIF1_data_scaled,2)
GIF1_std_data = std(GIF1_data_scaled,2)


# correlate G1G0 to E2F
N_E2F = 0.254855
#G1G0_syn = (1./E2F_mean_array[[1;2401;4801;7201],1]).^N_E2F
#G1G0_syn = (1./E2F_mean_array.^N_E2F)
E2F_mean_array = E2F_mean_array
#G1G0_syn = 1./(E2F_mean_array)*0.59 + (1-0.333)
G1G0_syn = zeros(12001)
G1G0_syn[1] = 1
alpha = 1
gamma = -3.5
for index in 2:(length(G1G0_syn)-1)
  G1G0_syn[index] = G1G0_syn[index-1] + 1/100000*(E2F_mean_array[index-1])^gamma
end

#E2F_alpha = (E2F_mean_array - minimum(E2F_mean_array))/(maximum(E2F_mean_array)- minimum(E2F_mean_array))
# 99% confidence interval or standard error
SF = (2.58)#/sqrt(number_of_samples)
SF2 = (2.58)/sqrt(number_of_samples)

# 99% confidence interbal
CD38_UB = CD38_mean_array + CD38_std_array*SF
CD38_LB = CD38_mean_array - CD38_std_array*SF
idx_z = find(CD38_LB.<0)
CD38_LB[idx_z] = 0.0

CD11b_UB = CD11b_mean_array + CD11b_std_array*SF
CD11b_LB = CD11b_mean_array - CD11b_std_array*SF
idx_z = find(CD11b_LB.<0)
CD11b_LB[idx_z] = 0.0

# 99% standard error from mean

CD11b_UB_SE = CD11b_mean_array + CD11b_std_array*SF2
CD11b_LB_SE = CD11b_mean_array - CD11b_std_array*SF2
idx_z = find(CD11b_LB.<0)
CD11b_LB_SE[idx_z] = 0.0

CD38_UB_SE = CD38_mean_array + CD38_std_array*SF2
CD38_LB_SE = CD38_mean_array - CD38_std_array*SF2
idx_z = find(CD38_LB.<0)
CD38_LB_SE[idx_z] = 0.0


G1G0_UB = G1G0_syn + E2F_std_array*SF
G1G0_LB = G1G0_syn - E2F_std_array*SF
idx_z = find(G1G0_LB.<0)
G1G0_LB[idx_z] = 0.0

G1G0_UB_SE = G1G0_syn + E2F_std_array*SF2
G1G0_LB_SE = G1G0_syn - E2F_std_array*SF2
idx_z = find(G1G0_LB_SE.<0)
G1G0_LB_SE[idx_z] = 0.0



# additional species
AhR_UB = AhR_mean_array + AhR_std_array*SF
AhR_LB = AhR_mean_array - AhR_std_array*SF
idx_z = find(AhR_LB.<0)
AhR_LB[idx_z] = 0.0

P47Phox_UB = P47Phox_mean_array + P47Phox_std_array*SF
P47Phox_LB = P47Phox_mean_array - P47Phox_std_array*SF
idx_z = find(P47Phox_LB.<0)
P47Phox_LB[idx_z] = 0.0

CEBPa_UB = CEBPa_mean_array + CEBPa_std_array*SF
CEBPa_LB = CEBPa_mean_array - CEBPa_std_array*SF
idx_z = find(CEBPa_LB.<0)
CEBPa_LB[idx_z] = 0.0



PU1_UB = PU1_mean_array + PU1_std_array*SF
PU1_LB = PU1_mean_array - PU1_std_array*SF
idx_z = find(PU1_LB.<0)
PU1_LB[idx_z] = 0.0

OCT4_UB = OCT4_mean_array + OCT4_std_array*SF
OCT4_LB = OCT4_mean_array - OCT4_std_array*SF
idx_z = find(OCT4_LB.<0)
OCT4_LB[idx_z] = 0.0

IRF1_UB = IRF1_mean_array + IRF1_std_array*SF
IRF1_LB = IRF1_mean_array - IRF1_std_array*SF
idx_z = find(IRF1_LB.<0)
IRF1_LB[idx_z] = 0.0

EGR1_UB = EGR1_mean_array + EGR1_std_array*SF
EGR1_LB = EGR1_mean_array - EGR1_std_array*SF
idx_z = find(EGR1_LB.<0)
EGR1_LB[idx_z] = 0.0

GIF1_UB = GIF1_mean_array + GIF1_std_array*SF
GIF1_LB = GIF1_mean_array - GIF1_std_array*SF
idx_z = find(GIF1_LB.<0)
GIF1_LB[idx_z] = 0.0



# Plotting Figures

# CD11b and CD38
figure(1)
a = plot(time_experimental,CD38_mean_array,"k")
b = errorbar(CD38_EXP[:,1],CD38_EXP[:,2],CD38_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD38_LB),vec(CD38_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(CD38_LB_SE),vec(CD38_UB_SE),color="dodgerblue",lw=2)
c = plot(time_experimental,CD11b_mean_array,"k")
d = errorbar(CD11b_EXP[:,1],CD11b_EXP[:,2],CD11b_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD11b_LB),vec(CD11b_UB),color="lightsalmon",lw=2)
fill_between(vec(time_experimental),vec(CD11b_LB_SE),vec(CD11b_UB_SE),color="tomato",lw=2)
#legend([a;b;c;d],["Ensemble Mean CD38","Experimental CD38","Ensemble Mean CD11b","Experimental CD11b"])

# E2F
figure(2)
a = plot(time_experimental,G1G0_syn,"k")
b = errorbar(G1G0_EXP[:,1],G1G0_EXP[:,2],G1G0_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(G1G0_LB),vec(G1G0_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(G1G0_LB_SE),vec(G1G0_UB_SE),color="dodgerblue",lw=2)
