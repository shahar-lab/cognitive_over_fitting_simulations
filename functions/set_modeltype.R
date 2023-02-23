#Aim:
#this code generates from a gui select list for the data that is going to be used for sampling

set_modeltype<-function(){
  
  mymodeltype   =dlg_list(list('parameter_estimation','model_comparison'), multiple = TRUE)$res
  
  return(mymodeltype)
}

