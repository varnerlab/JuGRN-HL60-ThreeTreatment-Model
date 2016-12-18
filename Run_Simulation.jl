include("Include.jl")
# Runs the model to SS, and issue the pertrubation -
function Simulation(time_start,time_stop,time_step_size,data_dictionary)

  # Run the model to steady-state -
  steady_state_array = EstimateSteadyState(0.01,data_dictionary);
  @show steady_state_array[57],steady_state_array[58],steady_state_array[59],steady_state_array[44]
  # Ok, reset the TRIGGER_RA and CRAF -
  steady_state_array[57] = 0;
  steady_state_array[58] = 1;
  steady_state_array[59] = 1;

  #@show steady_state_array[37:54]

  # Reset the IC's -
  data_dictionary["initial_condition_array"] = steady_state_array;

  # Solve the model equations -
  (T,X_RA) = SolveBalances(time_start,time_stop,time_step_size,data_dictionary)

  # Ok, reset the TRIGGER_D3 and CRAF -
  steady_state_array[57] = 1;
  steady_state_array[58] = 0;
  steady_state_array[59] = 1;

  # Reset the IC's -
  data_dictionary["initial_condition_array"] = steady_state_array;

  # Solve the model equations -
  (T,X_D3) = SolveBalances(time_start,time_stop,time_step_size,data_dictionary)
  @show X_D3[end,44]/X_D3[1,44]

  # eset the TRIGGER_D3 TRIGGER_RA and CRAF -
  steady_state_array[57] = 1;
  steady_state_array[58] = 1;
  steady_state_array[59] = 1;

  # Reset the IC's -
  data_dictionary["initial_condition_array"] = steady_state_array;

  # Solve the model equations -
  (T,X_RA_D3) = SolveBalances(time_start,time_stop,time_step_size,data_dictionary)
  @show X_RA_D3[end,44]/X_RA_D3[1,44]
  # return my simulation time, and state -
  plot(T,X_D3[:,44]/X_D3[1,44],T,X_RA_D3[:,44]/X_RA_D3[1,44],T,X_RA[:,44]/X_RA[1,44])

  writedlm("RS_RA.dat",X_RA)
  writedlm("RS_D3.dat",X_D3)
  writedlm("RS_RA_D3.dat",X_RA_D3)

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
parameter_array = readdlm("parameter_best_v1.dat.68")


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

# load experimental data
CD38_RA_EXP = readdlm("./data/CD38-WTHL60.txt");
CD14_RA_EXP = readdlm("./data/CD14-WTHL60.txt");
CD11b_RA_EXP = readdlm("./data/CD11b-WTHL60.txt");
G1G0_RA_EXP = readdlm("./data/G1G0-WTHL60.txt");
CD38_D3_EXP = readdlm("./data/CD38-WTHL60_RA_D3.txt");
CD14_D3_EXP = readdlm("./data/CD14-WTHL60_RA_D3.txt");
CD11b_D3_EXP = readdlm("./data/CD11b-WTHL60_RA_D3.txt");
G1G0_D3_EXP = readdlm("./data/G1G0-WTHL60_RA_D3.txt");
CD38_RA_D3_EXP = readdlm("./data/CD38-WTHL60_RA_D3.txt");
CD14_RA_D3_EXP = readdlm("./data/CD14-WTHL60_RA_D3.txt");
CD11b_RA_D3_EXP = readdlm("./data/CD11b-WTHL60_RA_D3.txt");
G1G0_RA_D3_EXP = readdlm("./data/G1G0-WTHL60_RA_D3.txt");
AhR_RA_EXP = readdlm("./data/AhR-WTHL60.txt");
#P21_RA_EXP = readdlm("./data/P21-WTHL60.txt");
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

RA = readdlm("RS_RA.dat");
D3 = readdlm("RS_D3.dat");
RA_D3 = readdlm("RS_RA_D3.dat");
a = 3
box_RA = []
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

OBJ_TOTAL = [obj_array_RA;obj_array_D3;obj_array_RA_D3];
@show sum(obj_array_RA),sum(obj_array_D3),sum(obj_array_RA_D3)


E2F_RA = RA[:,47]
E2F_D3 = D3[:,47]
E2F_RA_D3 = RA_D3[:,47]

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
  G1G0_syn_RA[index] = G1G0_syn_RA[index-1] + 1/25000*(E2F_RA[index-1]./E2F_RA[1])^gamma
  G1G0_syn_D3[index] = G1G0_syn_D3[index-1] + 1/25000*(E2F_D3[index-1]./E2F_D3[1])^gamma
  G1G0_syn_RA_D3[index] = G1G0_syn_RA_D3[index-1] + 1/25000*(E2F_RA_D3[index-1]./E2F_RA_D3[1])^gamma
end


#plot(CD14_D3_EXP[:,1],CD14_D3_EXP[:,2],"o")
#plot(CD14_RA_D3_EXP[:,1],CD14_RA_D3_EXP[:,2],"o")

figure("G1G0")
plot(time_array,G1G0_syn_RA,time_array,G1G0_syn_D3,time_array,G1G0_syn_RA_D3)
plot(G1G0_RA_EXP[:,1],G1G0_RA_EXP[:,2],"o",G1G0_D3_EXP[:,1],G1G0_D3_EXP[:,2],"o",G1G0_RA_D3_EXP[:,1],G1G0_RA_D3_EXP[:,2],"o")
plot(time_array,1./(E2F_RA./E2F_RA[1]),time_array,1./(E2F_D3./E2F_RA[1]),time_array,1./(E2F_RA_D3./E2F_RA[1]))

#figure(2)
#plot(time_array,RA[:,45]/RA[1,45],"--",time_array,D3[:,45]./D3[1,45],time_array,RA_D3[:,45]./RA_D3[1,45])
#plot(CD38_RA_EXP[:,1],CD38_RA_EXP[:,2],"o",CD38_D3_EXP[:,1],CD38_D3_EXP[:,2],"o",CD38_RA_D3_EXP[:,1],CD38_RA_D3_EXP[:,2],"o")

#figure(3)
#plot(time_array,RA[:,43]/RA[1,43],"--",time_array,D3[:,43]./D3[1,43],time_array,RA_D3[:,43]./RA_D3[1,43])
#plot(CD11b_RA_EXP[:,1],CD11b_RA_EXP[:,2],"o",CD11b_D3_EXP[:,1],CD11b_D3_EXP[:,2],"o",CD11b_RA_D3_EXP[:,1],CD11b_RA_D3_EXP[:,2],"o")


x_sim = [1:3:24;]
x_exp = [2:3:24;]
x_blank = [3:3:24;]
y_sim = [
    RA[4801,42]/RA[1,42]
    RA[4801,49]/RA[1,49]
    RA[4801,48]/RA[1,48]
    RA[4801,50]/RA[1,50]
    RA[4801,46]/RA[1,46]
    RA[4801,56]/RA[1,56]
    RA[4801,54]/RA[1,54]
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
    D3[4801,42]/D3[1,42]
    D3[4801,49]/D3[1,49]
    D3[4801,48]/D3[1,48]
    D3[4801,50]/D3[1,50]
    D3[4801,46]/D3[1,46]
    D3[4801,56]/D3[1,56]
    D3[4801,54]/D3[1,54]
    D3[4801,52]/D3[1,52]
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
    RA_D3[4801,42]/RA_D3[1,42]
    RA_D3[4801,49]/RA_D3[1,49]
    RA_D3[4801,48]/RA_D3[1,48]
    RA_D3[4801,50]/RA_D3[1,50]
    RA_D3[4801,46]/RA_D3[1,46]
    RA_D3[4801,56]/RA_D3[1,56]
    RA_D3[4801,54]/RA_D3[1,54]
    D3[4801,52]/RA_D3[1,52]
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
#fig = figure("RA_D3",figsize=(20,10))
#a = bar(x_sim,y_sim,color="#0f87bf",align="center",alpha=0.4)
#b = bar(x_exp,y_exp,color="salmon",align="center",alpha=0.4)
#axis("tight")
#title("RA_D3")
#figure(2)
#plot(time_array,RA[:,52]./RA[1,52])
# @show obj_array

# return the error array -
