# Random Forest Ensemble for Predicting Sleep Cycle Stages with EEG Signals
[Code (Jupyter Notebook)](https://github.com/fkarimzadeh6/CX4240_project/blob/Nihad-Ljubuncic/RandomForest.ipynb)
## Data Organization

Given 10 separate subjects, 1633 samples were recorded for each, giving a total of 16330 samples. However, given the nature of a sleep study, the data set was trimmed down to the last 834 samples since the first samples were populated with a single label (wake). Labels for each stage in the sleep cycle are given as 0, 1, 2, 3, and 5 for the stages N1, N2, N3, N4, and REM, respectively.

## Single Random Forest

Initially a single Random Forest was implemented on the data set. Because we had ten different subjects, one was saved for testing while the others were used for training. 


![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nihad-Ljubuncic/heatmap.png)
## Random Forest with Cross-Validation

In order to achieve a more accurate result, K fold cross-validation was also implemented for the data set. Because the data was already split into 10 individual subjects, 10 folds were used in congruence with Random Forest Ensemble. The 10 fold method allowed for each subject to act as a testing set, with results 

## Tuning


## Results

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/fkarimzadeh6/CX4240_project/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
