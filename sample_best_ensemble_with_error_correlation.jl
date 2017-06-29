include("Include.jl")

#number_of_samples = 1829
#number_of_parameters = 160
number_of_objectives = 36

# load up the parameters sets -
ensemble_array = readdlm("parameter_ensemble_1370.dat")
error_array = readdlm("error_ensemble_137.dat")

(number_of_samples,number_of_parameters) = size(ensemble_array)
# cut leading col -

#beginning = size - number_of_samples + 1
beginning = 1;
ensemble_array = ensemble_array[:,beginning:end]
error_array = error_array[:,beginning:end]

# get rid of messed up fits in the beginning when it was stuck --- use best hand fit as initial w/o perturbation
#good_index = find(x -> x<=200,error_array)
#ensemble_array = ensemble_array[:,good_index]
#error_array = error_array[good_index]'
(param,ens_size)= size(ensemble_array)
# calculate correlation for parameters
correlation = cor(ensemble_array,2)
correlation_ensemble = cor(ensemble_array,1)
(r,c) = size(correlation)
number_of_samples = ens_size

# make the NaN correlation values zero --- parameters that were set to zero and bound (expression of triggers and craf)
for r_index in [1:r;]
  for c_index in [1:c;]
    if isnan(correlation[r_index,c_index])
      correlation[r_index,c_index] = 0
    end
  end
end
(r,c) = size(correlation_ensemble)
for r_index in [1:r;]
  for c_index in [1:c;]
    if isnan(correlation_ensemble[r_index,c_index])
      correlation_ensemble[r_index,c_index] = 0
    end
  end
end

# compute the mean of correlation
mean_correlation_parameters = mean(correlation,2)
mean_correlation_ensembles = mean(correlation_ensemble,2)
correlation_min = minimum(mean_correlation_ensembles)


# sampling
error_median = median(error_array)
error_mean = mean(error_array)
error_std = std(error_array)
error_min = minimum(error_array)
correlation_median = median(mean_correlation_ensembles)
correlation_min = minimum(mean_correlation_ensembles)
correlation_std = std(mean_correlation_ensembles)
filtered_parameter_index = []
filtered_parameter_index_pure = []

#filtering through errors
error_cutoff = 1*error_min
for index = [beginning:number_of_samples;]
  error_difference = (error_array[index] - error_cutoff)^2
  prob_keep_set = exp(-1*error_difference/((error_std)^2));
  check_role = rand();
  if error_array[index] <=  error_cutoff # cut off point is the median of the error_array
    push!(filtered_parameter_index,index)
    push!(filtered_parameter_index_pure,index)
  elseif (prob_keep_set>check_role)
    push!(filtered_parameter_index,index);
  end
end

filtered_ensemble_array = ensemble_array[:,filtered_parameter_index]
filtered_error_array = error_array[:,filtered_parameter_index]

#mean_correlation_ensembles = mean(correlation_ensemble[filtered_parameter_index,filtered_parameter_index],2)
# initiate parameter indices for that passes correlation filter
cfiltered_parameter_index = []
cfiltered_parameter_index_pure = []

# filter through correlation
cutoff = 1*correlation_median
for index = [beginning:length(filtered_error_array);]
  correlation_difference = (mean_correlation_ensembles[filtered_parameter_index[index]] - (cutoff))^2
  prob_keep_set = exp(-1*correlation_difference/((correlation_std)^2));
  check_role = rand();
  if mean_correlation_ensembles[index] <= (cutoff) # cut off point is the median of the error_array
    push!(cfiltered_parameter_index,filtered_parameter_index[index])
    push!(cfiltered_parameter_index_pure,filtered_parameter_index[index])
  elseif (prob_keep_set>check_role)
    push!(cfiltered_parameter_index,filtered_parameter_index[index]);
  end
end
cfiltered_ensemble_array = ensemble_array[:,cfiltered_parameter_index]
cfiltered_error_array = error_array[:,cfiltered_parameter_index]
cfiltered_correlation_array = mean_correlation_ensembles[cfiltered_parameter_index]

number_of_samples = length(cfiltered_parameter_index)
@show number_of_samples
objective_archive = zeros(number_of_objectives,number_of_samples)
# Last ... run the model w/these sets, save the data -
for parameter_set_index = 1:number_of_samples

  # sample the ensemble_array -
  parameter_array = cfiltered_ensemble_array[:,parameter_set_index]

  # Load the data dictionary -
  data_dictionary = DataDictionary(0.0,0.0,0.0);

  # Update data dictionary to match new parameters before calculating obj
  parameter_mapping_array = data_dictionary["parameter_name_mapping_array"]
  for index = 1:length(parameter_mapping_array)
    if index <= data_dictionary["number_of_binding"]
      data_dictionary["binding_parameter_dictionary"][parameter_mapping_array[index]] = parameter_array[index]
    else
      data_dictionary["control_parameter_dictionary"][parameter_mapping_array[index]] = parameter_array[index]
    end
  end

  # Setup the time -
  time_start = 0.0
  time_stop = 120.0
  time_step_size = 0.01

  # Run the simulation -
  (T,X_RA,X_D3,X_RA_D3) = Simulation(time_start,time_stop,time_step_size,data_dictionary);
  obj_array = objective_function(parameter_array)
  objective_archive[:,parameter_set_index] = obj_array
  # dump data to disk -
  local_data_RA = [T X_RA];
  local_data_D3 = [T X_D3];
  local_data_RA_D3 = [T X_RA_D3];
  #data_filename = "./best_ensemble/sim_data_PSI_"*string(parameter_set_index)*".dat"
  data_filename = "./best_ensemble/RA/sim_data_PSI_"*string(parameter_set_index)*"_RA.dat"
  writedlm(data_filename,local_data_RA);
  data_filename = "./best_ensemble/D3/sim_data_PSI_"*string(parameter_set_index)*"_D3.dat"
  writedlm(data_filename,local_data_D3);
  data_filename = "./best_ensemble/RA_D3/sim_data_PSI_"*string(parameter_set_index)*"_RA_D3.dat"
  writedlm(data_filename,local_data_RA_D3);

end
  data_filename = "./best_ensemble/objective_archive.dat"
  writedlm(data_filename,objective_archive);
  data_filename = "./best_ensemble/correlation.dat"
  writedlm(data_filename,cfiltered_correlation_array);
  data_filename = "./best_ensemble/parameter_archive.dat"
  writedlm(data_filename,cfiltered_ensemble_array);
  data_filename = "./best_ensemble/error_archive.dat"
  writedlm(data_filename,sum(objective_archive,1));
