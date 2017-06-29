# include -
include("Include.jl")

#sample_index= readdlm("IRF_CD14_PU1_index.dat")
#sample_index_IRF1= readdlm("sample_index_IRF1_RA.dat")
ensemble = readdlm("best_parameter_norm_archive.dat")
#sample_index = vcat(sample_index_PU1,sample_index_IRF1)
# setup the calculation -
#sample_index = convert(Array{Int16},sample_index)
#sample_size = length(sample_index)
#sample_index = reshape(sample_index,sample_size) # convert 2d to 1d array
#sample_index = union(sort(sample_index))


ensemble_array = ensemble[:,2:1001] # get rid of zeros from the beginning
#ensemble_array = ensemble[:,sample_index] # only take the indices

(number_of_parameters,number_of_samples) = size(ensemble_array)



# Last ... run the model w/these sets, save the data -
for parameter_set_index = 1:number_of_samples

  # sample the ensemble_array -
  parameter_array = ensemble_array[:,parameter_set_index]

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
#data_filename = "./best_ensemble/objective_archive_sample_index.dat"
#writedlm(data_filename,objective_archive);
data_filename = "./best_ensemble/parameter_ensemble_may11_archive.dat"
writedlm(data_filename,ensemble_array);
include("process_best_ensemble.jl")
#data_filename = "./best_ensemble/error_archive_sample_index.dat"
#writedlm(data_filename,sum(objective_archive,1));
