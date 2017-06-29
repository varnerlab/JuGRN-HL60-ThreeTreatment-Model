include("Include.jl")

function updateCholesky(A,zV,CCOV,AVG_P_SUCC,PTHRESH)

  if (AVG_P_SUCC<PTHRESH)
		CA = sqrt(1-CCOV);
		F = 1 + ((1-CA^2)*(norm(zV))^2)/(CA^2);
		A = CA*A+CA/(norm(zV)^2)*(sqrt(F)-1)*A*zV*transpose(zV);
	else
		A = A;
	end

  return A;
end

function updateStepSize(LAMBDA_SUCC,AVG_P_SUCC,P_SUCC_TARGET,CP,D,SIGMA)

	# Compute AVG_P_SUCC -
	AVG_P_SUCC = (1-CP)*AVG_P_SUCC+CP*LAMBDA_SUCC;

	# Compute the step-size -
	F = (1/D)*(AVG_P_SUCC-(P_SUCC_TARGET/(1-P_SUCC_TARGET))*(1-AVG_P_SUCC));
	SIGMA = SIGMA*exp(F);

	if (SIGMA<= 1e-5)
		SIGMA = 1e-5;
	end

  return (SIGMA,AVG_P_SUCC);
end

function sample_function(parameter_guess,kVI,lower_bound_array,upper_bound_array,NPARAMETERS,A,SIGMA)#,perturbation_array)

  # Generate a new vector -
  zV = randn(NPARAMETERS);

  # Compute the new perturbed parameter vector -
  perturbed_parameter_array = parameter_guess.*(1 + SIGMA*A*zV);#.*perturbation_array);
  corrected_parameter_array = parameter_bounds_function(perturbed_parameter_array,lower_bound_array,upper_bound_array);

  # return -
  return (corrected_parameter_array,zV)
end

function bounds_function(number_of_parameters)

  # Setup my upper bound, and lower bounds on parameters -
  #lower_bound_array = zeros(number_of_parameters)
  lower_bound_array = [
  1	;	#	"n_gene_AP1_gene_AhR"			#	1
  0	;	#	"K_gene_AP1_gene_AhR"			#	2
  1	;	#	"n_gene_AP1_gene_PU1"			#	3
  0	;	#	"K_gene_AP1_gene_PU1"			#	4
  1	;	#	"n_gene_AP1_gene_PPARg"			#	5
  0	;	#	"K_gene_AP1_gene_PPARg"			#	6
  1	;	#	"n_gene_AhR_gene_Trigger_RA"			#	7
  0	;	#	"K_gene_AhR_gene_Trigger_RA"			#	8
  1	;	#	"n_gene_CD11b_gene_PU1_gene_cRAF"			#	9
  0	;	#	"K_gene_CD11b_gene_PU1_gene_cRAF"			#	10
  1	;	#	"n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"			#	11
  0	;	#	"K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"			#	12
  1	;	#	"n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"			#	13
  0	;	#	"K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"			#	14
  1	;	#	"n_gene_CEBPa_gene_Trigger_RA"			#	15
  0	;	#	"K_gene_CEBPa_gene_Trigger_RA"			#	16
  1	;	#	"n_gene_CEBPa_gene_Trigger_D3"			#	17
  0	;	#	"K_gene_CEBPa_gene_Trigger_D3"			#	18
  1	;	#	"n_gene_CEBPa_gene_PPARg"			#	19
  0	;	#	"K_gene_CEBPa_gene_PPARg"			#	20
  1	;	#	"n_gene_CEBPa_gene_CEBPa"			#	21
  0	;	#	"K_gene_CEBPa_gene_CEBPa"			#	22
  1	;	#	"n_gene_CEBPa_gene_GFI1"			#	23
  0	;	#	"K_gene_CEBPa_gene_GFI1"			#	24
  1	;	#	"n_gene_E2F_gene_E2F"			#	25
  0	;	#	"K_gene_E2F_gene_E2F"			#	26
  1	;	#	"n_gene_E2F_gene_PPARg"			#	27
  0	;	#	"K_gene_E2F_gene_PPARg"			#	28
  1	;	#	"n_gene_E2F_gene_CEBPa"			#	29
  0	;	#	"K_gene_E2F_gene_CEBPa"			#	30
  1	;	#	"n_gene_E2F_gene_GFI1"			#	31
  0	;	#	"K_gene_E2F_gene_GFI1"			#	32
  1	;	#	"n_gene_E2F_gene_cRAF"			#	33
  0	;	#	"K_gene_E2F_gene_cRAF"			#	34
  1	;	#	"n_gene_EGR1_gene_Trigger_RA"			#	35
  0	;	#	"K_gene_EGR1_gene_Trigger_RA"			#	36
  1	;	#	"n_gene_EGR1_gene_PU1"			#	37
  0	;	#	"K_gene_EGR1_gene_PU1"			#	38
  1	;	#	"n_gene_EGR1_gene_PPARg"			#	39
  0	;	#	"K_gene_EGR1_gene_PPARg"			#	40
  1	;	#	"n_gene_EGR1_gene_GFI1"			#	41
  0	;	#	"K_gene_EGR1_gene_GFI1"			#	42
  1	;	#	"n_gene_GFI1_gene_CEBPa"			#	43
  0	;	#	"K_gene_GFI1_gene_CEBPa"			#	44
  1	;	#	"n_gene_GFI1_gene_EGR1"			#	45
  0	;	#	"K_gene_GFI1_gene_EGR1"			#	46
  1	;	#	"n_gene_IRF1_gene_Trigger_RA"			#	47
  0	;	#	"K_gene_IRF1_gene_Trigger_RA"			#	48
  1	;	#	"n_gene_IRF1_gene_AhR"			#	49
  0	;	#	"K_gene_IRF1_gene_AhR"			#	50
  1	;	#	"n_gene_IRF1_gene_PPARg"			#	51
  0	;	#	"K_gene_IRF1_gene_PPARg"			#	52
  1	;	#	"n_gene_OCT1_gene_PPARg"			#	53
  0	;	#	"K_gene_OCT1_gene_PPARg"			#	54
  1	;	#	"n_gene_OCT4_gene_Trigger_RA"			#	55
  0	;	#	"K_gene_OCT4_gene_Trigger_RA"			#	56
  1	;	#	"n_gene_OCT4_gene_AhR"			#	57
  0	;	#	"K_gene_OCT4_gene_AhR"			#	58
  1	;	#	"n_gene_OCT4_gene_cRAF"			#	59
  0	;	#	"K_gene_OCT4_gene_cRAF"			#	60
  1	;	#	"n_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"			#	61
  0	;	#	"K_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"			#	62
  1	;	#	"n_gene_P21_gene_GFI1"			#	63
  0	;	#	"K_gene_P21_gene_GFI1"			#	64
  1	;	#	"n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"			#	65
  0	;	#	"K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"			#	66
  1	;	#	"n_gene_P47Phox_gene_PPARg"			#	67
  0	;	#	"K_gene_P47Phox_gene_PPARg"			#	68
  1	;	#	"n_gene_PPARg_gene_Trigger_RA"			#	69
  0	;	#	"K_gene_PPARg_gene_Trigger_RA"			#	70
  1	;	#	"n_gene_PPARg_gene_Trigger_D3"			#	71
  0	;	#	"K_gene_PPARg_gene_Trigger_D3"			#	72
  1	;	#	"n_gene_PPARg_gene_CEBPa"			#	73
  0	;	#	"K_gene_PPARg_gene_CEBPa"			#	74
  1	;	#	"n_gene_PPARg_gene_EGR1"			#	75
  0	;	#	"K_gene_PPARg_gene_EGR1"			#	76
  1	;	#	"n_gene_PPARg_gene_PU1"			#	77
  0	;	#	"K_gene_PPARg_gene_PU1"			#	78
  1	;	#	"n_gene_PPARg_gene_AP1"			#	79
  0	;	#	"K_gene_PPARg_gene_AP1"			#	80
  1	;	#	"n_gene_PU1_gene_Trigger_RA"			#	81
  0	;	#	"K_gene_PU1_gene_Trigger_RA"			#	82
  1	;	#	"n_gene_PU1_gene_Trigger_D3"			#	83
  0	;	#	"K_gene_PU1_gene_Trigger_D3"			#	84
  1	;	#	"n_gene_PU1_gene_CEBPa"			#	85
  0	;	#	"K_gene_PU1_gene_CEBPa"			#	86
  1	;	#	"n_gene_PU1_gene_PU1"			#	87
  0	;	#	"K_gene_PU1_gene_PU1"			#	88
  1	;	#	"n_gene_PU1_gene_AP1"			#	89
  0	;	#	"K_gene_PU1_gene_AP1"			#	90
  1	;	#	"n_gene_PU1_gene_OCT1"			#	91
  0	;	#	"K_gene_PU1_gene_OCT1"			#	92
  1	;	#	"n_gene_PU1_gene_AhR"			#	93
  0	;	#	"K_gene_PU1_gene_AhR"			#	94
  1	;	#	"n_gene_PU1_gene_GFI1"			#	95
  0	;	#	"K_gene_PU1_gene_GFI1"			#	96
  0	;	#	"W_gene_AP1_RNAP"			#	97
  0	;	#	"W_gene_AP1_gene_AhR"			#	98
  0	;	#	"W_gene_AP1_gene_PU1"			#	99
  0	;	#	"W_gene_AP1_gene_PPARg"			#	100
  0	;	#	"W_gene_AhR_RNAP"			#	101
  0	;	#	"W_gene_AhR_gene_Trigger_RA"			#	102
  0	;	#	"W_gene_CD11b_RNAP"			#	103
  0	;	#	"W_gene_CD11b_gene_PU1_gene_cRAF"			#	104
  0	;	#	"W_gene_CD14_RNAP"			#	105
  0	;	#	"W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"			#	106
  0	;	#	"W_gene_CD38_RNAP"			#	107
  0	;	#	"W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"			#	108
  0	;	#	"W_gene_CEBPa_RNAP"			#	109
  0	;	#	"W_gene_CEBPa_gene_Trigger_RA"			#	110
  0	;	#	"W_gene_CEBPa_gene_Trigger_D3"			#	111
  0	;	#	"W_gene_CEBPa_gene_PPARg"			#	112
  0	;	#	"W_gene_CEBPa_gene_CEBPa"			#	113
  0	;	#	"W_gene_CEBPa_gene_GFI1"			#	114
  0	;	#	"W_gene_E2F_RNAP"			#	115
  0	;	#	"W_gene_E2F_gene_E2F"			#	116
  0	;	#	"W_gene_E2F_gene_PPARg"			#	117
  0	;	#	"W_gene_E2F_gene_CEBPa"			#	118
  0	;	#	"W_gene_E2F_gene_GFI1"			#	119
  0	;	#	"W_gene_E2F_gene_cRAF"			#	120
  0	;	#	"W_gene_EGR1_RNAP"			#	121
  0	;	#	"W_gene_EGR1_gene_Trigger_RA"			#	122
  0	;	#	"W_gene_EGR1_gene_PU1"			#	123
  0	;	#	"W_gene_EGR1_gene_PPARg"			#	124
  0	;	#	"W_gene_EGR1_gene_GFI1"			#	125
  0	;	#	"W_gene_GFI1_RNAP"			#	126
  0	;	#	"W_gene_GFI1_gene_CEBPa"			#	127
  0	;	#	"W_gene_GFI1_gene_EGR1"			#	128
  0	;	#	"W_gene_IRF1_RNAP"			#	129
  0	;	#	"W_gene_IRF1_gene_Trigger_RA"			#	130
  0	;	#	"W_gene_IRF1_gene_AhR"			#	131
  0	;	#	"W_gene_IRF1_gene_PPARg"			#	132
  0	;	#	"W_gene_OCT1_RNAP"			#	133
  0	;	#	"W_gene_OCT1_gene_PPARg"			#	134
  0	;	#	"W_gene_OCT4_RNAP"			#	135
  0	;	#	"W_gene_OCT4_gene_Trigger_RA"			#	136
  0	;	#	"W_gene_OCT4_gene_AhR"			#	137
  0	;	#	"W_gene_OCT4_gene_cRAF"			#	138
  0	;	#	"W_gene_P21_RNAP"			#	139
  0	;	#	"W_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"			#	140
  0	;	#	"W_gene_P21_gene_GFI1"			#	141
  0	;	#	"W_gene_P47Phox_RNAP"			#	142
  0	;	#	"W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"			#	143
  0	;	#	"W_gene_P47Phox_gene_PPARg"			#	144
  0	;	#	"W_gene_PPARg_RNAP"			#	145
  0	;	#	"W_gene_PPARg_gene_Trigger_RA"			#	146
  0	;	#	"W_gene_PPARg_gene_Trigger_D3"			#	147
  0	;	#	"W_gene_PPARg_gene_CEBPa"			#	148
  0	;	#	"W_gene_PPARg_gene_EGR1"			#	149
  0	;	#	"W_gene_PPARg_gene_PU1"			#	150
  0	;	#	"W_gene_PPARg_gene_AP1"			#	151
  0	;	#	"W_gene_PU1_RNAP"			#	152
  0	;	#	"W_gene_PU1_gene_Trigger_RA"			#	153
  0	;	#	"W_gene_PU1_gene_Trigger_D3"			#	154
  0	;	#	"W_gene_PU1_gene_CEBPa"			#	155
  0	;	#	"W_gene_PU1_gene_PU1"			#	156
  0	;	#	"W_gene_PU1_gene_AP1"			#	157
  0	;	#	"W_gene_PU1_gene_OCT1"			#	158
  0	;	#	"W_gene_PU1_gene_AhR"			#	159
  0	;	#	"W_gene_PU1_gene_GFI1"			#	160
  0	;	#	"W_gene_Trigger_D3_RNAP"			#	161
  0	;	#	"W_gene_Trigger_RA_RNAP"			#	162
  0	;	#	"W_gene_cRAF_RNAP"			#	163
  ];

  upper_bound_array = [
  4	;	#	"n_gene_AP1_gene_AhR"			#	1
  500	;	#	"K_gene_AP1_gene_AhR"			#	2
  4	;	#	"n_gene_AP1_gene_PU1"			#	3
  500	;	#	"K_gene_AP1_gene_PU1"			#	4
  4	;	#	"n_gene_AP1_gene_PPARg"			#	5
  500	;	#	"K_gene_AP1_gene_PPARg"			#	6
  4	;	#	"n_gene_AhR_gene_Trigger_RA"			#	7
  500	;	#	"K_gene_AhR_gene_Trigger_RA"			#	8
  4	;	#	"n_gene_CD11b_gene_PU1_gene_cRAF"			#	9
  500	;	#	"K_gene_CD11b_gene_PU1_gene_cRAF"			#	10
  4	;	#	"n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"			#	11
  500	;	#	"K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"			#	12
  4	;	#	"n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"			#	13
  500	;	#	"K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"			#	14
  4	;	#	"n_gene_CEBPa_gene_Trigger_RA"			#	15
  500	;	#	"K_gene_CEBPa_gene_Trigger_RA"			#	16
  4	;	#	"n_gene_CEBPa_gene_Trigger_D3"			#	17
  500	;	#	"K_gene_CEBPa_gene_Trigger_D3"			#	18
  4	;	#	"n_gene_CEBPa_gene_PPARg"			#	19
  500	;	#	"K_gene_CEBPa_gene_PPARg"			#	20
  4	;	#	"n_gene_CEBPa_gene_CEBPa"			#	21
  500	;	#	"K_gene_CEBPa_gene_CEBPa"			#	22
  4	;	#	"n_gene_CEBPa_gene_GFI1"			#	23
  500	;	#	"K_gene_CEBPa_gene_GFI1"			#	24
  4	;	#	"n_gene_E2F_gene_E2F"			#	25
  500	;	#	"K_gene_E2F_gene_E2F"			#	26
  4	;	#	"n_gene_E2F_gene_PPARg"			#	27
  500	;	#	"K_gene_E2F_gene_PPARg"			#	28
  4	;	#	"n_gene_E2F_gene_CEBPa"			#	29
  500	;	#	"K_gene_E2F_gene_CEBPa"			#	30
  4	;	#	"n_gene_E2F_gene_GFI1"			#	31
  500	;	#	"K_gene_E2F_gene_GFI1"			#	32
  4	;	#	"n_gene_E2F_gene_cRAF"			#	33
  500	;	#	"K_gene_E2F_gene_cRAF"			#	34
  4	;	#	"n_gene_EGR1_gene_Trigger_RA"			#	35
  500	;	#	"K_gene_EGR1_gene_Trigger_RA"			#	36
  4	;	#	"n_gene_EGR1_gene_PU1"			#	37
  500	;	#	"K_gene_EGR1_gene_PU1"			#	38
  4	;	#	"n_gene_EGR1_gene_PPARg"			#	39
  500	;	#	"K_gene_EGR1_gene_PPARg"			#	40
  4	;	#	"n_gene_EGR1_gene_GFI1"			#	41
  500	;	#	"K_gene_EGR1_gene_GFI1"			#	42
  4	;	#	"n_gene_GFI1_gene_CEBPa"			#	43
  500	;	#	"K_gene_GFI1_gene_CEBPa"			#	44
  4	;	#	"n_gene_GFI1_gene_EGR1"			#	45
  500	;	#	"K_gene_GFI1_gene_EGR1"			#	46
  4	;	#	"n_gene_IRF1_gene_Trigger_RA"			#	47
  500	;	#	"K_gene_IRF1_gene_Trigger_RA"			#	48
  4	;	#	"n_gene_IRF1_gene_AhR"			#	49
  500	;	#	"K_gene_IRF1_gene_AhR"			#	50
  4	;	#	"n_gene_IRF1_gene_PPARg"			#	51
  500	;	#	"K_gene_IRF1_gene_PPARg"			#	52
  4	;	#	"n_gene_OCT1_gene_PPARg"			#	53
  500	;	#	"K_gene_OCT1_gene_PPARg"			#	54
  4	;	#	"n_gene_OCT4_gene_Trigger_RA"			#	55
  500	;	#	"K_gene_OCT4_gene_Trigger_RA"			#	56
  4	;	#	"n_gene_OCT4_gene_AhR"			#	57
  500	;	#	"K_gene_OCT4_gene_AhR"			#	58
  4	;	#	"n_gene_OCT4_gene_cRAF"			#	59
  500	;	#	"K_gene_OCT4_gene_cRAF"			#	60
  4	;	#	"n_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"			#	61
  500	;	#	"K_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"			#	62
  4	;	#	"n_gene_P21_gene_GFI1"			#	63
  500	;	#	"K_gene_P21_gene_GFI1"			#	64
  4	;	#	"n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"			#	65
  500	;	#	"K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"			#	66
  4	;	#	"n_gene_P47Phox_gene_PPARg"			#	67
  500	;	#	"K_gene_P47Phox_gene_PPARg"			#	68
  4	;	#	"n_gene_PPARg_gene_Trigger_RA"			#	69
  500	;	#	"K_gene_PPARg_gene_Trigger_RA"			#	70
  4	;	#	"n_gene_PPARg_gene_Trigger_D3"			#	71
  500	;	#	"K_gene_PPARg_gene_Trigger_D3"			#	72
  4	;	#	"n_gene_PPARg_gene_CEBPa"			#	73
  500	;	#	"K_gene_PPARg_gene_CEBPa"			#	74
  4	;	#	"n_gene_PPARg_gene_EGR1"			#	75
  500	;	#	"K_gene_PPARg_gene_EGR1"			#	76
  4	;	#	"n_gene_PPARg_gene_PU1"			#	77
  500	;	#	"K_gene_PPARg_gene_PU1"			#	78
  4	;	#	"n_gene_PPARg_gene_AP1"			#	79
  500	;	#	"K_gene_PPARg_gene_AP1"			#	80
  4	;	#	"n_gene_PU1_gene_Trigger_RA"			#	81
  500	;	#	"K_gene_PU1_gene_Trigger_RA"			#	82
  4	;	#	"n_gene_PU1_gene_Trigger_D3"			#	83
  500	;	#	"K_gene_PU1_gene_Trigger_D3"			#	84
  4	;	#	"n_gene_PU1_gene_CEBPa"			#	85
  500	;	#	"K_gene_PU1_gene_CEBPa"			#	86
  4	;	#	"n_gene_PU1_gene_PU1"			#	87
  500	;	#	"K_gene_PU1_gene_PU1"			#	88
  4	;	#	"n_gene_PU1_gene_AP1"			#	89
  500	;	#	"K_gene_PU1_gene_AP1"			#	90
  4	;	#	"n_gene_PU1_gene_OCT1"			#	91
  500	;	#	"K_gene_PU1_gene_OCT1"			#	92
  4	;	#	"n_gene_PU1_gene_AhR"			#	93
  500	;	#	"K_gene_PU1_gene_AhR"			#	94
  4	;	#	"n_gene_PU1_gene_GFI1"			#	95
  500	;	#	"K_gene_PU1_gene_GFI1"			#	96
  500	;	#	"W_gene_AP1_RNAP"			#	97
  500	;	#	"W_gene_AP1_gene_AhR"			#	98
  500	;	#	"W_gene_AP1_gene_PU1"			#	99
  500	;	#	"W_gene_AP1_gene_PPARg"			#	100
  500	;	#	"W_gene_AhR_RNAP"			#	101
  500	;	#	"W_gene_AhR_gene_Trigger_RA"			#	102
  500	;	#	"W_gene_CD11b_RNAP"			#	103
  500	;	#	"W_gene_CD11b_gene_PU1_gene_cRAF"			#	104
  500	;	#	"W_gene_CD14_RNAP"			#	105
  500	;	#	"W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"			#	106
  500	;	#	"W_gene_CD38_RNAP"			#	107
  500	;	#	"W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"			#	108
  500	;	#	"W_gene_CEBPa_RNAP"			#	109
  500	;	#	"W_gene_CEBPa_gene_Trigger_RA"			#	110
  500	;	#	"W_gene_CEBPa_gene_Trigger_D3"			#	111
  500	;	#	"W_gene_CEBPa_gene_PPARg"			#	112
  500	;	#	"W_gene_CEBPa_gene_CEBPa"			#	113
  500	;	#	"W_gene_CEBPa_gene_GFI1"			#	114
  500	;	#	"W_gene_E2F_RNAP"			#	115
  500	;	#	"W_gene_E2F_gene_E2F"			#	116
  500	;	#	"W_gene_E2F_gene_PPARg"			#	117
  500	;	#	"W_gene_E2F_gene_CEBPa"			#	118
  500	;	#	"W_gene_E2F_gene_GFI1"			#	119
  500	;	#	"W_gene_E2F_gene_cRAF"			#	120
  500	;	#	"W_gene_EGR1_RNAP"			#	121
  500	;	#	"W_gene_EGR1_gene_Trigger_RA"			#	122
  500	;	#	"W_gene_EGR1_gene_PU1"			#	123
  500	;	#	"W_gene_EGR1_gene_PPARg"			#	124
  500	;	#	"W_gene_EGR1_gene_GFI1"			#	125
  500	;	#	"W_gene_GFI1_RNAP"			#	126
  500	;	#	"W_gene_GFI1_gene_CEBPa"			#	127
  500	;	#	"W_gene_GFI1_gene_EGR1"			#	128
  500	;	#	"W_gene_IRF1_RNAP"			#	129
  500	;	#	"W_gene_IRF1_gene_Trigger_RA"			#	130
  500	;	#	"W_gene_IRF1_gene_AhR"			#	131
  500	;	#	"W_gene_IRF1_gene_PPARg"			#	132
  500	;	#	"W_gene_OCT1_RNAP"			#	133
  500	;	#	"W_gene_OCT1_gene_PPARg"			#	134
  500	;	#	"W_gene_OCT4_RNAP"			#	135
  500	;	#	"W_gene_OCT4_gene_Trigger_RA"			#	136
  500	;	#	"W_gene_OCT4_gene_AhR"			#	137
  500	;	#	"W_gene_OCT4_gene_cRAF"			#	138
  500	;	#	"W_gene_P21_RNAP"			#	139
  500	;	#	"W_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"			#	140
  500	;	#	"W_gene_P21_gene_GFI1"			#	141
  500	;	#	"W_gene_P47Phox_RNAP"			#	142
  500	;	#	"W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"			#	143
  500	;	#	"W_gene_P47Phox_gene_PPARg"			#	144
  500	;	#	"W_gene_PPARg_RNAP"			#	145
  500	;	#	"W_gene_PPARg_gene_Trigger_RA"			#	146
  500	;	#	"W_gene_PPARg_gene_Trigger_D3"			#	147
  500	;	#	"W_gene_PPARg_gene_CEBPa"			#	148
  500	;	#	"W_gene_PPARg_gene_EGR1"			#	149
  500	;	#	"W_gene_PPARg_gene_PU1"			#	150
  500	;	#	"W_gene_PPARg_gene_AP1"			#	151
  500	;	#	"W_gene_PU1_RNAP"			#	152
  500	;	#	"W_gene_PU1_gene_Trigger_RA"			#	153
  500	;	#	"W_gene_PU1_gene_Trigger_D3"			#	154
  500	;	#	"W_gene_PU1_gene_CEBPa"			#	155
  500	;	#	"W_gene_PU1_gene_PU1"			#	156
  500	;	#	"W_gene_PU1_gene_AP1"			#	157
  500	;	#	"W_gene_PU1_gene_OCT1"			#	158
  500	;	#	"W_gene_PU1_gene_AhR"			#	159
  500	;	#	"W_gene_PU1_gene_GFI1"			#	160
  0	;	#	"W_gene_Trigger_D3_RNAP"			#	161
  0	;	#	"W_gene_Trigger_RA_RNAP"			#	162
  0	;	#	"W_gene_cRAF_RNAP"			#	163
  ];

  return (lower_bound_array,upper_bound_array)
end

function estimate_parameters(pObjectiveFunction,initial_parameter_array,data_dictionary,number_of_iterations,error_target,perturbation_array)

  # Get the initial parameter set -
  kVI = initial_parameter_array;
  N = length(kVI);

  # Initialize the bounds -
  (lower_bound_array,upper_bound_array) = bounds_function(N);

  # Initialize the algorithm parameters -
  D = 1+N/2;
  P_SUCC_TARGET = 2/11;
  CP = 1/12;
  CC = 2/(N+2);
  CCOV = 2/(N^2+6);
  PTHRESH = 0.99;

  # Set the initial search directions - apply -
  A = eye(N,N);
  AVG_P_SUCC = P_SUCC_TARGET;

  # Setup the run -
  should_loop_continue = true
  parameter_array = kVI;
  SIGMA = 0.10;

  # Initialize -
  error_array = zeros(2)
  error_array[1] = Inf
  counter = 1;
  fail_counter = 1;
  max_number_of_failed_steps = 50;
  parameter_archive = zeros(N);
  error_archive = zeros(1);
  error_tolerance = 15000.0
  while (should_loop_continue == true)

    # Generate new parameter set -
  	(perturbed_parameter_array,zV) = sample_function(parameter_array,initial_parameter_array,lower_bound_array,upper_bound_array,N,A,SIGMA);#,perturbation_array);

    # added --- make first guess equal to actual parameter -- localize solutions around it
    #if counter == 1
    #  perturbed_parameter_array = parameter_array
    #end

    # Evaluate the parameter array -
    objective_function_array = pObjectiveFunction(perturbed_parameter_array);
    error_array[2] = sum(objective_function_array);

    # Was the step good or bad?
    delta_error = error_array[2] - error_array[1];
  	if (delta_error<0)
  		LAMBDA_SUCC = 1;
  	else
  		LAMBDA_SUCC = 0;
  	end

  	# Update the step size -
  	(SIGMA,AVG_P_SUCC) = updateStepSize(LAMBDA_SUCC,AVG_P_SUCC,P_SUCC_TARGET,CP,D,SIGMA);

    # Ok, recompute the direction array -
    if (LAMBDA_SUCC == 1)

      # Message -
      msg = "Step improved the objective function. New error = "*string(error_array[2])*" Old error = "*string(error_array[1])*" counter = "*string(counter)
      println(msg)

  		# Keep the peturbed parameters -
  		parameter_array = perturbed_parameter_array;

  		# Update the covariance matrix -
  		A = updateCholesky(A,zV,CCOV,AVG_P_SUCC,PTHRESH);

  		# Update the error -
  		error_array[1] = error_array[2];

  		# If we have a successful step and we are stuck at the min, reset this
  		if (SIGMA<=1e-5)
  			SIGMA = 0.05;
  		end;

      # Save the parameters -
      if error_array[1] <= error_tolerance
        parameter_archive = [parameter_archive parameter_array];
        writedlm("ensemble_may13_archive4.dat",parameter_archive);

        # Save the error_archive -
        error_archive = [error_archive error_array[1,1]];
        writedlm("error_may13_archivev4.dat", error_archive);
      end

  		# Update the counter =
  		counter = counter + 1;
      fail_counter = 1; # reset

      # Write parameters to disk ...
      writedlm("parameter_best_may13_v1.dat",parameter_array);

  	else
  		# If we have a successful step and we are stuck at the min, reset this
  		if (SIGMA<=1e-5)
  			SIGMA = 0.05;
  		end;

      fail_counter = fail_counter + 1;
      msg = "No improvement. Current error = "*string(error_array[1])*" Step error = "*string(error_array[2])*" counter = "*string(counter)
      println(msg)
  	end
     #=
    # Save the parameters -
    if error_array[2] <= error_tolerance
      parameter_archive = [parameter_archive perturbed_parameter_array];
      writedlm("best_parameter_archive.dat",parameter_archive);

      # Save the error_archive -
      error_archive = [error_archive error_array[2]];
      writedlm("error_archive.dat", error_archive);
    end
    =#

    # if we are beyond the max failed steps, reset the system w/a random parameter guess -
		if (fail_counter>=max_number_of_failed_steps)

			# Reset the step length -
			SIGMA = 0.10;

			# Reset the direction array -
			A = eye(N,N);
			AVG_P_SUCC = P_SUCC_TARGET;

			# Generate a random guess -
      (perturbed_parameter_array,zV) = sample_function(parameter_array,initial_parameter_array,lower_bound_array,upper_bound_array,N,A,SIGMA);

      # Evaluate the parameter array that becomes the best
      error_array[1,1] = sum(pObjectiveFunction(perturbed_parameter_array));


			# let the user know that we are reseting -
			msg = "Number of failed steps excedded - reset the parameters and search direction"
			println(msg);

			# reset the counter -
			number_of_failed_steps = 0;
		end


  	# Check to see if we need to set FLAG -
  	if (counter>=number_of_iterations)
  		should_loop_continue = false;
  	end
    if error_array[1,1] <= error_target
      should_loop_continue = false;
    end
  end

  return parameter_array
end


function main()

  # Initialize -
  number_of_parameters = 163

  # Setup initial parameter guess -
  initial_parameter_array = zeros(number_of_parameters);

  # Load the data dictionary -
  data_dictionary = DataDictionary(0.0,0.0,0.0)

  # set up array that indicates which parameters can be perturbs
  perturbation_array = zeros(number_of_parameters)
  perturbation_indices = [] # which parameters are allowed to vary?
  if length(perturbation_indices) == 0
    perturbation_array = ones(number_of_parameters)
  else
    for param_index in [1:number_of_parameters;]
      if param_index in perturbation_indices
        perturbation_array[param_index] = 1
      end
    end
  end

for sample_index in collect(1:1)
  # Load the parameter array -
  #previous_parameter_array = readdlm("./parameter_best_norm_v1.dat")
  #previous_parameter_array = readdlm("parameter_best_may9_CDs_fitsall3_v1.dat.3")
 previous_parameter_array = readdlm("parameter_best_may13_v1.dat")

  # Update data dictionary to match new parameters before calculating obj
  parameter_mapping_array = data_dictionary["parameter_name_mapping_array"]
  for index = 1:length(parameter_mapping_array)
    if index <= data_dictionary["number_of_binding"]
      #value = data_dictionary["binding_parameter_dictionary"][parameter_mapping_array[index]]
      value = previous_parameter_array[index]
      initial_parameter_array[index] = value;
    else
      #value = data_dictionary["control_parameter_dictionary"][parameter_mapping_array[index]]
      value = previous_parameter_array[index]
      initial_parameter_array[index] = value;
    end
  end

    # Setup stoping criteria -
    NUMBER_OF_ITERATIONS = 2000;
    ERR_TARGET = 0.01;

    # Setup function pointers -
    pObjectiveFunction = objective_function;

    # estimate parameters -
    parameter_array = estimate_parameters(pObjectiveFunction,initial_parameter_array,data_dictionary,NUMBER_OF_ITERATIONS,ERR_TARGET,perturbation_array);

    # Write parameters to disk ...
    @show sample_index
    writedlm("parameter_best_may13_v1.dat",parameter_array);
    writedlm("parameter_best_may13_v1.dat"*string(sample_index),parameter_array)
  end
end

# Run me ...
main()
