# usefull_functions_preprocessing_data
For my internship, I have to work with datasets for predictions which are not in the same format than the datasets used to train the model. 
Here some functions (some are still in development or test) useful to format your prediction dataset (by example, if you have to create a sparse matrix to run a xgboost).

## Main functions:
### list_variables: create a list of list

list_variables$class    (class of the set)
list_variables$Name_of_the_variable1
list_variables$Name_of_the_variable1$Class (class of variable 1)
list_variables$Name_of_the_variable1$Levels  (NULL not a factor, list of levels of factor)
list_variables$Name_of_the_variable2
list_variables$Name_of_the_variable2$Class
list_variables$Name_of_the_variable2$Levels
etc...

I am still working on it to create methods to help to manipulate it.

### format_pred: apply the format of the development set to the prediction set
Use several other functions (drop_columns,check_levels,change_class,update_levels) which are in the repository. Still testing, but works for dataframes and datables inputs. Still working on it for matrix. Inputs: list_variables_dev,prediction dataset. Return the prediction set in the same format than the devlopment set. Provide error if some columns are missing on the predictions set, and if the prediction set has, for categorical variables, some levels unknown in the development set (to avoid future problems when we apply the model).


## To be done: 
continue to test the functions, finish it for matrix. Provide a documentation for the pipe to use in order to automate the process (including the preprocessing done on the development set before the creation of the model: future engineering, NA replacement etc...). Further documentation to be provide.
Improve the object list_variables (easy call to the name of variables, easy display of class etc...).
