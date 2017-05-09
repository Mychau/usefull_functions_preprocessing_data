#apply the class of the variable in the development set to the same variable in the prediction set
#inputs: list_variables_dev, prediction set
#oupt: prediction set with the class changed

require(data.table)
change_class_df=function(list_variables_dev,pred){
  if(!"data.table"%in%class(pred)){#convertir set de pred en data.table si ne l'est pas déjà
    pred=data.table(pred)
  }
  #list_variables_pred=creer_list_variables(pred)
  vardev=names(list_variables_dev)[2:length(list_variables_dev)]
  for(i in 1:length(vardev)){
    attr=list_variables_dev[[i+1]]
    #print(attr[[1]]=="factor")
    if(attr[[1]]=="factor"){
    pred[[i]]=as.factor(pred[[i]])}
    else if(attr[[1]]=="logical"){
    pred[[i]]=as.logical(pred[[i]])  
    }
    else if(attr[[1]]=="integer"){
      pred[[i]]=as.integer(pred[[i]])
    }
    else if(attr[[1]]=="numeric"){
      pred[[i]]=as.numeric(pred[[i]])
    }
    else if(attr[[1]]=="character"){
      pred[[i]]=as.character(pred[[i]])
    }
  }
return(pred)
}