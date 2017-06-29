include("Include.jl")
using PyPlot
using PyCall

# load cost values

#ensemble_costs = readdlm("../../Documents/HL60_STATES/best_ensemble_v2/error_archive.dat")
#(number_of_obj,number_of_samples) = size(ensemble_costs)
#random_costs = readdlm("../../Documents/HL60_STATES/random_ensemble_v1/objective_archive.dat")
#sobol_costs = readdlm("../../Documents/HL60_STATES/sobol_random_ensemble_v1/objective_archive.dat")
ensemble_costs = readdlm("./best_ensemble/error_archive.dat")
(number_of_obj,number_of_samples) = size(ensemble_costs)
random_costs = readdlm("./random_ensemble/objective_array.dat")
sobol_costs = readdlm("./sobol_ensemble/objective_archive.dat")
combined_cost = [ensemble_costs; random_costs; sobol_costs];
y = log(combined_cost);
fig,ax = plt[:subplots](figsize=(20,10))
for index = [1:number_of_obj*3;]
  x = index*ones(number_of_samples)
  xindex = index
  density = 0.2 # for shading on plot
  # set colors for training and random parameters
  xcolor = "powderblue"
  mean_color = "blue"
  if index > 36
    xcolor = "mistyrose"
    mean_color = "red"
    x = index*ones(number_of_samples)+5
    xindex = index + 5
    density = 0.7
  end
  if index > 72
    xcolor = "lavender"
    mean_color = "darkorchid"
    x = index*ones(number_of_samples)+10
    xindex = index + 10
    density = 0.7
  end
  plot(x,y[index,:],"o",alpha=density,color=xcolor,markeredgewidth = 0,markersize=10)
  ymean = mean(y[index,:])
  ystd = std(y[index,:])
  #plot(index,ymean,".",color = mean_color,alpha = 1, markersize = 7)
  errorbar(xindex,ymean, yerr = ystd,fmt = ".", color = mean_color,alpha = 1,markersize = 7)
end
mean_ensemble = mean(log(ensemble_costs))
mean_random = mean(log(random_costs[!isnan(random_costs)]))
mean_sobol = mean(log(sobol_costs[!isnan(sobol_costs)]))
plot([1:36;],ones(36)*mean_ensemble,color="blue",linewidth=2)
plot([42:(42+35);],ones(36)*mean_random,color="red",linewidth=2)
plot([83:(83+35);],ones(36)*mean_sobol,color="purple",linewidth=2)


plt[:xlim]([0,number_of_obj*3+11])
ylabel("Log of Cost Functions")
xlabel("Measured Species")
#x = vec(["Training Ensemble", "Random Ensemble", "Sobol Ensemble"])
x = vec([" ", " ", " "])
ax[:set_xticks](sort([17,59,101]))
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
ax[:set_xticklabels](x,rotation=0)
