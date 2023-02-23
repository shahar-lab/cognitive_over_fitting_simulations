#Aim:
#this code generates from a gui select list for the data that is going to be used for sampling

set_rewardfunc<-function(){
  
  myrewardfunc   =dlg_list(list('stable','randomwalk'), multiple = TRUE)$res
  
  return(myrewardfunc)
}

