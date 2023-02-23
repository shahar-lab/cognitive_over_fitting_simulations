#This code generate artificial data based on simulated parameters

rm(list=ls())
source('./functions/my_packages.R')
source('./functions/my_starter.R')

#--------------------------------------------------------------------------------------------------------

myrewardfunc=set_rewardfunc()
#load parameters
load(paste0(path$data,'/model_parameters.Rdata'))

#set sample size
Nsubjects =dim(model_parameters$artificial_individual_parameters)[1] 

#set task variables 
cfg = list(Nblocks         =4,
           Ntrials_perblock=50,
           Narms           =4,  #number of arms in the task 
           Noptions        =2,  #number of arms offered for selection each trial
           rndwlk          =if(myrewardfunc=='randomwalk'){read.csv('./functions/rndwlk.csv',header=F)}
                            else{
                            t(data.frame(a=rep(0.46,1000),b=rep(0.48,1000),c=rep(0.5,1000),d=rep(0.52,1000))) 
                            })

#run simulation
source(paste0(path$model,'.r'))

df=data.frame()
for (subject in 1:Nsubjects) {
  df=rbind(df, sim.block(subject=subject, parameters=model_parameters$artificial_individual_parameters[subject,],cfg=cfg))
}

#save
save(df,file=paste0(path$data,'/artificial_data.Rdata'))
