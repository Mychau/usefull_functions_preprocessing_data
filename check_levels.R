#####check_levels------------------------------------------------------
#This function allows to check if two datasets have the same levels for their categorical variables. 
#In order to make it run, you need to run the function"list_variables" on the development and predictions datasets.

check_levels=function(list_dev,list_pred){

  if(length(setdiff(names(list_dev),names(list_pred)))!=0){
    stop(paste("Pb: the prediction set have more variables than the devlopment set",setdiff(names(list_dev),names(list_pred))))
  }
  var_level=c()
  list_var=c()
  
  for(i in 2:length(list_dev)){
    levels=c()
    variable=names(list_dev)[i]
    #print(variable)
    
    v=match(variable, names(list_dev))
    #print(v)
    w=match(variable, names(list_pred))
    #print(w)
    attr_dev=list_dev[[v]]
    #print(attr_dev)
    attr_prod=list_pred[[w]]
    #print(attr_prod)
    #print(attr_dev)
    
    if(length(attr_dev$Levels)!=0){#If variable is a factor
      #print("TRUE1")
      if(length(attr_dev$Levels)>length(attr_prod$Levels)){#if dev has more levels than pred
        #print("TRUE2")
        levels=attr_dev$Levels[(!attr_dev$Levels %in% attr_prod$Levels)]
        #print(levels)
        list_var=c(list_var,variable)
        temp=list(Levels=levels,nb=length(levels),Plus=0)
        all=list(variable=temp)
        var_level=c(var_level,all)
      }
      else if(length(attr_prod$Levels)>length(attr_dev$Levels)){#if pred has more levels than dev
        levels=attr_prod$Levels[(!attr_prod$Levels %in% attr_dev$Levels)]
        list_var=c(list_var,variable)
        temp=list(Levels=levels,nb=length(levels),Plus=1)
        all=list(variable=temp)
        var_level=c(var_level,all)
      }
      else{
        #print(TRUE)
        levels=attr_dev$Levels[(!attr_dev$Levels %in% attr_prod$Levels)]
        #print(levels)
        if(length(levels)!=0){
          list_var=c(list_var,variable)
          temp=list(Levels=levels,nb=length(levels),Plus=1)
          all=list(variable=temp)
          var_level=c(var_level,all)
          levels=attr_prod$Levels[(!attr_prod$Levels %in% attr_dev$Levels)]
          list_var=c(list_var,variable)
          temp=list(Levels=levels,nb=length(levels),Plus=0)
          all=list(variable=temp)
          var_level=c(var_level,all)}
      }
      
    }
    names(var_level)=list_var
  }
  return(var_level)
}