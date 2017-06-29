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
#parameter_array = readdlm("parameter_best_handfit.dat")
#parameter_array = readdlm("parameter_best_v1.dat.2")
#parameter_array = readdlm("parameter_best_training_newkin.dat")
#ensemble = readdlm("best_parameter_training_expscale_archive2.dat")
ensemble = readdlm("best_parameter_archive_training_newkin_pt5.dat")
parameter_array = ensemble[:,end]
parameter_array = readdlm("./parameter_training_newkin2_425.dat")
parameter_array = readdlm("./parameter_best_may3_v1.dat")
parameter_array = readdlm("parameter_best_may3_CDs_fitsall3_v2.dat.109")
parameter_array = readdlm("parameter_best_may3_CDs_fitsall3_v3.dat.1")
parameter_array = readdlm("parameter_best_may3_CDs_fitsall3_v2.dat.1")
parameter_array = readdlm("parameter_best_may3_ones_v2.dat.50")
parameter_array= readdlm("parameter_ensemble_v1.dat")
ens = readdlm("best_parameter_ensemble_may9_archive.dat")
parameter_array = ens[:,57]
#parameter_array = readdlm("./parameter_best_newkin_ones_v1.dat")
#parameter_array = readdlm("./parameter_best_newkin_v3.dat")
#parameter_array = readdlm("parameter_best_may9_CDs_fitsall3_v1.dat.3")
#parameter_array = readdlm("./parameter_best_newkin_HF.dat")
#parameter_array = readdlm("parameter_best_may9_CDs_fitsall3_v1_HF.dat")
#parameter_array = readdlm("./parameter_best_may3_CDs_fitsall3_v3_HF.dat.20")
#parameter_array = readdlm("./parameter_ensemble_v1.dat")
#parameter_array = readdlm("parameter_best_may3_CDs_fitsall3_v2.dat.56")
#parameter_array = ensemble[:,end]
#parameter_array = readdlm("parameter_best_handfit_BEST.dat")
#parameter_array[103] = 1e-4
#parameter_array[104] = 1.2
#parameter_array[12] = 1e-9
#parameter_array[11] = 0.33
#parameter_array[136] = 1e-5 #w rnap
#parameter_array[137] = 55.8 # w trigger complex
#parameter_array[138] = 1e-2 # w gfi repressor
#parameter_array[59] = 0.4
#parameter_array[60] = 5e-9
#parameter_array[61] = 2
#parameter_array[62] = 10
#=
parameter_array[142] = 4e-4 #pparg rnap, ra, d3, cepba, egr1, pu1, ap1

parameter_array[143:148] = 4e-4
parameter_array[144] = 4e-4#d3

# egr1
parameter_array[118] = 1e-4
parameter_array[119] = 1e-4
parameter_array[120] = 1e-4

# AhR
parameter_array[99] = 1e-4
parameter_array[100] = 1e-4

#oct1
parameter_array[119] = 1e-4
parameter_array[120] = 1e-4
=#


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
system_change_RA = ones(16,16)
system_change_D3 = ones(16,16)
system_change_RA_D3 = ones(16,16)
unperturbed_intial_conditions = deepcopy(data_dictionary["initial_condition_array"])
(time_array,simulation_state_array_RA,simulation_state_array_D3,simulation_state_array_RA_D3) = Simulation(time_start,time_stop,time_step_size,data_dictionary);
for species_index1 in [1:16;]
  for species_index2 in [species_index1:16;]
    @show species_index1, species_index2
    data_dictionary["initial_condition_array"] = copy(unperturbed_intial_conditions)
    data_dictionary["initial_condition_array"][species_index1] = 0
    data_dictionary["initial_condition_array"][species_index2] = 0
    @show data_dictionary["initial_condition_array"]
    (time_array,perturbed_state_RA,perturbed_state_D3,perturbed_state_RA_D3) = Simulation(time_start,time_stop,time_step_size,data_dictionary);
    system_change_RA[species_index1,species_index2] = norm(simulation_state_array_RA - perturbed_state_RA)
    system_change_D3[species_index1,species_index2] = norm(simulation_state_array_D3 - perturbed_state_D3)
    system_change_RA_D3[species_index1,species_index2] = norm(simulation_state_array_RA_D3 - perturbed_state_RA_D3)
    system_change_RA[species_index2,species_index1] = norm(simulation_state_array_RA - perturbed_state_RA)
    system_change_D3[species_index2,species_index1] = norm(simulation_state_array_D3 - perturbed_state_D3)
    system_change_RA_D3[species_index2,species_index1] = norm(simulation_state_array_RA_D3 - perturbed_state_RA_D3)
    #@show norm(simulation_state_array_RA - perturbed_state_RA),norm(simulation_state_array_D3 - perturbed_state_D3),norm(simulation_state_array_RA_D3 - perturbed_state_RA_D3)
  end
end

writedlm("gene_KO_RA.dat",system_change_RA)
writedlm("gene_KO_D3.dat",system_change_RA)
writedlm("gene_KO_RA_D3.dat",system_change_RA)
