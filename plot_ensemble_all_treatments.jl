using PyPlot
using PyCall
time_experimental = collect(0:0.01:120)

CD11b_array_RA_scaled = readdlm("./plot_best/scaled_state_CD11b_RA.dat");
CD14_array_RA_scaled = readdlm("./plot_best/scaled_state_CD14_RA.dat");
CD38_array_RA_scaled = readdlm("./plot_best/scaled_state_CD38_RA.dat");
AhR_array_RA_scaled = readdlm("./plot_best/scaled_state_AhR_RA.dat");
P47Phox_array_RA_scaled = readdlm("./plot_best/scaled_state_P47Phox_RA.dat");
IRF1_array_RA_scaled = readdlm("./plot_best/scaled_state_IRF1_RA.dat");
EGR1_array_RA_scaled = readdlm("./plot_best/scaled_state_EGR1_RA.dat");
PU1_array_RA_scaled = readdlm("./plot_best/scaled_state_PU1_RA.dat");
GIF1_array_RA_scaled = readdlm("./plot_best/scaled_state_GIF1_RA.dat");
E2F_array_RA_scaled = readdlm("./plot_best/scaled_state_E2F_RA.dat");
CEBPa_array_RA_scaled = readdlm("./plot_best/scaled_state_CEBPa_RA.dat");
OCT4_array_RA_scaled = readdlm("./plot_best/scaled_state_OCT4_RA.dat");

# interpreated simulation data to match times of data
CD11b_data_RA_scaled = readdlm("./plot_best/scaled_data_CD11b_RA.dat");
CD14_data_RA_scaled = readdlm("./plot_best/scaled_data_CD14_RA.dat");
CD38_data_RA_scaled = readdlm("./plot_best/scaled_data_CD38_RA.dat");
AhR_data_RA_scaled = readdlm("./plot_best/scaled_data_AhR_RA.dat");
P47Phox_data_RA_scaled = readdlm("./plot_best/scaled_data_P47Phox_RA.dat");
IRF1_data_RA_scaled = readdlm("./plot_best/scaled_data_IRF1_RA.dat");
EGR1_data_RA_scaled = readdlm("./plot_best/scaled_data_EGR1_RA.dat");
PU1_data_RA_scaled = readdlm("./plot_best/scaled_data_PU1_RA.dat");
GIF1_data_RA_scaled = readdlm("./plot_best/scaled_data_GIF1_RA.dat");
E2F_data_RA_scaled = readdlm("./plot_best/scaled_data_E2F_RA.dat");
CEBPa_data_RA_scaled = readdlm("./plot_best/scaled_data_CEBPa_RA.dat");
OCT4_data_RA_scaled = readdlm("./plot_best/scaled_data_OCT4_RA.dat");

# Load the measurements -
CD38_RA_EXP = readdlm("./data/CD38-WTHL60.txt");
CD14_RA_EXP = readdlm("./data/CD14-WTHL60.txt");
CD11b_RA_EXP = readdlm("./data/CD11b-WTHL60.txt");
G1G0_RA_EXP = readdlm("./data/G1G0-WTHL60.txt");
AhR_RA_EXP = readdlm("./data/AhR-WTHL60.txt");
#P21_RA_EXP = readdlm("./data/P21-WTHL60.txt");
GFI1_RA_EXP = readdlm("./data/GiF1-WTHL60.txt");
CEBPa_RA_EXP = readdlm("./data/CEBPa-WTHL60.txt");
PU1_RA_EXP = readdlm("./data/PU1-WTHL60.txt");
P47Phox_RA_EXP = readdlm("./data/P47Phox-WTHL60.txt");
OCT4_RA_EXP = readdlm("./data/OCT4-WTHL60.txt");
IRF1_RA_EXP = readdlm("./data/IRF1-WTHL60.txt");
EGR1_RA_EXP = readdlm("./data/EGR1-WTHL60.txt");

CD11b_array_D3_scaled = readdlm("./plot_best/scaled_state_CD11b_D3.dat");
CD14_array_D3_scaled = readdlm("./plot_best/scaled_state_CD14_D3.dat");
CD38_array_D3_scaled = readdlm("./plot_best/scaled_state_CD38_D3.dat");
AhR_array_D3_scaled = readdlm("./plot_best/scaled_state_AhR_D3.dat");
P47Phox_array_D3_scaled = readdlm("./plot_best/scaled_state_P47Phox_D3.dat");
IRF1_array_D3_scaled = readdlm("./plot_best/scaled_state_IRF1_D3.dat");
EGR1_array_D3_scaled = readdlm("./plot_best/scaled_state_EGR1_D3.dat");
PU1_array_D3_scaled = readdlm("./plot_best/scaled_state_PU1_D3.dat");
GIF1_array_D3_scaled = readdlm("./plot_best/scaled_state_GIF1_D3.dat");
E2F_array_D3_scaled = readdlm("./plot_best/scaled_state_E2F_D3.dat");
CEBPa_array_D3_scaled = readdlm("./plot_best/scaled_state_CEBPa_D3.dat");
OCT4_array_D3_scaled = readdlm("./plot_best/scaled_state_OCT4_D3.dat");

# interpreated simulation data to match times of data
CD11b_data_D3_scaled = readdlm("./plot_best/scaled_data_CD11b_D3.dat");
CD14_data_D3_scaled = readdlm("./plot_best/scaled_data_CD14_D3.dat");
CD38_data_D3_scaled = readdlm("./plot_best/scaled_data_CD38_D3.dat");
AhR_data_D3_scaled = readdlm("./plot_best/scaled_data_AhR_D3.dat");
P47Phox_data_D3_scaled = readdlm("./plot_best/scaled_data_P47Phox_D3.dat");
IRF1_data_D3_scaled = readdlm("./plot_best/scaled_data_IRF1_D3.dat");
EGR1_data_D3_scaled = readdlm("./plot_best/scaled_data_EGR1_D3.dat");
PU1_data_D3_scaled = readdlm("./plot_best/scaled_data_PU1_D3.dat");
GIF1_data_D3_scaled = readdlm("./plot_best/scaled_data_GIF1_D3.dat");
E2F_data_D3_scaled = readdlm("./plot_best/scaled_data_E2F_D3.dat");
CEBPa_data_D3_scaled = readdlm("./plot_best/scaled_data_CEBPa_D3.dat");
OCT4_data_D3_scaled = readdlm("./plot_best/scaled_data_OCT4_D3.dat");

# Load the measurements -
CD38_D3_EXP = readdlm("./data/CD38-WTHL60_D3.txt");
CD14_D3_EXP = readdlm("./data/CD14-WTHL60_D3.txt");
CD11b_D3_EXP = readdlm("./data/CD11b-WTHL60_D3.txt");
G1G0_D3_EXP = readdlm("./data/G1G0-WTHL60_D3.txt");
AhR_D3_EXP = readdlm("./data/AhR-WTHL60_D3.txt");
#P21_D3_EXP = readdlm("./data/P21-WTHL60_D3.txt");
GFI1_D3_EXP = readdlm("./data/GiF1-WTHL60_D3.txt");
CEBPa_D3_EXP = readdlm("./data/CEBPa-WTHL60_D3.txt");
PU1_D3_EXP = readdlm("./data/PU1-WTHL60_D3.txt");
P47Phox_D3_EXP = readdlm("./data/P47Phox-WTHL60_D3.txt");
OCT4_D3_EXP = readdlm("./data/OCT4-WTHL60_D3.txt");
IRF1_D3_EXP = readdlm("./data/IRF1-WTHL60_D3.txt");
EGR1_D3_EXP = readdlm("./data/EGR1-WTHL60_D3.txt");

CD11b_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_CD11b_RA_D3.dat");
CD14_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_CD14_RA_D3.dat");
CD38_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_CD38_RA_D3.dat");
AhR_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_AhR_RA_D3.dat");
P47Phox_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_P47Phox_RA_D3.dat");
IRF1_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_IRF1_RA_D3.dat");
EGR1_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_EGR1_RA_D3.dat");
PU1_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_PU1_RA_D3.dat");
GIF1_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_GIF1_RA_D3.dat");
E2F_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_E2F_RA_D3.dat");
CEBPa_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_CEBPa_RA_D3.dat");
OCT4_array_RA_D3_scaled = readdlm("./plot_best/scaled_state_OCT4_RA_D3.dat");

# interpreated simulation data to match times of data
CD11b_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_CD11b_RA_D3.dat");
CD14_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_CD14_RA_D3.dat");
CD38_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_CD38_RA_D3.dat");
AhR_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_AhR_RA_D3.dat");
P47Phox_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_P47Phox_RA_D3.dat");
IRF1_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_IRF1_RA_D3.dat");
EGR1_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_EGR1_RA_D3.dat");
PU1_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_PU1_RA_D3.dat");
GIF1_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_GIF1_RA_D3.dat");
E2F_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_E2F_RA_D3.dat");
CEBPa_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_CEBPa_RA_D3.dat");
OCT4_data_RA_D3_scaled = readdlm("./plot_best/scaled_data_OCT4_RA_D3.dat");

# Load the measurements -
CD38_RA_D3_EXP = readdlm("./data/CD38-WTHL60_RA_D3.txt");
CD14_RA_D3_EXP = readdlm("./data/CD14-WTHL60_RA_D3.txt");
CD11b_RA_D3_EXP = readdlm("./data/CD11b-WTHL60_RA_D3.txt");
G1G0_RA_D3_EXP = readdlm("./data/G1G0-WTHL60_RA_D3.txt");
AhR_RA_D3_EXP = readdlm("./data/AhR-WTHL60_RA_D3.txt");
#P21_RA_D3_EXP = readdlm("./data/P21-WTHL60_RA_D3.txt");
GFI1_RA_D3_EXP = readdlm("./data/GiF1-WTHL60_RA_D3.txt");
CEBPa_RA_D3_EXP = readdlm("./data/CEBPa-WTHL60_RA_D3.txt");
PU1_RA_D3_EXP = readdlm("./data/PU1-WTHL60_RA_D3.txt");
#P47Phox_RA_D3_EXP = readdlm("./data/P47Phox-WTHL60_RA_D3.txt");
OCT4_RA_D3_EXP = readdlm("./data/OCT4-WTHL60_RA_D3.txt");
IRF1_RA_D3_EXP = readdlm("./data/IRF1-WTHL60_RA_D3.txt");
EGR1_RA_D3_EXP = readdlm("./data/EGR1-WTHL60_RA_D3.txt");


# What is the size of the data?
(number_of_time,number_of_samples) = size(CD38_array_RA_scaled);

# calculate mean ---------------------------------------------------------
# for RA

CD38_mean_array_RA =  mean(CD38_array_RA_scaled,2)
CD38_std_array_RA = std(CD38_array_RA_scaled,2)
CD14_mean_array_RA =  mean(CD14_array_RA_scaled,2)
CD14_std_array_RA = std(CD14_array_RA_scaled,2)
CD11b_mean_array_RA =  mean(CD11b_array_RA_scaled,2)
CD11b_std_array_RA = std(CD11b_array_RA_scaled,2)
AhR_mean_array_RA =  mean(AhR_array_RA_scaled,2)
AhR_std_array_RA = std(AhR_array_RA_scaled,2)
P47Phox_mean_array_RA =  mean(P47Phox_array_RA_scaled,2)
P47Phox_std_array_RA = std(P47Phox_array_RA_scaled,2)
IRF1_mean_array_RA =  mean(IRF1_array_RA_scaled,2)
IRF1_std_array_RA = std(IRF1_array_RA_scaled,2)
PU1_mean_array_RA =  mean(PU1_array_RA_scaled,2)
PU1_std_array_RA = std(PU1_array_RA_scaled,2)
E2F_mean_array_RA =  mean(E2F_array_RA_scaled,2)
E2F_std_array_RA = std(E2F_array_RA_scaled,2)
CEBPa_mean_array_RA =  mean(CEBPa_array_RA_scaled,2)
CEBPa_std_array_RA = std(CEBPa_array_RA_scaled,2)
OCT4_mean_array_RA =  mean(OCT4_array_RA_scaled,2)
OCT4_std_array_RA = std(OCT4_array_RA_scaled,2)
EGR1_mean_array_RA =  mean(EGR1_array_RA_scaled,2)
EGR1_std_array_RA = std(EGR1_array_RA_scaled,2)
GIF1_mean_array_RA =  mean(GIF1_array_RA_scaled,2)
GIF1_std_array_RA = std(GIF1_array_RA_scaled,2)

CD38_mean_data_RA =  mean(CD38_data_RA_scaled,2)
CD38_std_data_RA = std(CD38_data_RA_scaled,2)
CD14_mean_data_RA =  mean(CD14_data_RA_scaled,2)
CD14_std_data_RA = std(CD14_data_RA_scaled,2)
CD11b_mean_data_RA =  mean(CD11b_data_RA_scaled,2)
CD11b_std_data_RA = std(CD11b_data_RA_scaled,2)
AhR_mean_data_RA =  mean(AhR_data_RA_scaled,2)
AhR_std_data_RA = std(AhR_data_RA_scaled,2)
P47Phox_mean_data_RA =  mean(P47Phox_data_RA_scaled,2)
P47Phox_std_data_RA = std(P47Phox_data_RA_scaled,2)
IRF1_mean_data_RA =  mean(IRF1_data_RA_scaled,2)
IRF1_std_data_RA = std(IRF1_data_RA_scaled,2)
PU1_mean_data_RA =  mean(PU1_data_RA_scaled,2)
PU1_std_data_RA = std(PU1_data_RA_scaled,2)
E2F_mean_data_RA =  mean(E2F_data_RA_scaled,2)
E2F_std_data_RA = std(E2F_data_RA_scaled,2)
CEBPa_mean_data_RA =  mean(CEBPa_data_RA_scaled,2)
CEBPa_std_data_RA = std(CEBPa_data_RA_scaled,2)
OCT4_mean_data_RA =  mean(OCT4_data_RA_scaled,2)
OCT4_std_data_RA = std(OCT4_data_RA_scaled,2)
EGR1_mean_data_RA =  mean(EGR1_data_RA_scaled,2)
EGR1_std_data_RA = std(EGR1_data_RA_scaled,2)
GIF1_mean_data_RA =  mean(GIF1_data_RA_scaled,2)
GIF1_std_data_RA = std(GIF1_data_RA_scaled,2)

# for D3 -------------------------------------------------------------------------------------------------------

# calculate mean
CD38_mean_array_D3 =  mean(CD38_array_D3_scaled,2)
CD38_std_array_D3 = std(CD38_array_D3_scaled,2)
CD14_mean_array_D3 =  mean(CD14_array_D3_scaled,2)
CD14_std_array_D3 = std(CD14_array_D3_scaled,2)
CD11b_mean_array_D3 =  mean(CD11b_array_D3_scaled,2)
CD11b_std_array_D3 = std(CD11b_array_D3_scaled,2)
AhR_mean_array_D3 =  mean(AhR_array_D3_scaled,2)
AhR_std_array_D3 = std(AhR_array_D3_scaled,2)
P47Phox_mean_array_D3 =  mean(P47Phox_array_D3_scaled,2)
P47Phox_std_array_D3 = std(P47Phox_array_D3_scaled,2)
IRF1_mean_array_D3 =  mean(IRF1_array_D3_scaled,2)
IRF1_std_array_D3 = std(IRF1_array_D3_scaled,2)
PU1_mean_array_D3 =  mean(PU1_array_D3_scaled,2)
PU1_std_array_D3 = std(PU1_array_D3_scaled,2)
E2F_mean_array_D3 =  mean(E2F_array_D3_scaled,2)
E2F_std_array_D3 = std(E2F_array_D3_scaled,2)
CEBPa_mean_array_D3 =  mean(CEBPa_array_D3_scaled,2)
CEBPa_std_array_D3 = std(CEBPa_array_D3_scaled,2)
OCT4_mean_array_D3 =  mean(OCT4_array_D3_scaled,2)
OCT4_std_array_D3 = std(OCT4_array_D3_scaled,2)
EGR1_mean_array_D3 =  mean(EGR1_array_D3_scaled,2)
EGR1_std_array_D3 = std(EGR1_array_D3_scaled,2)
GIF1_mean_array_D3 =  mean(GIF1_array_D3_scaled,2)
GIF1_std_array_D3 = std(GIF1_array_D3_scaled,2)

CD38_mean_data_D3 =  mean(CD38_data_D3_scaled,2)
CD38_std_data_D3 = std(CD38_data_D3_scaled,2)
CD14_mean_data_D3 =  mean(CD14_data_D3_scaled,2)
CD14_std_data_D3 = std(CD14_data_D3_scaled,2)
CD11b_mean_data_D3 =  mean(CD11b_data_D3_scaled,2)
CD11b_std_data_D3 = std(CD11b_data_D3_scaled,2)
AhR_mean_data_D3 =  mean(AhR_data_D3_scaled,2)
AhR_std_data_D3 = std(AhR_data_D3_scaled,2)
P47Phox_mean_data_D3 =  mean(P47Phox_data_D3_scaled,2)
P47Phox_std_data_D3 = std(P47Phox_data_D3_scaled,2)
IRF1_mean_data_D3 =  mean(IRF1_data_D3_scaled,2)
IRF1_std_data_D3 = std(IRF1_data_D3_scaled,2)
PU1_mean_data_D3 =  mean(PU1_data_D3_scaled,2)
PU1_std_data_D3 = std(PU1_data_D3_scaled,2)
E2F_mean_data_D3 =  mean(E2F_data_D3_scaled,2)
E2F_std_data_D3 = std(E2F_data_D3_scaled,2)
CEBPa_mean_data_D3 =  mean(CEBPa_data_D3_scaled,2)
CEBPa_std_data_D3 = std(CEBPa_data_D3_scaled,2)
OCT4_mean_data_D3 =  mean(OCT4_data_D3_scaled,2)
OCT4_std_data_D3 = std(OCT4_data_D3_scaled,2)
EGR1_mean_data_D3 =  mean(EGR1_data_D3_scaled,2)
EGR1_std_data_D3 = std(EGR1_data_D3_scaled,2)
GIF1_mean_data_D3 =  mean(GIF1_data_D3_scaled,2)
GIF1_std_data_D3 = std(GIF1_data_D3_scaled,2)

# for RA_D3-----------------------------------------------------------------------
# calculate mean
# calculate mean
CD38_mean_array_RA_D3 =  mean(CD38_array_RA_D3_scaled,2)
CD38_std_array_RA_D3 = std(CD38_array_RA_D3_scaled,2)
CD14_mean_array_RA_D3 =  mean(CD14_array_RA_D3_scaled,2)
CD14_std_array_RA_D3 = std(CD14_array_RA_D3_scaled,2)
CD11b_mean_array_RA_D3 =  mean(CD11b_array_RA_D3_scaled,2)
CD11b_std_array_RA_D3 = std(CD11b_array_RA_D3_scaled,2)
AhR_mean_array_RA_D3 =  mean(AhR_array_RA_D3_scaled,2)
AhR_std_array_RA_D3 = std(AhR_array_RA_D3_scaled,2)
P47Phox_mean_array_RA_D3 =  mean(P47Phox_array_RA_D3_scaled,2)
P47Phox_std_array_RA_D3 = std(P47Phox_array_RA_D3_scaled,2)
IRF1_mean_array_RA_D3 =  mean(IRF1_array_RA_D3_scaled,2)
IRF1_std_array_RA_D3 = std(IRF1_array_RA_D3_scaled,2)
PU1_mean_array_RA_D3 =  mean(PU1_array_RA_D3_scaled,2)
PU1_std_array_RA_D3 = std(PU1_array_RA_D3_scaled,2)
E2F_mean_array_RA_D3 =  mean(E2F_array_RA_D3_scaled,2)
E2F_std_array_RA_D3 = std(E2F_array_RA_D3_scaled,2)
CEBPa_mean_array_RA_D3 =  mean(CEBPa_array_RA_D3_scaled,2)
CEBPa_std_array_RA_D3 = std(CEBPa_array_RA_D3_scaled,2)
OCT4_mean_array_RA_D3 =  mean(OCT4_array_RA_D3_scaled,2)
OCT4_std_array_RA_D3 = std(OCT4_array_RA_D3_scaled,2)
EGR1_mean_array_RA_D3 =  mean(EGR1_array_RA_D3_scaled,2)
EGR1_std_array_RA_D3 = std(EGR1_array_RA_D3_scaled,2)
GIF1_mean_array_RA_D3 =  mean(GIF1_array_RA_D3_scaled,2)
GIF1_std_array_RA_D3 = std(GIF1_array_RA_D3_scaled,2)

CD38_mean_data_RA_D3 =  mean(CD38_data_RA_D3_scaled,2)
CD38_std_data_RA_D3 = std(CD38_data_RA_D3_scaled,2)
CD14_mean_data_RA_D3 =  mean(CD14_data_RA_D3_scaled,2)
CD14_std_data_RA_D3 = std(CD14_data_RA_D3_scaled,2)
CD11b_mean_data_RA_D3 =  mean(CD11b_data_RA_D3_scaled,2)
CD11b_std_data_RA_D3 = std(CD11b_data_RA_D3_scaled,2)
AhR_mean_data_RA_D3 =  mean(AhR_data_RA_D3_scaled,2)
AhR_std_data_RA_D3 = std(AhR_data_RA_D3_scaled,2)
P47Phox_mean_data_RA_D3 =  mean(P47Phox_data_RA_D3_scaled,2)
P47Phox_std_data_RA_D3 = std(P47Phox_data_RA_D3_scaled,2)
IRF1_mean_data_RA_D3 =  mean(IRF1_data_RA_D3_scaled,2)
IRF1_std_data_RA_D3 = std(IRF1_data_RA_D3_scaled,2)
PU1_mean_data_RA_D3 =  mean(PU1_data_RA_D3_scaled,2)
PU1_std_data_RA_D3 = std(PU1_data_RA_D3_scaled,2)
E2F_mean_data_RA_D3 =  mean(E2F_data_RA_D3_scaled,2)
E2F_std_data_RA_D3 = std(E2F_data_RA_D3_scaled,2)
CEBPa_mean_data_RA_D3 =  mean(CEBPa_data_RA_D3_scaled,2)
CEBPa_std_data_RA_D3 = std(CEBPa_data_RA_D3_scaled,2)
OCT4_mean_data_RA_D3 =  mean(OCT4_data_RA_D3_scaled,2)
OCT4_std_data_RA_D3 = std(OCT4_data_RA_D3_scaled,2)
EGR1_mean_data_RA_D3 =  mean(EGR1_data_RA_D3_scaled,2)
EGR1_std_data_RA_D3 = std(EGR1_data_RA_D3_scaled,2)
GIF1_mean_data_RA_D3 =  mean(GIF1_data_RA_D3_scaled,2)
GIF1_std_data_RA_D3 = std(GIF1_data_RA_D3_scaled,2)

G1G0_mean_array_RA = mean(1./E2F_array_RA_scaled,2)
G1G0_std_array_RA = std(1./E2F_array_RA_scaled,2)
G1G0_mean_array_D3 = mean(1./E2F_array_D3_scaled,2)
G1G0_std_array_D3 = std(1./E2F_array_D3_scaled,2)
G1G0_mean_array_RA_D3 = mean(1./E2F_array_RA_D3_scaled,2)
G1G0_std_array_RA_D3 = std(1./E2F_array_RA_D3_scaled,2)
# ---------------------------------------------------------------------------------
# correlate G1G0 to E2F
N_E2F = 0.254855
#G1G0_syn = (1./E2F_mean_array_RA[[1;2401;4801;7201],1]).^N_E2F
#G1G0_syn = (1./E2F_mean_array_RA.^N_E2F)
E2F_mean_array_RA = E2F_mean_array_RA
#G1G0_syn = 1./(E2F_mean_array_RA)*0.59 + (1-0.333)
G1G0_syn_RA = zeros(12001)
G1G0_syn_D3 = zeros(12001)
G1G0_syn_RA_D3 = zeros(12001)
G1G0_syn_RA[1] = 1
G1G0_syn_D3[1] = 1
G1G0_syn_RA_D3[1] = 1

#G1G0_syn = 1./E2F_mean_array_RA
alpha = 1
gamma = -3.5
for index in 2:(length(G1G0_syn_RA)-1)
  G1G0_syn_RA[index] = G1G0_syn_RA[index-1] + 1/25000*(E2F_mean_array_RA[index-1])^gamma
  G1G0_syn_D3[index] = G1G0_syn_D3[index-1] + 1/25000*(E2F_mean_array_D3[index-1])^gamma
  G1G0_syn_RA_D3[index] = G1G0_syn_RA_D3[index-1] + 1/25000*(E2F_mean_array_RA_D3[index-1])^gamma
end
# different relaton -- using inverse
G1G0_syn_RA2 = 1./E2F_mean_array_RA;
G1G0_syn_D32 = 1./E2F_mean_array_D3;
G1G0_syn_RA_D32 = 1./E2F_mean_array_RA_D3;

#E2F_alpha = (E2F_mean_array_RA - minimum(E2F_mean_array_RA))/(maximum(E2F_mean_array_RA)- minimum(E2F_mean_array_RA))
# 99% confidence interval or standard error
SF = (2.58)#/sqrt(number_of_samples)
SF2 = (2.58)/sqrt(number_of_samples)

# 99% confidence interbal
CD38_RA_UB = CD38_mean_array_RA + CD38_std_array_RA*SF
CD38_RA_LB = CD38_mean_array_RA - CD38_std_array_RA*SF
idx_z = find(CD38_RA_LB.<0)
CD38_RA_LB[idx_z] = 0.0

CD11b_RA_UB = CD11b_mean_array_RA + CD11b_std_array_RA*SF
CD11b_RA_LB = CD11b_mean_array_RA - CD11b_std_array_RA*SF
idx_z = find(CD11b_RA_LB.<0)
CD11b_RA_LB[idx_z] = 0.0

CD14_RA_UB = CD14_mean_array_RA + CD14_std_array_RA*SF
CD14_RA_LB = CD14_mean_array_RA - CD14_std_array_RA*SF
idx_z = find(CD14_RA_LB.<0)
CD14_RA_LB[idx_z] = 0.0

# 99% standard error from mean

CD11b_RA_UB_SE = CD11b_mean_array_RA + CD11b_std_array_RA*SF2
CD11b_RA_LB_SE = CD11b_mean_array_RA - CD11b_std_array_RA*SF2
idx_z = find(CD11b_RA_LB.<0)
CD11b_RA_LB_SE[idx_z] = 0.0

CD38_RA_UB_SE = CD38_mean_array_RA + CD38_std_array_RA*SF2
CD38_RA_LB_SE = CD38_mean_array_RA - CD38_std_array_RA*SF2
idx_z = find(CD38_RA_LB.<0)
CD38_RA_LB_SE[idx_z] = 0.0

CD14_RA_UB_SE = CD14_mean_array_RA + CD14_std_array_RA*SF2
CD14_RA_LB_SE = CD14_mean_array_RA - CD14_std_array_RA*SF2
idx_z = find(CD14_RA_LB.<0)
CD14_RA_LB_SE[idx_z] = 0.0


G1G0_RA_UB = G1G0_syn_RA + E2F_std_array_RA*SF
G1G0_RA_LB = G1G0_syn_RA - E2F_std_array_RA*SF
idx_z = find(G1G0_RA_LB.<0)
G1G0_RA_LB[idx_z] = 0.0

G1G0_RA_UB_SE = G1G0_syn_RA + E2F_std_array_RA*SF2
G1G0_RA_LB_SE = G1G0_syn_RA - E2F_std_array_RA*SF2
idx_z = find(G1G0_RA_LB_SE.<0)
G1G0_RA_LB_SE[idx_z] = 0.0

G1G0_RA_UB2 = G1G0_mean_array_RA + G1G0_std_array_RA*SF
G1G0_RA_LB2 = G1G0_mean_array_RA - G1G0_std_array_RA*SF
idx_z = find(G1G0_RA_LB2.<0)
G1G0_RA_LB2[idx_z] = 0.0

G1G0_RA_UB_SE2 = G1G0_mean_array_RA + G1G0_std_array_RA*SF2
G1G0_RA_LB_SE2 = G1G0_mean_array_RA - G1G0_std_array_RA*SF2
idx_z = find(G1G0_RA_LB_SE2.<0)
G1G0_RA_LB_SE2[idx_z] = 0.0

E2F_RA_UB = E2F_mean_array_RA + E2F_std_array_RA*SF
E2F_RA_LB = E2F_mean_array_RA - E2F_std_array_RA*SF
idx_z = find(G1G0_RA_LB.<0)
E2F_RA_LB[idx_z] = 0.0

E2F_RA_UB_SE = E2F_mean_array_RA + E2F_std_array_RA*SF2
E2F_RA_LB_SE = E2F_mean_array_RA - E2F_std_array_RA*SF2
idx_z = find(G1G0_RA_LB_SE.<0)
E2F_RA_LB_SE[idx_z] = 0.0



# additional species
AhR_RA_UB = AhR_mean_array_RA + AhR_std_array_RA*SF
AhR_RA_LB = AhR_mean_array_RA - AhR_std_array_RA*SF
idx_z = find(AhR_RA_LB.<0)
AhR_RA_LB[idx_z] = 0.0

P47Phox_RA_UB = P47Phox_mean_array_RA + P47Phox_std_array_RA*SF
P47Phox_RA_LB = P47Phox_mean_array_RA - P47Phox_std_array_RA*SF
idx_z = find(P47Phox_RA_LB.<0)
P47Phox_RA_LB[idx_z] = 0.0

CEBPa_RA_UB = CEBPa_mean_array_RA + CEBPa_std_array_RA*SF
CEBPa_RA_LB = CEBPa_mean_array_RA - CEBPa_std_array_RA*SF
idx_z = find(CEBPa_RA_LB.<0)
CEBPa_RA_LB[idx_z] = 0.0



PU1_RA_UB = PU1_mean_array_RA + PU1_std_array_RA*SF
PU1_RA_LB = PU1_mean_array_RA - PU1_std_array_RA*SF
idx_z = find(PU1_RA_LB.<0)
PU1_RA_LB[idx_z] = 0.0

OCT4_RA_UB = OCT4_mean_array_RA + OCT4_std_array_RA*SF
OCT4_RA_LB = OCT4_mean_array_RA - OCT4_std_array_RA*SF
idx_z = find(OCT4_RA_LB.<0)
OCT4_RA_LB[idx_z] = 0.0

IRF1_RA_UB = IRF1_mean_array_RA + IRF1_std_array_RA*SF
IRF1_RA_LB = IRF1_mean_array_RA - IRF1_std_array_RA*SF
idx_z = find(IRF1_RA_LB.<0)
IRF1_RA_LB[idx_z] = 0.0

EGR1_RA_UB = EGR1_mean_array_RA + EGR1_std_array_RA*SF
EGR1_RA_LB = EGR1_mean_array_RA - EGR1_std_array_RA*SF
idx_z = find(EGR1_RA_LB.<0)
EGR1_RA_LB[idx_z] = 0.0

GIF1_RA_UB = GIF1_mean_array_RA + GIF1_std_array_RA*SF
GIF1_RA_LB = GIF1_mean_array_RA - GIF1_std_array_RA*SF
idx_z = find(GIF1_RA_LB.<0)
GIF1_RA_LB[idx_z] = 0.0


# 99% confidence interbal
CD38_D3_UB = CD38_mean_array_D3 + CD38_std_array_D3*SF
CD38_D3_LB = CD38_mean_array_D3 - CD38_std_array_D3*SF
idx_z = find(CD38_D3_LB.<0)
CD38_D3_LB[idx_z] = 0.0

CD11b_D3_UB = CD11b_mean_array_D3 + CD11b_std_array_D3*SF
CD11b_D3_LB = CD11b_mean_array_D3 - CD11b_std_array_D3*SF
idx_z = find(CD11b_D3_LB.<0)
CD11b_D3_LB[idx_z] = 0.0

CD14_D3_UB = CD14_mean_array_D3 + CD14_std_array_D3*SF
CD14_D3_LB = CD14_mean_array_D3 - CD14_std_array_D3*SF
idx_z = find(CD14_D3_LB.<0)
CD14_D3_LB[idx_z] = 0.0

# 99% standard error from mean----D3 -----------------------------------

CD11b_D3_UB_SE = CD11b_mean_array_D3 + CD11b_std_array_D3*SF2
CD11b_D3_LB_SE = CD11b_mean_array_D3 - CD11b_std_array_D3*SF2
idx_z = find(CD11b_D3_LB.<0)
CD11b_D3_LB_SE[idx_z] = 0.0

CD38_D3_UB_SE = CD38_mean_array_D3 + CD38_std_array_D3*SF2
CD38_D3_LB_SE = CD38_mean_array_D3 - CD38_std_array_D3*SF2
idx_z = find(CD38_D3_LB.<0)
CD38_D3_LB_SE[idx_z] = 0.0

CD14_D3_UB_SE = CD14_mean_array_D3 + CD14_std_array_D3*SF2
CD14_D3_LB_SE = CD14_mean_array_D3 - CD14_std_array_D3*SF2
idx_z = find(CD14_D3_LB.<0)
CD14_D3_LB_SE[idx_z] = 0.0


G1G0_D3_UB = G1G0_syn_D3 + E2F_std_array_D3*SF
G1G0_D3_LB = G1G0_syn_D3 - E2F_std_array_D3*SF
idx_z = find(G1G0_D3_LB.<0)
G1G0_D3_LB[idx_z] = 0.0

G1G0_D3_UB_SE = G1G0_syn_D3 + E2F_std_array_D3*SF2
G1G0_D3_LB_SE = G1G0_syn_D3 - E2F_std_array_D3*SF2
idx_z = find(G1G0_D3_LB_SE.<0)
G1G0_D3_LB_SE[idx_z] = 0.0

E2F_D3_UB = E2F_mean_array_D3 + E2F_std_array_D3*SF
E2F_D3_LB = E2F_mean_array_D3 - E2F_std_array_D3*SF
idx_z = find(G1G0_D3_LB.<0)
E2F_D3_LB[idx_z] = 0.0

E2F_D3_UB_SE = E2F_mean_array_D3 + E2F_std_array_D3*SF2
E2F_D3_LB_SE = E2F_mean_array_D3 - E2F_std_array_D3*SF2
idx_z = find(G1G0_D3_LB_SE.<0)
E2F_D3_LB_SE[idx_z] = 0.0


G1G0_D3_UB2 = G1G0_mean_array_D3 + G1G0_std_array_D3*SF
G1G0_D3_LB2 = G1G0_mean_array_D3 - G1G0_std_array_D3*SF
idx_z = find(G1G0_RA_LB2.<0)
G1G0_D3_LB2[idx_z] = 0.0

G1G0_D3_UB_SE2 = G1G0_mean_array_D3 + G1G0_std_array_D3*SF2
G1G0_D3_LB_SE2 = G1G0_mean_array_D3 - G1G0_std_array_D3*SF2
idx_z = find(G1G0_D3_LB_SE2.<0)
G1G0_D3_LB_SE2[idx_z] = 0.0


# additional species
AhR_D3_UB = AhR_mean_array_D3 + AhR_std_array_D3*SF
AhR_D3_LB = AhR_mean_array_D3 - AhR_std_array_D3*SF
idx_z = find(AhR_D3_LB.<0)
AhR_D3_LB[idx_z] = 0.0

P47Phox_D3_UB = P47Phox_mean_array_D3 + P47Phox_std_array_D3*SF
P47Phox_D3_LB = P47Phox_mean_array_D3 - P47Phox_std_array_D3*SF
idx_z = find(P47Phox_D3_LB.<0)
P47Phox_D3_LB[idx_z] = 0.0

CEBPa_D3_UB = CEBPa_mean_array_D3 + CEBPa_std_array_D3*SF
CEBPa_D3_LB = CEBPa_mean_array_D3 - CEBPa_std_array_D3*SF
idx_z = find(CEBPa_D3_LB.<0)
CEBPa_D3_LB[idx_z] = 0.0



PU1_D3_UB = PU1_mean_array_D3 + PU1_std_array_D3*SF
PU1_D3_LB = PU1_mean_array_D3 - PU1_std_array_D3*SF
idx_z = find(PU1_D3_LB.<0)
PU1_D3_LB[idx_z] = 0.0

OCT4_D3_UB = OCT4_mean_array_D3 + OCT4_std_array_D3*SF
OCT4_D3_LB = OCT4_mean_array_D3 - OCT4_std_array_D3*SF
idx_z = find(OCT4_D3_LB.<0)
OCT4_D3_LB[idx_z] = 0.0

IRF1_D3_UB = IRF1_mean_array_D3 + IRF1_std_array_D3*SF
IRF1_D3_LB = IRF1_mean_array_D3 - IRF1_std_array_D3*SF
idx_z = find(IRF1_D3_LB.<0)
IRF1_D3_LB[idx_z] = 0.0

EGR1_D3_UB = EGR1_mean_array_D3 + EGR1_std_array_D3*SF
EGR1_D3_LB = EGR1_mean_array_D3 - EGR1_std_array_D3*SF
idx_z = find(EGR1_D3_LB.<0)
EGR1_D3_LB[idx_z] = 0.0

GIF1_D3_UB = GIF1_mean_array_D3 + GIF1_std_array_D3*SF
GIF1_D3_LB = GIF1_mean_array_D3 - GIF1_std_array_D3*SF
idx_z = find(GIF1_D3_LB.<0)
GIF1_D3_LB[idx_z] = 0.0


# 99% confidence interbal
CD38_RA_D3_UB = CD38_mean_array_RA_D3 + CD38_std_array_RA_D3*SF
CD38_RA_D3_LB = CD38_mean_array_RA_D3 - CD38_std_array_RA_D3*SF
idx_z = find(CD38_RA_D3_LB.<0)
CD38_RA_D3_LB[idx_z] = 0.0

CD11b_RA_D3_UB = CD11b_mean_array_RA_D3 + CD11b_std_array_RA_D3*SF
CD11b_RA_D3_LB = CD11b_mean_array_RA_D3 - CD11b_std_array_RA_D3*SF
idx_z = find(CD11b_RA_D3_LB.<0)
CD11b_RA_D3_LB[idx_z] = 0.0

CD14_RA_D3_UB = CD14_mean_array_RA_D3 + CD14_std_array_RA_D3*SF
CD14_RA_D3_LB = CD14_mean_array_RA_D3 - CD14_std_array_RA_D3*SF
idx_z = find(CD14_RA_D3_LB.<0)
CD14_RA_D3_LB[idx_z] = 0.0

# 99% standard error from mean --- RA_D3------------------------------

CD11b_RA_D3_UB_SE = CD11b_mean_array_RA_D3 + CD11b_std_array_RA_D3*SF2
CD11b_RA_D3_LB_SE = CD11b_mean_array_RA_D3 - CD11b_std_array_RA_D3*SF2
idx_z = find(CD11b_RA_D3_LB.<0)
CD11b_RA_D3_LB_SE[idx_z] = 0.0

CD38_RA_D3_UB_SE = CD38_mean_array_RA_D3 + CD38_std_array_RA_D3*SF2
CD38_RA_D3_LB_SE = CD38_mean_array_RA_D3 - CD38_std_array_RA_D3*SF2
idx_z = find(CD38_RA_D3_LB.<0)
CD38_RA_D3_LB_SE[idx_z] = 0.0

CD14_RA_D3_UB_SE = CD14_mean_array_RA_D3 + CD14_std_array_RA_D3*SF2
CD14_RA_D3_LB_SE = CD14_mean_array_RA_D3 - CD14_std_array_RA_D3*SF2
idx_z = find(CD14_RA_D3_LB.<0)
CD14_RA_D3_LB_SE[idx_z] = 0.0


G1G0_RA_D3_UB = G1G0_syn_RA_D3 + E2F_std_array_RA_D3*SF
G1G0_RA_D3_LB = G1G0_syn_RA_D3 - E2F_std_array_RA_D3*SF
idx_z = find(G1G0_RA_D3_LB.<0)
G1G0_RA_D3_LB[idx_z] = 0.0

G1G0_RA_D3_UB_SE = G1G0_syn_RA_D3 + E2F_std_array_RA_D3*SF2
G1G0_RA_D3_LB_SE = G1G0_syn_RA_D3 - E2F_std_array_RA_D3*SF2
idx_z = find(G1G0_RA_D3_LB_SE.<0)
G1G0_RA_D3_LB_SE[idx_z] = 0.0

E2F_RA_D3_UB = E2F_mean_array_RA_D3 + E2F_std_array_RA_D3*SF
E2F_RA_D3_LB = E2F_mean_array_RA_D3 - E2F_std_array_RA_D3*SF
idx_z = find(G1G0_RA_D3_LB.<0)
E2F_RA_D3_LB[idx_z] = 0.0

E2F_RA_D3_UB_SE = E2F_mean_array_RA_D3 + E2F_std_array_RA_D3*SF2
E2F_RA_D3_LB_SE = E2F_mean_array_RA_D3 - E2F_std_array_RA_D3*SF2
idx_z = find(G1G0_RA_D3_LB_SE.<0)
E2F_RA_D3_LB_SE[idx_z] = 0.0

G1G0_RA_D3_UB2 = G1G0_mean_array_RA_D3 + G1G0_std_array_RA_D3*SF
G1G0_RA_D3_LB2 = G1G0_mean_array_RA_D3 - G1G0_std_array_RA_D3*SF
idx_z = find(G1G0_RA_D3_LB2.<0)
G1G0_RA_D3_LB2[idx_z] = 0.0

G1G0_RA_D3_UB_SE2 = G1G0_mean_array_RA_D3 + G1G0_std_array_RA_D3*SF2
G1G0_RA_D3_LB_SE2 = G1G0_mean_array_RA_D3 - G1G0_std_array_RA_D3*SF2
idx_z = find(G1G0_RA_D3_LB_SE2.<0)
G1G0_RA_D3_LB_SE2[idx_z] = 0.0



# additional species
AhR_RA_D3_UB = AhR_mean_array_RA_D3 + AhR_std_array_RA_D3*SF
AhR_RA_D3_LB = AhR_mean_array_RA_D3 - AhR_std_array_RA_D3*SF
idx_z = find(AhR_RA_D3_LB.<0)
AhR_RA_D3_LB[idx_z] = 0.0

P47Phox_RA_D3_UB = P47Phox_mean_array_RA_D3 + P47Phox_std_array_RA_D3*SF
P47Phox_RA_D3_LB = P47Phox_mean_array_RA_D3 - P47Phox_std_array_RA_D3*SF
idx_z = find(P47Phox_RA_D3_LB.<0)
P47Phox_RA_D3_LB[idx_z] = 0.0

CEBPa_RA_D3_UB = CEBPa_mean_array_RA_D3 + CEBPa_std_array_RA_D3*SF
CEBPa_RA_D3_LB = CEBPa_mean_array_RA_D3 - CEBPa_std_array_RA_D3*SF
idx_z = find(CEBPa_RA_D3_LB.<0)
CEBPa_RA_D3_LB[idx_z] = 0.0



PU1_RA_D3_UB = PU1_mean_array_RA_D3 + PU1_std_array_RA_D3*SF
PU1_RA_D3_LB = PU1_mean_array_RA_D3 - PU1_std_array_RA_D3*SF
idx_z = find(PU1_RA_D3_LB.<0)
PU1_RA_D3_LB[idx_z] = 0.0

OCT4_RA_D3_UB = OCT4_mean_array_RA_D3 + OCT4_std_array_RA_D3*SF
OCT4_RA_D3_LB = OCT4_mean_array_RA_D3 - OCT4_std_array_RA_D3*SF
idx_z = find(OCT4_RA_D3_LB.<0)
OCT4_RA_D3_LB[idx_z] = 0.0

IRF1_RA_D3_UB = IRF1_mean_array_RA_D3 + IRF1_std_array_RA_D3*SF
IRF1_RA_D3_LB = IRF1_mean_array_RA_D3 - IRF1_std_array_RA_D3*SF
idx_z = find(IRF1_RA_D3_LB.<0)
IRF1_RA_D3_LB[idx_z] = 0.0

EGR1_RA_D3_UB = EGR1_mean_array_RA_D3 + EGR1_std_array_RA_D3*SF
EGR1_RA_D3_LB = EGR1_mean_array_RA_D3 - EGR1_std_array_RA_D3*SF
idx_z = find(EGR1_RA_D3_LB.<0)
EGR1_RA_D3_LB[idx_z] = 0.0








#Plotting Figures

# CD11b and CD38
figure("CD_RA")
a = plot(time_experimental,CD38_mean_array_RA,"k")
b = errorbar(CD38_RA_EXP[:,1],CD38_RA_EXP[:,2],CD38_RA_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD38_RA_LB),vec(CD38_RA_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(CD38_RA_LB_SE),vec(CD38_RA_UB_SE),color="dodgerblue",lw=2)
c = plot(time_experimental,CD11b_mean_array_RA,"k")
d = errorbar(CD11b_RA_EXP[:,1],CD11b_RA_EXP[:,2],CD11b_RA_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD11b_RA_LB),vec(CD11b_RA_UB),color="lightsalmon",lw=2)
fill_between(vec(time_experimental),vec(CD11b_RA_LB_SE),vec(CD11b_RA_UB_SE),color="tomato",lw=2)
e = plot(time_experimental,CD14_mean_array_RA,"k")
f = errorbar(CD14_RA_EXP[:,1],CD14_RA_EXP[:,2],CD14_RA_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD14_RA_LB),vec(CD14_RA_UB),color="lavenderblush",lw=2)
fill_between(vec(time_experimental),vec(CD14_RA_LB_SE),vec(CD14_RA_UB_SE),color="lavender",lw=2)

#legend([a;b;c;d],["Ensemble Mean CD38","Experimental CD38","Ensemble Mean CD11b","Experimental CD11b"])

# E2F
figure("G1G0_RA")
a = plot(time_experimental,G1G0_syn_RA,"k")
b = errorbar(G1G0_RA_EXP[:,1],G1G0_RA_EXP[:,2],G1G0_RA_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(G1G0_RA_LB),vec(G1G0_RA_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(G1G0_RA_LB_SE),vec(G1G0_RA_UB_SE),color="dodgerblue",lw=2)

figure("G1G0_RA2")
a = plot(time_experimental,G1G0_mean_array_RA,"k")
b = errorbar(G1G0_RA_EXP[:,1],G1G0_RA_EXP[:,2],G1G0_RA_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(G1G0_RA_LB2),vec(G1G0_RA_UB2),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(G1G0_RA_LB_SE2),vec(G1G0_RA_UB_SE2),color="dodgerblue",lw=2)



# CD11b and CD38
figure("CD_D3")
a = plot(time_experimental,CD38_mean_array_D3,"k")
b = errorbar(CD38_D3_EXP[:,1],CD38_D3_EXP[:,2],CD38_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD38_D3_LB),vec(CD38_D3_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(CD38_D3_LB_SE),vec(CD38_D3_UB_SE),color="dodgerblue",lw=2)
c = plot(time_experimental,CD11b_mean_array_D3,"k")
d = errorbar(CD11b_D3_EXP[:,1],CD11b_D3_EXP[:,2],CD11b_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD11b_D3_LB),vec(CD11b_D3_UB),color="lightsalmon",lw=2)
fill_between(vec(time_experimental),vec(CD11b_D3_LB_SE),vec(CD11b_D3_UB_SE),color="tomato",lw=2)
e = plot(time_experimental,CD14_mean_array_D3,"k")
f = errorbar(CD14_D3_EXP[:,1],CD14_D3_EXP[:,2],CD14_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD14_D3_LB),vec(CD14_D3_UB),color="lavenderblush",lw=2)
fill_between(vec(time_experimental),vec(CD14_D3_LB_SE),vec(CD14_D3_UB_SE),color="lavender",lw=2)

#legend([a;b;c;d],["Ensemble Mean CD38","Experimental CD38","Ensemble Mean CD11b","Experimental CD11b"])

# E2F
figure("G1G0_D3")
a = plot(time_experimental,G1G0_syn_D3,"k")
b = errorbar(G1G0_D3_EXP[:,1],G1G0_D3_EXP[:,2],G1G0_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(G1G0_D3_LB),vec(G1G0_D3_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(G1G0_D3_LB_SE),vec(G1G0_D3_UB_SE),color="dodgerblue",lw=2)
# E2F
figure("G1G0_D32")
a = plot(time_experimental,G1G0_mean_array_D3,"k")
b = errorbar(G1G0_D3_EXP[:,1],G1G0_D3_EXP[:,2],G1G0_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(G1G0_D3_LB2),vec(G1G0_D3_UB2),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(G1G0_D3_LB_SE2),vec(G1G0_D3_UB_SE2),color="dodgerblue",lw=2)



# CD11b and CD38
figure("CD_RA_D3")
a = plot(time_experimental,CD38_mean_array_RA_D3,"k")
b = errorbar(CD38_RA_D3_EXP[:,1],CD38_RA_D3_EXP[:,2],CD38_RA_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD38_RA_D3_LB),vec(CD38_RA_D3_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(CD38_RA_D3_LB_SE),vec(CD38_RA_D3_UB_SE),color="dodgerblue",lw=2)
c = plot(time_experimental,CD11b_mean_array_RA_D3,"k")
d = errorbar(CD11b_RA_D3_EXP[:,1],CD11b_RA_D3_EXP[:,2],CD11b_RA_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD11b_RA_D3_LB),vec(CD11b_RA_D3_UB),color="lightsalmon",lw=2)
fill_between(vec(time_experimental),vec(CD11b_RA_D3_LB_SE),vec(CD11b_RA_D3_UB_SE),color="tomato",lw=2)
e = plot(time_experimental,CD14_mean_array_RA_D3,"k")
f = errorbar(CD14_RA_D3_EXP[:,1],CD14_RA_D3_EXP[:,2],CD14_RA_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD14_RA_D3_LB),vec(CD14_RA_D3_UB),color="lavenderblush",lw=2)
fill_between(vec(time_experimental),vec(CD14_RA_D3_LB_SE),vec(CD14_RA_D3_UB_SE),color="lavender",lw=2)

#legend([a;b;c;d],["Ensemble Mean CD38","Experimental CD38","Ensemble Mean CD11b","Experimental CD11b"])


# E2F
figure("G1G0_RA_D3")
a = plot(time_experimental,G1G0_syn_RA_D3,"k")
b = errorbar(G1G0_RA_D3_EXP[:,1],G1G0_RA_D3_EXP[:,2],G1G0_RA_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(G1G0_RA_D3_LB),vec(G1G0_RA_D3_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(G1G0_RA_D3_LB_SE),vec(G1G0_RA_D3_UB_SE),color="dodgerblue",lw=2)
# E2F
figure("G1G0_RA_D3_2")
a = plot(time_experimental,G1G0_mean_array_RA_D3,"k")
b = errorbar(G1G0_RA_D3_EXP[:,1],G1G0_RA_D3_EXP[:,2],G1G0_RA_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(G1G0_RA_D3_LB2),vec(G1G0_RA_D3_UB2),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(G1G0_RA_D3_LB_SE2),vec(G1G0_RA_D3_UB_SE2),color="dodgerblue",lw=2)


# combined treatment figures
density = 0.5
figure("CD38_all_treatments")

c = plot(time_experimental,CD38_mean_array_D3,"k")
d = errorbar(CD38_D3_EXP[:,1],CD38_D3_EXP[:,2],CD38_D3_EXP[:,3], fmt = "o", color = "red")
c1 = fill_between(vec(time_experimental),vec(CD38_D3_LB),vec(CD38_D3_UB),color="lightsalmon",lw=2,alpha=1)
c2 = fill_between(vec(time_experimental),vec(CD38_D3_LB_SE),vec(CD38_D3_UB_SE),color="tomato",lw=2,alpha=1)

a1 = fill_between(vec(time_experimental),vec(CD38_RA_D3_LB),vec(CD38_RA_D3_UB),color="lightblue",lw=6,alpha=1)
a2 = fill_between(vec(time_experimental),vec(CD38_RA_D3_LB_SE),vec(CD38_RA_D3_UB_SE),color="dodgerblue",lw=5,alpha=1)
e1 = fill_between(vec(time_experimental),vec(CD38_RA_LB),vec(CD38_RA_UB),color=(221/255,200/255,221/255),lw=2,alpha=0.4)
e2 = fill_between(vec(time_experimental),vec(CD38_RA_LB_SE),vec(CD38_RA_UB_SE),color=(218/255,105/255,181/255),lw=2,alpha=0.4)
a = plot(time_experimental,CD38_mean_array_RA_D3,"k")
b = errorbar(CD38_RA_D3_EXP[:,1],CD38_RA_D3_EXP[:,2],CD38_RA_D3_EXP[:,3], fmt = "o", color = "blue")
e = plot(time_experimental,CD38_mean_array_RA,"k")
f = errorbar(CD38_RA_EXP[:,1],CD38_RA_EXP[:,2],CD38_RA_EXP[:,3], fmt = "o", color = "purple")

figure("CD11b_all_treatments")
a = plot(time_experimental,CD11b_mean_array_RA_D3,"k")
b = errorbar(CD11b_RA_D3_EXP[:,1],CD11b_RA_D3_EXP[:,2],CD11b_RA_D3_EXP[:,3], fmt = "o", color = "blue")
fill_between(vec(time_experimental),vec(CD11b_RA_D3_LB),vec(CD11b_RA_D3_UB),color="lightblue",lw=2,alpha=density)
fill_between(vec(time_experimental),vec(CD11b_RA_D3_LB_SE),vec(CD11b_RA_D3_UB_SE),color="dodgerblue",lw=2,alpha=density)
c = plot(time_experimental,CD11b_mean_array_D3,"k")
d = errorbar(CD11b_D3_EXP[:,1],CD11b_D3_EXP[:,2],CD11b_D3_EXP[:,3], fmt = "o", color = "red")
fill_between(vec(time_experimental),vec(CD11b_D3_LB),vec(CD11b_D3_UB),color="lightsalmon",lw=2,alpha=density)
fill_between(vec(time_experimental),vec(CD11b_D3_LB_SE),vec(CD11b_D3_UB_SE),color="tomato",lw=2,alpha=density)
e = plot(time_experimental,CD11b_mean_array_RA,"k")
f = errorbar(CD11b_RA_EXP[:,1],CD11b_RA_EXP[:,2],CD11b_RA_EXP[:,3], fmt = "o", color = "purple")
fill_between(vec(time_experimental),vec(CD11b_RA_LB),vec(CD11b_RA_UB),color="lavenderblush",lw=2,alpha=density)
fill_between(vec(time_experimental),vec(CD11b_RA_LB_SE),vec(CD11b_RA_UB_SE),color="lavender",lw=2,alpha=density)

figure("CD14_all_treatments")
a = plot(time_experimental,CD14_mean_array_RA_D3,"k")
b = errorbar(CD14_RA_D3_EXP[:,1],CD14_RA_D3_EXP[:,2],CD14_RA_D3_EXP[:,3], fmt = "o", color = "blue")
fill_between(vec(time_experimental),vec(CD14_RA_D3_LB),vec(CD14_RA_D3_UB),color="lightblue",lw=2,alpha=density)
fill_between(vec(time_experimental),vec(CD14_RA_D3_LB_SE),vec(CD14_RA_D3_UB_SE),color="dodgerblue",lw=2,alpha=density)
c = plot(time_experimental,CD14_mean_array_D3,"k")
d = errorbar(CD14_D3_EXP[:,1],CD14_D3_EXP[:,2],CD14_D3_EXP[:,3], fmt = "o", color = "red")
fill_between(vec(time_experimental),vec(CD14_D3_LB),vec(CD14_D3_UB),color="lightsalmon",lw=2,alpha=density)
fill_between(vec(time_experimental),vec(CD14_D3_LB_SE),vec(CD14_D3_UB_SE),color="tomato",lw=2,alpha=density)
e = plot(time_experimental,CD14_mean_array_RA,"k")
f = errorbar(CD14_RA_EXP[:,1],CD14_RA_EXP[:,2],CD14_RA_EXP[:,3], fmt = "o", color = "purple")
fill_between(vec(time_experimental),vec(CD14_RA_LB),vec(CD14_RA_UB),color="lavenderblush",lw=2,alpha=density)
fill_between(vec(time_experimental),vec(CD14_RA_LB_SE),vec(CD14_RA_UB_SE),color="lavender",lw=2,alpha=density)


figure("G1G0_all_treatments")
a = plot(time_experimental,G1G0_syn_RA,"k")
b = errorbar(G1G0_RA_EXP[:,1],G1G0_RA_EXP[:,2],G1G0_RA_EXP[:,3], fmt = "o", color = "blue")
fill_between(vec(time_experimental),vec(G1G0_RA_LB),vec(G1G0_RA_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(G1G0_RA_LB_SE),vec(G1G0_RA_UB_SE),color="dodgerblue",lw=2)
c = plot(time_experimental,G1G0_syn_D3,"k")
d = errorbar(G1G0_D3_EXP[:,1],G1G0_D3_EXP[:,2],G1G0_D3_EXP[:,3], fmt = "o", color = "red")
fill_between(vec(time_experimental),vec(G1G0_D3_LB),vec(G1G0_D3_UB),color="lightsalmon",lw=2)
fill_between(vec(time_experimental),vec(G1G0_D3_LB_SE),vec(G1G0_D3_UB_SE),color="tomato",lw=2)
e = plot(time_experimental,G1G0_syn_RA_D3,"k")
f = errorbar(G1G0_RA_D3_EXP[:,1],G1G0_RA_D3_EXP[:,2],G1G0_RA_D3_EXP[:,3], fmt = "o", color = "purple")
fill_between(vec(time_experimental),vec(G1G0_RA_D3_LB),vec(G1G0_RA_D3_UB),color="orchid",lw=2,alpha=0.2)
fill_between(vec(time_experimental),vec(G1G0_RA_D3_LB_SE),vec(G1G0_RA_D3_UB_SE),color="darkorchid",lw=2,alpha = 0.5)


x_sim_RA = [1:7:55;]
x_exp_RA = [2:7:55;]
x_sim_D3 = [3:7:55;]
x_exp_D3 = [4:7:55;]
x_sim_RA_D3 = [5:7:55;]
x_exp_RA_D3 = [6:7:55;]
x_blank = [7:7:55;]

y_sim_RA = [
    AhR_mean_data_RA[2,1]
    GIF1_mean_data_RA[2,1]
    EGR1_mean_data_RA[2,1]
    IRF1_mean_data_RA[2,1]
    CEBPa_mean_data_RA[2,1]
    PU1_mean_data_RA[2,1]
    P47Phox_mean_data_RA[2,1]
    OCT4_mean_data_RA[2,1]
]
y_sim_std_RA = [
    AhR_std_data_RA[2,1]
    GIF1_std_data_RA[2,1]
    EGR1_std_data_RA[2,1]
    IRF1_std_data_RA[2,1]
    CEBPa_std_data_RA[2,1]
    PU1_std_data_RA[2,1]
    P47Phox_std_data_RA[2,1]
    OCT4_std_data_RA[2,1]
]
y_exp_RA = [
  AhR_RA_EXP[2,2]
  GFI1_RA_EXP[2,2]
  EGR1_RA_EXP[2,2]
  IRF1_RA_EXP[2,2]
  CEBPa_RA_EXP[2,2]
  PU1_RA_EXP[2,2]
  P47Phox_RA_EXP[2,2]
  OCT4_RA_EXP[2,2]
]
y_exp_std_RA = [
  AhR_RA_EXP[2,3]
  GFI1_RA_EXP[2,3]
  EGR1_RA_EXP[2,3]
  IRF1_RA_EXP[2,3]
  CEBPa_RA_EXP[2,3]
  PU1_RA_EXP[2,3]
  P47Phox_RA_EXP[2,3]
  OCT4_RA_EXP[2,3]
]

y_sim_D3 = [
    AhR_mean_data_D3[2,1]
    GIF1_mean_data_D3[2,1]
    EGR1_mean_data_D3[2,1]
    IRF1_mean_data_D3[2,1]
    CEBPa_mean_data_D3[2,1]
    PU1_mean_data_D3[2,1]
    P47Phox_mean_data_D3[2,1]
    OCT4_mean_data_D3[2,1]
]
y_sim_std_D3 = [
    AhR_std_data_D3[2,1]
    GIF1_std_data_D3[2,1]
    EGR1_std_data_D3[2,1]
    IRF1_std_data_D3[2,1]
    CEBPa_std_data_D3[2,1]
    PU1_std_data_D3[2,1]
    P47Phox_std_data_D3[2,1]
    OCT4_std_data_D3[2,1]
]
y_exp_D3 = [
  AhR_D3_EXP[2,2]
  GFI1_D3_EXP[2,2]
  EGR1_D3_EXP[2,2]
  IRF1_D3_EXP[2,2]
  CEBPa_D3_EXP[2,2]
  PU1_D3_EXP[2,2]
  P47Phox_D3_EXP[2,2]
  OCT4_D3_EXP[2,2]
]
y_exp_std_D3 = [
  AhR_D3_EXP[2,3]
  GFI1_D3_EXP[2,3]
  EGR1_D3_EXP[2,3]
  IRF1_D3_EXP[2,3]
  CEBPa_D3_EXP[2,3]
  PU1_D3_EXP[2,3]
  P47Phox_D3_EXP[2,3]
  OCT4_D3_EXP[2,3]
]

y_sim_RA_D3 = [
    AhR_mean_data_RA_D3[2,1]
    GIF1_mean_data_RA_D3[2,1]
    EGR1_mean_data_RA_D3[2,1]
    IRF1_mean_data_RA_D3[2,1]
    CEBPa_mean_data_RA_D3[2,1]
    PU1_mean_data_RA_D3[2,1]
    P47Phox_mean_data_RA_D3[2,1]
    OCT4_mean_data_RA_D3[2,1]
]
y_sim_std_RA_D3 = [
    AhR_std_data_RA_D3[2,1]
    GIF1_std_data_RA_D3[2,1]
    EGR1_std_data_RA_D3[2,1]
    IRF1_std_data_RA_D3[2,1]
    CEBPa_std_data_RA_D3[2,1]
    PU1_std_data_RA_D3[2,1]
    P47Phox_std_data_RA_D3[2,1]
    OCT4_std_data_RA_D3[2,1]
]
y_exp_RA_D3 = [
  AhR_RA_D3_EXP[2,2]
  GFI1_RA_D3_EXP[2,2]
  EGR1_RA_D3_EXP[2,2]
  IRF1_RA_D3_EXP[2,2]
  CEBPa_RA_D3_EXP[2,2]
  PU1_RA_D3_EXP[2,2]
  0#P47Phox_RA_D3_EXP[2,2]
  OCT4_RA_D3_EXP[2,2]
]
y_exp_std_RA_D3 = [
  AhR_RA_D3_EXP[2,3]
  GFI1_RA_D3_EXP[2,3]
  EGR1_RA_D3_EXP[2,3]
  IRF1_RA_D3_EXP[2,3]
  CEBPa_RA_D3_EXP[2,3]
  PU1_RA_D3_EXP[2,3]
  0#P47Phox_RA_D3_EXP[2,3]
  OCT4_RA_D3_EXP[2,3]
]

#fig = figure("Expression1",figsize=(40,10))
fig,ax = plt[:subplots](figsize=(20,10))
a = bar(x_sim_RA,y_sim_RA,color=(185/255,216/255,250/255),align="center",alpha=1, yerr = y_sim_std_RA,ecolor = "k")
b = bar(x_sim_D3,y_sim_D3,color=(255/255,160/255,142/255),align="center",alpha=1, yerr = y_sim_std_D3,ecolor = "k")
c = bar(x_sim_RA_D3,y_sim_RA_D3,color=(221/255,200/255,221/255),align="center",alpha=1, yerr = y_sim_std_RA_D3,ecolor = "k")
e = bar(x_exp_RA,y_exp_RA,color=(165/255,219/255,255/255),align="center",alpha=1, yerr = y_exp_std_RA,ecolor = "k")
f = bar(x_exp_D3,y_exp_D3,color=(255/255,128/255,124/255),align="center",alpha=1, yerr = y_exp_std_D3,ecolor = "k")
g = bar(x_exp_RA_D3,y_exp_RA_D3,color=(218/255,165/255,211/255),align="center",alpha=1, yerr = y_exp_std_RA_D3,ecolor = "k")
plt[:ylim]([0,12])
plt[:xlim]([0,56])
x = vec(["AhR RA" "AhR D3" "AhR all" "GFI1 RA" "GFI1 D3" "GFI1 all" "EGR1 RA" "EGR1 D3" "EGR1 all" "IRF1 RA" "IRF1 D3" "IRF1 all" "CEBPa RA" "CEBPa D3" "CEBPa all" "PU1 RA" "PU1 D3" "PU1 all" "P47phox RA" "P47phox D3" "P47phox all" "OCT4 RA" "OCT4 D3" "OCT4 all"]')

#x = vec(["AhR RA" "AhR D3" "AhR RA D3" "GFI1 RA" "GFI1 D3" "GFI1 RA D3" "EGR1 RA" "EGR1 D3" "EGR1 RA D3" "IRF1 RA" "IRF1 D3" "IRF1 RA D3" "CEBPa RA" "CEBPa D3" "CEBPa RA D3" "PU1 RA" "PU1 D3" "PU1 RA D3" "P47phox RA" "P47phox D3" "P47phox RA D3" "OCT4 RA" "OCT4 D3" "OCT4 RA D3"]')
#x = vec(["AhR sim" "AhR exp" "GFI1 sim" "GFI1 exp" "EGR1 sim" "EGR1 exp" "IRF1 sim" "IRF1 exp" "CEBPa sim" "CEBPa exp" "PU1 sim" "PU1 exp" "P47phox sim" "P47phox exp" "OCT4 sim" "OCT4 exp"]')
ax[:set_xticks](sort([x_sim_RA;x_sim_D3;x_sim_RA_D3]+ones(length([x_sim_RA;x_sim_D3;x_sim_RA_D3]))*0.5))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
ax[:set_xticklabels](x,rotation=60)
