# ================ INITIALIZATION CODE DO NOT EDIT ====================================== %
# some global parameters -
BIG = 1e10
SMALL = 1e-8

# Load the experiment specifications -
tmp_value = JSON.parsefile("./experiments/Experiments.json")
experiment_array_RA = tmp_value["experiment_array_RA"] # RA treatment
experiment_array_D3 = tmp_value["experiment_array_D3"] # D3 treatment
experiment_array_RA_D3 = tmp_value["experiment_array_RA_D3"] # combination treatment

# preload the data -
cached_data_dictionary_RA = Dict()
for (experiment_index,experiment_dictionary_RA) in enumerate(experiment_array_RA)

  # Grab the data file -
  data_file_path = experiment_dictionary_RA["data_file"]
  experiment_id = experiment_dictionary_RA["experiment_id"]

  # Load the data -
  experimental_data_array = readdlm(data_file_path)

  # Cache the data w/experiment_id -
  cached_data_dictionary_RA[experiment_id] = experimental_data_array
end

cached_data_dictionary_D3 = Dict()
for (experiment_index,experiment_dictionary_D3) in enumerate(experiment_array_D3)

  # Grab the data file -
  data_file_path = experiment_dictionary_D3["data_file"]
  experiment_id = experiment_dictionary_D3["experiment_id"]

  # Load the data -
  experimental_data_array = readdlm(data_file_path)

  # Cache the data w/experiment_id -
  cached_data_dictionary_D3[experiment_id] = experimental_data_array
end

cached_data_dictionary_RA_D3 = Dict()
for (experiment_index,experiment_dictionary_RA_D3) in enumerate(experiment_array_RA_D3)

  # Grab the data file -
  data_file_path = experiment_dictionary_RA_D3["data_file"]
  experiment_id = experiment_dictionary_RA_D3["experiment_id"]

  # Load the data -
  experimental_data_array = readdlm(data_file_path)

  # Cache the data w/experiment_id -
  cached_data_dictionary_RA_D3[experiment_id] = experimental_data_array
end



# preload the error function calls -
cached_error_function_dictionary_RA = Dict()
for (experiment_index,experiment_dictionary_RA) in enumerate(experiment_array_RA)

  # Grab the experimental id -
  experiment_id = experiment_dictionary_RA["experiment_id"]

  # Grab the error functions from the experiment_dictionary -
  error_function = eval(parse(experiment_dictionary_RA["error_function"]))

  # cache these functions -
  cached_error_function_dictionary_RA[experiment_id] = error_function
end

cached_error_function_dictionary_D3 = Dict()
for (experiment_index,experiment_dictionary_D3) in enumerate(experiment_array_D3)

  # Grab the experimental id -
  experiment_id = experiment_dictionary_D3["experiment_id"]

  # Grab the error functions from the experiment_dictionary -
  error_function = eval(parse(experiment_dictionary_D3["error_function"]))

  # cache these functions -
  cached_error_function_dictionary_D3[experiment_id] = error_function
end

cached_error_function_dictionary_RA_D3 = Dict()
for (experiment_index,experiment_dictionary_RA_D3) in enumerate(experiment_array_RA_D3)

  # Grab the experimental id -
  experiment_id = experiment_dictionary_RA_D3["experiment_id"]

  # Grab the error functions from the experiment_dictionary -
  error_function = eval(parse(experiment_dictionary_RA_D3["error_function"]))

  # cache these functions -
  cached_error_function_dictionary_RA_D3[experiment_id] = error_function
end
# ================ INITIALIZATION CODE DO NOT EDIT ====================================== %


function objective_function(parameter_array)

  # Script to solve the balance equations -
  time_start = 0.0
  time_stop = 120.0
  time_step_size = 0.01

  # Load the data dictionary -
  data_dictionary = DataDictionary(time_start,time_stop,time_step_size)

  # Update data dictionary to match new parameters before calculating obj
  parameter_mapping_array = data_dictionary["parameter_name_mapping_array"]
  for index = 1:length(parameter_mapping_array)
    if index <= data_dictionary["number_of_binding"]
      data_dictionary["binding_parameter_dictionary"][parameter_mapping_array[index]] = parameter_array[index]
    else
      data_dictionary["control_parameter_dictionary"][parameter_mapping_array[index]] = parameter_array[index]
    end
  end

  # how many objectives do we have?
  obj_array_RA = BIG*ones(13,1)
  obj_array_D3 = BIG*ones(12,1)
  obj_array_RA_D3 = BIG*ones(11,1)

  # Call simulation routine -
  # (run the model to SS, and then set the ICs to the SS for this parameter set)
  (time_array,simulation_state_array_RA,simulation_state_array_D3,simulation_state_array_RA_D3) = Simulation(time_start,time_stop,time_step_size,data_dictionary);

  # Call the error functions -
  # loop through the experimental dictionary, and call the appropriate error function -
  for (experiment_index,experiment_dictionary) in enumerate(experiment_array_RA) # FOR RA

    # Get the error function pointer -
    error_function_pointer = experiment_dictionary["error_function"]
    output_index = parse(Int,experiment_dictionary["output_index"])
    experiment_id = experiment_dictionary["experiment_id"]
    species_symbol = experiment_dictionary["protein_symbol"];

    # Get the experimental data array -
    experimental_data_array = cached_data_dictionary_RA[experiment_id]

    # Call the error function -
    error_function = cached_error_function_dictionary_RA[experiment_id]
    error_value = error_function(experimental_data_array,time_array,simulation_state_array_RA,output_index,species_symbol,data_dictionary)

    # Add the error to the objective array -
    obj_array_RA[experiment_index] = error_value;
  end

  for (experiment_index,experiment_dictionary) in enumerate(experiment_array_D3) # FOR D3

    # Get the error function pointer -
    error_function_pointer = experiment_dictionary["error_function"]
    output_index = parse(Int,experiment_dictionary["output_index"])
    experiment_id = experiment_dictionary["experiment_id"]
    species_symbol = experiment_dictionary["protein_symbol"];

    # Get the experimental data array -
    experimental_data_array = cached_data_dictionary_D3[experiment_id]

    # Call the error function -
    error_function = cached_error_function_dictionary_D3[experiment_id]
    error_value = error_function(experimental_data_array,time_array,simulation_state_array_D3,output_index,species_symbol,data_dictionary)

    # Add the error to the objective array -
    obj_array_D3[experiment_index] = error_value;
  end

  for (experiment_index,experiment_dictionary) in enumerate(experiment_array_RA_D3) # FOR COMBINATION

    # Get the error function pointer -
    error_function_pointer = experiment_dictionary["error_function"]
    output_index = parse(Int,experiment_dictionary["output_index"])
    experiment_id = experiment_dictionary["experiment_id"]
    species_symbol = experiment_dictionary["protein_symbol"];

    # Get the experimental data array -
    experimental_data_array = cached_data_dictionary_RA_D3[experiment_id]

    # Call the error function -
    error_function = cached_error_function_dictionary_RA_D3[experiment_id]
    error_value = error_function(experimental_data_array,time_array,simulation_state_array_RA_D3,output_index,species_symbol,data_dictionary)

    # Add the error to the objective array -
    obj_array_RA_D3[experiment_index] = error_value;
  end

  OBJ_TOTAL = [obj_array_RA;obj_array_D3;obj_array_RA_D3];
  @show sum(obj_array_RA),sum(obj_array_D3),sum(obj_array_RA_D3)
  # @show obj_array

  combined_obj_array = [obj_array_RA;obj_array_D3;obj_array_RA_D3];
  # return the error array -
  return OBJ_TOTAL
end


function neighbor_function(parameter_array)

  SIGMA = 0.01
  number_of_parameters = length(parameter_array)

  # calculate new parameters -
  perturbed_parameter_array = parameter_array.*(1+SIGMA*randn(number_of_parameters));

  # Parameters -
  # "n_gene_AP1_gene_AhR"	;	# 1
  # "K_gene_AP1_gene_AhR"	;	# 2
  # "n_gene_AP1_gene_PU1"	;	# 3
  # "K_gene_AP1_gene_PU1"	;	# 4
  # "n_gene_AP1_gene_PPARg"	;	# 5
  # "K_gene_AP1_gene_PPARg"	;	# 6
  # "n_gene_AhR_gene_Trigger"	;	# 7
  # "K_gene_AhR_gene_Trigger"	;	# 8
  # "n_gene_CD11b_gene_PU1_gene_cRAF"	;	# 9
  # "K_gene_CD11b_gene_PU1_gene_cRAF"	;	# 10
  # "n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 11
  # "K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 12
  # "n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_gene_cRAF"	;	# 13
  # "K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_gene_cRAF"	;	# 14
  # "n_gene_CEBPa_gene_Trigger"	;	# 15
  # "K_gene_CEBPa_gene_Trigger"	;	# 16
  # "n_gene_CEBPa_gene_PPARg"	;	# 17
  # "K_gene_CEBPa_gene_PPARg"	;	# 18
  # "n_gene_CEBPa_gene_CEBPa"	;	# 19
  # "K_gene_CEBPa_gene_CEBPa"	;	# 20
  # "n_gene_CEBPa_gene_GFI1"	;	# 21
  # "K_gene_CEBPa_gene_GFI1"	;	# 22
  # "n_gene_E2F_gene_E2F"	;	# 23
  # "K_gene_E2F_gene_E2F"	;	# 24
  # "n_gene_E2F_gene_PPARg"	;	# 25
  # "K_gene_E2F_gene_PPARg"	;	# 26
  # "n_gene_E2F_gene_CEBPa"	;	# 27
  # "K_gene_E2F_gene_CEBPa"	;	# 28
  # "n_gene_E2F_gene_GFI1"	;	# 29
  # "K_gene_E2F_gene_GFI1"	;	# 30
  # "n_gene_E2F_gene_cRAF"	;	# 31
  # "K_gene_E2F_gene_cRAF"	;	# 32
  # "n_gene_EGR1_gene_Trigger"	;	# 33
  # "K_gene_EGR1_gene_Trigger"	;	# 34
  # "n_gene_EGR1_gene_PU1"	;	# 35
  # "K_gene_EGR1_gene_PU1"	;	# 36
  # "n_gene_EGR1_gene_PPARg"	;	# 37
  # "K_gene_EGR1_gene_PPARg"	;	# 38
  # "n_gene_EGR1_gene_GFI1"	;	# 39
  # "K_gene_EGR1_gene_GFI1"	;	# 40
  # "n_gene_GFI1_gene_CEBPa"	;	# 41
  # "K_gene_GFI1_gene_CEBPa"	;	# 42
  # "n_gene_GFI1_gene_EGR1"	;	# 43
  # "K_gene_GFI1_gene_EGR1"	;	# 44
  # "n_gene_IRF1_gene_Trigger"	;	# 45
  # "K_gene_IRF1_gene_Trigger"	;	# 46
  # "n_gene_IRF1_gene_AhR"	;	# 47
  # "K_gene_IRF1_gene_AhR"	;	# 48
  # "n_gene_IRF1_gene_PPARg"	;	# 49
  # "K_gene_IRF1_gene_PPARg"	;	# 50
  # "n_gene_OCT1_gene_PPARg"	;	# 51
  # "K_gene_OCT1_gene_PPARg"	;	# 52
  # "n_gene_OCT4_gene_Trigger"	;	# 53
  # "K_gene_OCT4_gene_Trigger"	;	# 54
  # "n_gene_OCT4_gene_AhR"	;	# 55
  # "K_gene_OCT4_gene_AhR"	;	# 56
  # "n_gene_OCT4_gene_cRAF"	;	# 57
  # "K_gene_OCT4_gene_cRAF"	;	# 58
  # "n_gene_P21_gene_Trigger_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 59
  # "K_gene_P21_gene_Trigger_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 60
  # "n_gene_P21_gene_GFI1"	;	# 61
  # "K_gene_P21_gene_GFI1"	;	# 62
  # "n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 63
  # "K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 64
  # "n_gene_P47Phox_gene_PPARg"	;	# 65
  # "K_gene_P47Phox_gene_PPARg"	;	# 66
  # "n_gene_PPARg_gene_Trigger"	;	# 67
  # "K_gene_PPARg_gene_Trigger"	;	# 68
  # "n_gene_PPARg_gene_CEBPa"	;	# 69
  # "K_gene_PPARg_gene_CEBPa"	;	# 70
  # "n_gene_PPARg_gene_EGR1"	;	# 71
  # "K_gene_PPARg_gene_EGR1"	;	# 72
  # "n_gene_PPARg_gene_PU1"	;	# 73
  # "K_gene_PPARg_gene_PU1"	;	# 74
  # "n_gene_PPARg_gene_AP1"	;	# 75
  # "K_gene_PPARg_gene_AP1"	;	# 76
  # "n_gene_PU1_gene_Trigger"	;	# 77
  # "K_gene_PU1_gene_Trigger"	;	# 78
  # "n_gene_PU1_gene_CEBPa"	;	# 79
  # "K_gene_PU1_gene_CEBPa"	;	# 80
  # "n_gene_PU1_gene_PU1"	;	# 81
  # "K_gene_PU1_gene_PU1"	;	# 82
  # "n_gene_PU1_gene_AP1"	;	# 83
  # "K_gene_PU1_gene_AP1"	;	# 84
  # "n_gene_PU1_gene_OCT1"	;	# 85
  # "K_gene_PU1_gene_OCT1"	;	# 86
  # "n_gene_PU1_gene_AhR"	;	# 87
  # "K_gene_PU1_gene_AhR"	;	# 88
  # "n_gene_PU1_gene_GFI1"	;	# 89
  # "K_gene_PU1_gene_GFI1"	;	# 90
  # "W_gene_AP1_RNAP"	;	# 91
  # "W_gene_AP1_gene_AhR"	;	# 92
  # "W_gene_AP1_gene_PU1"	;	# 93
  # "W_gene_AP1_gene_PPARg"	;	# 94
  # "W_gene_AhR_RNAP"	;	# 95
  # "W_gene_AhR_gene_Trigger"	;	# 96
  # "W_gene_CD11b_RNAP"	;	# 97
  # "W_gene_CD11b_gene_PU1_gene_cRAF"	;	# 98
  # "W_gene_CD14_RNAP"	;	# 99
  # "W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 100
  # "W_gene_CD38_RNAP"	;	# 101
  # "W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_gene_cRAF"	;	# 102
  # "W_gene_CEBPa_RNAP"	;	# 103
  # "W_gene_CEBPa_gene_Trigger"	;	# 104
  # "W_gene_CEBPa_gene_PPARg"	;	# 105
  # "W_gene_CEBPa_gene_CEBPa"	;	# 106
  # "W_gene_CEBPa_gene_GFI1"	;	# 107
  # "W_gene_E2F_RNAP"	;	# 108
  # "W_gene_E2F_gene_E2F"	;	# 109
  # "W_gene_E2F_gene_PPARg"	;	# 110
  # "W_gene_E2F_gene_CEBPa"	;	# 111
  # "W_gene_E2F_gene_GFI1"	;	# 112
  # "W_gene_E2F_gene_cRAF"	;	# 113
  # "W_gene_EGR1_RNAP"	;	# 114
  # "W_gene_EGR1_gene_Trigger"	;	# 115
  # "W_gene_EGR1_gene_PU1"	;	# 116
  # "W_gene_EGR1_gene_PPARg"	;	# 117
  # "W_gene_EGR1_gene_GFI1"	;	# 118
  # "W_gene_GFI1_RNAP"	;	# 119
  # "W_gene_GFI1_gene_CEBPa"	;	# 120
  # "W_gene_GFI1_gene_EGR1"	;	# 121
  # "W_gene_IRF1_RNAP"	;	# 122
  # "W_gene_IRF1_gene_Trigger"	;	# 123
  # "W_gene_IRF1_gene_AhR"	;	# 124
  # "W_gene_IRF1_gene_PPARg"	;	# 125
  # "W_gene_OCT1_RNAP"	;	# 126
  # "W_gene_OCT1_gene_PPARg"	;	# 127obj_array_RA;obj_array_D3;obj_array_RA_D3
  # "W_gene_OCT4_RNAP"	;	# 128
  # "W_gene_OCT4_gene_Trigger"	;	# 129
  # "W_gene_OCT4_gene_AhR"	;	# 130
  # "W_gene_OCT4_gene_cRAF"	;	# 131
  # "W_gene_P21_RNAP"	;	# 132
  # "W_gene_P21_gene_Trigger_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF"	;	# 133
  # "W_gene_P21_gene_GFI1"	;	# 134
  # "W_gene_P47Phox_RNAP"	;	# 135
  # "W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 136
  # "W_gene_P47Phox_gene_PPARg"	;	# 137
  # "W_gene_PPARg_RNAP"	;	# 138
  # "W_gene_PPARg_gene_Trigger"	;	# 139
  # "W_gene_PPARg_gene_CEBPa"	;	# 140
  # "W_gene_PPARg_gene_EGR1"	;	# 141
  # "W_gene_PPARg_gene_PU1"	;	# 142
  # "W_gene_PPARg_gene_AP1"	;	# 143
  # "W_gene_PU1_RNAP"	;	# 144
  # "W_gene_PU1_gene_Trigger"	;	# 145
  # "W_gene_PU1_gene_CEBPa"	;	# 146
  # "W_gene_PU1_gene_PU1"	;	# 147
  # "W_gene_PU1_gene_AP1"	;	# 148
  # "W_gene_PU1_gene_OCT1"	;	# 149
  # "W_gene_PU1_gene_AhR"	;	# 150
  # "W_gene_PU1_gene_GFI1"	;	# 151
  # "W_gene_Trigger_RNAP"	;	# 152
  # "W_gene_cRAF_RNAP"	;	# 153

  # Setup my upper bound, and lower bounds on parameters -
  lower_bound_array = [
   0.25	; # 1	"n_gene_AP1_gene_AhR"
0	; # 2	"K_gene_AP1_gene_AhR"
0.25	; # 3	"n_gene_AP1_gene_PU1"
0	; # 4	"K_gene_AP1_gene_PU1"
0.25	; # 5	"n_gene_AP1_gene_PPARg"
0	; # 6	"K_gene_AP1_gene_PPARg"
0.25	; # 7	"n_gene_AhR_gene_Trigger_RA"
0	; # 8	"K_gene_AhR_gene_Trigger_RA"
0.25	; # 9	"n_gene_CD11b_gene_PU1_gene_cRAF"
0	; # 10	"K_gene_CD11b_gene_PU1_gene_cRAF"
0.25	; # 11	"n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"
0	; # 12	"K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"
0.25	; # 13	"n_gene_CD14_gene_repressor14"
0	; # 14	"K_gene_CD14_gene_repressor14"
0.25	; # 15	"n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"
0	; # 16	"K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"
0.25	; # 17	"n_gene_CEBPa_gene_Trigger_RA"
0	; # 18	"K_gene_CEBPa_gene_Trigger_RA"
0.25	; # 19	"n_gene_CEBPa_gene_PPARg"
0	; # 20	"K_gene_CEBPa_gene_PPARg"
0.25	; # 21	"n_gene_CEBPa_gene_CEBPa"
0	; # 22	"K_gene_CEBPa_gene_CEBPa"
0.25	; # 23	"n_gene_CEBPa_gene_GFI1"
0	; # 24	"K_gene_CEBPa_gene_GFI1"
0.25	; # 25	"n_gene_E2F_gene_E2F"
0	; # 26	"K_gene_E2F_gene_E2F"
0.25	; # 27	"n_gene_E2F_gene_PPARg"
0	; # 28	"K_gene_E2F_gene_PPARg"
0.25	; # 29	"n_gene_E2F_gene_CEBPa"
0	; # 30	"K_gene_E2F_gene_CEBPa"
0.25	; # 31	"n_gene_E2F_gene_GFI1"
0	; # 32	"K_gene_E2F_gene_GFI1"
0.25	; # 33	"n_gene_E2F_gene_cRAF"
0	; # 34	"K_gene_E2F_gene_cRAF"
0.25	; # 35	"n_gene_EGR1_gene_Trigger_RA"
0	; # 36	"K_gene_EGR1_gene_Trigger_RA"
0.25	; # 37	"n_gene_EGR1_gene_PU1"
0	; # 38	"K_gene_EGR1_gene_PU1"
0.25	; # 39	"n_gene_EGR1_gene_PPARg"
0	; # 40	"K_gene_EGR1_gene_PPARg"
0.25	; # 41	"n_gene_EGR1_gene_GFI1"
0	; # 42	"K_gene_EGR1_gene_GFI1"
0.25	; # 43	"n_gene_GFI1_gene_CEBPa"
0	; # 44	"K_gene_GFI1_gene_CEBPa"
0.25	; # 45	"n_gene_GFI1_gene_EGR1"
0	; # 46	"K_gene_GFI1_gene_EGR1"
0.25	; # 47	"n_gene_IRF1_gene_Trigger_RA"
0	; # 48	"K_gene_IRF1_gene_Trigger_RA"
0.25	; # 49	"n_gene_IRF1_gene_AhR"
0	; # 50	"K_gene_IRF1_gene_AhR"
0.25	; # 51	"n_gene_IRF1_gene_PPARg"
0	; # 52	"K_gene_IRF1_gene_PPARg"
0.25	; # 53	"n_gene_OCT1_gene_PPARg"
0	; # 54	"K_gene_OCT1_gene_PPARg"
0.25	; # 55	"n_gene_OCT4_gene_Trigger_RA"
0	; # 56	"K_gene_OCT4_gene_Trigger_RA"
0.25	; # 57	"n_gene_OCT4_gene_AhR"
0	; # 58	"K_gene_OCT4_gene_AhR"
0.25	; # 59	"n_gene_OCT4_gene_cRAF"
0	; # 60	"K_gene_OCT4_gene_cRAF"
0.25	; # 61	"n_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"
0	; # 62	"K_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"
0.25	; # 63	"n_gene_P21_gene_GFI1"
0	; # 64	"K_gene_P21_gene_GFI1"
0.25	; # 65	"n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"
0	; # 66	"K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"
0.25	; # 67	"n_gene_P47Phox_gene_PPARg"
0	; # 68	"K_gene_P47Phox_gene_PPARg"
0.25	; # 69	"n_gene_PPARg_gene_Trigger_RA"
0	; # 70	"K_gene_PPARg_gene_Trigger_RA"
0.25	; # 71	"n_gene_PPARg_gene_Trigger_D3"
0	; # 72	"K_gene_PPARg_gene_Trigger_D3"
0.25	; # 73	"n_gene_PPARg_gene_CEBPa"
0	; # 74	"K_gene_PPARg_gene_CEBPa"
0.25	; # 75	"n_gene_PPARg_gene_EGR1"
0	; # 76	"K_gene_PPARg_gene_EGR1"
0.25	; # 77	"n_gene_PPARg_gene_PU1"
0	; # 78	"K_gene_PPARg_gene_PU1"
0.25	; # 79	"n_gene_PPARg_gene_AP1"
0	; # 80	"K_gene_PPARg_gene_AP1"
0.25	; # 81	"n_gene_PU1_gene_Trigger_RA"
0	; # 82	"K_gene_PU1_gene_Trigger_RA"
0.25	; # 83	"n_gene_PU1_gene_Trigger_D3"
0	; # 84	"K_gene_PU1_gene_Trigger_D3"
0.25	; # 85	"n_gene_PU1_gene_CEBPa"
0	; # 86	"K_gene_PU1_gene_CEBPa"
0.25	; # 87	"n_gene_PU1_gene_PU1"
0	; # 88	"K_gene_PU1_gene_PU1"
0.25	; # 89	"n_gene_PU1_gene_AP1"
0	; # 90	"K_gene_PU1_gene_AP1"
0.25	; # 91	"n_gene_PU1_gene_OCT1"
0	; # 92	"K_gene_PU1_gene_OCT1"
0.25	; # 93	"n_gene_PU1_gene_AhR"
0	; # 94	"K_gene_PU1_gene_AhR"
0.25	; # 95	"n_gene_PU1_gene_GFI1"
0	; # 96	"K_gene_PU1_gene_GFI1"
0.25	; # 97	"n_gene_repressor14_gene_Trigger_RA"
0	; # 98	"K_gene_repressor14_gene_Trigger_RA"
0	; # 99	"W_gene_AP1_RNAP"
0	; # 100	"W_gene_AP1_gene_AhR"
0	; # 101	"W_gene_AP1_gene_PU1"
0	; # 102	"W_gene_AP1_gene_PPARg"
0	; # 103	"W_gene_AhR_RNAP"
0	; # 104	"W_gene_AhR_gene_Trigger_RA"
0	; # 105	"W_gene_CD11b_RNAP"
0	; # 106	"W_gene_CD11b_gene_PU1_gene_cRAF"
0	; # 107	"W_gene_CD14_RNAP"
0	; # 108	"W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"
0	; # 109	"W_gene_CD14_gene_repressor14"
0	; # 110	"W_gene_CD38_RNAP"
0	; # 111	"W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"
0	; # 112	"W_gene_CEBPa_RNAP"
0	; # 113	"W_gene_CEBPa_gene_Trigger_RA"
0	; # 114	"W_gene_CEBPa_gene_PPARg"
0	; # 115	"W_gene_CEBPa_gene_CEBPa"
0	; # 116	"W_gene_CEBPa_gene_GFI1"
0	; # 117	"W_gene_E2F_RNAP"
0	; # 118	"W_gene_E2F_gene_E2F"
0	; # 119	"W_gene_E2F_gene_PPARg"
0	; # 120	"W_gene_E2F_gene_CEBPa"
0	; # 121	"W_gene_E2F_gene_GFI1"
0	; # 122	"W_gene_E2F_gene_cRAF"
0	; # 123	"W_gene_EGR1_RNAP"
0	; # 124	"W_gene_EGR1_gene_Trigger_RA"
0	; # 125	"W_gene_EGR1_gene_PU1"
0	; # 126	"W_gene_EGR1_gene_PPARg"
0	; # 127	"W_gene_EGR1_gene_GFI1"
0	; # 128	"W_gene_GFI1_RNAP"
0	; # 129	"W_gene_GFI1_gene_CEBPa"
0	; # 130	"W_gene_GFI1_gene_EGR1"
0	; # 131	"W_gene_IRF1_RNAP"
0	; # 132	"W_gene_IRF1_gene_Trigger_RA"
0	; # 133	"W_gene_IRF1_gene_AhR"
0	; # 134	"W_gene_IRF1_gene_PPARg"
0	; # 135	"W_gene_OCT1_RNAP"
0	; # 136	"W_gene_OCT1_gene_PPARg"
0	; # 137	"W_gene_OCT4_RNAP"
0	; # 138	"W_gene_OCT4_gene_Trigger_RA"
0	; # 139	"W_gene_OCT4_gene_AhR"
0	; # 140	"W_gene_OCT4_gene_cRAF"
0	; # 141	"W_gene_P21_RNAP"
0	; # 142	"W_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"
0	; # 143	"W_gene_P21_gene_GFI1"
0	; # 144	"W_gene_P47Phox_RNAP"
0	; # 145	"W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"
0	; # 146	"W_gene_P47Phox_gene_PPARg"
0	; # 147	"W_gene_PPARg_RNAP"
0	; # 148	"W_gene_PPARg_gene_Trigger_RA"
0	; # 149	"W_gene_PPARg_gene_Trigger_D3"
0	; # 150	"W_gene_PPARg_gene_CEBPa"
0	; # 151	"W_gene_PPARg_gene_EGR1"
0	; # 152	"W_gene_PPARg_gene_PU1"
0	; # 153	"W_gene_PPARg_gene_AP1"
0	; # 154	"W_gene_PU1_RNAP"
0	; # 155	"W_gene_PU1_gene_Trigger_RA"
0	; # 156	"W_gene_PU1_gene_Trigger_D3"
0	; # 157	"W_gene_PU1_gene_CEBPa"
0	; # 158	"W_gene_PU1_gene_PU1"
0	; # 159	"W_gene_PU1_gene_AP1"
0	; # 160	"W_gene_PU1_gene_OCT1"
0	; # 161	"W_gene_PU1_gene_AhR"
0	; # 162	"W_gene_PU1_gene_GFI1"
0	; # 163	"W_gene_Trigger_D3_RNAP"
0	; # 164	"W_gene_Trigger_RA_RNAP"
0	; # 165	"W_gene_cRAF_RNAP"
0	; # 166	"W_gene_repressor14_RNAP"
0	; # 167	"W_gene_repressor14_gene_Trigger_RA"


  ]
  upper_bound_array = [
  4	; # 1	"n_gene_AP1_gene_AhR"
500	; # 2	"K_gene_AP1_gene_AhR"
4	; # 3	"n_gene_AP1_gene_PU1"
500	; # 4	"K_gene_AP1_gene_PU1"
4	; # 5	"n_gene_AP1_gene_PPARg"
500	; # 6	"K_gene_AP1_gene_PPARg"
4	; # 7	"n_gene_AhR_gene_Trigger_RA"
500	; # 8	"K_gene_AhR_gene_Trigger_RA"
4	; # 9	"n_gene_CD11b_gene_PU1_gene_cRAF"
500	; # 10	"K_gene_CD11b_gene_PU1_gene_cRAF"
4	; # 11	"n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"
500	; # 12	"K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"
4	; # 13	"n_gene_CD14_gene_repressor14"
500	; # 14	"K_gene_CD14_gene_repressor14"
4	; # 15	"n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"
500	; # 16	"K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"
4	; # 17	"n_gene_CEBPa_gene_Trigger_RA"
500	; # 18	"K_gene_CEBPa_gene_Trigger_RA"
4	; # 19	"n_gene_CEBPa_gene_PPARg"
500	; # 20	"K_gene_CEBPa_gene_PPARg"
4	; # 21	"n_gene_CEBPa_gene_CEBPa"
500	; # 22	"K_gene_CEBPa_gene_CEBPa"
4	; # 23	"n_gene_CEBPa_gene_GFI1"
500	; # 24	"K_gene_CEBPa_gene_GFI1"
4	; # 25	"n_gene_E2F_gene_E2F"
500	; # 26	"K_gene_E2F_gene_E2F"
4	; # 27	"n_gene_E2F_gene_PPARg"
500	; # 28	"K_gene_E2F_gene_PPARg"
4	; # 29	"n_gene_E2F_gene_CEBPa"
500	; # 30	"K_gene_E2F_gene_CEBPa"
4	; # 31	"n_gene_E2F_gene_GFI1"
500	; # 32	"K_gene_E2F_gene_GFI1"
4	; # 33	"n_gene_E2F_gene_cRAF"
500	; # 34	"K_gene_E2F_gene_cRAF"
4	; # 35	"n_gene_EGR1_gene_Trigger_RA"
500	; # 36	"K_gene_EGR1_gene_Trigger_RA"
4	; # 37	"n_gene_EGR1_gene_PU1"
500	; # 38	"K_gene_EGR1_gene_PU1"
4	; # 39	"n_gene_EGR1_gene_PPARg"
500	; # 40	"K_gene_EGR1_gene_PPARg"
4	; # 41	"n_gene_EGR1_gene_GFI1"
500	; # 42	"K_gene_EGR1_gene_GFI1"
4	; # 43	"n_gene_GFI1_gene_CEBPa"
500	; # 44	"K_gene_GFI1_gene_CEBPa"
4	; # 45	"n_gene_GFI1_gene_EGR1"
500	; # 46	"K_gene_GFI1_gene_EGR1"
4	; # 47	"n_gene_IRF1_gene_Trigger_RA"
500	; # 48	"K_gene_IRF1_gene_Trigger_RA"
4	; # 49	"n_gene_IRF1_gene_AhR"
500	; # 50	"K_gene_IRF1_gene_AhR"
4	; # 51	"n_gene_IRF1_gene_PPARg"
500	; # 52	"K_gene_IRF1_gene_PPARg"
4	; # 53	"n_gene_OCT1_gene_PPARg"
500	; # 54	"K_gene_OCT1_gene_PPARg"
4	; # 55	"n_gene_OCT4_gene_Trigger_RA"
500	; # 56	"K_gene_OCT4_gene_Trigger_RA"
4	; # 57	"n_gene_OCT4_gene_AhR"
500	; # 58	"K_gene_OCT4_gene_AhR"
4	; # 59	"n_gene_OCT4_gene_cRAF"
500	; # 60	"K_gene_OCT4_gene_cRAF"
4	; # 61	"n_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"
500	; # 62	"K_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"
4	; # 63	"n_gene_P21_gene_GFI1"
500	; # 64	"K_gene_P21_gene_GFI1"
4	; # 65	"n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"
500	; # 66	"K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"
4	; # 67	"n_gene_P47Phox_gene_PPARg"
500	; # 68	"K_gene_P47Phox_gene_PPARg"
4	; # 69	"n_gene_PPARg_gene_Trigger_RA"
500	; # 70	"K_gene_PPARg_gene_Trigger_RA"
4	; # 71	"n_gene_PPARg_gene_Trigger_D3"
500	; # 72	"K_gene_PPARg_gene_Trigger_D3"
4	; # 73	"n_gene_PPARg_gene_CEBPa"
500	; # 74	"K_gene_PPARg_gene_CEBPa"
4	; # 75	"n_gene_PPARg_gene_EGR1"
500	; # 76	"K_gene_PPARg_gene_EGR1"
4	; # 77	"n_gene_PPARg_gene_PU1"
500	; # 78	"K_gene_PPARg_gene_PU1"
4	; # 79	"n_gene_PPARg_gene_AP1"
500	; # 80	"K_gene_PPARg_gene_AP1"
4	; # 81	"n_gene_PU1_gene_Trigger_RA"
500	; # 82	"K_gene_PU1_gene_Trigger_RA"
4	; # 83	"n_gene_PU1_gene_Trigger_D3"
500	; # 84	"K_gene_PU1_gene_Trigger_D3"
4	; # 85	"n_gene_PU1_gene_CEBPa"
500	; # 86	"K_gene_PU1_gene_CEBPa"
4	; # 87	"n_gene_PU1_gene_PU1"
500	; # 88	"K_gene_PU1_gene_PU1"
4	; # 89	"n_gene_PU1_gene_AP1"
500	; # 90	"K_gene_PU1_gene_AP1"
4	; # 91	"n_gene_PU1_gene_OCT1"
500	; # 92	"K_gene_PU1_gene_OCT1"
4	; # 93	"n_gene_PU1_gene_AhR"
500	; # 94	"K_gene_PU1_gene_AhR"
4	; # 95	"n_gene_PU1_gene_GFI1"
500	; # 96	"K_gene_PU1_gene_GFI1"
4	; # 97	"n_gene_repressor14_gene_Trigger_RA"
500	; # 98	"K_gene_repressor14_gene_Trigger_RA"
100	; # 99	"W_gene_AP1_RNAP"
100	; # 100	"W_gene_AP1_gene_AhR"
100	; # 101	"W_gene_AP1_gene_PU1"
100	; # 102	"W_gene_AP1_gene_PPARg"
100	; # 103	"W_gene_AhR_RNAP"
100	; # 104	"W_gene_AhR_gene_Trigger_RA"
100	; # 105	"W_gene_CD11b_RNAP"
100	; # 106	"W_gene_CD11b_gene_PU1_gene_cRAF"
100	; # 107	"W_gene_CD14_RNAP"
100	; # 108	"W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"
100	; # 109	"W_gene_CD14_gene_repressor14"
100	; # 110	"W_gene_CD38_RNAP"
100	; # 111	"W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"
100	; # 112	"W_gene_CEBPa_RNAP"
100	; # 113	"W_gene_CEBPa_gene_Trigger_RA"
100	; # 114	"W_gene_CEBPa_gene_PPARg"
100	; # 115	"W_gene_CEBPa_gene_CEBPa"
100	; # 116	"W_gene_CEBPa_gene_GFI1"
100	; # 117	"W_gene_E2F_RNAP"
100	; # 118	"W_gene_E2F_gene_E2F"
100	; # 119	"W_gene_E2F_gene_PPARg"
100	; # 120	"W_gene_E2F_gene_CEBPa"
100	; # 121	"W_gene_E2F_gene_GFI1"
100	; # 122	"W_gene_E2F_gene_cRAF"
100	; # 123	"W_gene_EGR1_RNAP"
100	; # 124	"W_gene_EGR1_gene_Trigger_RA"
100	; # 125	"W_gene_EGR1_gene_PU1"
100	; # 126	"W_gene_EGR1_gene_PPARg"
100	; # 127	"W_gene_EGR1_gene_GFI1"
100	; # 128	"W_gene_GFI1_RNAP"
100	; # 129	"W_gene_GFI1_gene_CEBPa"
100	; # 130	"W_gene_GFI1_gene_EGR1"
100	; # 131	"W_gene_IRF1_RNAP"
100	; # 132	"W_gene_IRF1_gene_Trigger_RA"
100	; # 133	"W_gene_IRF1_gene_AhR"
100	; # 134	"W_gene_IRF1_gene_PPARg"
100	; # 135	"W_gene_OCT1_RNAP"
100	; # 136	"W_gene_OCT1_gene_PPARg"
100	; # 137	"W_gene_OCT4_RNAP"
100	; # 138	"W_gene_OCT4_gene_Trigger_RA"
100	; # 139	"W_gene_OCT4_gene_AhR"
100	; # 140	"W_gene_OCT4_gene_cRAF"
100	; # 141	"W_gene_P21_RNAP"
100	; # 142	"W_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"
100	; # 143	"W_gene_P21_gene_GFI1"
100	; # 144	"W_gene_P47Phox_RNAP"
100	; # 145	"W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"
100	; # 146	"W_gene_P47Phox_gene_PPARg"
100	; # 147	"W_gene_PPARg_RNAP"
100	; # 148	"W_gene_PPARg_gene_Trigger_RA"
100	; # 149	"W_gene_PPARg_gene_Trigger_D3"
100	; # 150	"W_gene_PPARg_gene_CEBPa"
100	; # 151	"W_gene_PPARg_gene_EGR1"
100	; # 152	"W_gene_PPARg_gene_PU1"
100	; # 153	"W_gene_PPARg_gene_AP1"
100	; # 154	"W_gene_PU1_RNAP"
100	; # 155	"W_gene_PU1_gene_Trigger_RA"
100	; # 156	"W_gene_PU1_gene_Trigger_D3"
100	; # 157	"W_gene_PU1_gene_CEBPa"
100	; # 158	"W_gene_PU1_gene_PU1"
100	; # 159	"W_gene_PU1_gene_AP1"
100	; # 160	"W_gene_PU1_gene_OCT1"
100	; # 161	"W_gene_PU1_gene_AhR"
100	; # 162	"W_gene_PU1_gene_GFI1"
100	; # 163	"W_gene_Trigger_D3_RNAP"
100	; # 164	"W_gene_Trigger_RA_RNAP"
100	; # 165	"W_gene_cRAF_RNAP"
100	; # 166	"W_gene_repressor14_RNAP"
100	; # 167	"W_gene_repressor14_gene_Trigger_RA"


  ];

  # return the corrected value -
  return parameter_bounds_function(perturbed_parameter_array,lower_bound_array,upper_bound_array);
end

function acceptance_probability_function(rank_array,temperature)
  return (exp(-rank_array[end]/temperature))
end

function cooling_function(temperature)

  # define my new temperature -
  alpha = 0.90
  return alpha*temperature
end


function parameter_bounds_function(parameter_array,lower_bound_array,upper_bound_array)

  # iterate through and fix the parameters -
  new_parameter_array = copy(parameter_array)
  for (index,value) in enumerate(parameter_array)

    lower_bound = lower_bound_array[index]
    upper_bound = upper_bound_array[index]

    if (value<lower_bound)
      new_parameter_array[index] = lower_bound
    elseif (value>upper_bound)
      new_parameter_array[index] = upper_bound
    end
  end

  return new_parameter_array
end
