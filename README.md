# Random Forest Ensemble for Predicting Sleep Cycle Stages with EEG Signals
[Code (Jupyter Notebook)](https://github.com/fkarimzadeh6/CX4240_project/blob/Nihad-Ljubuncic/RF_with_kfold.ipynb)
## Data Organization

Given 10 separate subjects, 1633 samples were recorded for each, giving a total of 16330 samples. However, given the nature of a sleep study, the data set was trimmed down to the last 834 samples since the first samples were populated with a single label (wake). Labels for each stage in the sleep cycle are given as 0, 1, 2, 3, and 5 for the stages awake, N1, N3, N4, and REM, respectively.


## Tuning

The RandomForestClassifier function is provided with Scikit Learn, and has many different potential parameters. In order to reach the highest result possible the Random Forest was run with different paramenters specified. Use of the out-of-bag (OOB_score) parameter proved to be very useful, since it helps fit and validate the data while being trained. 40 decision trees proved to be most efficient, since not much extra accuracy was gained from increasing the number of trees further, only runtime. The micro precision score of the Random Forest on this dataset came to be 79% and the macro precision score came to be 72%. 



## Single Random Forest

Random Forest Ensemble works by creating n number of decision trees and splitting the data either based off of Gini impurity or information gain between splits. For the results shown information gain is used to calculate the splits. Initially a single Random Forest was implemented on the data set with 40 separate trees; this yielded good results while keeping runtime low.  Because we had ten different subjects, one was saved for testing while the others were used for training. This meant that our data was split 90% for training, and 10% for testing. As a result, around 80% accuracy was achieved by using Random Forest. The results from the Random Forest also reflect the average person's sleep cycle, where the majority of samples the subject is in the N2 stage of sleep. 

### Confusion Matrix
Below is the confusion matrix for one run of the Random Forest:
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nihad-Ljubuncic/heatmap_copy.png)
### Precision and Recall Values
Below is a detailed look at the precision and recall for the same run of the Random Forest:
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nihad-Ljubuncic/class_report.png)
## Random Forest with Cross-Validation

In order to achieve a more accurate result, K fold cross-validation was also implemented for the data set. Cross validation is typically used to combat overfitting. Because the data was already split into 10 individual subjects, 10 folds were used in congruence with Random Forest Ensemble. This means that the same Random Forest algorithm as before was run, however each subject's data set acted as the test data for one iteration. On average between each fold, results were still around 80% accuracy. 
### 10-Fold Cross Validation Results
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nihad-Ljubuncic/kfoldtable.png)
