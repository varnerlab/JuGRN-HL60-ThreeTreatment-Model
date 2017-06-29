function Error(experimental_data_array,simulation_time_array,simulation_state_array,output_index,species_symbol,data_dictionary)

  # initialize -
  total_error_value = Inf
  # Interpole the simulation data to the experimental time scale -
  interpolated_simulated_trajectory = np.interp(experimental_data_array[:,1],simulation_time_array,simulation_state_array[:,output_index]);

  # Compute the error -
  # Error is the sum of a shape function, a scale function and a background_copy_number function -

  # Compute the shape term -
  scaled_data_array = alpha_scaling(experimental_data_array[:,2]);
  scaled_simulation_array = alpha_scaling(interpolated_simulated_trajectory);
  shape_term = sum((scaled_data_array - scaled_simulation_array).^2); #original
  #shape_term = norm(scaled_data_array - scaled_simulation_array) # norm scaling


  # Compute the initial value term -
  background_copy_number_dictionary = data_dictionary["background_copy_number_dictionary"];
  background_copy_number = background_copy_number_dictionary[species_symbol]
  cell_volume = data_dictionary["cell_volume"];
  av_number = data_dictionary["av_number"];
  initial_concentration = background_copy_number*(1/av_number)*(1/cell_volume)*1e9; # nM
  # divisor to initial value scaling to weight big and small number_of_rates --- revised april 26
  divisor = initial_concentration
  if interpolated_simulated_trajectory[1] - initial_concentration <=0
    divisor = -interpolated_simulated_trajectory[1]
  end
  initial_value_term = (((interpolated_simulated_trajectory[1] - initial_concentration)/divisor)); #no equare
  #@show species_symbol, initial_value_term
  # Compute the scale term -
  simulated_fold_change = (interpolated_simulated_trajectory)./(interpolated_simulated_trajectory[1]);
  scale_term = sum(((simulated_fold_change - experimental_data_array[:,2])).^2); #original

  # compute the total error -
  num_data_points = length(experimental_data_array[:,2])

  # scaling -- multiple 48hr expression datas by their 48 hr exp fold change

  if length(simulated_fold_change)<=2
    scale_term = scale_term*experimental_data_array[end,2] # multiple by experimental measurement @ 48 hr for scaling
  end
  #=
  if output_index == 41 # CD11b
    scale_term = scale_term*15
  end

  if output_index == 43 # CD38
    scale_term = scale_term*20
  end
  =#

  if output_index == 42 # CD14
    scale_term = scale_term*5
  end
  if output_index == 48 # IRF
    scale_term = scale_term*5
  end

  if output_index == 46 # EGR1
    scale_term = scale_term*10
  end
  if output_index == 44 # CEBPa
    scale_term = scale_term*10
  end
  if output_index == 54 # PU1
    scale_term = scale_term*5
  end
  if output_index == 40 # AhR
    scale_term = scale_term*5
  end
  if output_index == 52 # p47Phox
    scale_term = scale_term*3
  end

  #scale_term = scale_term*experimental_data_array[end,2]


  total_error_value = shape_term+scale_term+initial_value_term;

  # return -
  return total_error_value
end

function Error_E2F(experimental_data_array,simulation_time_array,simulation_state_array,output_index,species_symbol,data_dictionary)

  # initialize -
  total_error_value = Inf

  # Interpole the simulation data to the experimental time scale -
  interpolated_simulated_trajectory = np.interp(experimental_data_array[:,1],simulation_time_array,simulation_state_array[:,output_index]);

  # Compute G1G0 -
  simulated_G1G0 = 1./interpolated_simulated_trajectory;

  # Compute the shape term -
  scaled_data_array = alpha_scaling(experimental_data_array[:,2]);
  scaled_simulation_array = alpha_scaling(simulated_G1G0);
  shape_term = sum((scaled_data_array - scaled_simulation_array).^2);

  # Compute the initial value term -
  background_copy_number_dictionary = data_dictionary["background_copy_number_dictionary"];
  background_copy_number = background_copy_number_dictionary[species_symbol]
  cell_volume = data_dictionary["cell_volume"];
  av_number = data_dictionary["av_number"];
  initial_concentration = background_copy_number*(1/av_number)*(1/cell_volume)*1e9; # nM
  initial_value_term = ((interpolated_simulated_trajectory[1] - initial_concentration)^2);

  # Compute the fold change term -
  scaling_factor = simulated_G1G0[1];
  simulated_fold_change = (simulated_G1G0)./(scaling_factor);
  scale_term = sum(((simulated_fold_change - experimental_data_array[:,2])*40).^2);


  total_error_value = shape_term+scale_term+initial_value_term;

  # return -
  return total_error_value;
end

function alpha_scaling(data_array)

  # get the dimension -
  number_of_points = length(data_array)

  # what is the min index?
  min_index = indmin(data_array)
  min_value = data_array[min_index]

  # What is the max index?
  max_index = indmax(data_array)
  max_value = data_array[max_index]

  # compute the scaling -
  scaled_array = Float64[]
  for index = 1:number_of_points

    value = data_array[index]
    scaled_value = (value - min_value)/(max_value - min_value)
    push!(scaled_array,scaled_value)
  end

  return scaled_array
end

function Error_Initial_no_data(simulation_time_array,simulation_state_array,output_index,data_dictionary)

  # initialize -
  total_error_value = Inf

  # Interpole the simulation data to the experimental time scale -
  #interpolated_simulated_trajectory = np.interp(experimental_data_array[:,1],simulation_time_array,simulation_state_array[:,output_index]);

  # Compute the error -
  # Error is the sum of a shape function, a scale function and a background_copy_number function -



  # Compute the initial value term -
  background_copy_number_dictionary = data_dictionary["background_copy_number_dictionary"];
  background_copy_number = 100#background_copy_number_dictionary[species_symbol]
  cell_volume = data_dictionary["cell_volume"];
  av_number = data_dictionary["av_number"];
  initial_concentration = background_copy_number*(1/av_number)*(1/cell_volume)*1e9; # nM
  # divisor to initial value scaling to weight big and small number_of_rates --- revised april 26
  divisor = initial_concentration
  if simulation_state_array[1,output_index] - initial_concentration <=0
    divisor = -simulation_state_array[1,output_index]
  end
  initial_value_term = (((simulation_state_array[1,output_index] - initial_concentration)/divisor)); #no equare
  #@show output_index, initial_value_term
  # Compute the scale term -

  total_error_value = initial_value_term;

  # return -
  return total_error_value
end
