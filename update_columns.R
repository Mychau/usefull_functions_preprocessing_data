#delete all variables not in the list of variables of the development dataset
#Stop and error if variables are missing in the prediction set
#input: list_variables_dev, dataset for predictions
#Output: prediction dataset without non used columns



require(data.table)

Update_columns=function(list_variables_dev,predictions){
  if(!"data.table"%in%class(predictions)){
    predictions=data.table(predictions)
  }
  
  list_variables_names=names(list_variables_dev)[2:length(list_variables_dev)]
  predictions_names=colnames(predictions)
  #print(paste("predictions1",length(predictions_names)))
  miss_col=setdiff(list_variables_names,predictions_names)#
  if(length(miss_col)!=0){#dev has more columns than pred
    stop("Variables are missing in the prediction set",setdiff(list_variables_names,predictions_names),". Process stopped.")
    #for(variable in miss_col){
      #predictions$variable=NULL
    #}
  }
  #print(paste("predictions2",length(predictions)))
  drop_col=setdiff(predictions_names,list_variables_names)
  #print(drop_col)
  if(length(drop_col)!=0){
    warning("Variables:",drop_col,"not used in the model")
    predictions=predictions[,(drop_col):=NULL]
  }
 #return(list(predictions=predictions,miss=miss_col) ) uniquement dans cadre test
  return(predictions)
}