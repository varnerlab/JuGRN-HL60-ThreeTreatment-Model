# include -
include("Include.jl")

# How many parameters?
number_of_parameters = 167;
starting_set = 1;
number_of_initial_sets = 1;
number_of_final_sets = 152;
number_of_samples = 152;
number_of_objectives = 36;

# Simple script to generate ensemble by sampling -

# Establish bounds -
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
];

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
0	; # 163	"W_gene_Trigger_D3_RNAP"
0	; # 164	"W_gene_Trigger_RA_RNAP"
0	; # 165	"W_gene_cRAF_RNAP"
100	; # 166	"W_gene_repressor14_RNAP"
100	; # 167	"W_gene_repressor14_gene_Trigger_RA"
];
bounds_array = [lower_bound_array upper_bound_array]

# Generate an ensemble of parameter sets -
ensemble_array = zeros(number_of_parameters,number_of_final_sets);
objective_array = zeros(number_of_objectives,number_of_final_sets)
sobol_sequence = SobolSeq(number_of_parameters,bounds_array[:,1],bounds_array[:,2]);
for parameter_set_index = 1:number_of_final_sets

  # sample the parameter array -
  parameter_array = next(sobol_sequence)

  for parameter_index = 1:number_of_parameters
    ensemble_array[parameter_index,parameter_set_index] = parameter_array[parameter_index];
  end
end

# Solve the model to calculate the error -
error_array = zeros(number_of_final_sets);
for parameter_set_index = 1:number_of_final_sets

  # sample the ensemble_array -
  parameter_array = ensemble_array[:,parameter_set_index]

  # error -
  error_value = objective_function(parameter_array);
  objective_array[:,parameter_set_index] = error_value
  error_array[parameter_set_index] = sum(error_value);

  @show (parameter_set_index,error_value)
end


# Last ... run the model w/these sets, save the data -
ensemble_index_array = [1:number_of_final_sets;]
for (local_index,parameter_set_index) in enumerate(ensemble_index_array)

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
  #obj_array = objective_function(parameter_array)
  #objective_archive[:,parameter_set_index] = obj_array

  # dump data to disk -
  local_data_RA = [T X_RA];
  local_data_D3 = [T X_D3];
  local_data_RA_D3 = [T X_RA_D3];
  #data_filename = "./best_ensemble/sim_data_PSI_"*string(parameter_set_index)*".dat"
  data_filename = "../../Documents/HL60_STATES/sobol_random_ensemble_v1/RA/sim_data_PSI_"*string(parameter_set_index)*"_RA.dat"
  writedlm(data_filename,local_data_RA);
  data_filename = "../../Documents/HL60_STATES/sobol_random_ensemble_v1/D3/sim_data_PSI_"*string(parameter_set_index)*"_D3.dat"
  writedlm(data_filename,local_data_D3);
  data_filename = "../../Documents/HL60_STATES/sobol_random_ensemble_v1/RA_D3/sim_data_PSI_"*string(parameter_set_index)*"_RA_D3.dat"
  writedlm(data_filename,local_data_RA_D3);
end

# Write the simple ensemble -
filename = "../../Documents/HL60_STATES/sobol_random_ensemble_v1/simple_ensemble_parameter_sets.dat"
writedlm(filename,ensemble_array);

# Write the simple ensemble -
filename = "../../Documents/HL60_STATES/sobol_random_ensemble_v1/objective_archive.dat"
writedlm(filename,objective_array);
