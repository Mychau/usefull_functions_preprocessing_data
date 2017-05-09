#still testing it

#Inputs: Matrix or sparse matrix


#Renvoie un objet list_variables:

#list_variables$class    (class of the input)
#$variable1
#$Class
#$Levels  (NULL if not factor, liste of levels if factor)
#$variable2
#$Class
#$Levels  (NULL if not factor, liste of levels if factor)

require(Matrix)


list_variables_matrix=function(base){
  require(Matrix)
  if(class(base)=="dgCMatrix"){
    pattern=attr(base,"assign")
    variables=c()
    class=c()
    #namefac=NA
    racines=c()
    list_variables=c()
    names_col=c()
    list_variables=c(class(base))
    #print(list_variables)
    for(i in 1:(length(pattern)-1)){
      if(length(grep(pattern[i],pattern))==1){
        variables=c(variables,colnames(base)[i])#find all not factor variables
        names_col=c(names_col,colnames(base)[i])
        temp=list(Class="numeric",Levels=NULL)#ne pas rajouter si racine déjà dedans
        all=list(variable=temp)
        list_variables=c(list_variables,all)}
      
      else{#Obtenir la racine de la variable
        pos=grep(pattern[i],pattern)
        #print(pos)
        allnames=colnames(base)[pos]
        all_val=c()
        list_char=c()
        
        for(value in allnames){
          list_char=c(list_char,strsplit(value,""))
        }
        size=c()
        for(value in list_char){
          y=length(unlist(value))
          size=c(size,y)
        }
        stops=c()
        for(i in 1:(length(list_char)-1)){
          for(j in 1:min(size)){
            if(unlist(list_char[i])[j]!=unlist(list_char[i+1])[j]){
              stops=c(stops,j-1)
              break
            }
          }
        }
        racine=paste(unlist(list_char[1])[1:min(stops)],sep="",collapse="")
        if(!racine %in% racines){
          racines=c(racines,racine)
          names_col=c(names_col,racine)
          Levels=c()
          for(value in list_char){
            niv=paste(unlist(value)[(min(stops)+1):length(value)],sep="",collapse="")
            Levels=c(Levels,niv)
          }
          temp=list(Class="factor",Levels=Levels)#ne pas rajouter si racine déjà dedans
          all=list(variable=temp)
          list_variables=c(list_variables,all)
          #all_match=c(all_match,temp)}
        }
      }
    }
    names(list_variables)<-c("class",names_col)
  }
  
  if(is.matrix(base)){
    variables=c()
    class=c()
    #namefac=NA
    racines=c()
    list_variables=c()
    names_col=c()
    list_variables=c(class(base))
    for(i in 1:ncol(base)){
      names_col=c(names_col,colnames(base)[i])
      if(length(unique(base[,i]))<20){
        Levels=unique(base[,i])
        temp=list(Class="factor",Levels=Levels)}
      else{
        temp=list(Class="numeric",Levels=NULL)
      }
      all=list(variable=temp)
      list_variables=c(list_variables,all)
    }
    #print(names_col)
    names(list_variables)<-c("class",names_col)
  }
  setClass("list_variables",slots=c("list"))
  #class(list_variables)="list_variables"
  return(list_variables)
}