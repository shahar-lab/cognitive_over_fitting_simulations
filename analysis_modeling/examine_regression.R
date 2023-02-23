# Aim: Run some basic sanity checks using linear / logistic regression
rm(list=ls())
source('./functions/my_packages.R')
source('./functions/my_starter.R')

#--------------------------------------------------------------------------------------------------------


load(paste0(path$data,'/artificial_data.Rdata'))


df=df%>%mutate(stay_key               =(ch_key==lag(ch_key)),
               reward_oneback         =lag(reward))

model= glmer(stay_key ~ reward_oneback+(reward_oneback| subject), 
             data = df,
             family = binomial,
             control = glmerControl(optimizer = "bobyqa"), nAGQ = 0)

plot(effects::effect("reward_oneback",model))
