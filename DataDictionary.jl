# ----------------------------------------------------------------------------------- #
# Copyright (c) 2016 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
#
# ----------------------------------------------------------------------------------- #
# Function: DataDictionary
# Description: Holds simulation and model parameters as key => value pairs in a Julia Dict()
# Generated on: 2016-12-01T13:12:23.543
#
# Input arguments:
# time_start::Float64 => Simulation start time value (scalar)
# time_stop::Float64 => Simulation stop time value (scalar)
# time_step::Float64 => Simulation time step (scalar)
#
# Output arguments:
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model and simulation parameters as key => value pairs
# ----------------------------------------------------------------------------------- #
function DataDictionary(time_start::Float64,time_stop::Float64,time_step_size::Float64)

	# stoichiometric_matrix and dilution_matrix -
	stoichiometric_matrix = readdlm("./Network.dat")
	dilution_matrix = readdlm("./Dilution.dat")
	degradation_matrix = readdlm("./Degradation.dat")

	# array of gene lengths -
	gene_coding_length_array = [
		10323	;	# 1	gene_AP1
		47530	;	# 2	gene_AhR
		72925	;	# 3	gene_CD11b
		8974	;	# 4	gene_CD14
		74978	;	# 5	gene_CD38
		2630	;	# 6	gene_CEBPa
		17919	;	# 7	gene_E2F
		10824	;	# 8	gene_EGR1
		13833	;	# 9	gene_GFI1
		16165	;	# 10	gene_IRF1
		206516 	;	# 11	gene_OCT1
		6356	;	# 12	gene_OCT4
		15651	;	# 13	gene_P21
		3074	;	# 14	gene_P47Phox https://www.ncbi.nlm.nih.gov/nuccore/AF003533.1   #1475	;	# 14	gene_P47Phox -- https://www.ncbi.nlm.nih.gov/nuccore/NM_000265.5
		153507	;	# 15	gene_PPARg
		40782	;	# 16	gene_PU1
		15000	;	# 17	gene_Trigger_D3 --- not used for gene expression, only as input for the model
		15000	;	# 18	gene_Trigger_RA
		15000	;	# 19	gene_cRAF
		15000	;	# 20	gene_repressor14
	]

	# array of mRNA coding lengths -
	mRNA_coding_length_array = [
		gene_coding_length_array[1]	;	# 21	1	mRNA_gene_AP1
		gene_coding_length_array[2]	;	# 22	2	mRNA_gene_AhR
		gene_coding_length_array[3]	;	# 23	3	mRNA_gene_CD11b
		gene_coding_length_array[4]	;	# 24	4	mRNA_gene_CD14
		gene_coding_length_array[5]	;	# 25	5	mRNA_gene_CD38
		gene_coding_length_array[6]	;	# 26	6	mRNA_gene_CEBPa
		gene_coding_length_array[7]	;	# 27	7	mRNA_gene_E2F
		gene_coding_length_array[8]	;	# 28	8	mRNA_gene_EGR1
		gene_coding_length_array[9]	;	# 29	9	mRNA_gene_GFI1
		gene_coding_length_array[10]	;	# 30	10	mRNA_gene_IRF1
		gene_coding_length_array[11]	;	# 31	11	mRNA_gene_OCT1
		gene_coding_length_array[12]	;	# 32	12	mRNA_gene_OCT4
		gene_coding_length_array[13]	;	# 33	13	mRNA_gene_P21
		gene_coding_length_array[14]	;	# 34	14	mRNA_gene_P47Phox
		gene_coding_length_array[15]	;	# 35	15	mRNA_gene_PPARg
		gene_coding_length_array[16]	;	# 36	16	mRNA_gene_PU1
		gene_coding_length_array[17]	;	# 37	17	mRNA_gene_Trigger_D3
		gene_coding_length_array[18]	;	# 38	18	mRNA_gene_Trigger_RA
		gene_coding_length_array[19]	;	# 39	19	mRNA_gene_cRAF
		gene_coding_length_array[20]	;	# 40	20	mRNA_gene_repressor14
	]

	# array of mRNA coding lengths -
	protein_coding_length_array = [
		331	;	# 37	1	protein_gene_AP1
		848	;	# 38	2	protein_gene_AhR
		1153	;	# 39	3	protein_gene_CD11b
		375	;	# 40	4	protein_gene_CD14
		300	;	# 41	5	protein_gene_CD38
		393	;	# 42	6	protein_gene_CEBPa
		437	;	# 43	7	protein_gene_E2F
		543	;	# 44	8	protein_gene_EGR1
		422	;	# 45	9	protein_gene_GFI1
		325	;	# 46	10	protein_gene_IRF1
		741.3333333333	;	# 47	11	protein_gene_OCT1
		206.3333333	;	# 48	12	protein_gene_OCT4
		198	;	# 49	13	protein_gene_P21
		390	;	# 50	14	protein_gene_P47Phox -- https://www.ncbi.nlm.nih.gov/protein/NP_000256.4
		250	;	# 51	15	protein_gene_PPARg
		270.5	;	# 52	16	protein_gene_PU1
		round((0.33)*mRNA_coding_length_array[17])	;	# 57	17	protein_gene_Trigger_D3
		round((0.33)*mRNA_coding_length_array[18])	;	# 58	18	protein_gene_Trigger_RA
		round((0.33)*mRNA_coding_length_array[19])	;	# 59	19	protein_gene_cRAF
		round((0.33)*mRNA_coding_length_array[20])	;	# 60	20	protein_gene_repressor14
	]

	# ------------------------------------------------------------------------------------------#
	# constants (from bionumbers)       units
	# ------------------------------------------------------------------------------------------#
	cell_diameter = 12                  # mum
	number_of_rnapII = 75000            # copies/cells
	number_of_ribosome = 1e6            # copies/cells
	mRNA_half_life_TF = 2               # hrs
	protein_half_life = 10              # hrs
	doubling_time_cell = 19.5           # hrs
	max_translation_rate = 5            # aa/sec
	max_transcription_rate = 6.0        # nt/sec
	average_transcript_length = 15000   # nt
	average_protein_length = 5000       # aa
	fraction_nucleus = 0.49             # dimensionless
	av_number = 6.02e23                 # number/mol
	avg_gene_number = 2                 # number of copies of a gene
	# ------------------------------------------------------------------------------------------#
	#
	# ------------------------------------------------------------------------------------------#
	# Calculate constants using bionumber values
	# ------------------------------------------------------------------------------------------#
	# Calculate the volume (convert to L)
	V = ((1-fraction_nucleus)*(1/6)*(3.14159)*(cell_diameter)^3)*(1e-15)

	# Calculate the rnapII_concentration and ribosome_concentration
	rnapII_concentration = number_of_rnapII*(1/av_number)*(1/V)*1e9                   # nM
	ribosome_concentration = number_of_ribosome*(1/av_number)*(1/V)*1e9               # nM

	# degrdation rate constants -
	degradation_constant_mRNA = -(1/mRNA_half_life_TF)*log(0.5)                       # hr^-1
	degradation_constant_protein = -(1/protein_half_life)*log(0.5)                    # hr^-1

	# kcats for transcription and translation -
	kcat_transcription = max_transcription_rate*(3600/average_transcript_length)      # hr^-1
	kcat_translation = max_translation_rate*(3600/average_protein_length)             # hr^-1

	# Maximum specific growth rate -
	maximum_specific_growth_rate = (1/doubling_time_cell)*log(2)                      # hr^-1

	# What is the average gene concentration -
	avg_gene_concentration = avg_gene_number*(1/av_number)*(1/V)*1e9                  # nM

	# How fast do my cells die?
	death_rate_constant = 0.2*maximum_specific_growth_rate                            # hr^-1

	# Saturation constants for translation and trascription -
	saturation_transcription = 4600*(1/av_number)*(1/V)*1e9                           # nM
	saturation_translation = 100000*(1/av_number)*(1/V)*1e9                           # nM
	# -------------------------------------------------------------------------------------------#

	# initial condition array -
	initial_condition_array = [
		avg_gene_concentration	;	# 1	gene_AP1
		avg_gene_concentration	;	# 2	gene_AhR
		avg_gene_concentration	;	# 3	gene_CD11b
		avg_gene_concentration	;	# 4	gene_CD14
		avg_gene_concentration	;	# 5	gene_CD38
		avg_gene_concentration	;	# 6	gene_CEBPa
		avg_gene_concentration	;	# 7	gene_E2F
		avg_gene_concentration	;	# 8	gene_EGR1
		avg_gene_concentration	;	# 9	gene_GFI1
		avg_gene_concentration	;	# 10	gene_IRF1
		avg_gene_concentration	;	# 11	gene_OCT1
		avg_gene_concentration	;	# 12	gene_OCT4
		avg_gene_concentration	;	# 13	gene_P21
		avg_gene_concentration	;	# 14	gene_P47Phox
		avg_gene_concentration	;	# 15	gene_PPARg
		avg_gene_concentration	;	# 16	gene_PU1
		avg_gene_concentration	;	# 17	gene_Trigger_D3
		avg_gene_concentration	;	# 18	gene_Trigger_RA
		avg_gene_concentration	;	# 19	gene_cRAF
		avg_gene_concentration	;	# 20	gene_repressor14
		0.0	;	# 21	mRNA_gene_AP1
		0.0	;	# 22	mRNA_gene_AhR
		0.0	;	# 23	mRNA_gene_CD11b
		0.0	;	# 24	mRNA_gene_CD14
		0.0	;	# 25	mRNA_gene_CD38
		0.0	;	# 26	mRNA_gene_CEBPa
		0.0	;	# 27	mRNA_gene_E2F
		0.0	;	# 28	mRNA_gene_EGR1
		0.0	;	# 29	mRNA_gene_GFI1
		0.0	;	# 30	mRNA_gene_IRF1
		0.0	;	# 31	mRNA_gene_OCT1
		0.0	;	# 32	mRNA_gene_OCT4
		0.0	;	# 33	mRNA_gene_P21
		0.0	;	# 34	mRNA_gene_P47Phox
		0.0	;	# 35	mRNA_gene_PPARg
		0.0	;	# 36	mRNA_gene_PU1
		0.0	;	# 37	mRNA_gene_Trigger_D3
		0.0	;	# 38	mRNA_gene_Trigger_RA
		0.0	;	# 39	mRNA_gene_cRAF
		0.0	;	# 40	mRNA_gene_repressor14
		0.0	;	# 41	protein_gene_AP1
		0.0	;	# 42	protein_gene_AhR
		0.0	;	# 43	protein_gene_CD11b
		0.0	;	# 44	protein_gene_CD14
		0.0	;	# 45	protein_gene_CD38
		0.0	;	# 46	protein_gene_CEBPa
		0.0	;	# 47	protein_gene_E2F
		0.0	;	# 48	protein_gene_EGR1
		0.0	;	# 49	protein_gene_GFI1
		0.0	;	# 50	protein_gene_IRF1
		0.0	;	# 51	protein_gene_OCT1
		0.0	;	# 52	protein_gene_OCT4
		0.0	;	# 53	protein_gene_P21
		0.0	;	# 54	protein_gene_P47Phox
		0.0	;	# 55	protein_gene_PPARg
		0.0	;	# 56	protein_gene_PU1
		0.0	;	# 57	protein_gene_Trigger_D3
		0.0	;	# 58	protein_gene_Trigger_RA
		0.0	;	# 59	protein_gene_cRAF
		0.0	;	# 60	protein_gene_repressor14
	]

	binding_parameter_dictionary = Dict{AbstractString,Float64}()
	binding_parameter_dictionary["n_gene_AP1_gene_AhR"] = 1.0
	binding_parameter_dictionary["K_gene_AP1_gene_AhR"] = 120.0
	binding_parameter_dictionary["n_gene_AP1_gene_PU1"] = 1.0
	binding_parameter_dictionary["K_gene_AP1_gene_PU1"] = 120.0
	binding_parameter_dictionary["n_gene_AP1_gene_PPARg"] = 1.0
	binding_parameter_dictionary["K_gene_AP1_gene_PPARg"] = 120.0
	binding_parameter_dictionary["n_gene_AhR_gene_Trigger_RA"] = 1.0
	binding_parameter_dictionary["K_gene_AhR_gene_Trigger_RA"] = 120.0
	binding_parameter_dictionary["n_gene_CD11b_gene_PU1_gene_cRAF"] = 1.0
	binding_parameter_dictionary["K_gene_CD11b_gene_PU1_gene_cRAF"] = 120.0
	binding_parameter_dictionary["n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"] = 1.0
	binding_parameter_dictionary["K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"] = 120.0
	binding_parameter_dictionary["n_gene_CD14_gene_repressor14"] = 1.0
	binding_parameter_dictionary["K_gene_CD14_gene_repressor14"] = 120.0
	binding_parameter_dictionary["n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"] = 1.0
	binding_parameter_dictionary["K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"] = 120.0
	binding_parameter_dictionary["n_gene_CEBPa_gene_Trigger_RA"] = 1.0
	binding_parameter_dictionary["K_gene_CEBPa_gene_Trigger_RA"] = 120.0
	binding_parameter_dictionary["n_gene_CEBPa_gene_PPARg"] = 1.0
	binding_parameter_dictionary["K_gene_CEBPa_gene_PPARg"] = 120.0
	binding_parameter_dictionary["n_gene_CEBPa_gene_CEBPa"] = 1.0
	binding_parameter_dictionary["K_gene_CEBPa_gene_CEBPa"] = 120.0
	binding_parameter_dictionary["n_gene_CEBPa_gene_GFI1"] = 1.0
	binding_parameter_dictionary["K_gene_CEBPa_gene_GFI1"] = 120.0
	binding_parameter_dictionary["n_gene_E2F_gene_E2F"] = 1.0
	binding_parameter_dictionary["K_gene_E2F_gene_E2F"] = 120.0
	binding_parameter_dictionary["n_gene_E2F_gene_PPARg"] = 1.0
	binding_parameter_dictionary["K_gene_E2F_gene_PPARg"] = 120.0
	binding_parameter_dictionary["n_gene_E2F_gene_CEBPa"] = 1.0
	binding_parameter_dictionary["K_gene_E2F_gene_CEBPa"] = 120.0
	binding_parameter_dictionary["n_gene_E2F_gene_GFI1"] = 1.0
	binding_parameter_dictionary["K_gene_E2F_gene_GFI1"] = 120.0
	binding_parameter_dictionary["n_gene_E2F_gene_cRAF"] = 1.0
	binding_parameter_dictionary["K_gene_E2F_gene_cRAF"] = 120.0
	binding_parameter_dictionary["n_gene_EGR1_gene_Trigger_RA"] = 1.0
	binding_parameter_dictionary["K_gene_EGR1_gene_Trigger_RA"] = 120.0
	binding_parameter_dictionary["n_gene_EGR1_gene_PU1"] = 1.0
	binding_parameter_dictionary["K_gene_EGR1_gene_PU1"] = 120.0
	binding_parameter_dictionary["n_gene_EGR1_gene_PPARg"] = 1.0
	binding_parameter_dictionary["K_gene_EGR1_gene_PPARg"] = 120.0
	binding_parameter_dictionary["n_gene_EGR1_gene_GFI1"] = 1.0
	binding_parameter_dictionary["K_gene_EGR1_gene_GFI1"] = 120.0
	binding_parameter_dictionary["n_gene_GFI1_gene_CEBPa"] = 1.0
	binding_parameter_dictionary["K_gene_GFI1_gene_CEBPa"] = 120.0
	binding_parameter_dictionary["n_gene_GFI1_gene_EGR1"] = 1.0
	binding_parameter_dictionary["K_gene_GFI1_gene_EGR1"] = 120.0
	binding_parameter_dictionary["n_gene_IRF1_gene_Trigger_RA"] = 1.0
	binding_parameter_dictionary["K_gene_IRF1_gene_Trigger_RA"] = 120.0
	binding_parameter_dictionary["n_gene_IRF1_gene_AhR"] = 1.0
	binding_parameter_dictionary["K_gene_IRF1_gene_AhR"] = 120.0
	binding_parameter_dictionary["n_gene_IRF1_gene_PPARg"] = 1.0
	binding_parameter_dictionary["K_gene_IRF1_gene_PPARg"] = 120.0
	binding_parameter_dictionary["n_gene_OCT1_gene_PPARg"] = 1.0
	binding_parameter_dictionary["K_gene_OCT1_gene_PPARg"] = 120.0
	binding_parameter_dictionary["n_gene_OCT4_gene_Trigger_RA"] = 1.0
	binding_parameter_dictionary["K_gene_OCT4_gene_Trigger_RA"] = 120.0
	binding_parameter_dictionary["n_gene_OCT4_gene_AhR"] = 1.0
	binding_parameter_dictionary["K_gene_OCT4_gene_AhR"] = 120.0
	binding_parameter_dictionary["n_gene_OCT4_gene_cRAF"] = 1.0
	binding_parameter_dictionary["K_gene_OCT4_gene_cRAF"] = 120.0
	binding_parameter_dictionary["n_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"] = 1.0
	binding_parameter_dictionary["K_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"] = 120.0
	binding_parameter_dictionary["n_gene_P21_gene_GFI1"] = 1.0
	binding_parameter_dictionary["K_gene_P21_gene_GFI1"] = 120.0
	binding_parameter_dictionary["n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"] = 1.0
	binding_parameter_dictionary["K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"] = 120.0
	binding_parameter_dictionary["n_gene_P47Phox_gene_PPARg"] = 1.0
	binding_parameter_dictionary["K_gene_P47Phox_gene_PPARg"] = 120.0
	binding_parameter_dictionary["n_gene_PPARg_gene_Trigger_RA"] = 1.0
	binding_parameter_dictionary["K_gene_PPARg_gene_Trigger_RA"] = 120.0
	binding_parameter_dictionary["n_gene_PPARg_gene_Trigger_D3"] = 1.0
	binding_parameter_dictionary["K_gene_PPARg_gene_Trigger_D3"] = 120.0
	binding_parameter_dictionary["n_gene_PPARg_gene_CEBPa"] = 1.0
	binding_parameter_dictionary["K_gene_PPARg_gene_CEBPa"] = 120.0
	binding_parameter_dictionary["n_gene_PPARg_gene_EGR1"] = 1.0
	binding_parameter_dictionary["K_gene_PPARg_gene_EGR1"] = 120.0
	binding_parameter_dictionary["n_gene_PPARg_gene_PU1"] = 1.0
	binding_parameter_dictionary["K_gene_PPARg_gene_PU1"] = 120.0
	binding_parameter_dictionary["n_gene_PPARg_gene_AP1"] = 1.0
	binding_parameter_dictionary["K_gene_PPARg_gene_AP1"] = 120.0
	binding_parameter_dictionary["n_gene_PU1_gene_Trigger_RA"] = 1.0
	binding_parameter_dictionary["K_gene_PU1_gene_Trigger_RA"] = 120.0
	binding_parameter_dictionary["n_gene_PU1_gene_Trigger_D3"] = 1.0
	binding_parameter_dictionary["K_gene_PU1_gene_Trigger_D3"] = 120.0
	binding_parameter_dictionary["n_gene_PU1_gene_CEBPa"] = 1.0
	binding_parameter_dictionary["K_gene_PU1_gene_CEBPa"] = 120.0
	binding_parameter_dictionary["n_gene_PU1_gene_PU1"] = 1.0
	binding_parameter_dictionary["K_gene_PU1_gene_PU1"] = 120.0
	binding_parameter_dictionary["n_gene_PU1_gene_AP1"] = 1.0
	binding_parameter_dictionary["K_gene_PU1_gene_AP1"] = 120.0
	binding_parameter_dictionary["n_gene_PU1_gene_OCT1"] = 1.0
	binding_parameter_dictionary["K_gene_PU1_gene_OCT1"] = 120.0
	binding_parameter_dictionary["n_gene_PU1_gene_AhR"] = 1.0
	binding_parameter_dictionary["K_gene_PU1_gene_AhR"] = 120.0
	binding_parameter_dictionary["n_gene_PU1_gene_GFI1"] = 1.0
	binding_parameter_dictionary["K_gene_PU1_gene_GFI1"] = 120.0
	binding_parameter_dictionary["n_gene_repressor14_gene_Trigger_RA"] = 1.0
	binding_parameter_dictionary["K_gene_repressor14_gene_Trigger_RA"] = 120.0

	# Alias the control function parameters -
	control_parameter_dictionary = Dict{AbstractString,Float64}()
	control_parameter_dictionary["W_gene_AP1_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_AP1_gene_AhR"] = 1.0
	control_parameter_dictionary["W_gene_AP1_gene_PU1"] = 1.0
	control_parameter_dictionary["W_gene_AP1_gene_PPARg"] = 1.0
	control_parameter_dictionary["W_gene_AhR_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_AhR_gene_Trigger_RA"] = 1.0
	control_parameter_dictionary["W_gene_CD11b_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_CD11b_gene_PU1_gene_cRAF"] = 1.0
	control_parameter_dictionary["W_gene_CD14_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"] = 1.0
	control_parameter_dictionary["W_gene_CD14_gene_repressor14"] = 1.0
	control_parameter_dictionary["W_gene_CD38_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"] = 1.0
	control_parameter_dictionary["W_gene_CEBPa_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_CEBPa_gene_Trigger_RA"] = 1.0
	control_parameter_dictionary["W_gene_CEBPa_gene_PPARg"] = 1.0
	control_parameter_dictionary["W_gene_CEBPa_gene_CEBPa"] = 1.0
	control_parameter_dictionary["W_gene_CEBPa_gene_GFI1"] = 1.0
	control_parameter_dictionary["W_gene_E2F_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_E2F_gene_E2F"] = 1.0
	control_parameter_dictionary["W_gene_E2F_gene_PPARg"] = 1.0
	control_parameter_dictionary["W_gene_E2F_gene_CEBPa"] = 1.0
	control_parameter_dictionary["W_gene_E2F_gene_GFI1"] = 1.0
	control_parameter_dictionary["W_gene_E2F_gene_cRAF"] = 1.0
	control_parameter_dictionary["W_gene_EGR1_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_EGR1_gene_Trigger_RA"] = 1.0
	control_parameter_dictionary["W_gene_EGR1_gene_PU1"] = 1.0
	control_parameter_dictionary["W_gene_EGR1_gene_PPARg"] = 1.0
	control_parameter_dictionary["W_gene_EGR1_gene_GFI1"] = 1.0
	control_parameter_dictionary["W_gene_GFI1_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_GFI1_gene_CEBPa"] = 1.0
	control_parameter_dictionary["W_gene_GFI1_gene_EGR1"] = 1.0
	control_parameter_dictionary["W_gene_IRF1_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_IRF1_gene_Trigger_RA"] = 1.0
	control_parameter_dictionary["W_gene_IRF1_gene_AhR"] = 1.0
	control_parameter_dictionary["W_gene_IRF1_gene_PPARg"] = 1.0
	control_parameter_dictionary["W_gene_OCT1_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_OCT1_gene_PPARg"] = 1.0
	control_parameter_dictionary["W_gene_OCT4_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_OCT4_gene_Trigger_RA"] = 1.0
	control_parameter_dictionary["W_gene_OCT4_gene_AhR"] = 1.0
	control_parameter_dictionary["W_gene_OCT4_gene_cRAF"] = 1.0
	control_parameter_dictionary["W_gene_P21_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"] = 1.0
	control_parameter_dictionary["W_gene_P21_gene_GFI1"] = 1.0
	control_parameter_dictionary["W_gene_P47Phox_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"] = 1.0
	control_parameter_dictionary["W_gene_P47Phox_gene_PPARg"] = 1.0
	control_parameter_dictionary["W_gene_PPARg_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_PPARg_gene_Trigger_RA"] = 1.0
	control_parameter_dictionary["W_gene_PPARg_gene_Trigger_D3"] = 1.0
	control_parameter_dictionary["W_gene_PPARg_gene_CEBPa"] = 1.0
	control_parameter_dictionary["W_gene_PPARg_gene_EGR1"] = 1.0
	control_parameter_dictionary["W_gene_PPARg_gene_PU1"] = 1.0
	control_parameter_dictionary["W_gene_PPARg_gene_AP1"] = 1.0
	control_parameter_dictionary["W_gene_PU1_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_PU1_gene_Trigger_RA"] = 1.0
	control_parameter_dictionary["W_gene_PU1_gene_Trigger_D3"] = 1.0
	control_parameter_dictionary["W_gene_PU1_gene_CEBPa"] = 1.0
	control_parameter_dictionary["W_gene_PU1_gene_PU1"] = 1.0
	control_parameter_dictionary["W_gene_PU1_gene_AP1"] = 1.0
	control_parameter_dictionary["W_gene_PU1_gene_OCT1"] = 1.0
	control_parameter_dictionary["W_gene_PU1_gene_AhR"] = 1.0
	control_parameter_dictionary["W_gene_PU1_gene_GFI1"] = 1.0
	control_parameter_dictionary["W_gene_Trigger_D3_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_Trigger_RA_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_cRAF_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_repressor14_RNAP"] = 0.001
	control_parameter_dictionary["W_gene_repressor14_gene_Trigger_RA"] = 1.0

	# Parameter name index array -
	parameter_name_mapping_array = [
		"n_gene_AP1_gene_AhR"	;	# 1
		"K_gene_AP1_gene_AhR"	;	# 2
		"n_gene_AP1_gene_PU1"	;	# 3
		"K_gene_AP1_gene_PU1"	;	# 4
		"n_gene_AP1_gene_PPARg"	;	# 5
		"K_gene_AP1_gene_PPARg"	;	# 6
		"n_gene_AhR_gene_Trigger_RA"	;	# 7
		"K_gene_AhR_gene_Trigger_RA"	;	# 8
		"n_gene_CD11b_gene_PU1_gene_cRAF"	;	# 9
		"K_gene_CD11b_gene_PU1_gene_cRAF"	;	# 10
		"n_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 11
		"K_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 12
		"n_gene_CD14_gene_repressor14"	;	# 13
		"K_gene_CD14_gene_repressor14"	;	# 14
		"n_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 15
		"K_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 16
		"n_gene_CEBPa_gene_Trigger_RA"	;	# 17
		"K_gene_CEBPa_gene_Trigger_RA"	;	# 18
		"n_gene_CEBPa_gene_PPARg"	;	# 19
		"K_gene_CEBPa_gene_PPARg"	;	# 20
		"n_gene_CEBPa_gene_CEBPa"	;	# 21
		"K_gene_CEBPa_gene_CEBPa"	;	# 22
		"n_gene_CEBPa_gene_GFI1"	;	# 23
		"K_gene_CEBPa_gene_GFI1"	;	# 24
		"n_gene_E2F_gene_E2F"	;	# 25
		"K_gene_E2F_gene_E2F"	;	# 26
		"n_gene_E2F_gene_PPARg"	;	# 27
		"K_gene_E2F_gene_PPARg"	;	# 28
		"n_gene_E2F_gene_CEBPa"	;	# 29
		"K_gene_E2F_gene_CEBPa"	;	# 30
		"n_gene_E2F_gene_GFI1"	;	# 31
		"K_gene_E2F_gene_GFI1"	;	# 32
		"n_gene_E2F_gene_cRAF"	;	# 33
		"K_gene_E2F_gene_cRAF"	;	# 34
		"n_gene_EGR1_gene_Trigger_RA"	;	# 35
		"K_gene_EGR1_gene_Trigger_RA"	;	# 36
		"n_gene_EGR1_gene_PU1"	;	# 37
		"K_gene_EGR1_gene_PU1"	;	# 38
		"n_gene_EGR1_gene_PPARg"	;	# 39
		"K_gene_EGR1_gene_PPARg"	;	# 40
		"n_gene_EGR1_gene_GFI1"	;	# 41
		"K_gene_EGR1_gene_GFI1"	;	# 42
		"n_gene_GFI1_gene_CEBPa"	;	# 43
		"K_gene_GFI1_gene_CEBPa"	;	# 44
		"n_gene_GFI1_gene_EGR1"	;	# 45
		"K_gene_GFI1_gene_EGR1"	;	# 46
		"n_gene_IRF1_gene_Trigger_RA"	;	# 47
		"K_gene_IRF1_gene_Trigger_RA"	;	# 48
		"n_gene_IRF1_gene_AhR"	;	# 49
		"K_gene_IRF1_gene_AhR"	;	# 50
		"n_gene_IRF1_gene_PPARg"	;	# 51
		"K_gene_IRF1_gene_PPARg"	;	# 52
		"n_gene_OCT1_gene_PPARg"	;	# 53
		"K_gene_OCT1_gene_PPARg"	;	# 54
		"n_gene_OCT4_gene_Trigger_RA"	;	# 55
		"K_gene_OCT4_gene_Trigger_RA"	;	# 56
		"n_gene_OCT4_gene_AhR"	;	# 57
		"K_gene_OCT4_gene_AhR"	;	# 58
		"n_gene_OCT4_gene_cRAF"	;	# 59
		"K_gene_OCT4_gene_cRAF"	;	# 60
		"n_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"	;	# 61
		"K_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"	;	# 62
		"n_gene_P21_gene_GFI1"	;	# 63
		"K_gene_P21_gene_GFI1"	;	# 64
		"n_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 65
		"K_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 66
		"n_gene_P47Phox_gene_PPARg"	;	# 67
		"K_gene_P47Phox_gene_PPARg"	;	# 68
		"n_gene_PPARg_gene_Trigger_RA"	;	# 69
		"K_gene_PPARg_gene_Trigger_RA"	;	# 70
		"n_gene_PPARg_gene_Trigger_D3"	;	# 71
		"K_gene_PPARg_gene_Trigger_D3"	;	# 72
		"n_gene_PPARg_gene_CEBPa"	;	# 73
		"K_gene_PPARg_gene_CEBPa"	;	# 74
		"n_gene_PPARg_gene_EGR1"	;	# 75
		"K_gene_PPARg_gene_EGR1"	;	# 76
		"n_gene_PPARg_gene_PU1"	;	# 77
		"K_gene_PPARg_gene_PU1"	;	# 78
		"n_gene_PPARg_gene_AP1"	;	# 79
		"K_gene_PPARg_gene_AP1"	;	# 80
		"n_gene_PU1_gene_Trigger_RA"	;	# 81
		"K_gene_PU1_gene_Trigger_RA"	;	# 82
		"n_gene_PU1_gene_Trigger_D3"	;	# 83
		"K_gene_PU1_gene_Trigger_D3"	;	# 84
		"n_gene_PU1_gene_CEBPa"	;	# 85
		"K_gene_PU1_gene_CEBPa"	;	# 86
		"n_gene_PU1_gene_PU1"	;	# 87
		"K_gene_PU1_gene_PU1"	;	# 88
		"n_gene_PU1_gene_AP1"	;	# 89
		"K_gene_PU1_gene_AP1"	;	# 90
		"n_gene_PU1_gene_OCT1"	;	# 91
		"K_gene_PU1_gene_OCT1"	;	# 92
		"n_gene_PU1_gene_AhR"	;	# 93
		"K_gene_PU1_gene_AhR"	;	# 94
		"n_gene_PU1_gene_GFI1"	;	# 95
		"K_gene_PU1_gene_GFI1"	;	# 96
		"n_gene_repressor14_gene_Trigger_RA"	;	# 97
		"K_gene_repressor14_gene_Trigger_RA"	;	# 98
		"W_gene_AP1_RNAP"	;	# 99
		"W_gene_AP1_gene_AhR"	;	# 100
		"W_gene_AP1_gene_PU1"	;	# 101
		"W_gene_AP1_gene_PPARg"	;	# 102
		"W_gene_AhR_RNAP"	;	# 103
		"W_gene_AhR_gene_Trigger_RA"	;	# 104
		"W_gene_CD11b_RNAP"	;	# 105
		"W_gene_CD11b_gene_PU1_gene_cRAF"	;	# 106
		"W_gene_CD14_RNAP"	;	# 107
		"W_gene_CD14_gene_PPARg_gene_CEBPa_gene_EGR1_gene_cRAF"	;	# 108
		"W_gene_CD14_gene_repressor14"	;	# 109
		"W_gene_CD38_RNAP"	;	# 110
		"W_gene_CD38_gene_IRF1_gene_PPARg_gene_Trigger_RA_gene_cRAF"	;	# 111
		"W_gene_CEBPa_RNAP"	;	# 112
		"W_gene_CEBPa_gene_Trigger_RA"	;	# 113
		"W_gene_CEBPa_gene_PPARg"	;	# 114
		"W_gene_CEBPa_gene_CEBPa"	;	# 115
		"W_gene_CEBPa_gene_GFI1"	;	# 116
		"W_gene_E2F_RNAP"	;	# 117
		"W_gene_E2F_gene_E2F"	;	# 118
		"W_gene_E2F_gene_PPARg"	;	# 119
		"W_gene_E2F_gene_CEBPa"	;	# 120
		"W_gene_E2F_gene_GFI1"	;	# 121
		"W_gene_E2F_gene_cRAF"	;	# 122
		"W_gene_EGR1_RNAP"	;	# 123
		"W_gene_EGR1_gene_Trigger_RA"	;	# 124
		"W_gene_EGR1_gene_PU1"	;	# 125
		"W_gene_EGR1_gene_PPARg"	;	# 126
		"W_gene_EGR1_gene_GFI1"	;	# 127
		"W_gene_GFI1_RNAP"	;	# 128
		"W_gene_GFI1_gene_CEBPa"	;	# 129
		"W_gene_GFI1_gene_EGR1"	;	# 130
		"W_gene_IRF1_RNAP"	;	# 131
		"W_gene_IRF1_gene_Trigger_RA"	;	# 132
		"W_gene_IRF1_gene_AhR"	;	# 133
		"W_gene_IRF1_gene_PPARg"	;	# 134
		"W_gene_OCT1_RNAP"	;	# 135
		"W_gene_OCT1_gene_PPARg"	;	# 136
		"W_gene_OCT4_RNAP"	;	# 137
		"W_gene_OCT4_gene_Trigger_RA"	;	# 138
		"W_gene_OCT4_gene_AhR"	;	# 139
		"W_gene_OCT4_gene_cRAF"	;	# 140
		"W_gene_P21_RNAP"	;	# 141
		"W_gene_P21_gene_Trigger_RA_gene_AP1_gene_PPARg_gene_PU1_gene_IRF1_gene_CEBPa_gene_cRAF_gene_Trigger_D3"	;	# 142
		"W_gene_P21_gene_GFI1"	;	# 143
		"W_gene_P47Phox_RNAP"	;	# 144
		"W_gene_P47Phox_gene_PU1_gene_CEBPa_gene_cRAF"	;	# 145
		"W_gene_P47Phox_gene_PPARg"	;	# 146
		"W_gene_PPARg_RNAP"	;	# 147
		"W_gene_PPARg_gene_Trigger_RA"	;	# 148
		"W_gene_PPARg_gene_Trigger_D3"	;	# 149
		"W_gene_PPARg_gene_CEBPa"	;	# 150
		"W_gene_PPARg_gene_EGR1"	;	# 151
		"W_gene_PPARg_gene_PU1"	;	# 152
		"W_gene_PPARg_gene_AP1"	;	# 153
		"W_gene_PU1_RNAP"	;	# 154
		"W_gene_PU1_gene_Trigger_RA"	;	# 155
		"W_gene_PU1_gene_Trigger_D3"	;	# 156
		"W_gene_PU1_gene_CEBPa"	;	# 157
		"W_gene_PU1_gene_PU1"	;	# 158
		"W_gene_PU1_gene_AP1"	;	# 159
		"W_gene_PU1_gene_OCT1"	;	# 160
		"W_gene_PU1_gene_AhR"	;	# 161
		"W_gene_PU1_gene_GFI1"	;	# 162
		"W_gene_Trigger_D3_RNAP"	;	# 163
		"W_gene_Trigger_RA_RNAP"	;	# 164
		"W_gene_cRAF_RNAP"	;	# 165
		"W_gene_repressor14_RNAP"	;	# 166
		"W_gene_repressor14_gene_Trigger_RA"	;	# 167
	]

	# Background copy number - (added by JV)
	background_copy_number_dictionary = Dict{AbstractString,Float64}()
	background_copy_number_dictionary["protein_gene_AP1"] = 100.0
	background_copy_number_dictionary["protein_gene_AhR"] = 100.0
	background_copy_number_dictionary["protein_gene_CD11b"] = 100.0
	background_copy_number_dictionary["protein_gene_CD14"] = 10.0
	background_copy_number_dictionary["protein_gene_CD38"] = 100.0
	background_copy_number_dictionary["protein_gene_CEBPa"] = 100.0
	background_copy_number_dictionary["protein_gene_E2F"] = 10000.0
	background_copy_number_dictionary["protein_gene_OCT4"] = 10000.0
	background_copy_number_dictionary["protein_gene_EGR1"] = 100.0
	background_copy_number_dictionary["protein_gene_GFI1"] = 100.0
	background_copy_number_dictionary["protein_gene_OCT1"] = 100.0
	background_copy_number_dictionary["protein_gene_P21"] = 1000.0
	background_copy_number_dictionary["protein_gene_P47Phox"] = 100.0
	background_copy_number_dictionary["protein_gene_PPARg"] = 100.0
	background_copy_number_dictionary["protein_gene_PU1"] = 1000.0
	background_copy_number_dictionary["protein_gene_IRF1"] = 100.0

	# =============================== DO NOT EDIT BELOW THIS LINE ============================== #
	data_dictionary = Dict{AbstractString,Any}()
	data_dictionary["initial_condition_array"] = initial_condition_array
	data_dictionary["average_transcript_length"] = average_transcript_length
	data_dictionary["average_protein_length"] = average_protein_length
	data_dictionary["gene_coding_length_array"] = gene_coding_length_array
	data_dictionary["mRNA_coding_length_array"] = mRNA_coding_length_array
	data_dictionary["protein_coding_length_array"] = protein_coding_length_array
	data_dictionary["rnapII_concentration"] = rnapII_concentration  # muM
	data_dictionary["ribosome_concentration"] = ribosome_concentration # muM
	data_dictionary["degradation_constant_mRNA"] = degradation_constant_mRNA  # hr^-1
	data_dictionary["degradation_constant_protein"] = degradation_constant_protein  # hr^-1
	data_dictionary["kcat_transcription"] = kcat_transcription  # hr^-1
	data_dictionary["kcat_translation"] = kcat_translation  # hr^-1
	data_dictionary["maximum_specific_growth_rate"] = maximum_specific_growth_rate  # hr^-1
	data_dictionary["death_rate_constant"] = death_rate_constant
	data_dictionary["avg_gene_concentration"] = avg_gene_concentration
	data_dictionary["saturation_constant_transcription"] = saturation_transcription
	data_dictionary["saturation_constant_translation"] = saturation_translation

	data_dictionary["stoichiometric_matrix"] = stoichiometric_matrix
	data_dictionary["dilution_matrix"] = dilution_matrix
	data_dictionary["degradation_matrix"] = degradation_matrix

	data_dictionary["binding_parameter_dictionary"] = binding_parameter_dictionary
	data_dictionary["control_parameter_dictionary"] = control_parameter_dictionary
	data_dictionary["parameter_name_mapping_array"] = parameter_name_mapping_array

	data_dictionary["background_copy_number_dictionary"] = background_copy_number_dictionary;
	data_dictionary["cell_volume"] = V;
	data_dictionary["av_number"] = av_number;
	data_dictionary["number_of_binding"] = 98;
	# =============================== DO NOT EDIT ABOVE THIS LINE ============================== #
	return data_dictionary
end
