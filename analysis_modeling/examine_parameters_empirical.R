#This code plot recovered parameters against the true parameters

rm(list=ls())
source('./functions/my_packages.R')
source('./functions/my_starter.R')
mydatatype=set_datatype()


#--------------------------------------------------------------------------------------------------------

#load recovered parameters
fit=readRDS(paste0(path$data,'/modelfit_empirical.rds'))
fit=readRDS(paste0(path$data,'/modelfit_empirical_inbal.rds'))

#--------------------------------------------------------------------------------------------------------

#population level parameters
my_posteriorplot(x       = plogis(fit$draws(variables ='population_locations[1]',
                                            format='draws_matrix')),
                 myxlim  = c(0,1),
                 my_vline= 0, 
                 myxlab  = expression(alpha['card_location']),
                 mycolor = "pink")


my_posteriorplot(x       = plogis(fit$draws(variables ='population_locations[2]',
                                            format='draws_matrix')),
                 myxlim  = c(0,1),
                 my_vline= 0, 
                 myxlab  = expression(alpha['key_location']),
                 mycolor = "pink")

my_posteriorplot(x       = plogis(fit$draws(variables ='population_locations[3]',
                                            format='draws_matrix')),
                 myxlim  = c(0,1),
                 my_vline= 0, 
                 myxlab  = expression(alpha['card_key_location']),
                 mycolor = "pink")

my_posteriorplot(x       = fit$draws(variables ='population_locations[4]',
                                     format='draws_matrix'),
                 myxlim  = c(0,10),
                 my_vline= 0, 
                 myxlab  = expression(beta['card_location']),
                 mycolor = "pink")

my_posteriorplot(x       = fit$draws(variables ='population_locations[5]',
                                     format='draws_matrix'),
                 myxlim  = c(0,10),
                 my_vline= 0, 
                 myxlab  = expression(beta['key_location']),
                 mycolor = "pink")

my_posteriorplot(x       = fit$draws(variables ='population_locations[6]',
                                     format='draws_matrix'),
                 myxlim  = c(0,10),
                 my_vline= 0, 
                 myxlab  = expression(beta['card_key_location']),
                 mycolor = "pink")

#--------------------------------------------------------------------------------------------------------

# individual level parameters

alpha=apply(fit$draws(variables ='alpha',format='draws_matrix'), 2, mean)
omega=apply(fit$draws(variables ='omega' ,format='draws_matrix'), 2, mean)
beta=apply(fit$draws(variables ='beta' ,format='draws_matrix'), 2, mean)

corrplot(cor(data.frame(alpha,omega,beta)))
