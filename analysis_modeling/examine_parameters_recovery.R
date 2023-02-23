#This code plot recovered parameters against the true parameters

rm(list=ls())
source('./functions/my_packages.R')
source('./functions/my_starter.R')
mydatatype=set_datatype()


#--------------------------------------------------------------------------------------------------------

#load recovered parameters
fit=readRDS(paste0(path$data,'/modelfit_recovery.rds'))

#load artificial parameters
load(paste0(path$data,'/model_parameters.Rdata'))


#--------------------------------------------------------------------------------------------------------

#population level parameters
my_posteriorplot(x       = plogis(fit$draws(variables ='population_locations[1]',
                                               format='draws_matrix')),
                     myxlim  = c(0,1),
                     my_vline= model_parameters$artificial_population_location[1], 
                     myxlab  = expression(alpha['location']),
                     mycolor = "pink")



my_posteriorplot(x       = plogis(fit$draws(variables ='population_locations[2]',
                                        format='draws_matrix')),
                     myxlim  = c(0,1),
                     my_vline= model_parameters$artificial_population_location[2], 
                     myxlab  = expression(omega['location']),
                     mycolor = "pink")

my_posteriorplot(x       = plogis(fit$draws(variables ='population_locations[3]',
                                            format='draws_matrix')),
                 myxlim  = c(0,1),
                 my_vline= model_parameters$artificial_population_location[3], 
                 myxlab  = expression(omega['location']),
                 mycolor = "pink")

my_posteriorplot(x       = fit$draws(variables ='population_locations[4]',
                                     format='draws_matrix'),
                 myxlim  = c(0,10),
                 my_vline= model_parameters$artificial_population_location[4], 
                 myxlab  = expression(omega['location']),
                 mycolor = "pink")

my_posteriorplot(x       = fit$draws(variables ='population_locations[5]',
                                     format='draws_matrix'),
                 myxlim  = c(0,10),
                 my_vline= model_parameters$artificial_population_location[5], 
                 myxlab  = expression(omega['location']),
                 mycolor = "pink")

my_posteriorplot(x       = fit$draws(variables ='population_locations[6]',
                                     format='draws_matrix'),
                 myxlim  = c(0,10),
                 my_vline= model_parameters$artificial_population_location[6], 
                 myxlab  = expression(omega['location']),
                 mycolor = "pink")

#--------------------------------------------------------------------------------------------------------

# individual level parameters

my_xyplot(model_parameters$artificial_individual_parameters[,'alpha_color'],apply(fit$draws(variables ='alpha_color',format='draws_matrix'), 2, mean),'true','recovered','navy')
my_xyplot(model_parameters$artificial_individual_parameters[,'alpha_key'], apply(fit$draws(variables ='alpha_key' ,format='draws_matrix'), 2, mean),'true','recovered','navy')
my_xyplot(model_parameters$artificial_individual_parameters[,'alpha_shape'], apply(fit$draws(variables ='alpha_shape' ,format='draws_matrix'), 2, mean),'true','recovered','navy')
my_xyplot(model_parameters$artificial_individual_parameters[,'beta_color'], apply(fit$draws(variables ='beta_color' ,format='draws_matrix'), 2, mean),'true','recovered','navy')
my_xyplot(model_parameters$artificial_individual_parameters[,'beta_key'], apply(fit$draws(variables ='beta_key' ,format='draws_matrix'), 2, mean),'true','recovered','navy')
my_xyplot(model_parameters$artificial_individual_parameters[,'beta_shape'], apply(fit$draws(variables ='beta_shape' ,format='draws_matrix'), 2, mean),'true','recovered','navy')

