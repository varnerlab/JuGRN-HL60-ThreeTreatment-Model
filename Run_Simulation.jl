include("Include.jl")
# Runs the model to SS, and issue the pertrubation -
function Simulation(time_start,time_stop,time_step_size,data_dictionary)

  # Run the model to steady-state -
  steady_state_array = EstimateSteadyState(0.01,data_dictionary);
  @show steady_state_array[55],steady_state_array[56],steady_state_array[57],steady_state_array[42]
  # Ok, reset the TRIGGER_RA and CRAF -


  steady_state_array[55] = 0;
  steady_state_array[56] = 1;
  steady_state_array[57] = 0;

  #@show steady_state_array[37:54]

  # Reset the IC's -
  data_dictionary["initial_condition_array"] = steady_state_array;

  # Solve the model equations -
  (T,X_RA) = SolveBalances(time_start,time_stop,time_step_size,data_dictionary)

  # Ok, reset the TRIGGER_D3 and CRAF -
  steady_state_array[55] = 1;
  steady_state_array[56] = 0;
  steady_state_array[57] = 0;

  # Reset the IC's -
  data_dictionary["initial_condition_array"] = steady_state_array;

  # Solve the model equations -
  (T,X_D3) = SolveBalances(time_start,time_stop,time_step_size,data_dictionary)
  @show X_D3[end,42]/X_D3[1,42]

  # eset the TRIGGER_D3 TRIGGER_RA and CRAF -
  steady_state_array[55] = 1;
  steady_state_array[56] = 1;
  steady_state_array[57] = 0;

  # Reset the IC's -
  data_dictionary["initial_condition_array"] = steady_state_array;

  # Solve the model equations -
  (T,X_RA_D3) = SolveBalances(time_start,time_stop,time_step_size,data_dictionary)
  @show X_RA_D3[end,42]/X_RA_D3[1,42]
  # return my simulation time, and state -
  #plot(T,X_D3[:,42]/X_D3[1,42],T,X_RA_D3[:,42]/X_RA_D3[1,42],T,X_RA[:,42]/X_RA[1,42])

  #writedlm("RS_RA.dat",X_RA)
  #writedlm("RS_D3.dat",X_D3)
  #writedlm("RS_RA_D3.dat",X_RA_D3)

  return (T,X_RA,X_D3,X_RA_D3);
end

function EstimateSteadyState(epsilon,data_dictionary)

  initial_condition_vector = data_dictionary["initial_condition_array"];
  ic_array = copy(data_dictionary["initial_condition_array"])
  number_of_states = length(ic_array)

  # Setup loop -
  EPSILON = epsilon;
  TSTART = 0.0;
  Ts = 1.0;
  TSTOP = 1000;
  did_reach_steady_state = false
  while (!did_reach_steady_state)

    # solve the balances -
    (TSIM,X1) = SolveBalances(TSTART,TSTOP,Ts,data_dictionary)

    # Take a few additional steps -
    TNEXT_START = TSTOP+Ts;
    TNEXT_STOP = TNEXT_START+1.0;
    Ts = 0.1;

    # solve the balances again 0
    initial_condition_array = vec(X1[end,:])
    data_dictionary["initial_condition_array"] = initial_condition_array;
    (TSIM,X2) = SolveBalances(TNEXT_START,TNEXT_STOP,Ts,data_dictionary)

    # Find the difference -
    DIFF = norm((X2[end,:] - X1[end,:]));

    # Should we stop -or- go around again?
    if (DIFF<EPSILON)
      did_reach_steady_state = true;
      return (vec(X2[end,:]));
    else

      # No, we did *not* reach steady state ....
      TSTART = TSTOP+Ts
      TSTOP = 1.0 + TSTART;
      Ts = 0.1;

      initial_condition_array = vec(X2[end,:])
      data_dictionary["initial_condition_array"] = initial_condition_array;
    end
  end

  # return
  return XSS;
end


# ----------------------------------execution---------------------------------------------
# some global parameters -
BIG = 1e10
SMALL = 1e-8

#load parameter array to test

#ens = readdlm("ensemble_may13_archive4.dat")
#err = readdlm("error_may13_archive3.dat")
ens = readdlm("parameter_archive_525_may16.dat")
ens1 = readdlm("child_ensemble_may30_525.dat")
#parameter_array = ens1[:,36]
parameter_array = ens1[:,250]#readdlm("parameter_best_may30.dat")
#parameter_array[9] = 3
#parameter_array[10] = 1E-2
#parameter_array = readdlm("parameter_best_may13_v1.dat")
#parameter_array = readdlm("parameter_best_may14_v1.dat")
#parameter_array = readdlm("parameter_best_may14_v1.dat1")




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

# unmeasured species
cached_error_function_dictionary_unmeasured = Dict()
for (experiment_index,experiment_dictionary_unmeasured) in enumerate(experiment_array_unmeasured)

  # Grab the experimental id -
  experiment_id = experiment_dictionary_unmeasured["experiment_id"]

  # Grab the error functions from the experiment_dictionary -
  error_function = eval(parse(experiment_dictionary_unmeasured["error_function"]))

  # cache these functions -
  cached_error_function_dictionary_unmeasured[experiment_id] = error_function
end
cached_data_dictionary_unmeasured = Dict()
for (experiment_index,experiment_dictionary_unmeasured) in enumerate(experiment_array_unmeasured)

  # Grab the data file -
  data_file_path = experiment_dictionary_unmeasured["data_file"]
  experiment_id = experiment_dictionary_unmeasured["experiment_id"]

  # Load the data -
  experimental_data_array = readdlm(data_file_path)

  # Cache the data w/experiment_id -
  cached_data_dictionary_unmeasured[experiment_id] = experimental_data_array
end


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

# Call simulation routine -
# (run the model to SS, and then set the ICs to the SS for this parameter set)
(time_array,simulation_state_array_RA,simulation_state_array_D3,simulation_state_array_RA_D3) = Simulation(time_start,time_stop,time_step_size,data_dictionary);


# Calculate objective and load experimental data
obj_array_RA = BIG*ones(13,1)
obj_array_D3 = BIG*ones(12,1)
obj_array_RA_D3 = BIG*ones(11,1)
obj_unmeasured = BIG*ones(3,1)
# load experimental data
CD38_RA_EXP = readdlm("./data/CD38-WTHL60.txt");
CD14_RA_EXP = readdlm("./data/CD14-WTHL60.txt");
CD11b_RA_EXP = readdlm("./data/CD11b-WTHL60.txt");
G1G0_RA_EXP = readdlm("./data/G1G0-WTHL60.txt");
CD38_D3_EXP = readdlm("./data/CD38-WTHL60_D3.txt");
CD14_D3_EXP = readdlm("./data/CD14-WTHL60_D3.txt");
CD11b_D3_EXP = readdlm("./data/CD11b-WTHL60_D3.txt");
G1G0_D3_EXP = readdlm("./data/G1G0-WTHL60_RA_D3.txt");
CD38_RA_D3_EXP = readdlm("./data/CD38-WTHL60_RA_D3.txt");
CD14_RA_D3_EXP = readdlm("./data/CD14-WTHL60_RA_D3.txt");
CD11b_RA_D3_EXP = readdlm("./data/CD11b-WTHL60_RA_D3.txt");
G1G0_RA_D3_EXP = readdlm("./data/G1G0-WTHL60_RA_D3.txt");
AhR_RA_EXP = readdlm("./data/AhR-WTHL60.txt");
P21_RA_EXP = readdlm("./data/P21-WTHL60-Synthetic.txt");
GFI1_RA_EXP = readdlm("./data/GiF1-WTHL60.txt");
CEBPa_RA_EXP = readdlm("./data/CEBPa-WTHL60.txt");
PU1_RA_EXP = readdlm("./data/PU1-WTHL60.txt");
P47Phox_RA_EXP = readdlm("./data/P47Phox-WTHL60.txt");
OCT4_RA_EXP = readdlm("./data/OCT4-WTHL60.txt");
IRF1_RA_EXP = readdlm("./data/IRF1-WTHL60.txt");
EGR1_RA_EXP = readdlm("./data/EGR1-WTHL60.txt");
AhR_D3_EXP = readdlm("./data/AhR-WTHL60_D3.txt");
GFI1_D3_EXP = readdlm("./data/GiF1-WTHL60_D3.txt");
CEBPa_D3_EXP = readdlm("./data/CEBPa-WTHL60_D3.txt");
PU1_D3_EXP = readdlm("./data/PU1-WTHL60_D3.txt");
P47Phox_D3_EXP = readdlm("./data/P47Phox-WTHL60_D3.txt");
OCT4_D3_EXP = readdlm("./data/OCT4-WTHL60_D3.txt");
IRF1_D3_EXP = readdlm("./data/IRF1-WTHL60_D3.txt");
EGR1_D3_EXP = readdlm("./data/EGR1-WTHL60_D3.txt");
AhR_RA_D3_EXP = readdlm("./data/AhR-WTHL60_RA_D3.txt");
GFI1_RA_D3_EXP = readdlm("./data/GiF1-WTHL60_RA_D3.txt");
CEBPa_RA_D3_EXP = readdlm("./data/CEBPa-WTHL60_RA_D3.txt");
PU1_RA_D3_EXP = readdlm("./data/PU1-WTHL60_RA_D3.txt");
OCT4_RA_D3_EXP = readdlm("./data/OCT4-WTHL60_RA_D3.txt");
IRF1_RA_D3_EXP = readdlm("./data/IRF1-WTHL60_RA_D3.txt");
EGR1_RA_D3_EXP = readdlm("./data/EGR1-WTHL60_RA_D3.txt");

CD38_RA_EXP_SIZE = [11;11;13;11]
CD38_RA_EXP[:,3] = CD38_RA_EXP[:,3]./sqrt(CD38_RA_EXP_SIZE);
CD14_RA_EXP_SIZE = [14;14;16;14]
CD14_RA_EXP[:,3] = CD14_RA_EXP[:,3]./sqrt(CD14_RA_EXP_SIZE);
CD11b_RA_EXP_SIZE = [14;14;16;13]
CD11b_RA_EXP[:,3] = CD11b_RA_EXP[:,3]./sqrt(CD11b_RA_EXP_SIZE);
G1G0_RA_EXP_SIZE = [11;11;11;12]
G1G0_RA_EXP[:,3] = G1G0_RA_EXP[:,3]./sqrt(G1G0_RA_EXP_SIZE);

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

#RA = readdlm("RS_RA.dat");
#D3 = readdlm("RS_D3.dat");
#RA_D3 = readdlm("RS_RA_D3.dat");
a = 3
box_RA = []
unmeasured_index = [39,49,53]
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
  @show experiment_index, error_value,species_symbol,output_index
  # Add the error to the objective array -
  obj_array_RA[experiment_index] = error_value;

  (n,m) = size(experimental_data_array)

end
unmeasure_error = zeros(length(unmeasured_index))
for (index,species_index) in enumerate(unmeasured_index)
  output_index = species_index
  error_value = Error_Initial_no_data(time_array,simulation_state_array_RA,output_index,data_dictionary)
  unmeasure_error[index]= error_value
end
obj_array_RA = [obj_array_RA; unmeasure_error]
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
  @show experiment_index, error_value,species_symbol,output_index
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
  @show experiment_index, error_value,species_symbol,output_index
  obj_array_RA_D3[experiment_index] = error_value;
end

for (experiment_index,experiment_dictionary) in enumerate(experiment_array_unmeasured) # FOR unmeasured

  # Get the error function pointer -
  error_function_pointer = experiment_dictionary["error_function"]
  output_index = parse(Int,experiment_dictionary["output_index"])
  experiment_id = experiment_dictionary["experiment_id"]
  species_symbol = experiment_dictionary["protein_symbol"];

  # Get the experimental data array -
  experimental_data_array = cached_data_dictionary_unmeasured[experiment_id]

  # Call the error function -
  error_function = cached_error_function_dictionary_unmeasured[experiment_id]
    #  @show experimental_data_array,experiment_index
    #  experimental_data_array_D3[experiment_index] = experimental_data_array[end,2]
  error_value = error_function(time_array,simulation_state_array_RA,output_index,data_dictionary)


  obj_unmeasured[experiment_index] = error_value;
end

OBJ_TOTAL = [obj_array_RA;obj_array_D3;obj_array_RA_D3;obj_unmeasured];
@show sum(obj_array_RA),sum(obj_array_D3),sum(obj_array_RA_D3),sum(obj_unmeasured)

# plotting combined figures
CD38_mean_array_RA =  simulation_state_array_RA[:,43]./simulation_state_array_RA[1,43]
CD38_std_array_RA = 0 # std(CD38_array_RA_scaled,2)
CD14_mean_array_RA =  simulation_state_array_RA[:,42]./simulation_state_array_RA[1,42]
CD14_std_array_RA = 0 # std(CD14_array_RA_scaled,2)
CD11b_mean_array_RA =  simulation_state_array_RA[:,41]./simulation_state_array_RA[1,41]
CD11b_std_array_RA = 0 # std(CD11b_array_RA_scaled,2)



AhR_mean_data_RA =  simulation_state_array_RA[4801,40]/simulation_state_array_RA[1,40]
AhR_std_data_RA = 0 # std(AhR_data_RA_scaled,2)
P47Phox_mean_data_RA =  simulation_state_array_RA[4801,52]/simulation_state_array_RA[1,52]
P47Phox_std_data_RA = 0 # std(P47Phox_data_RA_scaled,2)
IRF1_mean_data_RA =      simulation_state_array_RA[4801,48]/simulation_state_array_RA[1,48]
IRF1_std_data_RA = 0 # std(IRF1_data_RA_scaled,2)
PU1_mean_data_RA =      simulation_state_array_RA[4801,54]/simulation_state_array_RA[1,54]
PU1_std_data_RA = 0 # std(PU1_data_RA_scaled,2)
CEBPa_mean_data_RA =  simulation_state_array_RA[4801,44]/simulation_state_array_RA[1,44]
CEBPa_std_data_RA = 0 # std(CEBPa_data_RA_scaled,2)
OCT4_mean_data_RA =  simulation_state_array_RA[4801,50]/simulation_state_array_RA[1,50]
OCT4_std_data_RA = 0 # std(OCT4_data_RA_scaled,2)
EGR1_mean_data_RA =  simulation_state_array_RA[4801,46]/simulation_state_array_RA[1,46]
EGR1_std_data_RA = 0 # std(EGR1_data_RA_scaled,2)
GIF1_mean_data_RA =  simulation_state_array_RA[4801,47]/simulation_state_array_RA[1,47]
GIF1_std_data_RA = 0 # std(GIF1_data_RA_scaled,2)

CD38_mean_array_D3 =  simulation_state_array_D3[:,43]./simulation_state_array_D3[1,43]
CD38_std_array_D3 = 0 # std(CD38_array_D3_scaled,2)
CD14_mean_array_D3 =  simulation_state_array_D3[:,42]./simulation_state_array_D3[1,42]
CD14_std_array_D3 = 0 # std(CD14_array_D3_scaled,2)
CD11b_mean_array_D3 =  simulation_state_array_D3[:,41]./simulation_state_array_D3[1,41]
CD11b_std_array_D3 = 0 # std(CD11b_array_D3_scaled,2)



AhR_mean_data_D3 =  simulation_state_array_D3[4801,40]/simulation_state_array_D3[1,40]
AhR_std_data_D3 = 0 # std(AhR_data_D3_scaled,2)
P47Phox_mean_data_D3 =  simulation_state_array_D3[4801,52]/simulation_state_array_D3[1,52]
P47Phox_std_data_D3 = 0 # std(P47Phox_data_D3_scaled,2)
IRF1_mean_data_D3 =      simulation_state_array_D3[4801,48]/simulation_state_array_D3[1,48]
IRF1_std_data_D3 = 0 # std(IRF1_data_D3_scaled,2)
PU1_mean_data_D3 =      simulation_state_array_D3[4801,54]/simulation_state_array_D3[1,54]
PU1_std_data_D3 = 0 # std(PU1_data_D3_scaled,2)
CEBPa_mean_data_D3 =  simulation_state_array_D3[4801,44]/simulation_state_array_D3[1,44]
CEBPa_std_data_D3 = 0 # std(CEBPa_data_D3_scaled,2)
OCT4_mean_data_D3 =  simulation_state_array_D3[4801,50]/simulation_state_array_D3[1,50]
OCT4_std_data_D3 = 0 # std(OCT4_data_D3_scaled,2)
EGR1_mean_data_D3 =  simulation_state_array_D3[4801,46]/simulation_state_array_D3[1,46]
EGR1_std_data_D3 = 0 # std(EGR1_data_D3_scaled,2)
GIF1_mean_data_D3 =  simulation_state_array_D3[4801,47]/simulation_state_array_D3[1,47]
GIF1_std_data_D3 = 0 # std(GIF1_data_D3_scaled,2)

CD38_mean_array_RA_D3 =  simulation_state_array_RA_D3[:,43]./simulation_state_array_RA_D3[1,43]
CD38_std_array_RA_D3 = 0 # std(CD38_array_RA_D3_scaled,2)
CD14_mean_array_RA_D3 =  simulation_state_array_RA_D3[:,42]./simulation_state_array_RA_D3[1,42]
CD14_std_array_RA_D3 = 0 # std(CD14_array_RA_D3_scaled,2)
CD11b_mean_array_RA_D3 =  simulation_state_array_RA_D3[:,41]./simulation_state_array_RA_D3[1,41]
CD11b_std_array_RA_D3 = 0 # std(CD11b_array_RA_D3_scaled,2)



AhR_mean_data_RA_D3 =  simulation_state_array_RA_D3[4801,40]/simulation_state_array_RA_D3[1,40]
AhR_std_data_RA_D3 = 0 # std(AhR_data_RA_D3_scaled,2)
P47Phox_mean_data_RA_D3 =  simulation_state_array_RA_D3[4801,52]/simulation_state_array_RA_D3[1,52]
P47Phox_std_data_RA_D3 = 0 # std(P47Phox_data_RA_D3_scaled,2)
IRF1_mean_data_RA_D3 =      simulation_state_array_RA_D3[4801,48]/simulation_state_array_RA_D3[1,48]
IRF1_std_data_RA_D3 = 0 # std(IRF1_data_RA_D3_scaled,2)
PU1_mean_data_RA_D3 =      simulation_state_array_RA_D3[4801,54]/simulation_state_array_RA_D3[1,54]
PU1_std_data_RA_D3 = 0 # std(PU1_data_RA_D3_scaled,2)
CEBPa_mean_data_RA_D3 =  simulation_state_array_RA_D3[4801,44]/simulation_state_array_RA_D3[1,44]
CEBPa_std_data_RA_D3 = 0 # std(CEBPa_data_RA_D3_scaled,2)
OCT4_mean_data_RA_D3 =  simulation_state_array_RA_D3[4801,50]/simulation_state_array_RA_D3[1,50]
OCT4_std_data_RA_D3 = 0 # std(OCT4_data_RA_D3_scaled,2)
EGR1_mean_data_RA_D3 =  simulation_state_array_RA_D3[4801,46]/simulation_state_array_RA_D3[1,46]
EGR1_std_data_RA_D3 = 0 # std(EGR1_data_RA_D3_scaled,2)
GIF1_mean_data_RA_D3 =  simulation_state_array_RA_D3[4801,47]/simulation_state_array_RA_D3[1,47]
GIF1_std_data_RA_D3 = 0 # std(GIF1_data_RA_D3_scaled,2)


# CD11b and CD38
time_experimental = collect(0:0.01:120)
figure("timecourse")
fig1=subplot(3,3,1)
a = plot(time_experimental,CD38_mean_array_RA,"k")
b = errorbar(CD38_RA_EXP[:,1],CD38_RA_EXP[:,2],CD38_RA_EXP[:,3], fmt = "o", color = "k")
title("CD38_RA")
#fill_between(vec(time_experimental),vec(CD38_RA_LB),vec(CD38_RA_UB),color="lightblue",lw=2)
#fill_between(vec(time_experimental),vec(CD38_RA_LB_SE),vec(CD38_RA_UB_SE),color="dodgerblue",lw=2)
fig1=subplot(3,3,2)
a2 = plot(time_experimental,CD38_mean_array_D3,"k")
b2 = errorbar(CD38_D3_EXP[:,1],CD38_D3_EXP[:,2],CD38_D3_EXP[:,3], fmt = "o", color = "k")
title("CD38_D3")
#fill_between(vec(time_experimental),vec(CD38_D3_LB),vec(CD38_D3_UB),color="lightblue",lw=2)
#fill_between(vec(time_experimental),vec(CD38_D3_LB_SE),vec(CD38_D3_UB_SE),color="dodgerblue",lw=2)
fig1=subplot(3,3,3)
a3 = plot(time_experimental,CD38_mean_array_RA_D3,"k")
b3 = errorbar(CD38_RA_D3_EXP[:,1],CD38_RA_D3_EXP[:,2],CD38_RA_D3_EXP[:,3], fmt = "o", color = "k")
title("CD38 RA_D3")
#fill_between(vec(time_experimental),vec(CD38_RA_D3_LB),vec(CD38_RA_D3_UB),color="lightblue",lw=2)
#fill_between(vec(time_experimental),vec(CD38_RA_D3_LB_SE),vec(CD38_RA_D3_UB_SE),color="dodgerblue",lw=2)
fig1=subplot(3,3,4)
c = plot(time_experimental,CD11b_mean_array_RA,"k")
d = errorbar(CD11b_RA_EXP[:,1],CD11b_RA_EXP[:,2],CD11b_RA_EXP[:,3], fmt = "o", color = "k")
title("CD11b RA")
#fill_between(vec(time_experimental),vec(CD11b_RA_LB),vec(CD11b_RA_UB),color="lightsalmon",lw=2)
#fill_between(vec(time_experimental),vec(CD11b_RA_LB_SE),vec(CD11b_RA_UB_SE),color="tomato",lw=2)
fig1=subplot(3,3,5)
c2 = plot(time_experimental,CD11b_mean_array_D3,"k")
d2 = errorbar(CD11b_D3_EXP[:,1],CD11b_D3_EXP[:,2],CD11b_D3_EXP[:,3], fmt = "o", color = "k")
title("CD11b D3")
#fill_between(vec(time_experimental),vec(CD11b_D3_LB),vec(CD11b_D3_UB),color="lightsalmon",lw=2)
#fill_between(vec(time_experimental),vec(CD11b_D3_LB_SE),vec(CD11b_D3_UB_SE),color="tomato",lw=2)
fig1=subplot(3,3,6)
c3 = plot(time_experimental,CD11b_mean_array_RA_D3,"k")
d3 = errorbar(CD11b_RA_D3_EXP[:,1],CD11b_RA_D3_EXP[:,2],CD11b_RA_D3_EXP[:,3], fmt = "o", color = "k")
title("CD11b RA_D3")
#fill_between(vec(time_experimental),vec(CD11b_RA_D3_LB),vec(CD11b_RA_D3_UB),color="lightsalmon",lw=2,alpha=0.3)
#fill_between(vec(time_experimental),vec(CD11b_RA_D3_LB_SE),vec(CD11b_RA_D3_UB_SE),color="tomato",lw=2)
fig1=subplot(3,3,7)
e = plot(time_experimental,CD14_mean_array_RA,"k")
f = errorbar(CD14_RA_EXP[:,1],CD14_RA_EXP[:,2],CD14_RA_EXP[:,3], fmt = "o", color = "k")
title("CD14 RA")
#fill_between(vec(time_experimental),vec(CD14_RA_LB),vec(CD14_RA_UB),color="lavenderblush",lw=2)
#fill_between(vec(time_experimental),vec(CD14_RA_LB_SE),vec(CD14_RA_UB_SE),color="lavender",lw=2)
subplot(3,3,8)
e2 = plot(time_experimental,CD14_mean_array_D3,"k")
f2 = errorbar(CD14_D3_EXP[:,1],CD14_D3_EXP[:,2],CD14_D3_EXP[:,3], fmt = "o", color = "k")
title("CD14 D3")
#fill_between(vec(time_experimental),vec(CD14_D3_LB),vec(CD14_D3_UB),color="lavenderblush",lw=2)
#fill_between(vec(time_experimental),vec(CD14_D3_LB_SE),vec(CD14_D3_UB_SE),color="lavender",lw=2)
fig1=subplot(3,3,9)
e3 = plot(time_experimental,CD14_mean_array_RA_D3,"k")
f3 = errorbar(CD14_RA_D3_EXP[:,1],CD14_RA_D3_EXP[:,2],CD14_RA_D3_EXP[:,3], fmt = "o", color = "k")
title("CD14 RA_D3")
#fill_between(vec(time_experimental),vec(CD14_RA_D3_LB),vec(CD14_RA_D3_UB),color="lavenderblush",lw=2)
#fill_between(vec(time_experimental),vec(CD14_RA_D3_LB_SE),vec(CD14_RA_D3_UB_SE),color="lavender",lw=2)

# coombined bar graphs for 48 hr expression
x_sim = [1:3:8;]
x_exp = [2:3:8;]
size_sample = sqrt(495)


y_sim_AhR = [
    AhR_mean_data_RA
    AhR_mean_data_D3
    AhR_mean_data_RA_D3
]
y_sim_std_AhR = [
    AhR_std_data_RA/size_sample
    AhR_std_data_D3/size_sample
    AhR_std_data_RA_D3/size_sample
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
    GIF1_mean_data_RA
    GIF1_mean_data_D3
    GIF1_mean_data_RA_D3
]
y_sim_std_GIF1 = [
    GIF1_std_data_RA/size_sample
    GIF1_std_data_D3/size_sample
    GIF1_std_data_RA_D3/size_sample
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
    EGR1_mean_data_RA
    EGR1_mean_data_D3
    EGR1_mean_data_RA_D3
]
y_sim_std_EGR1 = [
    EGR1_std_data_RA/size_sample
    EGR1_std_data_D3/size_sample
    EGR1_std_data_RA_D3/size_sample
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
    IRF1_mean_data_RA
    IRF1_mean_data_D3
    IRF1_mean_data_RA_D3
]
y_sim_std_IRF1 = [
    IRF1_std_data_RA/size_sample
    IRF1_std_data_D3/size_sample
    IRF1_std_data_RA_D3/size_sample
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
    CEBPa_mean_data_RA
    CEBPa_mean_data_D3
    CEBPa_mean_data_RA_D3
]
y_sim_std_CEBPa = [
    CEBPa_std_data_RA/size_sample
    CEBPa_std_data_D3/size_sample
    CEBPa_std_data_RA_D3/size_sample
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
    PU1_mean_data_RA
    PU1_mean_data_D3
    PU1_mean_data_RA_D3
]
y_sim_std_PU1 = [
    PU1_std_data_RA/size_sample
    PU1_std_data_D3/size_sample
    PU1_std_data_RA_D3/size_sample
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
    P47Phox_mean_data_RA
    P47Phox_mean_data_D3
    P47Phox_mean_data_RA_D3
]
y_sim_std_P47Phox = [
    P47Phox_std_data_RA/size_sample
    P47Phox_std_data_D3/size_sample
    P47Phox_std_data_RA_D3/size_sample
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
    OCT4_mean_data_RA
    OCT4_mean_data_D3
    OCT4_mean_data_RA_D3
]
y_sim_std_OCT4 = [
    OCT4_std_data_RA/size_sample
    OCT4_std_data_D3/size_sample
    OCT4_std_data_RA_D3/size_sample
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


figure("48hr")
fig2 = subplot(4,2,1)
a = bar(x_sim,y_sim_AhR,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_AhR,ecolor = "k")
b = bar(x_exp,y_exp_AhR,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_AhR,ecolor = "k")
x = vec(["AhR" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,2)
a = bar(x_sim,y_sim_GIF1,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_GIF1,ecolor = "k")
b = bar(x_exp,y_exp_GIF1,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_GIF1,ecolor = "k")
x = vec(["GFI" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,3)
a = bar(x_sim,y_sim_EGR1,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_EGR1,ecolor = "k")
b = bar(x_exp,y_exp_EGR1,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_EGR1,ecolor = "k")
x = vec(["EGR1" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,4)
a = bar(x_sim,y_sim_IRF1,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_IRF1,ecolor = "k")
b = bar(x_exp,y_exp_IRF1,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_IRF1,ecolor = "k")
x = vec(["IRF1" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,5)
a = bar(x_sim,y_sim_CEBPa,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_CEBPa,ecolor = "k")
b = bar(x_exp,y_exp_CEBPa,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_CEBPa,ecolor = "k")
x = vec(["CEBPa" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,6)
a = bar(x_sim,y_sim_PU1,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_PU1,ecolor = "k")
b = bar(x_exp,y_exp_PU1,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_PU1,ecolor = "k")
x = vec(["PU1" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,7)
a = bar(x_sim,y_sim_P47Phox,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_P47Phox,ecolor = "k")
b = bar(x_exp,y_exp_P47Phox,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_P47Phox,ecolor = "k")
x = vec(["P47phox" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks

fig2 = subplot(4,2,8)
a = bar(x_sim,y_sim_OCT4,color="lightgrey",align="center",alpha=1, yerr = y_sim_std_OCT4,ecolor = "k")
b = bar(x_exp,y_exp_OCT4,color="darkgrey",align="center",alpha=1, yerr = y_exp_std_OCT4,ecolor = "k")
x = vec(["OCT4" "" "" "" "" "" "" "" ""]')
fig2[:set_xticks](collect(1:9))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
fig2[:set_xticklabels](x,rotation=0)
My = matplotlib[:ticker][:MultipleLocator](2) # Define interval of major ticks
fig2[:yaxis][:set_major_locator](My) # Set interval of major ticks
PPARg_mean_data_RA = simulation_state_array_RA[4801,53]/simulation_state_array_RA[1,53]
PPARg_mean_data_D3 = simulation_state_array_D3[4801,53]/simulation_state_array_D3[1,53]
PPARg_mean_data_RA_D3 = simulation_state_array_RA_D3[4801,53]/simulation_state_array_RA_D3[1,53]
@show PPARg_mean_data_RA,PPARg_mean_data_D3,PPARg_mean_data_RA_D3

AP1_mean_data_RA = simulation_state_array_RA[4801,39]/simulation_state_array_RA[1,39]
AP1_mean_data_D3 = simulation_state_array_D3[4801,39]/simulation_state_array_D3[1,39]
AP1_mean_data_RA_D3 = simulation_state_array_RA_D3[4801,39]/simulation_state_array_RA_D3[1,39]
@show AP1_mean_data_RA,AP1_mean_data_D3,AP1_mean_data_RA_D3

P21_mean_data_RA = simulation_state_array_RA[4801,51]/simulation_state_array_RA[1,51]
P21_mean_data_D3 = simulation_state_array_D3[4801,51]/simulation_state_array_D3[1,51]
P21_mean_data_RA_D3 = simulation_state_array_RA_D3[4801,51]/simulation_state_array_RA_D3[1,51]
@show P21_mean_data_RA,P21_mean_data_D3,P21_mean_data_RA_D3


a = simulation_state_array_RA
b = simulation_state_array_D3
c = simulation_state_array_RA_D3
q  = find(x->x<0.001,a[end,39:end])
w = q+38
low_species = [w a[end, w]]
protein_end = a[end,39:end]
protein_end2 = b[end,39:end]
protein_end3 = c[end,39:end]
listinitial = [[39:39+18;] a[1,39:end] a[1,20:38]]
listproteins = [[39:39+18;] data_dictionary["species_name_mapping_array"][[39:39+18;]] a[1,39:end] protein_end a[1,20:38] a[end,20:38]]
listproteins2 = [[39:39+18;] data_dictionary["species_name_mapping_array"][[39:39+18;]] b[1,39:end] protein_end2 b[1,20:38] b[end,20:38]]
listproteins3 = [[39:39+18;] data_dictionary["species_name_mapping_array"][[39:39+18;]] c[1,39:end] protein_end3 c[1,20:38] c[end,20:38]]
list_total = [listproteins;listproteins2;listproteins3]
#E2F_RA = RA[:,47]
#E2F_D3 = D3[:,47]
#E2F_RA_D3 = RA_D3[:,47]

#G1G0_syn_RA = zeros(12001)
#G1G0_syn_D3 = zeros(12001)
#G1G0_syn_RA_D3 = zeros(12001)
#G1G0_syn_RA[1] = 1
#G1G0_syn_D3[1] = 1
#G1G0_syn_RA_D3[1] = 1

#G1G0_syn = 1./E2F_mean_array_RA
#alpha = 1
#gamma = -3.5
#for index in 2:(length(G1G0_syn_RA)-1)
#  G1G0_syn_RA[index] = G1G0_syn_RA[index-1] + 1/25000*(E2F_RA[index-1]./E2F_RA[1])^gamma
#  G1G0_syn_D3[index] = G1G0_syn_D3[index-1] + 1/25000*(E2F_D3[index-1]./E2F_D3[1])^gamma
#  G1G0_syn_RA_D3[index] = G1G0_syn_RA_D3[index-1] + 1/25000*(E2F_RA_D3[index-1]./E2F_RA_D3[1])^gamma
#end


#plot(CD14_D3_EXP[:,1],CD14_D3_EXP[:,2],"o")
#plot(CD14_RA_D3_EXP[:,1],CD14_RA_D3_EXP[:,2],"o")

#figure("G1G0")
#plot(time_array,G1G0_syn_RA,time_array,G1G0_syn_D3,time_array,G1G0_syn_RA_D3)
#plot(G1G0_RA_EXP[:,1],G1G0_RA_EXP[:,2],"o",G1G0_D3_EXP[:,1],G1G0_D3_EXP[:,2],"o",G1G0_RA_D3_EXP[:,1],G1G0_RA_D3_EXP[:,2],"o")
#plot(time_array,1./(E2F_RA./E2F_RA[1]),time_array,1./(E2F_D3./E2F_RA[1]),time_array,1./(E2F_RA_D3./E2F_RA[1]))

#figure(2)
#plot(time_array,RA[:,45]/RA[1,45],"--",time_array,D3[:,45]./D3[1,45],time_array,RA_D3[:,45]./RA_D3[1,45])
#plot(CD38_RA_EXP[:,1],CD38_RA_EXP[:,2],"o",CD38_D3_EXP[:,1],CD38_D3_EXP[:,2],"o",CD38_RA_D3_EXP[:,1],CD38_RA_D3_EXP[:,2],"o")

#figure(3)
#plot(time_array,RA[:,43]/RA[1,43],"--",time_array,D3[:,43]./D3[1,43],time_array,RA_D3[:,43]./RA_D3[1,43])
#plot(CD11b_RA_EXP[:,1],CD11b_RA_EXP[:,2],"o",CD11b_D3_EXP[:,1],CD11b_D3_EXP[:,2],"o",CD11b_RA_D3_EXP[:,1],CD11b_RA_D3_EXP[:,2],"o")
#=

x_sim = [1:3:24;]
x_exp = [2:3:24;]
x_blank = [3:3:24;]
y_sim = [
    RA[4801,40]/RA[1,40]
    RA[4801,47]/RA[1,47]
    RA[4801,46]/RA[1,46]
    RA[4801,48]/RA[1,48]
    RA[4801,44]/RA[1,44]
    RA[4801,54]/RA[1,54]
    RA[4801,52]/RA[1,52]
    RA[4801,52]/RA[1,52]
]

y_exp = [
  AhR_RA_EXP[2,2]
  GFI1_RA_EXP[2,2]
  EGR1_RA_EXP[2,2]
  IRF1_RA_EXP[2,2]
  CEBPa_RA_EXP[2,2]
  PU1_RA_EXP[2,2]
  P47Phox_RA_EXP[2,2]
  OCT4_RA_EXP[2,2]
]
#fig = figure("RA",figsize=(20,10))
#a = bar(x_sim,y_sim,color="#0f87bf",align="center",alpha=0.4)
#b = bar(x_exp,y_exp,color="salmon",align="center",alpha=0.4)
#title("RA")

# plot D3
x_sim = [1:3:24;]
x_exp = [2:3:24;]
x_blank = [3:3:24;]
y_sim = [
    D3[4801,40]/D3[1,40]
    D3[4801,47]/D3[1,47]
    D3[4801,46]/D3[1,46]
    D3[4801,48]/D3[1,48]
    D3[4801,44]/D3[1,44]
    D3[4801,54]/D3[1,54]
    D3[4801,52]/D3[1,52]
    D3[4801,50]/D3[1,50]
]

y_exp = [
  AhR_D3_EXP[2,2]
  GFI1_D3_EXP[2,2]
  EGR1_D3_EXP[2,2]
  IRF1_D3_EXP[2,2]
  CEBPa_D3_EXP[2,2]
  PU1_D3_EXP[2,2]
  P47Phox_D3_EXP[2,2]
  OCT4_D3_EXP[2,2]
]
#fig = figure("D3",figsize=(20,10))
#a = bar(x_sim,y_sim,color="#0f87bf",align="center",alpha=0.4)
#b = bar(x_exp,y_exp,color="salmon",align="center",alpha=0.4)
#axis("tight")
#title("D3")
#grid("on")
#xlabel("X")
#ylabel("Y")
#RA_scaled = RA./RA[1,:]
#D3_scaled = D3./D3[1,:]
#RA_D3_scaled = RA_D3./RA_D3[1,:]


# plot D3
x_sim = [1:3:24;]
x_exp = [2:3:24;]
x_blank = [3:3:24;]
y_sim = [
    RA_D3[4801,40]/RA_D3[1,40]
    RA_D3[4801,47]/RA_D3[1,47]
    RA_D3[4801,46]/RA_D3[1,46]
    RA_D3[4801,48]/RA_D3[1,48]
    RA_D3[4801,44]/RA_D3[1,44]
    RA_D3[4801,54]/RA_D3[1,54]
    RA_D3[4801,52]/RA_D3[1,52]
    RA_D3[4801,50]/RA_D3[1,50]
]

y_exp = [
  AhR_RA_D3_EXP[2,2]
  GFI1_RA_D3_EXP[2,2]
  EGR1_RA_D3_EXP[2,2]
  IRF1_RA_D3_EXP[2,2]
  CEBPa_RA_D3_EXP[2,2]
  PU1_RA_D3_EXP[2,2]
  0
  OCT4_RA_D3_EXP[2,2]
]
=#
#fig = figure("RA_D3",figsize=(20,10))
#a = bar(x_sim,y_sim,color="#0f87bf",align="center",alpha=0.4)
#b = bar(x_exp,y_exp,color="salmon",align="center",alpha=0.4)
#axis("tight")
#title("RA_D3")
#figure(2)
#plot(time_array,RA[:,52]./RA[1,52])
# @show obj_array

# return the error array -
