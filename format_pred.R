#Still working on it for matrix, don't use for matrix! Ok for df and datable
#####format_pred----------------------------------------------------------
require(data.table)
require(Matrix)

format_pred=function(list_variables_dev,pred){
  if("matrix"%in%list_variables_dev$class|"dgCMatrix"%in%list_variables_dev$class){
    #warning:implementation à consolider
    pred=update_levels_mat(list_variables_dev,pred)
  }
  else if("data.frame"%in%list_variables_dev$class|"data.table"%in%list_variables_dev$class){
    pred=update_columns(list_variables_dev,pred)
    pred=appliquer_class_df(list_variables_dev,pred)
    pred=update_levels_df(list_variables_dev,pred)
  }
  return(pred)
}