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

function sample_function(parameter_guess,kVI,lower_bound_array,upper_bound_array,NPARAMETERS,A,SIGMA)

  # Generate a new vector -
  zV = randn(NPARAMETERS);

  # Compute the new perturbed parameter vector -
  perturbed_parameter_array = parameter_guess.*(1 + SIGMA*A*zV);
  corrected_parameter_array = parameter_bounds_function(perturbed_parameter_array,lower_bound_array,upper_bound_array);

  # return -
  return (corrected_parameter_array,zV)
end

function bounds_function(number_of_parameters)

  # Setup my upper bound, and lower bounds on parameters -
  #lower_bound_array = zeros(number_of_parameters)
  lower_bound_array = [
      0.25	;	#	"n_gene_AP1_gene_AhR"	;	# 1
      0	;	#	"K_gene_AP1_gene_AhR"	;	# 2
      0.25	;	#	"n_gene_AP1_gene_PU1"	;	# 3
      0	;	#	"K_gene_AP1_gene_PU1"	;	# 4
      0.25	;	#	"n_gene_AP1_gene_PPARg"	;	# 5
      0	;	#	"K_gene_AP1_gene_PPARg"	;	# 6
      0.25	;	#	"n_gene_AhR_gene_Trigger_RA"	;	# 7
      0	;	#	"K_gene_AhR_gene_Trigger_RA"	;	# 8
      0.25	;	#	"n_gene_CD11b_gene_PU1_gene_cRAF"	;	# 9
      0	;	#	"K_gene_CD11b_gene_PU1_gene_cRAF"	;	# 10
      0.25	;	#	"n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 11
      0	;	#	"K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 12
      0.25	;	#	"n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 13
      0	;	#	"K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 14
      0.25	;	#	"n_gene_CEBPa_gene_Trigger_RA"	;	# 15
      0	;	#	"K_gene_CEBPa_gene_Trigger_RA"	;	# 16
      0.25	;	#	"n_gene_CEBPa_gene_PPARg"	;	# 17
      0	;	#	"K_gene_CEBPa_gene_PPARg"	;	# 18
      0.25	;	#	"n_gene_CEBPa_gene_CEBPa"	;	# 19
      0	;	#	"K_gene_CEBPa_gene_CEBPa"	;	# 20
      0.25	;	#	"n_gene_CEBPa_gene_GFI1"	;	# 21
      0	;	#	"K_gene_CEBPa_gene_GFI1"	;	# 22
      0.25	;	#	"n_gene_E2F_gene_E2F"	;	# 23
      0	;	#	"K_gene_E2F_gene_E2F"	;	# 24
      0.25	;	#	"n_gene_E2F_gene_PPARg"	;	# 25
      0	;	#	"K_gene_E2F_gene_PPARg"	;	# 26
      0.25	;	#	"n_gene_E2F_gene_CEBPa"	;	# 27
      0	;	#	"K_gene_E2F_gene_CEBPa"	;	# 28
      0.25	;	#	"n_gene_E2F_gene_GFI1"	;	# 29
      0	;	#	"K_gene_E2F_gene_GFI1"	;	# 30
      0.25	;	#	"n_gene_E2F_gene_cRAF"	;	# 31
      0	;	#	"K_gene_E2F_gene_cRAF"	;	# 32
      0.25	;	#	"n_gene_EGR1_gene_Trigger_RA"	;	# 33
      0	;	#	"K_gene_EGR1_gene_Trigger_RA"	;	# 34
      0.25	;	#	"n_gene_EGR1_gene_PU1"	;	# 35
      0	;	#	"K_gene_EGR1_gene_PU1"	;	# 36
      0.25	;	#	"n_gene_EGR1_gene_PPARg"	;	# 37
      0	;	#	"K_gene_EGR1_gene_PPARg"	;	# 38
      0.25	;	#	"n_gene_EGR1_gene_GFI1"	;	# 39
      0	;	#	"K_gene_EGR1_gene_GFI1"	;	# 40
      0.25	;	#	"n_gene_GFI1_gene_CEBPa"	;	# 41
      0	;	#	"K_gene_GFI1_gene_CEBPa"	;	# 42
      0.25	;	#	"n_gene_GFI1_gene_EGR1"	;	# 43
      0	;	#	"K_gene_GFI1_gene_EGR1"	;	# 44
      0.25	;	#	"n_gene_IRF1_gene_Trigger_RA"	;	# 45
      0	;	#	"K_gene_IRF1_gene_Trigger_RA"	;	# 46
      0.25	;	#	"n_gene_IRF1_gene_AhR"	;	# 47
      0	;	#	"K_gene_IRF1_gene_AhR"	;	# 48
      0.25	;	#	"n_gene_IRF1_gene_PPARg"	;	# 49
      0	;	#	"K_gene_IRF1_gene_PPARg"	;	# 50
      0.25	;	#	"n_gene_OCT1_gene_PPARg"	;	# 51
      0	;	#	"K_gene_OCT1_gene_PPARg"	;	# 52
      0.25	;	#	"n_gene_OCT4_gene_Trigger_RA"	;	# 53
      0	;	#	"K_gene_OCT4_gene_Trigger_RA"	;	# 54
      0.25	;	#	"n_gene_OCT4_gene_AhR"	;	# 55
      0	;	#	"K_gene_OCT4_gene_AhR"	;	# 56
      0.25	;	#	"n_gene_OCT4_gene_cRAF"	;	# 57
      0	;	#	"K_gene_OCT4_gene_cRAF"	;	# 58
      0.25	;	#	"n_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 59
      0	;	#	"K_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 60
      0.25	;	#	"n_gene_P21_gene_GFI1"	;	# 61
      0	;	#	"K_gene_P21_gene_GFI1"	;	# 62
      0.25	;	#	"n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 63
      0	;	#	"K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 64
      0.25	;	#	"n_gene_P47Phox_gene_PPARg"	;	# 65
      0	;	#	"K_gene_P47Phox_gene_PPARg"	;	# 66
      0.25	;	#	"n_gene_PPARg_gene_Trigger_RA"	;	# 67
      0	;	#	"K_gene_PPARg_gene_Trigger_RA"	;	# 68
      0.25	;	#	"n_gene_PPARg_gene_Trigger_D3"	;	# 69
      0	;	#	"K_gene_PPARg_gene_Trigger_D3"	;	# 70
      0.25	;	#	"n_gene_PPARg_gene_CEBPa"	;	# 71
      0	;	#	"K_gene_PPARg_gene_CEBPa"	;	# 72
      0.25	;	#	"n_gene_PPARg_gene_EGR1"	;	# 73
      0	;	#	"K_gene_PPARg_gene_EGR1"	;	# 74
      0.25	;	#	"n_gene_PPARg_gene_PU1"	;	# 75
      0	;	#	"K_gene_PPARg_gene_PU1"	;	# 76
      0.25	;	#	"n_gene_PPARg_gene_AP1"	;	# 77
      0	;	#	"K_gene_PPARg_gene_AP1"	;	# 78
      0.25	;	#	"n_gene_PU1_gene_Trigger_RA"	;	# 79
      0	;	#	"K_gene_PU1_gene_Trigger_RA"	;	# 80
      0.25	;	#	"n_gene_PU1_gene_Trigger_D3"	;	# 81
      0	;	#	"K_gene_PU1_gene_Trigger_D3"	;	# 82
      0.25	;	#	"n_gene_PU1_gene_CEBPa"	;	# 83
      0	;	#	"K_gene_PU1_gene_CEBPa"	;	# 84
      0.25	;	#	"n_gene_PU1_gene_PU1"	;	# 85
      0	;	#	"K_gene_PU1_gene_PU1"	;	# 86
      0.25	;	#	"n_gene_PU1_gene_AP1"	;	# 87
      0	;	#	"K_gene_PU1_gene_AP1"	;	# 88
      0.25	;	#	"n_gene_PU1_gene_OCT1"	;	# 89
      0	;	#	"K_gene_PU1_gene_OCT1"	;	# 90
      0.25	;	#	"n_gene_PU1_gene_AhR"	;	# 91
      0	;	#	"K_gene_PU1_gene_AhR"	;	# 92
      0.25	;	#	"n_gene_PU1_gene_GFI1"	;	# 93
      0	;	#	"K_gene_PU1_gene_GFI1"	;	# 94
      0	;	#	"W_gene_AP1_RNAP"	;	# 95
      0	;	#	"W_gene_AP1_gene_AhR"	;	# 96
      0	;	#	"W_gene_AP1_gene_PU1"	;	# 97
      0	;	#	"W_gene_AP1_gene_PPARg"	;	# 98
      0	;	#	"W_gene_AhR_RNAP"	;	# 99
      0	;	#	"W_gene_AhR_gene_Trigger_RA"	;	# 100
      0	;	#	"W_gene_CD11b_RNAP"	;	# 101
      0	;	#	"W_gene_CD11b_gene_PU1_gene_cRAF"	;	# 102
      0	;	#	"W_gene_CD14_RNAP"	;	# 103
      0	;	#	"W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 104
      0	;	#	"W_gene_CD38_RNAP"	;	# 105
      0	;	#	"W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 106
      0	;	#	"W_gene_CEBPa_RNAP"	;	# 107
      0	;	#	"W_gene_CEBPa_gene_Trigger_RA"	;	# 108
      0	;	#	"W_gene_CEBPa_gene_PPARg"	;	# 109
      0	;	#	"W_gene_CEBPa_gene_CEBPa"	;	# 110
      0	;	#	"W_gene_CEBPa_gene_GFI1"	;	# 111
      0	;	#	"W_gene_E2F_RNAP"	;	# 112
      0	;	#	"W_gene_E2F_gene_E2F"	;	# 113
      0	;	#	"W_gene_E2F_gene_PPARg"	;	# 114
      0	;	#	"W_gene_E2F_gene_CEBPa"	;	# 115
      0	;	#	"W_gene_E2F_gene_GFI1"	;	# 116
      0	;	#	"W_gene_E2F_gene_cRAF"	;	# 117
      0	;	#	"W_gene_EGR1_RNAP"	;	# 118
      0	;	#	"W_gene_EGR1_gene_Trigger_RA"	;	# 119
      0	;	#	"W_gene_EGR1_gene_PU1"	;	# 120
      0	;	#	"W_gene_EGR1_gene_PPARg"	;	# 121
      0	;	#	"W_gene_EGR1_gene_GFI1"	;	# 122
      0	;	#	"W_gene_GFI1_RNAP"	;	# 123
      0	;	#	"W_gene_GFI1_gene_CEBPa"	;	# 124
      0	;	#	"W_gene_GFI1_gene_EGR1"	;	# 125
      0	;	#	"W_gene_IRF1_RNAP"	;	# 126
      0	;	#	"W_gene_IRF1_gene_Trigger_RA"	;	# 127
      0	;	#	"W_gene_IRF1_gene_AhR"	;	# 128
      0	;	#	"W_gene_IRF1_gene_PPARg"	;	# 129
      0	;	#	"W_gene_OCT1_RNAP"	;	# 130
      0	;	#	"W_gene_OCT1_gene_PPARg"	;	# 131
      0	;	#	"W_gene_OCT4_RNAP"	;	# 132
      0	;	#	"W_gene_OCT4_gene_Trigger_RA"	;	# 133
      0	;	#	"W_gene_OCT4_gene_AhR"	;	# 134
      0	;	#	"W_gene_OCT4_gene_cRAF"	;	# 135
      0	;	#	"W_gene_P21_RNAP"	;	# 136
      0	;	#	"W_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 137
      0	;	#	"W_gene_P21_gene_GFI1"	;	# 138
      0	;	#	"W_gene_P47Phox_RNAP"	;	# 139
      0	;	#	"W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 140
      0	;	#	"W_gene_P47Phox_gene_PPARg"	;	# 141
      0	;	#	"W_gene_PPARg_RNAP"	;	# 142
      0	;	#	"W_gene_PPARg_gene_Trigger_RA"	;	# 143
      0	;	#	"W_gene_PPARg_gene_Trigger_D3"	;	# 144
      0	;	#	"W_gene_PPARg_gene_CEBPa"	;	# 145
      0	;	#	"W_gene_PPARg_gene_EGR1"	;	# 146
      0	;	#	"W_gene_PPARg_gene_PU1"	;	# 147
      0	;	#	"W_gene_PPARg_gene_AP1"	;	# 148
      0	;	#	"W_gene_PU1_RNAP"	;	# 149
      0	;	#	"W_gene_PU1_gene_Trigger_RA"	;	# 150
      0	;	#	"W_gene_PU1_gene_Trigger_D3"	;	# 151
      0	;	#	"W_gene_PU1_gene_CEBPa"	;	# 152
      0	;	#	"W_gene_PU1_gene_PU1"	;	# 153
      0	;	#	"W_gene_PU1_gene_AP1"	;	# 154
      0	;	#	"W_gene_PU1_gene_OCT1"	;	# 155
      0	;	#	"W_gene_PU1_gene_AhR"	;	# 156
      0	;	#	"W_gene_PU1_gene_GFI1"	;	# 157
      0	;	#	"W_gene_Trigger_D3_RNAP"	;	# 158
      0	;	#	"W_gene_Trigger_RA_RNAP"	;	# 159
      0	;	#	"W_gene_cRAF_RNAP"	;	# 160
  ];

  upper_bound_array = [
  4	; #	"n_gene_AP1_gene_AhR"	;	# 1
  500	; #	"K_gene_AP1_gene_AhR"	;	# 2
  4	; #	"n_gene_AP1_gene_PU1"	;	# 3
  500	; #	"K_gene_AP1_gene_PU1"	;	# 4
  4	; #	"n_gene_AP1_gene_PPARg"	;	# 5
  500	; #	"K_gene_AP1_gene_PPARg"	;	# 6
  4	; #	"n_gene_AhR_gene_Trigger_RA"	;	# 7
  500	; #	"K_gene_AhR_gene_Trigger_RA"	;	# 8
  4	; #	"n_gene_CD11b_gene_PU1_gene_cRAF"	;	# 9
  500	; #	"K_gene_CD11b_gene_PU1_gene_cRAF"	;	# 10
  4	; #	"n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 11
  500	; #	"K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 12
  4	; #	"n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 13
  500	; #	"K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 14
  4	; #	"n_gene_CEBPa_gene_Trigger_RA"	;	# 15
  500	; #	"K_gene_CEBPa_gene_Trigger_RA"	;	# 16
  4	; #	"n_gene_CEBPa_gene_PPARg"	;	# 17
  500	; #	"K_gene_CEBPa_gene_PPARg"	;	# 18
  4	; #	"n_gene_CEBPa_gene_CEBPa"	;	# 19
  500	; #	"K_gene_CEBPa_gene_CEBPa"	;	# 20
  4	; #	"n_gene_CEBPa_gene_GFI1"	;	# 21
  500	; #	"K_gene_CEBPa_gene_GFI1"	;	# 22
  4	; #	"n_gene_E2F_gene_E2F"	;	# 23
  500	; #	"K_gene_E2F_gene_E2F"	;	# 24
  4	; #	"n_gene_E2F_gene_PPARg"	;	# 25
  500	; #	"K_gene_E2F_gene_PPARg"	;	# 26
  4	; #	"n_gene_E2F_gene_CEBPa"	;	# 27
  500	; #	"K_gene_E2F_gene_CEBPa"	;	# 28
  4	; #	"n_gene_E2F_gene_GFI1"	;	# 29
  500	; #	"K_gene_E2F_gene_GFI1"	;	# 30
  4	; #	"n_gene_E2F_gene_cRAF"	;	# 31
  500	; #	"K_gene_E2F_gene_cRAF"	;	# 32
  4	; #	"n_gene_EGR1_gene_Trigger_RA"	;	# 33
  500	; #	"K_gene_EGR1_gene_Trigger_RA"	;	# 34
  4	; #	"n_gene_EGR1_gene_PU1"	;	# 35
  500	; #	"K_gene_EGR1_gene_PU1"	;	# 36
  4	; #	"n_gene_EGR1_gene_PPARg"	;	# 37
  500	; #	"K_gene_EGR1_gene_PPARg"	;	# 38
  4	; #	"n_gene_EGR1_gene_GFI1"	;	# 39
  500	; #	"K_gene_EGR1_gene_GFI1"	;	# 40
  4	; #	"n_gene_GFI1_gene_CEBPa"	;	# 41
  500	; #	"K_gene_GFI1_gene_CEBPa"	;	# 42
  4	; #	"n_gene_GFI1_gene_EGR1"	;	# 43
  500	; #	"K_gene_GFI1_gene_EGR1"	;	# 44
  4	; #	"n_gene_IRF1_gene_Trigger_RA"	;	# 45
  500	; #	"K_gene_IRF1_gene_Trigger_RA"	;	# 46
  4	; #	"n_gene_IRF1_gene_AhR"	;	# 47
  500	; #	"K_gene_IRF1_gene_AhR"	;	# 48
  4	; #	"n_gene_IRF1_gene_PPARg"	;	# 49
  500	; #	"K_gene_IRF1_gene_PPARg"	;	# 50
  4	; #	"n_gene_OCT1_gene_PPARg"	;	# 51
  500	; #	"K_gene_OCT1_gene_PPARg"	;	# 52
  4	; #	"n_gene_OCT4_gene_Trigger_RA"	;	# 53
  500	; #	"K_gene_OCT4_gene_Trigger_RA"	;	# 54
  4	; #	"n_gene_OCT4_gene_AhR"	;	# 55
  500	; #	"K_gene_OCT4_gene_AhR"	;	# 56
  4	; #	"n_gene_OCT4_gene_cRAF"	;	# 57
  500	; #	"K_gene_OCT4_gene_cRAF"	;	# 58
  4	; #	"n_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 59
  500	; #	"K_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 60
  4	; #	"n_gene_P21_gene_GFI1"	;	# 61
  500	; #	"K_gene_P21_gene_GFI1"	;	# 62
  4	; #	"n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 63
  500	; #	"K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 64
  4	; #	"n_gene_P47Phox_gene_PPARg"	;	# 65
  500	; #	"K_gene_P47Phox_gene_PPARg"	;	# 66
  4	; #	"n_gene_PPARg_gene_Trigger_RA"	;	# 67
  500	; #	"K_gene_PPARg_gene_Trigger_RA"	;	# 68
  4	; #	"n_gene_PPARg_gene_Trigger_D3"	;	# 69
  500	; #	"K_gene_PPARg_gene_Trigger_D3"	;	# 70
  4	; #	"n_gene_PPARg_gene_CEBPa"	;	# 71
  500	; #	"K_gene_PPARg_gene_CEBPa"	;	# 72
  4	; #	"n_gene_PPARg_gene_EGR1"	;	# 73
  500	; #	"K_gene_PPARg_gene_EGR1"	;	# 74
  4	; #	"n_gene_PPARg_gene_PU1"	;	# 75
  500	; #	"K_gene_PPARg_gene_PU1"	;	# 76
  4	; #	"n_gene_PPARg_gene_AP1"	;	# 77
  500	; #	"K_gene_PPARg_gene_AP1"	;	# 78
  4	; #	"n_gene_PU1_gene_Trigger_RA"	;	# 79
  500	; #	"K_gene_PU1_gene_Trigger_RA"	;	# 80
  4	; #	"n_gene_PU1_gene_Trigger_D3"	;	# 81
  500	; #	"K_gene_PU1_gene_Trigger_D3"	;	# 82
  4	; #	"n_gene_PU1_gene_CEBPa"	;	# 83
  500	; #	"K_gene_PU1_gene_CEBPa"	;	# 84
  4	; #	"n_gene_PU1_gene_PU1"	;	# 85
  500	; #	"K_gene_PU1_gene_PU1"	;	# 86
  4	; #	"n_gene_PU1_gene_AP1"	;	# 87
  500	; #	"K_gene_PU1_gene_AP1"	;	# 88
  4	; #	"n_gene_PU1_gene_OCT1"	;	# 89
  500	; #	"K_gene_PU1_gene_OCT1"	;	# 90
  4	; #	"n_gene_PU1_gene_AhR"	;	# 91
  500	; #	"K_gene_PU1_gene_AhR"	;	# 92
  4	; #	"n_gene_PU1_gene_GFI1"	;	# 93
  500	; #	"K_gene_PU1_gene_GFI1"	;	# 94
  100	; #	"W_gene_AP1_RNAP"	;	# 95
  100	; #	"W_gene_AP1_gene_AhR"	;	# 96
  100	; #	"W_gene_AP1_gene_PU1"	;	# 97
  100	; #	"W_gene_AP1_gene_PPARg"	;	# 98
  100	; #	"W_gene_AhR_RNAP"	;	# 99
  100	; #	"W_gene_AhR_gene_Trigger_RA"	;	# 100
  100	; #	"W_gene_CD11b_RNAP"	;	# 101
  100	; #	"W_gene_CD11b_gene_PU1_gene_cRAF"	;	# 102
  100	; #	"W_gene_CD14_RNAP"	;	# 103
  100	; #	"W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 104
  100	; #	"W_gene_CD38_RNAP"	;	# 105
  100	; #	"W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 106
  100	; #	"W_gene_CEBPa_RNAP"	;	# 107
  100	; #	"W_gene_CEBPa_gene_Trigger_RA"	;	# 108
  100	; #	"W_gene_CEBPa_gene_PPARg"	;	# 109
  100	; #	"W_gene_CEBPa_gene_CEBPa"	;	# 110
  100	; #	"W_gene_CEBPa_gene_GFI1"	;	# 111
  100	; #	"W_gene_E2F_RNAP"	;	# 112
  100	; #	"W_gene_E2F_gene_E2F"	;	# 113
  100	; #	"W_gene_E2F_gene_PPARg"	;	# 114
  100	; #	"W_gene_E2F_gene_CEBPa"	;	# 115
  100	; #	"W_gene_E2F_gene_GFI1"	;	# 116
  100	; #	"W_gene_E2F_gene_cRAF"	;	# 117
  100	; #	"W_gene_EGR1_RNAP"	;	# 118
  100	; #	"W_gene_EGR1_gene_Trigger_RA"	;	# 119
  100	; #	"W_gene_EGR1_gene_PU1"	;	# 120
  100	; #	"W_gene_EGR1_gene_PPARg"	;	# 121
  100	; #	"W_gene_EGR1_gene_GFI1"	;	# 122
  100	; #	"W_gene_GFI1_RNAP"	;	# 123
  100	; #	"W_gene_GFI1_gene_CEBPa"	;	# 124
  100	; #	"W_gene_GFI1_gene_EGR1"	;	# 125
  100	; #	"W_gene_IRF1_RNAP"	;	# 126
  100	; #	"W_gene_IRF1_gene_Trigger_RA"	;	# 127
  100	; #	"W_gene_IRF1_gene_AhR"	;	# 128
  100	; #	"W_gene_IRF1_gene_PPARg"	;	# 129
  100	; #	"W_gene_OCT1_RNAP"	;	# 130
  100	; #	"W_gene_OCT1_gene_PPARg"	;	# 131
  100	; #	"W_gene_OCT4_RNAP"	;	# 132
  100	; #	"W_gene_OCT4_gene_Trigger_RA"	;	# 133
  100	; #	"W_gene_OCT4_gene_AhR"	;	# 134
  100	; #	"W_gene_OCT4_gene_cRAF"	;	# 135
  100	; #	"W_gene_P21_RNAP"	;	# 136
  100	; #	"W_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 137
  100	; #	"W_gene_P21_gene_GFI1"	;	# 138
  100	; #	"W_gene_P47Phox_RNAP"	;	# 139
  100	; #	"W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 140
  100	; #	"W_gene_P47Phox_gene_PPARg"	;	# 141
  100	; #	"W_gene_PPARg_RNAP"	;	# 142
  100	; #	"W_gene_PPARg_gene_Trigger_RA"	;	# 143
  100	; #	"W_gene_PPARg_gene_Trigger_D3"	;	# 144
  100	; #	"W_gene_PPARg_gene_CEBPa"	;	# 145
  100	; #	"W_gene_PPARg_gene_EGR1"	;	# 146
  100	; #	"W_gene_PPARg_gene_PU1"	;	# 147
  100	; #	"W_gene_PPARg_gene_AP1"	;	# 148
  100	; #	"W_gene_PU1_RNAP"	;	# 149
  100	; #	"W_gene_PU1_gene_Trigger_RA"	;	# 150
  100	; #	"W_gene_PU1_gene_Trigger_D3"	;	# 151
  100	; #	"W_gene_PU1_gene_CEBPa"	;	# 152
  100	; #	"W_gene_PU1_gene_PU1"	;	# 153
  100	; #	"W_gene_PU1_gene_AP1"	;	# 154
  100	; #	"W_gene_PU1_gene_OCT1"	;	# 155
  100	; #	"W_gene_PU1_gene_AhR"	;	# 156
  100	; #	"W_gene_PU1_gene_GFI1"	;	# 157
  0	; #	"W_gene_Trigger_D3_RNAP"	;	# 158
  0	; #	"W_gene_Trigger_RA_RNAP"	;	# 159
  0	; #	"W_gene_cRAF_RNAP"	;	# 160
  ];

  return (lower_bound_array,upper_bound_array)
end

function estimate_parameters(pObjectiveFunction,initial_parameter_array,data_dictionary,number_of_iterations,error_target)

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
  while (should_loop_continue == true)

    # Generate new parameter set -
  	(perturbed_parameter_array,zV) = sample_function(parameter_array,initial_parameter_array,lower_bound_array,upper_bound_array,N,A,SIGMA);

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

  		# Update the counter =
  		counter = counter + 1;
      fail_counter = 1; # reset

      # Write parameters to disk ...
      writedlm("./parameter_best_v2.dat",parameter_array);

  	else
  		# If we have a successful step and we are stuck at the min, reset this
  		if (SIGMA<=1e-5)
  			SIGMA = 0.05;
  		end;

      fail_counter = fail_counter + 1;
      msg = "No improvement. Current error = "*string(error_array[1])*" Step error = "*string(error_array[2])*" counter = "*string(counter)
      println(msg)
  	end

  	# Check to see if we need to set FLAG -
  	if (counter>=number_of_iterations || error_array[1] <= error_target || fail_counter >= 1000)
  		should_loop_continue = false;
  	end
  end

  return parameter_array
end


function main()

  # Initialize -
  number_of_parameters = 160

  # Setup initial parameter guess -
  initial_parameter_array = zeros(number_of_parameters);

  # Load the data dictionary -
  data_dictionary = DataDictionary(0.0,0.0,0.0);

for sample_index in collect(25:100)
  # Load the parameter array -
  previous_parameter_array = readdlm("./parameter_best_v2.dat")

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
    NUMBER_OF_ITERATIONS = 100;
    ERR_TARGET = 50;

    # Setup function pointers -
    pObjectiveFunction = objective_function;

    # estimate parameters -
    parameter_array = estimate_parameters(pObjectiveFunction,initial_parameter_array,data_dictionary,NUMBER_OF_ITERATIONS,ERR_TARGET);

    # Write parameters to disk ...
    @show sample_index
    writedlm("./parameter_best_v2.dat",parameter_array);
    writedlm("./parameter_best_v2.dat."*string(sample_index),parameter_array)
  end
end

# Run me ...
main()
