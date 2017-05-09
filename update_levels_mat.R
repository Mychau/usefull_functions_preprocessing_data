#NOT COMPLETLY WORKING,STILL WORKING ON IT!

#####update_levels_mat----------------------------------------------------------------
require(data.table)
require(Matrix)
update_levels_mat=function(list_variables_dev,pred){
  list_variables_pred=creer_list_variables(pred)
  #print(list_variables_pred)
  checklev=check_levels(list_variables_dev,list_variables_pred)
  new_cols=c()
  if(list_variables_pred$class=="dgCMatrix"){
    mat_pred=matrix(nrow=nrow(pred),ncol=ncol(pred),data=pred)
    colnames(mat_pred)=colnames(pred)
  }
  else{
    mat_pred=pred
  }
  
  for(i in 1:length(checklev)){
    variable=names(checklev)[i]
    attr_checklev=checklev[[i]]
    
    if(attr_checklev$Plus==0){#dev has more levels than pred
      stop(paste("Error vraiable ",variable," has levels unknown in the dev dataset: ",attr_checklev$Levels))}
    
    if(attr_checklev$Plus==1){#pred has more levels than dev
      coln=c()
      cols=matrix(nrow=nrow(pred),ncol=attr_checklev$nb,data=0)
      new_cols=c(new_cols,list(variable=variable,New_levels=attr_checklev$Levels))
      for(i in attr_checklev$Levels){
        coln=c(coln,paste(variable,i,sep="",collapse=""))
      }
      colnames(cols)=coln
      #print(cols)}
      mat_pred=cbind(mat_pred,cols)
    }
  }
  
  if(list_variables_pred$class=="dgCMatrix"){
    mat_pred=Matrix(mat_pred,sparse=TRUE)
  }
  return(mat_pred)
}