#aim: Hierarchical fit Stan 
rm(list=ls())
source('./functions/my_packages.R')
#load model
current_model=source('./functions/my_starter.R')

mydatatype=set_datatype()

#--------------------------------------------------------------------------------------------------------

# load data
#current_model_data="./data/model_one_prediction_error_with_lambda"
if (mydatatype=='empirical') {print('using empirical data')
  load('./data/empirical_data/empirical_standata.Rdata')
  #load('./data/empirical_data/inbal_empirical_standata.Rdata')
  }
if (mydatatype=='artificial'){print('using artificial data')
  load(paste0(current_model$value$data,'/artificial_standata.Rdata'))}

# Enabling parallel processing via future
options(mc.cores = parallel::detectCores())
plan(multisession)

mymodeltype=set_modeltype()
if (mymodeltype=='parameter_estimation') {
  print('estimating parameters')
  load(paste0(path$data,'/modelfit_compile.rdata'))
  fit<- my_compiledmodel$sample(
    data = data_for_stan, 
    iter_sampling = 50,
    iter_warmup = 1000,
    chains           = 20,
    parallel_chains  = 20)  
  
  #save
  if (mydatatype=='empirical'){fit$save_object(paste0(path$data,'/modelfit_empirical.rds'))}
  if (mydatatype=='artificial'){fit$save_object(paste0(path$data,'/modelfit_recovery.rds'))}
}
if (mymodeltype=='model_comparison') {
  print('comparing models')
  load(paste0(path$data,'/modelfit_loo_compile.rdata'))
  like=
    lapply(1:max(data_for_stan$Nblocks), function(mytestfold) {
      print(Sys.time())
      print(mytestfold)
      data_for_stan$testfold=mytestfold
      fit= my_compiledmodel$sample(
        data = data_for_stan, 
        iter_warmup = 1000,
        iter_sampling = 1000,
        chains           = 4,
        parallel_chains  = 4)
      fit$draws(variables ='log_lik',format='draws_matrix')
    })
  
  #aggregate across all four blocks
  like=Reduce("+",like) 
  
  # save mean predicted probability per trial (across samples)
  # note2self - I counted that the number of missing data was exactly what line 39 took out as NA so this does not cause any problems
  like   =t(sapply(1:dim(like)[1], function(i){x=c(t(like[i,]))
  x[x==0]<-NA
  x=na.omit(x)}))
  
  save(like, file=paste0(path$data,'/modelfit_like_per_trial.rdata'))
}

