using PyPlot
using PyCall
time_experimental = collect(0:0.01:120)
iteration_number = 1000

CD11b_array_RA_scaled = readdlm("./plot_best/scaled_state_CD11b_RA.dat");
CD14_array_RA_scaled = readdlm("./plot_best/scaled_state_CD14_RA.dat");
CD38_array_RA_scaled = readdlm("./plot_best/scaled_state_CD38_RA.dat");


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


#================================================================
  randomly select a small subset of parameter sets from the ensemble so that the sample size of simulation is same as experiment
=#
CD38_RA_EXP_SIZE = [11;11;13;11]
CD14_RA_EXP_SIZE = [14;14;16;14]
CD11b_RA_EXP_SIZE = [14;14;16;13]
G1G0_RA_EXP_SIZE = [11;11;11;12]

EXP_SIZE = 3


(n_time,n_sample)=size(CD11b_array_RA_scaled)
# assign a random number to each sample -- used for random sampling
CD38_RA_EXP_SIZE = [11;11;13;11]
CD38_RA_EXP[:,3] = CD38_RA_EXP[:,3]./sqrt(CD38_RA_EXP_SIZE);
CD14_RA_EXP_SIZE = [14;14;16;14]
CD14_RA_EXP[:,3] = CD14_RA_EXP[:,3]./sqrt(CD14_RA_EXP_SIZE);
CD11b_RA_EXP_SIZE = [14;14;16;13]
CD11b_RA_EXP[:,3] = CD11b_RA_EXP[:,3]./sqrt(CD11b_RA_EXP_SIZE);

EXP_SIZE = 3
AhR_RA_EXP[:,3] = AhR_RA_EXP[:,3]./EXP_SIZE.^0.5
#P21_RA_EXP[:,3] = P21_RA_EXP[:,3]./EXP_SIZE.^0.5
GFI1_RA_EXP[:,3] = GFI1_RA_EXP[:,3]./EXP_SIZE.^0.5
CEBPa_RA_EXP[:,3] = CEBPa_RA_EXP[:,3]./EXP_SIZE.^0.5
PU1_RA_EXP[:,3] = PU1_RA_EXP[:,3]./EXP_SIZE.^0.5
P47Phox_RA_EXP[:,3] = P47Phox_RA_EXP[:,3]./EXP_SIZE.^0.5
OCT4_RA_EXP[:,3] = OCT4_RA_EXP[:,3]./EXP_SIZE.^0.5
IRF1_RA_EXP[:,3] = IRF1_RA_EXP[:,3]./EXP_SIZE.^0.5
EGR1_RA_EXP[:,3] = EGR1_RA_EXP[:,3]./EXP_SIZE.^0.5

# D3
CD38_D3_EXP_SIZE = [11;11;13;11]
CD38_D3_EXP[:,3] = CD38_D3_EXP[:,3]./sqrt(CD38_D3_EXP_SIZE);
CD14_D3_EXP_SIZE = [14;13;12;8]
CD14_D3_EXP[:,3] = CD14_D3_EXP[:,3]./sqrt(CD14_D3_EXP_SIZE);
CD11b_D3_EXP_SIZE = [14;14;16;13]
CD11b_D3_EXP[:,3] = CD11b_D3_EXP[:,3]./sqrt(CD11b_D3_EXP_SIZE);
G1G0_D3_EXP_SIZE = [11;11;11;12]
G1G0_D3_EXP[:,3] = G1G0_D3_EXP[:,3]./sqrt(G1G0_D3_EXP_SIZE);

EXP_SIZE = 3
AhR_D3_EXP[:,3] = AhR_D3_EXP[:,3]./EXP_SIZE.^0.5
#P21_D3_EXP[:,3] = P21_D3_EXP[:,3]./EXP_SIZE.^0.5
GFI1_D3_EXP[:,3] = GFI1_D3_EXP[:,3]./EXP_SIZE.^0.5
CEBPa_D3_EXP[:,3] = CEBPa_D3_EXP[:,3]./EXP_SIZE.^0.5
PU1_D3_EXP[:,3] = PU1_D3_EXP[:,3]./EXP_SIZE.^0.5
P47Phox_D3_EXP[:,3] = P47Phox_D3_EXP[:,3]./EXP_SIZE.^0.5
OCT4_D3_EXP[:,3] = OCT4_D3_EXP[:,3]./EXP_SIZE.^0.5
IRF1_D3_EXP[:,3] = IRF1_D3_EXP[:,3]./EXP_SIZE.^0.5
EGR1_D3_EXP[:,3] = EGR1_D3_EXP[:,3]./EXP_SIZE.^0.5

# RA+D3 ------------------------------------------------------------
CD38_RA_D3_EXP_SIZE = [11;10;10;9]
CD38_RA_D3_EXP[:,3] = CD38_RA_D3_EXP[:,3]./sqrt(CD38_RA_D3_EXP_SIZE);
CD14_RA_D3_EXP_SIZE = [14;12;11;6]
CD14_RA_D3_EXP[:,3] = CD14_RA_D3_EXP[:,3]./sqrt(CD14_RA_D3_EXP_SIZE);
CD11b_RA_D3_EXP_SIZE = [14;13;13;11]
CD11b_RA_D3_EXP[:,3] = CD11b_RA_D3_EXP[:,3]./sqrt(CD11b_RA_D3_EXP_SIZE);
G1G0_RA_D3_EXP_SIZE = [11;11;10;11]
G1G0_RA_D3_EXP[:,3] = G1G0_RA_D3_EXP[:,3]./sqrt(G1G0_RA_D3_EXP_SIZE);

EXP_SIZE = 3
AhR_RA_D3_EXP[:,3] = AhR_RA_D3_EXP[:,3]./EXP_SIZE.^0.5
#P21_RA_D3_EXP[:,3] = P21_RA_D3_EXP[:,3]./EXP_SIZE.^0.5
GFI1_RA_D3_EXP[:,3] = GFI1_RA_D3_EXP[:,3]./EXP_SIZE.^0.5
CEBPa_RA_D3_EXP[:,3] = CEBPa_RA_D3_EXP[:,3]./EXP_SIZE.^0.5
PU1_RA_D3_EXP[:,3] = PU1_RA_D3_EXP[:,3]./EXP_SIZE.^0.5
#P47Phox_RA_D3_EXP[:,3] = P47Phox_RA_D3_EXP[:,3]./EXP_SIZE.^0.5
OCT4_RA_D3_EXP[:,3] = OCT4_RA_D3_EXP[:,3]./EXP_SIZE.^0.5
IRF1_RA_D3_EXP[:,3] = IRF1_RA_D3_EXP[:,3]./EXP_SIZE.^0.5
EGR1_RA_D3_EXP[:,3] = EGR1_RA_D3_EXP[:,3]./EXP_SIZE.^0.5

# initiate archive arrays
CD38_mean_array_archive_RA = zeros(n_time)
CD38_std_array_archive_RA = zeros(n_time)
CD14_mean_array_archive_RA = zeros(n_time)
CD14_std_array_archive_RA = zeros(n_time)
CD11b_mean_array_archive_RA = zeros(n_time)
CD11b_std_array_archive_RA = zeros(n_time)

CD38_mean_data_archive_RA 	=	zeros(4)
CD38_std_data_archive_RA 	=	zeros(4)
CD14_mean_data_archive_RA 	=	zeros(4)
CD14_std_data_archive_RA 	=	zeros(4)
CD11b_mean_data_archive_RA 	=	zeros(4)
CD11b_std_data_archive_RA 	=	zeros(4)
AhR_mean_data_archive_RA 	=	zeros(2)
AhR_std_data_archive_RA 	=	zeros(2)
P47Phox_mean_data_archive_RA 	=	zeros(2)
P47Phox_std_data_archive_RA 	=	zeros(2)
IRF1_mean_data_archive_RA 	=	zeros(2)
IRF1_std_data_archive_RA 	=	zeros(2)
PU1_mean_data_archive_RA 	=	zeros(2)
PU1_std_data_archive_RA 	=	zeros(2)
E2F_mean_data_archive_RA 	=	zeros(4)
E2F_std_data_archive_RA 	=	zeros(4)
CEBPa_mean_data_archive_RA 	=	zeros(2)
CEBPa_std_data_archive_RA 	=	zeros(2)
OCT4_mean_data_archive_RA 	=	zeros(2)
OCT4_std_data_archive_RA 	=	zeros(2)
EGR1_mean_data_archive_RA 	=	zeros(2)
EGR1_std_data_archive_RA 	=	zeros(2)
GIF1_mean_data_archive_RA 	=	zeros(2)
GIF1_std_data_archive_RA 	=	zeros(2)

#D3
CD38_mean_array_archive_D3 = zeros(n_time)
CD38_std_array_archive_D3 = zeros(n_time)
CD14_mean_array_archive_D3 = zeros(n_time)
CD14_std_array_archive_D3 = zeros(n_time)
CD11b_mean_array_archive_D3 = zeros(n_time)
CD11b_std_array_archive_D3 = zeros(n_time)

CD38_mean_data_archive_D3 	=	zeros(4)
CD38_std_data_archive_D3 	=	zeros(4)
CD14_mean_data_archive_D3 	=	zeros(4)
CD14_std_data_archive_D3 	=	zeros(4)
CD11b_mean_data_archive_D3 	=	zeros(4)
CD11b_std_data_archive_D3 	=	zeros(4)
AhR_mean_data_archive_D3 	=	zeros(2)
AhR_std_data_archive_D3 	=	zeros(2)
P47Phox_mean_data_archive_D3 	=	zeros(2)
P47Phox_std_data_archive_D3 	=	zeros(2)
IRF1_mean_data_archive_D3 	=	zeros(2)
IRF1_std_data_archive_D3 	=	zeros(2)
PU1_mean_data_archive_D3 	=	zeros(2)
PU1_std_data_archive_D3 	=	zeros(2)
E2F_mean_data_archive_D3 	=	zeros(4)
E2F_std_data_archive_D3 	=	zeros(4)
CEBPa_mean_data_archive_D3 	=	zeros(2)
CEBPa_std_data_archive_D3 	=	zeros(2)
OCT4_mean_data_archive_D3 	=	zeros(2)
OCT4_std_data_archive_D3 	=	zeros(2)
EGR1_mean_data_archive_D3 	=	zeros(2)
EGR1_std_data_archive_D3 	=	zeros(2)
GIF1_mean_data_archive_D3 	=	zeros(2)
GIF1_std_data_archive_D3 	=	zeros(2)

# RA D3
CD38_mean_array_archive_RA_D3 = zeros(n_time)
CD38_std_array_archive_RA_D3 = zeros(n_time)
CD14_mean_array_archive_RA_D3 = zeros(n_time)
CD14_std_array_archive_RA_D3 = zeros(n_time)
CD11b_mean_array_archive_RA_D3 = zeros(n_time)
CD11b_std_array_archive_RA_D3 = zeros(n_time)

CD38_mean_data_archive_RA_D3 	=	zeros(4)
CD38_std_data_archive_RA_D3 	=	zeros(4)
CD14_mean_data_archive_RA_D3 	=	zeros(4)
CD14_std_data_archive_RA_D3 	=	zeros(4)
CD11b_mean_data_archive_RA_D3 	=	zeros(4)
CD11b_std_data_archive_RA_D3 	=	zeros(4)
AhR_mean_data_archive_RA_D3 	=	zeros(2)
AhR_std_data_archive_RA_D3 	=	zeros(2)
P47Phox_mean_data_archive_RA_D3 	=	zeros(2)
P47Phox_std_data_archive_RA_D3 	=	zeros(2)
IRF1_mean_data_archive_RA_D3 	=	zeros(2)
IRF1_std_data_archive_RA_D3 	=	zeros(2)
PU1_mean_data_archive_RA_D3 	=	zeros(2)
PU1_std_data_archive_RA_D3 	=	zeros(2)
E2F_mean_data_archive_RA_D3 	=	zeros(4)
E2F_std_data_archive_RA_D3 	=	zeros(4)
CEBPa_mean_data_archive_RA_D3 	=	zeros(2)
CEBPa_std_data_archive_RA_D3 	=	zeros(2)
OCT4_mean_data_archive_RA_D3 	=	zeros(2)
OCT4_std_data_archive_RA_D3 	=	zeros(2)
EGR1_mean_data_archive_RA_D3 	=	zeros(2)
EGR1_std_data_archive_RA_D3 	=	zeros(2)
GIF1_mean_data_archive_RA_D3 	=	zeros(2)
GIF1_std_data_archive_RA_D3 	=	zeros(2)

for sampling_index = [1:iteration_number;]

  # random sampling
  sample_index_adjusted_data = rand(1:n_sample,14,1)
  sample_index_adjusted_CD38 = sample_index_adjusted_data[1:11]
  sample_index_adjusted_CD14 = vec(sample_index_adjusted_data)
  sample_index_adjusted_CD11b = vec(sample_index_adjusted_data)
  sample_index_adjusted = sample_index_adjusted_data[1:3]

  CD11b_array_RA_scaled_adjusted 	=	CD11b_array_RA_scaled[:,sample_index_adjusted_CD11b]
  CD14_array_RA_scaled_adjusted 	=	CD14_array_RA_scaled[:,sample_index_adjusted_CD14]
  CD38_array_RA_scaled_adjusted 	=	CD38_array_RA_scaled[:,sample_index_adjusted_CD38]


  CD11b_array_D3_scaled_adjusted 	=	CD11b_array_D3_scaled[:,sample_index_adjusted_CD11b]
  CD14_array_D3_scaled_adjusted 	=	CD14_array_D3_scaled[:,sample_index_adjusted_CD14]
  CD38_array_D3_scaled_adjusted 	=	CD38_array_D3_scaled[:,sample_index_adjusted_CD38]


  CD11b_array_RA_D3_scaled_adjusted 	=	CD11b_array_RA_D3_scaled[:,sample_index_adjusted_CD11b]
  CD14_array_RA_D3_scaled_adjusted 	=	CD14_array_RA_D3_scaled[:,sample_index_adjusted_CD14]
  CD38_array_RA_D3_scaled_adjusted 	=	CD38_array_RA_D3_scaled[:,sample_index_adjusted_CD38]



  # data
  CD11b_data_RA_scaled_adjusted 	=	CD11b_data_RA_scaled[:,sample_index_adjusted]
  CD14_data_RA_scaled_adjusted 	=	CD14_data_RA_scaled[:,sample_index_adjusted]
  CD38_data_RA_scaled_adjusted 	=	CD38_data_RA_scaled[:,sample_index_adjusted]
  AhR_data_RA_scaled_adjusted 	=	AhR_data_RA_scaled[:,sample_index_adjusted]
  P47Phox_data_RA_scaled_adjusted 	=	P47Phox_data_RA_scaled[:,sample_index_adjusted]
  IRF1_data_RA_scaled_adjusted 	=	IRF1_data_RA_scaled[:,sample_index_adjusted]
  EGR1_data_RA_scaled_adjusted 	=	EGR1_data_RA_scaled[:,sample_index_adjusted]
  PU1_data_RA_scaled_adjusted 	=	PU1_data_RA_scaled[:,sample_index_adjusted]
  GIF1_data_RA_scaled_adjusted 	=	GIF1_data_RA_scaled[:,sample_index_adjusted]
  E2F_data_RA_scaled_adjusted 	=	E2F_data_RA_scaled[:,sample_index_adjusted]
  CEBPa_data_RA_scaled_adjusted 	=	CEBPa_data_RA_scaled[:,sample_index_adjusted]
  OCT4_data_RA_scaled_adjusted 	=	OCT4_data_RA_scaled[:,sample_index_adjusted]

  CD11b_data_D3_scaled_adjusted 	=	CD11b_data_D3_scaled[:,sample_index_adjusted]
  CD14_data_D3_scaled_adjusted 	=	CD14_data_D3_scaled[:,sample_index_adjusted]
  CD38_data_D3_scaled_adjusted 	=	CD38_data_D3_scaled[:,sample_index_adjusted]
  AhR_data_D3_scaled_adjusted 	=	AhR_data_D3_scaled[:,sample_index_adjusted]
  P47Phox_data_D3_scaled_adjusted 	=	P47Phox_data_D3_scaled[:,sample_index_adjusted]
  IRF1_data_D3_scaled_adjusted 	=	IRF1_data_D3_scaled[:,sample_index_adjusted]
  EGR1_data_D3_scaled_adjusted 	=	EGR1_data_D3_scaled[:,sample_index_adjusted]
  PU1_data_D3_scaled_adjusted 	=	PU1_data_D3_scaled[:,sample_index_adjusted]
  GIF1_data_D3_scaled_adjusted 	=	GIF1_data_D3_scaled[:,sample_index_adjusted]
  E2F_data_D3_scaled_adjusted 	=	E2F_data_D3_scaled[:,sample_index_adjusted]
  CEBPa_data_D3_scaled_adjusted 	=	CEBPa_data_D3_scaled[:,sample_index_adjusted]
  OCT4_data_D3_scaled_adjusted 	=	OCT4_data_D3_scaled[:,sample_index_adjusted]

  CD11b_data_RA_D3_scaled_adjusted 	=	CD11b_data_RA_D3_scaled[:,sample_index_adjusted]
  CD14_data_RA_D3_scaled_adjusted 	=	CD14_data_RA_D3_scaled[:,sample_index_adjusted]
  CD38_data_RA_D3_scaled_adjusted 	=	CD38_data_RA_D3_scaled[:,sample_index_adjusted]
  AhR_data_RA_D3_scaled_adjusted 	=	AhR_data_RA_D3_scaled[:,sample_index_adjusted]
  P47Phox_data_RA_D3_scaled_adjusted 	=	P47Phox_data_RA_D3_scaled[:,sample_index_adjusted]
  IRF1_data_RA_D3_scaled_adjusted 	=	IRF1_data_RA_D3_scaled[:,sample_index_adjusted]
  EGR1_data_RA_D3_scaled_adjusted 	=	EGR1_data_RA_D3_scaled[:,sample_index_adjusted]
  PU1_data_RA_D3_scaled_adjusted 	=	PU1_data_RA_D3_scaled[:,sample_index_adjusted]
  GIF1_data_RA_D3_scaled_adjusted 	=	GIF1_data_RA_D3_scaled[:,sample_index_adjusted]
  E2F_data_RA_D3_scaled_adjusted 	=	E2F_data_RA_D3_scaled[:,sample_index_adjusted]
  CEBPa_data_RA_D3_scaled_adjusted 	=	CEBPa_data_RA_D3_scaled[:,sample_index_adjusted]
  OCT4_data_RA_D3_scaled_adjusted 	=	OCT4_data_RA_D3_scaled[:,sample_index_adjusted]


  #=
  =================================================================#


  # convert experimental standard deviation into standard errors -------------------------


  #--------------------------------------------------------------------
  # What is the size of the data?
  (number_of_time,number_of_samples) = size(CD38_array_RA_scaled_adjusted);

  # calculate mean ---------------------------------------------------------
  # for RA
  CD38_mean_array_RA =  mean(CD38_array_RA_scaled_adjusted,2)
  CD38_std_array_RA = std(CD38_array_RA_scaled_adjusted,2)
  CD14_mean_array_RA =  mean(CD14_array_RA_scaled_adjusted,2)
  CD14_std_array_RA = std(CD14_array_RA_scaled_adjusted,2)
  CD11b_mean_array_RA =  mean(CD11b_array_RA_scaled_adjusted,2)
  CD11b_std_array_RA = std(CD11b_array_RA_scaled_adjusted,2)


  CD38_mean_data_RA =  mean(CD38_data_RA_scaled_adjusted,2)
  CD38_std_data_RA = std(CD38_data_RA_scaled_adjusted,2)
  CD14_mean_data_RA =  mean(CD14_data_RA_scaled_adjusted,2)
  CD14_std_data_RA = std(CD14_data_RA_scaled_adjusted,2)
  CD11b_mean_data_RA =  mean(CD11b_data_RA_scaled_adjusted,2)
  CD11b_std_data_RA = std(CD11b_data_RA_scaled_adjusted,2)
  AhR_mean_data_RA =  mean(AhR_data_RA_scaled_adjusted,2)
  AhR_std_data_RA = std(AhR_data_RA_scaled_adjusted,2)
  P47Phox_mean_data_RA =  mean(P47Phox_data_RA_scaled_adjusted,2)
  P47Phox_std_data_RA = std(P47Phox_data_RA_scaled_adjusted,2)
  IRF1_mean_data_RA =  mean(IRF1_data_RA_scaled_adjusted,2)
  IRF1_std_data_RA = std(IRF1_data_RA_scaled_adjusted,2)
  PU1_mean_data_RA =  mean(PU1_data_RA_scaled_adjusted,2)
  PU1_std_data_RA = std(PU1_data_RA_scaled_adjusted,2)
  E2F_mean_data_RA =  mean(E2F_data_RA_scaled_adjusted,2)
  E2F_std_data_RA = std(E2F_data_RA_scaled_adjusted,2)
  CEBPa_mean_data_RA =  mean(CEBPa_data_RA_scaled_adjusted,2)
  CEBPa_std_data_RA = std(CEBPa_data_RA_scaled_adjusted,2)
  OCT4_mean_data_RA =  mean(OCT4_data_RA_scaled_adjusted,2)
  OCT4_std_data_RA = std(OCT4_data_RA_scaled_adjusted,2)
  EGR1_mean_data_RA =  mean(EGR1_data_RA_scaled_adjusted,2)
  EGR1_std_data_RA = std(EGR1_data_RA_scaled_adjusted,2)
  GIF1_mean_data_RA =  mean(GIF1_data_RA_scaled_adjusted,2)
  GIF1_std_data_RA = std(GIF1_data_RA_scaled_adjusted,2)

  # for D3 -------------------------------------------------------------------------------------------------------

  # calculate mean
  CD38_mean_array_D3 =  mean(CD38_array_D3_scaled_adjusted,2)
  CD38_std_array_D3 = std(CD38_array_D3_scaled_adjusted,2)
  CD14_mean_array_D3 =  mean(CD14_array_D3_scaled_adjusted,2)
  CD14_std_array_D3 = std(CD14_array_D3_scaled_adjusted,2)
  CD11b_mean_array_D3 =  mean(CD11b_array_D3_scaled_adjusted,2)
  CD11b_std_array_D3 = std(CD11b_array_D3_scaled_adjusted,2)


  CD38_mean_data_D3 =  mean(CD38_data_D3_scaled_adjusted,2)
  CD38_std_data_D3 = std(CD38_data_D3_scaled_adjusted,2)
  CD14_mean_data_D3 =  mean(CD14_data_D3_scaled_adjusted,2)
  CD14_std_data_D3 = std(CD14_data_D3_scaled_adjusted,2)
  CD11b_mean_data_D3 =  mean(CD11b_data_D3_scaled_adjusted,2)
  CD11b_std_data_D3 = std(CD11b_data_D3_scaled_adjusted,2)
  AhR_mean_data_D3 =  mean(AhR_data_D3_scaled_adjusted,2)
  AhR_std_data_D3 = std(AhR_data_D3_scaled_adjusted,2)
  P47Phox_mean_data_D3 =  mean(P47Phox_data_D3_scaled_adjusted,2)
  P47Phox_std_data_D3 = std(P47Phox_data_D3_scaled_adjusted,2)
  IRF1_mean_data_D3 =  mean(IRF1_data_D3_scaled_adjusted,2)
  IRF1_std_data_D3 = std(IRF1_data_D3_scaled_adjusted,2)
  PU1_mean_data_D3 =  mean(PU1_data_D3_scaled_adjusted,2)
  PU1_std_data_D3 = std(PU1_data_D3_scaled_adjusted,2)
  E2F_mean_data_D3 =  mean(E2F_data_D3_scaled_adjusted,2)
  E2F_std_data_D3 = std(E2F_data_D3_scaled_adjusted,2)
  CEBPa_mean_data_D3 =  mean(CEBPa_data_D3_scaled_adjusted,2)
  CEBPa_std_data_D3 = std(CEBPa_data_D3_scaled_adjusted,2)
  OCT4_mean_data_D3 =  mean(OCT4_data_D3_scaled_adjusted,2)
  OCT4_std_data_D3 = std(OCT4_data_D3_scaled_adjusted,2)
  EGR1_mean_data_D3 =  mean(EGR1_data_D3_scaled_adjusted,2)
  EGR1_std_data_D3 = std(EGR1_data_D3_scaled_adjusted,2)
  GIF1_mean_data_D3 =  mean(GIF1_data_D3_scaled_adjusted,2)
  GIF1_std_data_D3 = std(GIF1_data_D3_scaled_adjusted,2)

  # for RA_D3-----------------------------------------------------------------------
  # calculate mean
  CD38_mean_array_RA_D3 =  mean(CD38_array_RA_D3_scaled_adjusted,2)
  CD38_std_array_RA_D3 = std(CD38_array_RA_D3_scaled_adjusted,2)
  CD14_mean_array_RA_D3 =  mean(CD14_array_RA_D3_scaled_adjusted,2)
  CD14_std_array_RA_D3 = std(CD14_array_RA_D3_scaled_adjusted,2)
  CD11b_mean_array_RA_D3 =  mean(CD11b_array_RA_D3_scaled_adjusted,2)
  CD11b_std_array_RA_D3 = std(CD11b_array_RA_D3_scaled_adjusted,2)

  CD38_mean_data_RA_D3 =  mean(CD38_data_RA_D3_scaled_adjusted,2)
  CD38_std_data_RA_D3 = std(CD38_data_RA_D3_scaled_adjusted,2)
  CD14_mean_data_RA_D3 =  mean(CD14_data_RA_D3_scaled_adjusted,2)
  CD14_std_data_RA_D3 = std(CD14_data_RA_D3_scaled_adjusted,2)
  CD11b_mean_data_RA_D3 =  mean(CD11b_data_RA_D3_scaled_adjusted,2)
  CD11b_std_data_RA_D3 = std(CD11b_data_RA_D3_scaled_adjusted,2)
  AhR_mean_data_RA_D3 =  mean(AhR_data_RA_D3_scaled_adjusted,2)
  AhR_std_data_RA_D3 = std(AhR_data_RA_D3_scaled_adjusted,2)
  P47Phox_mean_data_RA_D3 =  mean(P47Phox_data_RA_D3_scaled_adjusted,2)
  P47Phox_std_data_RA_D3 = std(P47Phox_data_RA_D3_scaled_adjusted,2)
  IRF1_mean_data_RA_D3 =  mean(IRF1_data_RA_D3_scaled_adjusted,2)
  IRF1_std_data_RA_D3 = std(IRF1_data_RA_D3_scaled_adjusted,2)
  PU1_mean_data_RA_D3 =  mean(PU1_data_RA_D3_scaled_adjusted,2)
  PU1_std_data_RA_D3 = std(PU1_data_RA_D3_scaled_adjusted,2)
  E2F_mean_data_RA_D3 =  mean(E2F_data_RA_D3_scaled_adjusted,2)
  E2F_std_data_RA_D3 = std(E2F_data_RA_D3_scaled_adjusted,2)
  CEBPa_mean_data_RA_D3 =  mean(CEBPa_data_RA_D3_scaled_adjusted,2)
  CEBPa_std_data_RA_D3 = std(CEBPa_data_RA_D3_scaled_adjusted,2)
  OCT4_mean_data_RA_D3 =  mean(OCT4_data_RA_D3_scaled_adjusted,2)
  OCT4_std_data_RA_D3 = std(OCT4_data_RA_D3_scaled_adjusted,2)
  EGR1_mean_data_RA_D3 =  mean(EGR1_data_RA_D3_scaled_adjusted,2)
  EGR1_std_data_RA_D3 = std(EGR1_data_RA_D3_scaled_adjusted,2)
  GIF1_mean_data_RA_D3 =  mean(GIF1_data_RA_D3_scaled_adjusted,2)
  GIF1_std_data_RA_D3 = std(GIF1_data_RA_D3_scaled_adjusted,2)


  # appending to archive
  CD38_mean_array_archive_RA 	=	[CD38_mean_array_archive_RA CD38_mean_array_RA]
  CD38_std_array_archive_RA 	=	[CD38_std_array_archive_RA CD38_std_array_RA]
  CD14_mean_array_archive_RA 	=	[CD14_mean_array_archive_RA CD14_mean_array_RA]
  CD14_std_array_archive_RA 	=	[CD14_std_array_archive_RA CD14_std_array_RA]
  CD11b_mean_array_archive_RA 	=	[CD11b_mean_array_archive_RA CD11b_mean_array_RA]
  CD11b_std_array_archive_RA 	=	[CD11b_std_array_archive_RA CD11b_std_array_RA]

  CD38_mean_data_archive_RA 	=	[CD38_mean_data_archive_RA CD38_mean_data_RA]
  CD38_std_data_archive_RA 	=	[CD38_std_data_archive_RA CD38_std_data_RA]
  CD14_mean_data_archive_RA 	=	[CD14_mean_data_archive_RA CD14_mean_data_RA]
  CD14_std_data_archive_RA 	=	[CD14_std_data_archive_RA CD14_std_data_RA]
  CD11b_mean_data_archive_RA 	=	[CD11b_mean_data_archive_RA CD11b_mean_data_RA]
  CD11b_std_data_archive_RA 	=	[CD11b_std_data_archive_RA CD11b_std_data_RA]
  AhR_mean_data_archive_RA 	=	[AhR_mean_data_archive_RA AhR_mean_data_RA]
  AhR_std_data_archive_RA 	=	[AhR_std_data_archive_RA AhR_std_data_RA]
  P47Phox_mean_data_archive_RA 	=	[P47Phox_mean_data_archive_RA P47Phox_mean_data_RA]
  P47Phox_std_data_archive_RA 	=	[P47Phox_std_data_archive_RA P47Phox_std_data_RA]
  IRF1_mean_data_archive_RA 	=	[IRF1_mean_data_archive_RA IRF1_mean_data_RA]
  IRF1_std_data_archive_RA 	=	[IRF1_std_data_archive_RA IRF1_std_data_RA]
  PU1_mean_data_archive_RA 	=	[PU1_mean_data_archive_RA PU1_mean_data_RA]
  PU1_std_data_archive_RA 	=	[PU1_std_data_archive_RA PU1_std_data_RA]
  E2F_mean_data_archive_RA 	=	[E2F_mean_data_archive_RA E2F_mean_data_RA]
  E2F_std_data_archive_RA 	=	[E2F_std_data_archive_RA E2F_std_data_RA]
  CEBPa_mean_data_archive_RA 	=	[CEBPa_mean_data_archive_RA CEBPa_mean_data_RA]
  CEBPa_std_data_archive_RA 	=	[CEBPa_std_data_archive_RA CEBPa_std_data_RA]
  OCT4_mean_data_archive_RA 	=	[OCT4_mean_data_archive_RA OCT4_mean_data_RA]
  OCT4_std_data_archive_RA 	=	[OCT4_std_data_archive_RA OCT4_std_data_RA]
  EGR1_mean_data_archive_RA 	=	[EGR1_mean_data_archive_RA EGR1_mean_data_RA]
  EGR1_std_data_archive_RA 	=	[EGR1_std_data_archive_RA EGR1_std_data_RA]
  GIF1_mean_data_archive_RA 	=	[GIF1_mean_data_archive_RA GIF1_mean_data_RA]
  GIF1_std_data_archive_RA 	=	[GIF1_std_data_archive_RA GIF1_std_data_RA]

  CD38_mean_array_archive_D3 	=	[CD38_mean_array_archive_D3 CD38_mean_array_D3]
  CD38_std_array_archive_D3 	=	[CD38_std_array_archive_D3 CD38_std_array_D3]
  CD14_mean_array_archive_D3 	=	[CD14_mean_array_archive_D3 CD14_mean_array_D3]
  CD14_std_array_archive_D3 	=	[CD14_std_array_archive_D3 CD14_std_array_D3]
  CD11b_mean_array_archive_D3 	=	[CD11b_mean_array_archive_D3 CD11b_mean_array_D3]
  CD11b_std_array_archive_D3 	=	[CD11b_std_array_archive_D3 CD11b_std_array_D3]

  CD38_mean_data_archive_D3 	=	[CD38_mean_data_archive_D3 CD38_mean_data_D3]
  CD38_std_data_archive_D3 	=	[CD38_std_data_archive_D3 CD38_std_data_D3]
  CD14_mean_data_archive_D3 	=	[CD14_mean_data_archive_D3 CD14_mean_data_D3]
  CD14_std_data_archive_D3 	=	[CD14_std_data_archive_D3 CD14_std_data_D3]
  CD11b_mean_data_archive_D3 	=	[CD11b_mean_data_archive_D3 CD11b_mean_data_D3]
  CD11b_std_data_archive_D3 	=	[CD11b_std_data_archive_D3 CD11b_std_data_D3]
  AhR_mean_data_archive_D3 	=	[AhR_mean_data_archive_D3 AhR_mean_data_D3]
  AhR_std_data_archive_D3 	=	[AhR_std_data_archive_D3 AhR_std_data_D3]
  P47Phox_mean_data_archive_D3 	=	[P47Phox_mean_data_archive_D3 P47Phox_mean_data_D3]
  P47Phox_std_data_archive_D3 	=	[P47Phox_std_data_archive_D3 P47Phox_std_data_D3]
  IRF1_mean_data_archive_D3 	=	[IRF1_mean_data_archive_D3 IRF1_mean_data_D3]
  IRF1_std_data_archive_D3 	=	[IRF1_std_data_archive_D3 IRF1_std_data_D3]
  PU1_mean_data_archive_D3 	=	[PU1_mean_data_archive_D3 PU1_mean_data_D3]
  PU1_std_data_archive_D3 	=	[PU1_std_data_archive_D3 PU1_std_data_D3]
  E2F_mean_data_archive_D3 	=	[E2F_mean_data_archive_D3 E2F_mean_data_D3]
  E2F_std_data_archive_D3 	=	[E2F_std_data_archive_D3 E2F_std_data_D3]
  CEBPa_mean_data_archive_D3 	=	[CEBPa_mean_data_archive_D3 CEBPa_mean_data_D3]
  CEBPa_std_data_archive_D3 	=	[CEBPa_std_data_archive_D3 CEBPa_std_data_D3]
  OCT4_mean_data_archive_D3 	=	[OCT4_mean_data_archive_D3 OCT4_mean_data_D3]
  OCT4_std_data_archive_D3 	=	[OCT4_std_data_archive_D3 OCT4_std_data_D3]
  EGR1_mean_data_archive_D3 	=	[EGR1_mean_data_archive_D3 EGR1_mean_data_D3]
  EGR1_std_data_archive_D3 	=	[EGR1_std_data_archive_D3 EGR1_std_data_D3]
  GIF1_mean_data_archive_D3 	=	[GIF1_mean_data_archive_D3 GIF1_mean_data_D3]
  GIF1_std_data_archive_D3 	=	[GIF1_std_data_archive_D3 GIF1_std_data_D3]

      # RA D3
  CD38_mean_array_archive_RA_D3 	=	[CD38_mean_array_archive_RA_D3 CD38_mean_array_RA_D3]
  CD38_std_array_archive_RA_D3 	=	[CD38_std_array_archive_RA_D3 CD38_std_array_RA_D3]
  CD14_mean_array_archive_RA_D3 	=	[CD14_mean_array_archive_RA_D3 CD14_mean_array_RA_D3]
  CD14_std_array_archive_RA_D3 	=	[CD14_std_array_archive_RA_D3 CD14_std_array_RA_D3]
  CD11b_mean_array_archive_RA_D3 	=	[CD11b_mean_array_archive_RA_D3 CD11b_mean_array_RA_D3]
  CD11b_std_array_archive_RA_D3 	=	[CD11b_std_array_archive_RA_D3 CD11b_std_array_RA_D3]

  CD38_mean_data_archive_RA_D3 	=	[CD38_mean_data_archive_RA_D3 CD38_mean_data_RA_D3]
  CD38_std_data_archive_RA_D3 	=	[CD38_std_data_archive_RA_D3 CD38_std_data_RA_D3]
  CD14_mean_data_archive_RA_D3 	=	[CD14_mean_data_archive_RA_D3 CD14_mean_data_RA_D3]
  CD14_std_data_archive_RA_D3 	=	[CD14_std_data_archive_RA_D3 CD14_std_data_RA_D3]
  CD11b_mean_data_archive_RA_D3 	=	[CD11b_mean_data_archive_RA_D3 CD11b_mean_data_RA_D3]
  CD11b_std_data_archive_RA_D3 	=	[CD11b_std_data_archive_RA_D3 CD11b_std_data_RA_D3]
  AhR_mean_data_archive_RA_D3 	=	[AhR_mean_data_archive_RA_D3 AhR_mean_data_RA_D3]
  AhR_std_data_archive_RA_D3 	=	[AhR_std_data_archive_RA_D3 AhR_std_data_RA_D3]
  P47Phox_mean_data_archive_RA_D3 	=	[P47Phox_mean_data_archive_RA_D3 P47Phox_mean_data_RA_D3]
  P47Phox_std_data_archive_RA_D3 	=	[P47Phox_std_data_archive_RA_D3 P47Phox_std_data_RA_D3]
  IRF1_mean_data_archive_RA_D3 	=	[IRF1_mean_data_archive_RA_D3 IRF1_mean_data_RA_D3]
  IRF1_std_data_archive_RA_D3 	=	[IRF1_std_data_archive_RA_D3 IRF1_std_data_RA_D3]
  PU1_mean_data_archive_RA_D3 	=	[PU1_mean_data_archive_RA_D3 PU1_mean_data_RA_D3]
  PU1_std_data_archive_RA_D3 	=	[PU1_std_data_archive_RA_D3 PU1_std_data_RA_D3]
  E2F_mean_data_archive_RA_D3 	=	[E2F_mean_data_archive_RA_D3 E2F_mean_data_RA_D3]
  E2F_std_data_archive_RA_D3 	=	[E2F_std_data_archive_RA_D3 E2F_std_data_RA_D3]
  CEBPa_mean_data_archive_RA_D3 	=	[CEBPa_mean_data_archive_RA_D3 CEBPa_mean_data_RA_D3]
  CEBPa_std_data_archive_RA_D3 	=	[CEBPa_std_data_archive_RA_D3 CEBPa_std_data_RA_D3]
  OCT4_mean_data_archive_RA_D3 	=	[OCT4_mean_data_archive_RA_D3 OCT4_mean_data_RA_D3]
  OCT4_std_data_archive_RA_D3 	=	[OCT4_std_data_archive_RA_D3 OCT4_std_data_RA_D3]
  EGR1_mean_data_archive_RA_D3 	=	[EGR1_mean_data_archive_RA_D3 EGR1_mean_data_RA_D3]
  EGR1_std_data_archive_RA_D3 	=	[EGR1_std_data_archive_RA_D3 EGR1_std_data_RA_D3]
  GIF1_mean_data_archive_RA_D3 	=	[GIF1_mean_data_archive_RA_D3 GIF1_mean_data_RA_D3]
  GIF1_std_data_archive_RA_D3 	=	[GIF1_std_data_archive_RA_D3 GIF1_std_data_RA_D3]

end # end main loop of sampling
# get rid of zeros from INITIALIZATION
CD38_std_array_archive_RA = CD38_std_array_archive_RA[:,2:end]
CD14_mean_array_archive_RA = CD14_mean_array_archive_RA[:,2:end]
CD14_std_array_archive_RA = CD14_std_array_archive_RA[:,2:end]
CD11b_mean_array_archive_RA = CD11b_mean_array_archive_RA[:,2:end]
CD11b_std_array_archive_RA = CD11b_std_array_archive_RA[:,2:end]

CD38_mean_data_archive_RA = CD38_mean_data_archive_RA[:,2:end]
CD38_std_data_archive_RA = CD38_std_data_archive_RA[:,2:end]
CD14_mean_data_archive_RA = CD14_mean_data_archive_RA[:,2:end]
CD14_std_data_archive_RA = CD14_std_data_archive_RA[:,2:end]
CD11b_mean_data_archive_RA = CD11b_mean_data_archive_RA[:,2:end]
CD11b_std_data_archive_RA = CD11b_std_data_archive_RA[:,2:end]
AhR_mean_data_archive_RA = AhR_mean_data_archive_RA[:,2:end]
AhR_std_data_archive_RA = AhR_std_data_archive_RA[:,2:end]
P47Phox_mean_data_archive_RA = P47Phox_mean_data_archive_RA[:,2:end]
P47Phox_std_data_archive_RA = P47Phox_std_data_archive_RA[:,2:end]
IRF1_mean_data_archive_RA = IRF1_mean_data_archive_RA[:,2:end]
IRF1_std_data_archive_RA = IRF1_std_data_archive_RA[:,2:end]
PU1_mean_data_archive_RA = PU1_mean_data_archive_RA[:,2:end]
PU1_std_data_archive_RA = PU1_std_data_archive_RA[:,2:end]
E2F_mean_data_archive_RA = E2F_mean_data_archive_RA[:,2:end]
E2F_std_data_archive_RA = E2F_std_data_archive_RA[:,2:end]
CEBPa_mean_data_archive_RA = CEBPa_mean_data_archive_RA[:,2:end]
CEBPa_std_data_archive_RA = CEBPa_std_data_archive_RA[:,2:end]
OCT4_mean_data_archive_RA = OCT4_mean_data_archive_RA[:,2:end]
OCT4_std_data_archive_RA = OCT4_std_data_archive_RA[:,2:end]
EGR1_mean_data_archive_RA = EGR1_mean_data_archive_RA[:,2:end]
EGR1_std_data_archive_RA = EGR1_std_data_archive_RA[:,2:end]
GIF1_mean_data_archive_RA = GIF1_mean_data_archive_RA[:,2:end]
GIF1_std_data_archive_RA = GIF1_std_data_archive_RA[:,2:end]

CD38_mean_array_archive_D3 = CD38_mean_array_archive_D3[:,2:end]
CD38_std_array_archive_D3 = CD38_std_array_archive_D3[:,2:end]
CD14_mean_array_archive_D3 = CD14_mean_array_archive_D3[:,2:end]
CD14_std_array_archive_D3 = CD14_std_array_archive_D3[:,2:end]
CD11b_mean_array_archive_D3 = CD11b_mean_array_archive_D3[:,2:end]
CD11b_std_array_archive_D3 = CD11b_std_array_archive_D3[:,2:end]

CD38_mean_data_archive_D3 = CD38_mean_data_archive_D3[:,2:end]
CD38_std_data_archive_D3 = CD38_std_data_archive_D3[:,2:end]
CD14_mean_data_archive_D3 = CD14_mean_data_archive_D3[:,2:end]
CD14_std_data_archive_D3 = CD14_std_data_archive_D3[:,2:end]
CD11b_mean_data_archive_D3 = CD11b_mean_data_archive_D3[:,2:end]
CD11b_std_data_archive_D3 = CD11b_std_data_archive_D3[:,2:end]
AhR_mean_data_archive_D3 = AhR_mean_data_archive_D3[:,2:end]
AhR_std_data_archive_D3 = AhR_std_data_archive_D3[:,2:end]
P47Phox_mean_data_archive_D3 = P47Phox_mean_data_archive_D3[:,2:end]
P47Phox_std_data_archive_D3 = P47Phox_std_data_archive_D3[:,2:end]
IRF1_mean_data_archive_D3 = IRF1_mean_data_archive_D3[:,2:end]
IRF1_std_data_archive_D3 = IRF1_std_data_archive_D3[:,2:end]
PU1_mean_data_archive_D3 = PU1_mean_data_archive_D3[:,2:end]
PU1_std_data_archive_D3 = PU1_std_data_archive_D3[:,2:end]
E2F_mean_data_archive_D3 = E2F_mean_data_archive_D3[:,2:end]
E2F_std_data_archive_D3 = E2F_std_data_archive_D3[:,2:end]
CEBPa_mean_data_archive_D3 = CEBPa_mean_data_archive_D3[:,2:end]
CEBPa_std_data_archive_D3 = CEBPa_std_data_archive_D3[:,2:end]
OCT4_mean_data_archive_D3 = OCT4_mean_data_archive_D3[:,2:end]
OCT4_std_data_archive_D3 = OCT4_std_data_archive_D3[:,2:end]
EGR1_mean_data_archive_D3 = EGR1_mean_data_archive_D3[:,2:end]
EGR1_std_data_archive_D3 = EGR1_std_data_archive_D3[:,2:end]
GIF1_mean_data_archive_D3 = GIF1_mean_data_archive_D3[:,2:end]
GIF1_std_data_archive_D3 = GIF1_std_data_archive_D3[:,2:end]

CD38_mean_array_archive_RA_D3 = CD38_mean_array_archive_RA_D3[:,2:end]
CD38_std_array_archive_RA_D3 = CD38_std_array_archive_RA_D3[:,2:end]
CD14_mean_array_archive_RA_D3 = CD14_mean_array_archive_RA_D3[:,2:end]
CD14_std_array_archive_RA_D3 = CD14_std_array_archive_RA_D3[:,2:end]
CD11b_mean_array_archive_RA_D3 = CD11b_mean_array_archive_RA_D3[:,2:end]
CD11b_std_array_archive_RA_D3 = CD11b_std_array_archive_RA_D3[:,2:end]

CD38_mean_data_archive_RA_D3 = CD38_mean_data_archive_RA_D3[:,2:end]
CD38_std_data_archive_RA_D3 = CD38_std_data_archive_RA_D3[:,2:end]
CD14_mean_data_archive_RA_D3 = CD14_mean_data_archive_RA_D3[:,2:end]
CD14_std_data_archive_RA_D3 = CD14_std_data_archive_RA_D3[:,2:end]
CD11b_mean_data_archive_RA_D3 = CD11b_mean_data_archive_RA_D3[:,2:end]
CD11b_std_data_archive_RA_D3 = CD11b_std_data_archive_RA_D3[:,2:end]
AhR_mean_data_archive_RA_D3 = AhR_mean_data_archive_RA_D3[:,2:end]
AhR_std_data_archive_RA_D3 = AhR_std_data_archive_RA_D3[:,2:end]
P47Phox_mean_data_archive_RA_D3 = P47Phox_mean_data_archive_RA_D3[:,2:end]
P47Phox_std_data_archive_RA_D3 = P47Phox_std_data_archive_RA_D3[:,2:end]
IRF1_mean_data_archive_RA_D3 = IRF1_mean_data_archive_RA_D3[:,2:end]
IRF1_std_data_archive_RA_D3 = IRF1_std_data_archive_RA_D3[:,2:end]
PU1_mean_data_archive_RA_D3 = PU1_mean_data_archive_RA_D3[:,2:end]
PU1_std_data_archive_RA_D3 = PU1_std_data_archive_RA_D3[:,2:end]
E2F_mean_data_archive_RA_D3 = E2F_mean_data_archive_RA_D3[:,2:end]
E2F_std_data_archive_RA_D3 = E2F_std_data_archive_RA_D3[:,2:end]
CEBPa_mean_data_archive_RA_D3 = CEBPa_mean_data_archive_RA_D3[:,2:end]
CEBPa_std_data_archive_RA_D3 = CEBPa_std_data_archive_RA_D3[:,2:end]
OCT4_mean_data_archive_RA_D3 = OCT4_mean_data_archive_RA_D3[:,2:end]
OCT4_std_data_archive_RA_D3 = OCT4_std_data_archive_RA_D3[:,2:end]
EGR1_mean_data_archive_RA_D3 = EGR1_mean_data_archive_RA_D3[:,2:end]
EGR1_std_data_archive_RA_D3 = EGR1_std_data_archive_RA_D3[:,2:end]
GIF1_mean_data_archive_RA_D3 = GIF1_mean_data_archive_RA_D3[:,2:end]
GIF1_std_data_archive_RA_D3 = GIF1_std_data_archive_RA_D3[:,2:end]
# compile everything
#forRA
CD38_mean_array_RA = mean(CD38_mean_array_archive_RA,2)
CD38_std_array_RA = mean(CD38_std_array_archive_RA,2)
CD14_mean_array_RA = mean(CD14_mean_array_archive_RA,2)
CD14_std_array_RA = mean(CD14_std_array_archive_RA,2)
CD11b_mean_array_RA = mean(CD11b_mean_array_archive_RA,2)
CD11b_std_array_RA = mean(CD11b_std_array_archive_RA,2)


CD38_mean_data_RA = mean(CD38_mean_data_archive_RA,2)
CD38_std_data_RA = mean(CD38_std_data_archive_RA,2)
CD14_mean_data_RA = mean(CD14_mean_data_archive_RA,2)
CD14_std_data_RA = mean(CD14_std_data_archive_RA,2)
CD11b_mean_data_RA = mean(CD11b_mean_data_archive_RA,2)
CD11b_std_data_RA = mean(CD11b_std_data_archive_RA,2)
AhR_mean_data_RA = mean(AhR_mean_data_archive_RA,2)
AhR_std_data_RA = mean(AhR_std_data_archive_RA,2)
P47Phox_mean_data_RA = mean(P47Phox_mean_data_archive_RA,2)
P47Phox_std_data_RA = mean(P47Phox_std_data_archive_RA,2)
IRF1_mean_data_RA = mean(IRF1_mean_data_archive_RA,2)
IRF1_std_data_RA = mean(IRF1_std_data_archive_RA,2)
PU1_mean_data_RA = mean(PU1_mean_data_archive_RA,2)
PU1_std_data_RA = mean(PU1_std_data_archive_RA,2)
E2F_mean_data_RA = mean(E2F_mean_data_archive_RA,2)
E2F_std_data_RA = mean(E2F_std_data_archive_RA,2)
CEBPa_mean_data_RA = mean(CEBPa_mean_data_archive_RA,2)
CEBPa_std_data_RA = mean(CEBPa_std_data_archive_RA,2)
OCT4_mean_data_RA = mean(OCT4_mean_data_archive_RA,2)
OCT4_std_data_RA = mean(OCT4_std_data_archive_RA,2)
EGR1_mean_data_RA = mean(EGR1_mean_data_archive_RA,2)
EGR1_std_data_RA = mean(EGR1_std_data_archive_RA,2)
GIF1_mean_data_RA = mean(GIF1_mean_data_archive_RA,2)
GIF1_std_data_RA = mean(GIF1_std_data_archive_RA,2)

#forD3-------------------------------------------------------------------------------------------------------

#calculatemean
CD38_mean_array_D3 = mean(CD38_mean_array_archive_D3,2)
CD38_std_array_D3 = mean(CD38_std_array_archive_D3,2)
CD14_mean_array_D3 = mean(CD14_mean_array_archive_D3,2)
CD14_std_array_D3 = mean(CD14_std_array_archive_D3,2)
CD11b_mean_array_D3 = mean(CD11b_mean_array_archive_D3,2)
CD11b_std_array_D3 = mean(CD11b_std_array_archive_D3,2)


CD38_mean_data_D3 = mean(CD38_mean_data_archive_D3,2)
CD38_std_data_D3 = mean(CD38_std_data_archive_D3,2)
CD14_mean_data_D3 = mean(CD14_mean_data_archive_D3,2)
CD14_std_data_D3 = mean(CD14_std_data_archive_D3,2)
CD11b_mean_data_D3 = mean(CD11b_mean_data_archive_D3,2)
CD11b_std_data_D3 = mean(CD11b_std_data_archive_D3,2)
AhR_mean_data_D3 = mean(AhR_mean_data_archive_D3,2)
AhR_std_data_D3 = mean(AhR_std_data_archive_D3,2)
P47Phox_mean_data_D3 = mean(P47Phox_mean_data_archive_D3,2)
P47Phox_std_data_D3 = mean(P47Phox_std_data_archive_D3,2)
IRF1_mean_data_D3 = mean(IRF1_mean_data_archive_D3,2)
IRF1_std_data_D3 = mean(IRF1_std_data_archive_D3,2)
PU1_mean_data_D3 = mean(PU1_mean_data_archive_D3,2)
PU1_std_data_D3 = mean(PU1_std_data_archive_D3,2)
E2F_mean_data_D3 = mean(E2F_mean_data_archive_D3,2)
E2F_std_data_D3 = mean(E2F_std_data_archive_D3,2)
CEBPa_mean_data_D3 = mean(CEBPa_mean_data_archive_D3,2)
CEBPa_std_data_D3 = mean(CEBPa_std_data_archive_D3,2)
OCT4_mean_data_D3 = mean(OCT4_mean_data_archive_D3,2)
OCT4_std_data_D3 = mean(OCT4_std_data_archive_D3,2)
EGR1_mean_data_D3 = mean(EGR1_mean_data_archive_D3,2)
EGR1_std_data_D3 = mean(EGR1_std_data_archive_D3,2)
GIF1_mean_data_D3 = mean(GIF1_mean_data_archive_D3,2)
GIF1_std_data_D3 = mean(GIF1_std_data_archive_D3,2)

#forRA_D3-----------------------------------------------------------------------
#calculatemean
CD38_mean_array_RA_D3 = mean(CD38_mean_array_archive_RA_D3,2)
CD38_std_array_RA_D3 = mean(CD38_std_array_archive_RA_D3,2)
CD14_mean_array_RA_D3 = mean(CD14_mean_array_archive_RA_D3,2)
CD14_std_array_RA_D3 = mean(CD14_std_array_archive_RA_D3,2)
CD11b_mean_array_RA_D3 = mean(CD11b_mean_array_archive_RA_D3,2)
CD11b_std_array_RA_D3 = mean(CD11b_std_array_archive_RA_D3,2)

CD38_mean_data_RA_D3 = mean(CD38_mean_data_archive_RA_D3,2)
CD38_std_data_RA_D3 = mean(CD38_std_data_archive_RA_D3,2)
CD14_mean_data_RA_D3 = mean(CD14_mean_data_archive_RA_D3,2)
CD14_std_data_RA_D3 = mean(CD14_std_data_archive_RA_D3,2)
CD11b_mean_data_RA_D3 = mean(CD11b_mean_data_archive_RA_D3,2)
CD11b_std_data_RA_D3 = mean(CD11b_std_data_archive_RA_D3,2)
AhR_mean_data_RA_D3 = mean(AhR_mean_data_archive_RA_D3,2)
AhR_std_data_RA_D3 = mean(AhR_std_data_archive_RA_D3,2)
P47Phox_mean_data_RA_D3 = mean(P47Phox_mean_data_archive_RA_D3,2)
P47Phox_std_data_RA_D3 = mean(P47Phox_std_data_archive_RA_D3,2)
IRF1_mean_data_RA_D3 = mean(IRF1_mean_data_archive_RA_D3,2)
IRF1_std_data_RA_D3 = mean(IRF1_std_data_archive_RA_D3,2)
PU1_mean_data_RA_D3 = mean(PU1_mean_data_archive_RA_D3,2)
PU1_std_data_RA_D3 = mean(PU1_std_data_archive_RA_D3,2)
E2F_mean_data_RA_D3 = mean(E2F_mean_data_archive_RA_D3,2)
E2F_std_data_RA_D3 = mean(E2F_std_data_archive_RA_D3,2)
CEBPa_mean_data_RA_D3 = mean(CEBPa_mean_data_archive_RA_D3,2)
CEBPa_std_data_RA_D3 = mean(CEBPa_std_data_archive_RA_D3,2)
OCT4_mean_data_RA_D3 = mean(OCT4_mean_data_archive_RA_D3,2)
OCT4_std_data_RA_D3 = mean(OCT4_std_data_archive_RA_D3,2)
EGR1_mean_data_RA_D3 = mean(EGR1_mean_data_archive_RA_D3,2)
EGR1_std_data_RA_D3 = mean(EGR1_std_data_archive_RA_D3,2)
GIF1_mean_data_RA_D3 = mean(GIF1_mean_data_archive_RA_D3,2)
GIF1_std_data_RA_D3 = mean(GIF1_std_data_archive_RA_D3,2)

# 99% confidence interval or standard error
SF = (2.58)#/sqrt(number_of_samples)
#SF2 = (2.58)/sqrt(number_of_samples)


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

CD11b_RA_UB_SE = CD11b_mean_array_RA + CD11b_std_array_RA*SF/sqrt(14)
CD11b_RA_LB_SE = CD11b_mean_array_RA - CD11b_std_array_RA*SF/sqrt(14)
idx_z = find(CD11b_RA_LB.<0)
CD11b_RA_LB_SE[idx_z] = 0.0

CD38_RA_UB_SE = CD38_mean_array_RA + CD38_std_array_RA*SF/sqrt(11)
CD38_RA_LB_SE = CD38_mean_array_RA - CD38_std_array_RA*SF/sqrt(11)
idx_z = find(CD38_RA_LB.<0)
CD38_RA_LB_SE[idx_z] = 0.0

CD14_RA_UB_SE = CD14_mean_array_RA + CD14_std_array_RA*SF/sqrt(14)
CD14_RA_LB_SE = CD14_mean_array_RA - CD14_std_array_RA*SF/sqrt(14)
idx_z = find(CD14_RA_LB.<0)
CD14_RA_LB_SE[idx_z] = 0.0





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

CD11b_D3_UB_SE = CD11b_mean_array_D3 + CD11b_std_array_D3/sqrt(14)
CD11b_D3_LB_SE = CD11b_mean_array_D3 - CD11b_std_array_D3/sqrt(14)
idx_z = find(CD11b_D3_LB.<0)
CD11b_D3_LB_SE[idx_z] = 0.0

CD38_D3_UB_SE = CD38_mean_array_D3 + CD38_std_array_D3/sqrt(11)
CD38_D3_LB_SE = CD38_mean_array_D3 - CD38_std_array_D3/sqrt(11)
idx_z = find(CD38_D3_LB.<0)
CD38_D3_LB_SE[idx_z] = 0.0

CD14_D3_UB_SE = CD14_mean_array_D3 + CD14_std_array_D3/sqrt(14)
CD14_D3_LB_SE = CD14_mean_array_D3 - CD14_std_array_D3/sqrt(14)
idx_z = find(CD14_D3_LB.<0)
CD14_D3_LB_SE[idx_z] = 0.0



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

CD11b_RA_D3_UB_SE = CD11b_mean_array_RA_D3 + CD11b_std_array_RA_D3/sqrt(14)
CD11b_RA_D3_LB_SE = CD11b_mean_array_RA_D3 - CD11b_std_array_RA_D3/sqrt(14)
idx_z = find(CD11b_RA_D3_LB.<0)
CD11b_RA_D3_LB_SE[idx_z] = 0.0

CD38_RA_D3_UB_SE = CD38_mean_array_RA_D3 + CD38_std_array_RA_D3/sqrt(11)
CD38_RA_D3_LB_SE = CD38_mean_array_RA_D3 - CD38_std_array_RA_D3/sqrt(11)
idx_z = find(CD38_RA_D3_LB.<0)
CD38_RA_D3_LB_SE[idx_z] = 0.0

CD14_RA_D3_UB_SE = CD14_mean_array_RA_D3 + CD14_std_array_RA_D3/sqrt(14)
CD14_RA_D3_LB_SE = CD14_mean_array_RA_D3 - CD14_std_array_RA_D3/sqrt(14)
idx_z = find(CD14_RA_D3_LB.<0)
CD14_RA_D3_LB_SE[idx_z] = 0.0






# CD11b and CD38
figure("timecourse")
subplot(3,3,1)
a = plot(time_experimental,CD38_mean_array_RA,"k")
b = errorbar(CD38_RA_EXP[:,1],CD38_RA_EXP[:,2],CD38_RA_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD38_RA_LB),vec(CD38_RA_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(CD38_RA_LB_SE),vec(CD38_RA_UB_SE),color="dodgerblue",lw=2)
subplot(3,3,2)
a2 = plot(time_experimental,CD38_mean_array_D3,"k")
b2 = errorbar(CD38_D3_EXP[:,1],CD38_D3_EXP[:,2],CD38_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD38_D3_LB),vec(CD38_D3_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(CD38_D3_LB_SE),vec(CD38_D3_UB_SE),color="dodgerblue",lw=2)
subplot(3,3,3)
a3 = plot(time_experimental,CD38_mean_array_RA_D3,"k")
b3 = errorbar(CD38_RA_D3_EXP[:,1],CD38_RA_D3_EXP[:,2],CD38_RA_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD38_RA_D3_LB),vec(CD38_RA_D3_UB),color="lightblue",lw=2)
fill_between(vec(time_experimental),vec(CD38_RA_D3_LB_SE),vec(CD38_RA_D3_UB_SE),color="dodgerblue",lw=2)
subplot(3,3,4)
c = plot(time_experimental,CD11b_mean_array_RA,"k")
d = errorbar(CD11b_RA_EXP[:,1],CD11b_RA_EXP[:,2],CD11b_RA_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD11b_RA_LB),vec(CD11b_RA_UB),color="lightsalmon",lw=2)
fill_between(vec(time_experimental),vec(CD11b_RA_LB_SE),vec(CD11b_RA_UB_SE),color="tomato",lw=2)
subplot(3,3,5)
c2 = plot(time_experimental,CD11b_mean_array_D3,"k")
d2 = errorbar(CD11b_D3_EXP[:,1],CD11b_D3_EXP[:,2],CD11b_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD11b_D3_LB),vec(CD11b_D3_UB),color="lightsalmon",lw=2)
fill_between(vec(time_experimental),vec(CD11b_D3_LB_SE),vec(CD11b_D3_UB_SE),color="tomato",lw=2)
subplot(3,3,6)
c3 = plot(time_experimental,CD11b_mean_array_RA_D3,"k")
d3 = errorbar(CD11b_RA_D3_EXP[:,1],CD11b_RA_D3_EXP[:,2],CD11b_RA_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD11b_RA_D3_LB),vec(CD11b_RA_D3_UB),color="lightsalmon",lw=2,alpha=1)
fill_between(vec(time_experimental),vec(CD11b_RA_D3_LB_SE),vec(CD11b_RA_D3_UB_SE),color="tomato",lw=2)
subplot(3,3,7)
e = plot(time_experimental,CD14_mean_array_RA,"k")
f = errorbar(CD14_RA_EXP[:,1],CD14_RA_EXP[:,2],CD14_RA_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD14_RA_LB),vec(CD14_RA_UB),color="lavender",lw=2)
fill_between(vec(time_experimental),vec(CD14_RA_LB_SE),vec(CD14_RA_UB_SE),color="orchid",lw=2)
plt[:ylim]([0,6])
subplot(3,3,8)
e2 = plot(time_experimental,CD14_mean_array_D3,"k")
f2 = errorbar(CD14_D3_EXP[:,1],CD14_D3_EXP[:,2],CD14_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD14_D3_LB),vec(CD14_D3_UB),color="lavender",lw=2)
fill_between(vec(time_experimental),vec(CD14_D3_LB_SE),vec(CD14_D3_UB_SE),color="orchid",lw=2)
subplot(3,3,9)
e3 = plot(time_experimental,CD14_mean_array_RA_D3,"k")
f3 = errorbar(CD14_RA_D3_EXP[:,1],CD14_RA_D3_EXP[:,2],CD14_RA_D3_EXP[:,3], fmt = "o", color = "k")
fill_between(vec(time_experimental),vec(CD14_RA_D3_LB),vec(CD14_RA_D3_UB),color="lavender",lw=2)
fill_between(vec(time_experimental),vec(CD14_RA_D3_LB_SE),vec(CD14_RA_D3_UB_SE),color="orchid",lw=2)

# coombined bar graphs for 48 hr expression
x_sim = [1:3:8;]
x_exp = [2:3:8;]
number_of_samples = 3
size_sample = sqrt(number_of_samples)/SF # Stdev divided by this gives 99% standard error


y_sim_AhR = [
    AhR_mean_data_RA[2,1]
    AhR_mean_data_D3[2,1]
    AhR_mean_data_RA_D3[2,1]
]
y_sim_std_AhR = [
    AhR_std_data_RA[2,1]/size_sample
    AhR_std_data_D3[2,1]/size_sample
    AhR_std_data_RA_D3[2,1]/size_sample
]
y_exp_AhR = [
  AhR_RA_EXP[2,2]
  AhR_D3_EXP[2,2]
  AhR_RA_D3_EXP[2,2]
]
y_exp_std_AhR = [
  AhR_RA_EXP[2,3]
  AhR_D3_EXP[2,3]
  AhR_RA_D3_EXP[2,3]
]
y_sim_GIF1 = [
    GIF1_mean_data_RA[2,1]
    GIF1_mean_data_D3[2,1]
    GIF1_mean_data_RA_D3[2,1]
]
y_sim_std_GIF1 = [
    GIF1_std_data_RA[2,1]/size_sample
    GIF1_std_data_D3[2,1]/size_sample
    GIF1_std_data_RA_D3[2,1]/size_sample
]
y_exp_GIF1 = [
  GFI1_RA_EXP[2,2]
  GFI1_D3_EXP[2,2]
  GFI1_RA_D3_EXP[2,2]
]
y_exp_std_GIF1 = [
  GFI1_RA_EXP[2,3]
  GFI1_D3_EXP[2,3]
  GFI1_RA_D3_EXP[2,3]
]

y_sim_EGR1 = [
    EGR1_mean_data_RA[2,1]
    EGR1_mean_data_D3[2,1]
    EGR1_mean_data_RA_D3[2,1]
]
y_sim_std_EGR1 = [
    EGR1_std_data_RA[2,1]/size_sample
    EGR1_std_data_D3[2,1]/size_sample
    EGR1_std_data_RA_D3[2,1]/size_sample
]
y_exp_EGR1 = [
  EGR1_RA_EXP[2,2]
  EGR1_D3_EXP[2,2]
  EGR1_RA_D3_EXP[2,2]
]
y_exp_std_EGR1 = [
  EGR1_RA_EXP[2,3]
  EGR1_D3_EXP[2,3]
  EGR1_RA_D3_EXP[2,3]
]
y_sim_IRF1 = [
    IRF1_mean_data_RA[2,1]
    IRF1_mean_data_D3[2,1]
    IRF1_mean_data_RA_D3[2,1]
]
y_sim_std_IRF1 = [
    IRF1_std_data_RA[2,1]/size_sample
    IRF1_std_data_D3[2,1]/size_sample
    IRF1_std_data_RA_D3[2,1]/size_sample
]
y_exp_IRF1 = [
  IRF1_RA_EXP[2,2]
  IRF1_D3_EXP[2,2]
  IRF1_RA_D3_EXP[2,2]
]
y_exp_std_IRF1 = [
  IRF1_RA_EXP[2,3]
  IRF1_D3_EXP[2,3]
  IRF1_RA_D3_EXP[2,3]
]

y_sim_CEBPa = [
    CEBPa_mean_data_RA[2,1]
    CEBPa_mean_data_D3[2,1]
    CEBPa_mean_data_RA_D3[2,1]
]
y_sim_std_CEBPa = [
    CEBPa_std_data_RA[2,1]/size_sample
    CEBPa_std_data_D3[2,1]/size_sample
    CEBPa_std_data_RA_D3[2,1]/size_sample
]
y_exp_CEBPa = [
  CEBPa_RA_EXP[2,2]
  CEBPa_D3_EXP[2,2]
  CEBPa_RA_D3_EXP[2,2]
]
y_exp_std_CEBPa = [
  CEBPa_RA_EXP[2,3]
  CEBPa_D3_EXP[2,3]
  CEBPa_RA_D3_EXP[2,3]
]

y_sim_PU1 = [
    PU1_mean_data_RA[2,1]
    PU1_mean_data_D3[2,1]
    PU1_mean_data_RA_D3[2,1]
]
y_sim_std_PU1 = [
    PU1_std_data_RA[2,1]/size_sample
    PU1_std_data_D3[2,1]/size_sample
    PU1_std_data_RA_D3[2,1]/size_sample
]
y_exp_PU1 = [
  PU1_RA_EXP[2,2]
  PU1_D3_EXP[2,2]
  PU1_RA_D3_EXP[2,2]
]
y_exp_std_PU1 = [
  PU1_RA_EXP[2,3]
  PU1_D3_EXP[2,3]
  PU1_RA_D3_EXP[2,3]
]


y_sim_P47Phox = [
    P47Phox_mean_data_RA[2,1]
    P47Phox_mean_data_D3[2,1]
    P47Phox_mean_data_RA_D3[2,1]
]
y_sim_std_P47Phox = [
    P47Phox_std_data_RA[2,1]/size_sample
    P47Phox_std_data_D3[2,1]/size_sample
    P47Phox_std_data_RA_D3[2,1]/size_sample
]
y_exp_P47Phox = [
  P47Phox_RA_EXP[2,2]
  P47Phox_D3_EXP[2,2]
  0#P47Phox_RA_D3_EXP[2,2]
]
y_exp_std_P47Phox = [
  P47Phox_RA_EXP[2,3]
  P47Phox_D3_EXP[2,3]
  0#P47Phox_RA_D3_EXP[2,3]
]

y_sim_OCT4 = [
    OCT4_mean_data_RA[2,1]
    OCT4_mean_data_D3[2,1]
    OCT4_mean_data_RA_D3[2,1]
]
y_sim_std_OCT4 = [
    OCT4_std_data_RA[2,1]/size_sample
    OCT4_std_data_D3[2,1]/size_sample
    OCT4_std_data_RA_D3[2,1]/size_sample
]
y_exp_OCT4 = [
  OCT4_RA_EXP[2,2]
  OCT4_D3_EXP[2,2]
  OCT4_RA_D3_EXP[2,2]
]
y_exp_std_OCT4 = [
  OCT4_RA_EXP[2,3]
  OCT4_D3_EXP[2,3]
  OCT4_RA_D3_EXP[2,3]
]


figure("48hr expression")
fig2 = subplot(4,2,1)
a = bar(x_sim,y_sim_AhR,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_AhR,ecolor = "k")
b = bar(x_exp,y_exp_AhR,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_AhR,ecolor = "k")
c = plot([0:9;],ones(10),"--",color = "k", linewidth=1)
plt[:ylim]([0,4])
x = vec(["AhR" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,2)
a = bar(x_sim,y_sim_GIF1,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_GIF1,ecolor = "k")
b = bar(x_exp,y_exp_GIF1,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_GIF1,ecolor = "k")
c = plot([0:9;],ones(10),"--",color = "k", linewidth=1)
plt[:ylim]([0,6])
x = vec(["GFI1" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,3)
a = bar(x_sim,y_sim_EGR1,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_EGR1,ecolor = "k")
b = bar(x_exp,y_exp_EGR1,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_EGR1,ecolor = "k")
c = plot([0:9;],ones(10),"--",color = "k", linewidth=1)
plt[:ylim]([0,5])
x = vec(["EGR1" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,4)
a = bar(x_sim,y_sim_IRF1,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_IRF1,ecolor = "k")
b = bar(x_exp,y_exp_IRF1,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_IRF1,ecolor = "k")
c = plot([0:9;],ones(10),"--",color = "k", linewidth=1)
plt[:ylim]([0,4])
x = vec(["IRF1" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,5)
a = bar(x_sim,y_sim_CEBPa,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_CEBPa,ecolor = "k")
b = bar(x_exp,y_exp_CEBPa,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_CEBPa,ecolor = "k")
c = plot([0:9;],ones(10),"--",color = "k", linewidth=1)
plt[:ylim]([0,10])
x = vec(["CEBPa" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,6)
a = bar(x_sim,y_sim_PU1,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_PU1,ecolor = "k")
b = bar(x_exp,y_exp_PU1,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_PU1,ecolor = "k")
c = plot([0:9;],ones(10),"--",color = "k", linewidth=1)
plt[:ylim]([0,10])
x = vec(["PU1" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,7)
a = bar(x_sim,y_sim_P47Phox,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_P47Phox,ecolor = "k")
b = bar(x_exp,y_exp_P47Phox,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_P47Phox,ecolor = "k")
c = plot([0:9;],ones(10),"--",color = "k", linewidth=1)
plt[:ylim]([0,10])
x = vec(["P47Phox" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,8)
a = bar(x_sim,y_sim_OCT4,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_OCT4,ecolor = "k")
b = bar(x_exp,y_exp_OCT4,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_OCT4,ecolor = "k")
c = plot([0:9;],ones(10),"--",color = "k", linewidth=1)
plt[:ylim]([0,4])
x = vec(["OCT4" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of maj
