include("Include.jl")

# which file extentions for data processing
foler_pointer = "RA/"
directory_pointer = "_RA"

for count = collect(1:3)
  if count == 1
    folder_pointer = "RA/"
    directory_pointer = "_RA"
  elseif count == 2
    folder_pointer = "D3/"
    directory_pointer = "_D3"
  elseif count == 3
    folder_pointer = "RA_D3/"
    directory_pointer = "_RA_D3"
  end
  @show count, folder_pointer
  # Where are my files stored?
  #path_to_sim_files = "./best_ensemble"
  path_to_sim_files = "./best_ensemble/"folder_pointer

  # Load the ensemble for AhR -
  time_AhR = [0.0 48.0]
  (raw_data_AhR,scaled_data_AhR,scaled_state_AhR,raw_state_AhR) = process_ensemble_data(path_to_sim_files,time_AhR,42);
  writedlm("./plot_best/scaled_data_AhR"*directory_pointer*".dat",scaled_data_AhR);
  writedlm("./plot_best/raw_data_AhR"*directory_pointer*".dat",raw_data_AhR);
  writedlm("./plot_best/scaled_state_AhR"*directory_pointer*".dat",scaled_state_AhR);
  writedlm("./plot_best/raw_state_AhR"*directory_pointer*".dat",raw_state_AhR);

  # Load the ensemble for CD38 -
  time_CD38 = [0.0 24.0 48.0 72.0]
  (raw_data_CD38,scaled_data_CD38,scaled_state_CD38,raw_state_CD38) = process_ensemble_data(path_to_sim_files,time_CD38,45);
  writedlm("./plot_best/scaled_data_CD38"*directory_pointer*".dat",scaled_data_CD38);
  writedlm("./plot_best/raw_data_CD38"*directory_pointer*".dat",raw_data_CD38);
  writedlm("./plot_best/scaled_state_CD38"*directory_pointer*".dat",scaled_state_CD38);
  writedlm("./plot_best/raw_state_CD38"*directory_pointer*".dat",raw_state_CD38);

  # Load the ensemble for CD14 -
  time_CD14 = [0.0 24.0 48.0 72.0]
  (raw_data_CD14,scaled_data_CD14,scaled_state_CD14,raw_state_CD14) = process_ensemble_data(path_to_sim_files,time_CD14,44);
  writedlm("./plot_best/scaled_data_CD14"*directory_pointer*".dat",scaled_data_CD14);
  writedlm("./plot_best/raw_data_CD14"*directory_pointer*".dat",raw_data_CD14);
  writedlm("./plot_best/scaled_state_CD14"*directory_pointer*".dat",scaled_state_CD14);
  writedlm("./plot_best/raw_state_CD14"*directory_pointer*".dat",raw_state_CD14);

  # Load the ensemble for CD11b -
  time_CD11b = [0.0 24.0 48.0 72.0]
  (raw_data_CD11b,scaled_data_CD11b,scaled_state_CD11b,raw_state_CD11b) = process_ensemble_data(path_to_sim_files,time_CD11b,43);
  writedlm("./plot_best/scaled_data_CD11b"*directory_pointer*".dat",scaled_data_CD11b);
  writedlm("./plot_best/raw_data_CD11b"*directory_pointer*".dat",raw_data_CD11b);
  writedlm("./plot_best/scaled_state_CD11b"*directory_pointer*".dat",scaled_state_CD11b);
  writedlm("./plot_best/raw_state_CD11b"*directory_pointer*".dat",raw_state_CD11b);

  # Load the ensemble for P47Phox -
  time_P47Phox = [0.0 48.0]
  (raw_data_P47Phox,scaled_data_P47Phox,scaled_state_P47Phox,raw_state_P47Phox) = process_ensemble_data(path_to_sim_files,time_P47Phox,54);
  writedlm("./plot_best/scaled_data_P47Phox"*directory_pointer*".dat",scaled_data_P47Phox);
  writedlm("./plot_best/raw_data_P47Phox"*directory_pointer*".dat",raw_data_P47Phox);
  writedlm("./plot_best/scaled_state_P47Phox"*directory_pointer*".dat",scaled_state_P47Phox);
  writedlm("./plot_best/raw_state_P47Phox"*directory_pointer*".dat",raw_state_P47Phox);

  # Load the ensemble for EGR1 -
  time_EGR1 = [0.0 48.0]
  (raw_data_EGR1,scaled_data_EGR1,scaled_state_EGR1,raw_state_EGR1) = process_ensemble_data(path_to_sim_files,time_EGR1,48);
  writedlm("./plot_best/scaled_data_EGR1"*directory_pointer*".dat",scaled_data_EGR1);
  writedlm("./plot_best/raw_data_EGR1"*directory_pointer*".dat",raw_data_EGR1);
  writedlm("./plot_best/scaled_state_EGR1"*directory_pointer*".dat",scaled_state_EGR1);
  writedlm("./plot_best/raw_state_EGR1"*directory_pointer*".dat",raw_state_EGR1);

  # Load the ensemble for IRF1 -
  time_IRF1 = [0.0 48.0]
  (raw_data_IRF1,scaled_data_IRF1,scaled_state_IRF1,raw_state_IRF1) = process_ensemble_data(path_to_sim_files,time_IRF1,50);
  writedlm("./plot_best/scaled_data_IRF1"*directory_pointer*".dat",scaled_data_IRF1);
  writedlm("./plot_best/raw_data_IRF1"*directory_pointer*".dat",raw_data_IRF1);
  writedlm("./plot_best/scaled_state_IRF1"*directory_pointer*".dat",scaled_state_IRF1);
  writedlm("./plot_best/raw_state_IRF1"*directory_pointer*".dat",raw_state_IRF1);

  # Load the ensemble for GIF1 -
  time_GIF1 = [0.0 48.0]
  (raw_data_GIF1,scaled_data_GIF1,scaled_state_GIF1,raw_state_GIF1) = process_ensemble_data(path_to_sim_files,time_GIF1,49);
  writedlm("./plot_best/scaled_data_GIF1"*directory_pointer*".dat",scaled_data_GIF1);
  writedlm("./plot_best/raw_data_GIF1"*directory_pointer*".dat",raw_data_GIF1);
  writedlm("./plot_best/scaled_state_GIF1"*directory_pointer*".dat",scaled_state_GIF1);
  writedlm("./plot_best/raw_state_GIF1"*directory_pointer*".dat",raw_state_GIF1);

  # Load the ensemble for PU1 -
  time_PU1 = [0.0 48.0]
  (raw_data_PU1,scaled_data_PU1,scaled_state_PU1,raw_state_PU1) = process_ensemble_data(path_to_sim_files,time_PU1,56);
  writedlm("./plot_best/scaled_data_PU1"*directory_pointer*".dat",scaled_data_PU1);
  writedlm("./plot_best/raw_data_PU1"*directory_pointer*".dat",raw_data_PU1);
  writedlm("./plot_best/scaled_state_PU1"*directory_pointer*".dat",scaled_state_PU1);
  writedlm("./plot_best/raw_state_PU1"*directory_pointer*".dat",raw_state_PU1);

  # Load the ensemble for OCT4 -
  time_OCT4 = [0.0 48.0]
  (raw_data_OCT4,scaled_data_OCT4,scaled_state_OCT4,raw_state_OCT4) = process_ensemble_data(path_to_sim_files,time_OCT4,52);
  writedlm("./plot_best/scaled_data_OCT4"*directory_pointer*".dat",scaled_data_OCT4);
  writedlm("./plot_best/raw_data_OCT4"*directory_pointer*".dat",raw_data_OCT4);
  writedlm("./plot_best/scaled_state_OCT4"*directory_pointer*".dat",scaled_state_OCT4);
  writedlm("./plot_best/raw_state_OCT4"*directory_pointer*".dat",raw_state_OCT4);

  # Load the ensemble for CEBPa -
  time_CEBPa = [0.0 48.0]
  (raw_data_CEBPa,scaled_data_CEBPa,scaled_state_CEBPa,raw_state_CEBPa) = process_ensemble_data(path_to_sim_files,time_CEBPa,46);
  writedlm("./plot_best/scaled_data_CEBPa"*directory_pointer*".dat",scaled_data_CEBPa);
  writedlm("./plot_best/raw_data_CEBPa"*directory_pointer*".dat",raw_data_CEBPa);
  writedlm("./plot_best/scaled_state_CEBPa"*directory_pointer*".dat",scaled_state_CEBPa);
  writedlm("./plot_best/raw_state_CEBPa"*directory_pointer*".dat",raw_state_CEBPa);

  # Load the ensemble for E2F -
  time_E2F = [0.0 24.0 48.0 72.0]
  (raw_data_E2F,scaled_data_E2F,scaled_state_E2F,raw_state_E2F) = process_ensemble_data(path_to_sim_files,time_E2F,47);
  writedlm("./plot_best/scaled_data_E2F"*directory_pointer*".dat",scaled_data_E2F);
  writedlm("./plot_best/raw_data_E2F"*directory_pointer*".dat",raw_data_E2F);
  writedlm("./plot_best/scaled_state_E2F"*directory_pointer*".dat",scaled_state_E2F);
  writedlm("./plot_best/raw_state_E2F"*directory_pointer*".dat",raw_state_E2F);
end
