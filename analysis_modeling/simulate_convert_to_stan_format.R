#This code generate artificial data based on simulated parameters

rm(list=ls())
source('./functions/my_packages.R')
source('./functions/my_starter.R')


###convert to a standata format ###----------------------------------------------------------------------------------

#load data
mydatatype=set_datatype()
if (mydatatype=='empirical') {print('using empirical data')
  # DUAL-TASK
  #the ch_key is encoded 0 for right and 1 for left, so I change it here to be the same as in the model.
  load('./data/empirical_data/empirical_data.Rdata')
  df=as.data.frame.data.frame(cards)
  df=df%>%mutate(ch_key=if_else(ch_key==0,1,0),first_trial_in_block=(block!=lag(block,default=1))*1,selected_offer=ch_key,fold=block,ch_key=ch_key+1,ch_card=ch_card+1,card_left=card_left+1,card_right=card_right+1)
  colnames(df)[1]="subject"
  ##Win-loss
  #load('./data/empirical_data/inbal_empirical_data.Rdata')
  #df=as.data.frame.data.frame(df)
  #df=df%>%rename("block"="blk","trial"="trl")%>%mutate(first_trial_in_block=(block!=lag(block,default=1))*1,ch_key=ifelse(choice==offer1,1,2),selected_offer=ch_key-1,fold=block,ch_card=choice+1,card_left=offer1+1,card_right=offer2+1)

  }
if (mydatatype=='artificial'){print('using artificial data')
  load(paste0(path$data,'/artificial_data.Rdata'))
}
df=df%>%mutate(first_trial_in_block=(block!=lag(block,default=1))*1)
df$first_trial_in_block[1]=1
#convert

data_for_stan<-make_mystandata(data=df, 
                               subject_column     =df$subject,
                               block_column       =df$block,
                               var_toinclude      =c(
                                 'first_trial_in_block', 
                                 'trial',
                                 'card_left',
                                 'card_right',
                                 'reward',
                                 'ch_key',
                                 'ch_card',
                                 'selected_offer'),
                               additional_arguments=list(Narms=4, Nraffle=2))

#save
if (mydatatype=='empirical') {print('using empirical data')
  save(data_for_stan,file='./data/empirical_data/empirical_standata.Rdata')
  #save(data_for_stan,file='./data/empirical_data/inbal_empirical_standata.Rdata')
  }
if (mydatatype=='artificial'){print('using artificial data')
  save(data_for_stan,file=paste0(path$data,'/artificial_standata.Rdata'))}


