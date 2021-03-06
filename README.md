
# Automatic Annotation of EEG signals for different stages of a sleep cycle using Machine Learning
## Foroozan Karimzadeh, Nael Mizanur Rahman, Nihad Ljubuncic


# Problem Definition and Motivation:
During  the  past  decades,  a  great  amount  of research   has   been   devoted   to   automatic   sleep   stage scoring using the electroencephalogram (EEG) signal. Automatic and accurate classification of sleep stages from EEG signals are critical due to the following reasons:
  - First, the fact that these information will be used for dioagnosing different sleep disorders such as sleep apnea, parasomnia, narcolepsy etc..  
  - Second, manual sleep scoring is a time-consuming process for an expert which is prone to human error. 
  - Finally, smart EEG machines reduce depandance on expert perosnnel, who may not be readily avaibale at all times. 
  
  However, the results are not yet satisfactory to be used as a standard procedure  in  clinical  studies. In  this  project, we have investigated different machine learning algorithms to automatically classify sleep stages and compared the results.
  
  According to the AASM manual, sleep EEG consists of 5 stages. Each of the five stages is defined below and also illustrated in Fig. 1: ![Image](https://github.com/fkarimzadeh6/CX4240_project/blob/master/Figure/Stage.jpg) *Fig.1. This figure illustrates Wake, N1, N2, N3, REM stages, from top to bottom panels, respectively.*


**-W:** Awake state (stage W) is characterized by alpha or faster frequency bands occupying more than 50% of the epoch, frequent eye movements and high EMG tone.

**-N1:** Stage N1 is scored when alpha occupies more than 50% of epoch while theta activity, slow rolling eye movements and vertex waves are evident.

**-N2:** Stage N2 is scored when sleep spindles or K-complexes (less than 3 min apart) are noted.

**-N3:** Stage N3 is characterized by delta activity detected in over 20% of the epoch length.

**-REM:** Upon sleep scoring an epoch is marked as REM when saw-tooth waves along with rapid eye movements as well as lowest EMG signals are observed through each epoch.

  
# Sleep Stage Classification   
  The overal process for sleep stage scoring consists of three steps which are explained below: 
  1. Preprocessing
  2. Feature Extraction
  3. Classification 
  
  ![Image](https://github.com/fkarimzadeh6/CX4240_project/blob/master/Figure/sleepstageprocess.png)
  
## Raw Dataset:
  
  The publicly available sleep datasets provided by [PhysioBank](http://physionet.org/physiobank/database/sleep-edfx/) has been employed in this study to assess the proposed methods. The utilized set in the SleepEDF Database contains ten healthy subjects without any sleep-related medication. The PSGs include EEG, EOG and EMG signals of healthy young subjects within the age range of 21-35. The EEG signal has been sampled at 100 Hz, divided into 30 s epochs and manually annotated. The annotations consist of sleep stages including W, R, N1, N2, N3. For this study, the single-channel Pz-Oz is used according to former studies [1], as it has been suggested that deeper sleep stages are better detected (visually) in this channel. The overal percentages of each stage in our dataset is illustrated in a pie chart in the section: Dataset After Feature Extraction.

## Preprocessing:

  To enhance the EEG signal quality, a preprocessing step is required. Given a raw input EEG signal, a band-pass filter (Butterworth of order eight) with pass-band bandwidth of 0.5–40 Hz is applied. Noise in the EEG signal caused due to movement are also removed by using a filter of this range, as this noise usually occurs at a much higher frequency.
  
## Feature Extraction: 

  Contineous wavelet transform (CWT) is used to represent EEG signals into the time-frequency [2]. We employed mother wavelets of Daubechies (db20) with center frequency of 0.67. After passing the EEGs through wavelet's filters, entropy of each filtered signal is determined according to Eq.1 for each of the frequency bands including 
  - delta (0-4 Hz), 
  - theta (4-8 Hz), 
  - alpha (8-12 Hz), 
  - beta1(13-22 Hz), 
  - beta2 (022-30 Hz),  
  - sleep spindle(12-14 Hz), 
  - K-complex (0.5-1.5 Hz); 
  
  Therefore, 7 frequency bands are totally considered. 
  
  ![Image](https://github.com/fkarimzadeh6/CX4240_project/blob/master/Figure/entropy.JPG)
	
where _p_ is the histogram distribution of wavelet coefficients in each band with _n_ bins.
	
These entropy values are arranged in a feature vector for each epoch. Therefore, by calculating the entropy in seven frequency bands for CWT, a feature vector consisting of 7 elements for each epoch is formed. This is repeated for all epochs in the entire EEG signal. The sleep stage classification process is then continued by feeding these features into different classifiers, discussed subsequently.

[code](https://github.com/fkarimzadeh6/CX4240_project/tree/master/code)

# Supervised Learning after Feature Extraction
[ipython notebook code and data](https://github.com/fkarimzadeh6/CX4240_project/tree/Nael)
## Dataset After Feature Extraction
The original dataset after pre-processing and feature extraction of the signals consists of 16330 samples, 1633 each from 10 different subjects. Each sample refers to a single epoch, as explained above, and is accompanied by a label (N1, N2, N3, N4 and REM) denoted by 0,1,2,3,4 respectively. The dataset is trimmed to eliminate the first 700 samples from each subject (1633 samples per subject) which consists entirely of a single label (0). This would have biased the dataset heavily towards a single label. The trimmed dataset now consists of ((1633-700)*10=)9330 samples each with 7 features. The following charts shows the distribution of various labels within the dataset. The dataset contains the most of the N2 stage as is expected in a standard sleeping pattern of a subject:

![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/pie.png)

## Perceptron Algorithm 
The Perceptron learning algorithm is a linear classifer that assigns weights to features of a sample to generate a hyperplane. The plane  is then updated based on any wrong classifications. This continues until the weights converge to an optimum solution (the average loss changes by less than a tolerance between successive iterations). The perceptron algorithm is guaranteed to converge, provided the dataset is linearly separable[3]. 

<p align="center">
  <img width="500" height="320" src="https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/Capture.PNG">
</p>

Considering this fact, the convergance of the algorithm is a fair metric to verify the linearity of the dataset. Should the algorithm converge when applied to the given samples, the dataset can be assumed to be linearly separable. The perceptron algorithm, however, failed to converge on the EEG dataset even after 50000 iterations. 
<p align="center">
  <img width="460" height="300" src="https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/perceptronloss.png">
</p>
The difference in the average loss even after 50000 iterations showed variations greater than the tolerance of (1e-3) and therefore failed to provide an final stable weight matrix. 
There was, thus, no sufficiently viable linear hyperplane that could efficently separate the different classes. 

## Support Vector Machine
Support Vector machines have been used to classify EEG signals in several previous research works[4]. Lajnef *et al* have so far demonstrated one of the best result on EEG classifcation. Their endevor focused on the the use of a dendogram based multi class SVM that achieved an overall accuracy of 92%. Our work focuses on the classical one-vs-one multiclass classification using SVM, employing  non-linear kernels. As mentioned before, the dataset does not appear to be linearly separable and therefore requires non-linear kernels for SVM. For our current study, we resorted to the Radiul Basis Function kernel and optimized the hyperparameters associated with it.

### Cross Validation and Hyperparamters
For this work, we chose to optimize two hyper parameters: gamma (for 'curvature' of the kernel) and C (penalty parameter for the error function). The optimization of parameters was done using a 5-fold cross validation on the training dataset. The training dataset consisted of 90% of the original dataset, while the remaining 10% was left for testing. The scoring metric upon which the cross-validation was judged was the average accuracy of prediction. It is important to note that both the training and testing feature matrices were scaled across each feature before being fed into the SVM.
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/svmflowchart.PNG)

### Hyperparameter, C
The parameter 'C' is the penalty parameter for error in an SVM and determines the degree of softness of an SVM. A lower value of C allows some support vectors to be placed on the wrong side of the margin, therby creating a trade-off between error in training for more robustness and stability in the model overall. A high value of C hardens the SVM, allowing little missclassification. For a more detailed explanation [click here](https://chrisalbon.com/machine_learning/support_vector_machines/svc_parameters_using_rbf_kernel/). 
The variation in accuracy with changes in C is shown. The graph shows a maxima for C at around 0.8, showing the SVM to be somwhat soft in nature. Hardening the SVM with high C values shows drastic decline in accuracy, as is expected due to a hit on the robustness of the model as a whole. 
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/C.png)

### Hyperparameter, gamma:
The gamma parameter determines the spread of the RBF kernel. It can be thought of as the inverse of the radius of influence of the samples that are considered to be support vectors by the kernel. A small value of gamma forces the kernel to adopt a somewhat linear shape, redcuing its curvature. A high vlaue of gamma makes the kernel a bit more non-linear, often allowing islands of decision boundaries to be generated. For detailed explanation [click here](https://chrisalbon.com/machine_learning/support_vector_machines/svc_parameters_using_rbf_kernel/).
The variation of accuracy across gamma is plotted below, showing a local maxima at gamma = 3. While it is possible that this maxima is  a local maxima and another global maxima may exist, time and computation restrictions prevented us from broadening the search space for this parameter.
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/gamma.png)

### Performance metrics of SVM:
**The SVM with an RBF kernel and optimized hyperparameters achieved an accuracy of 54.23% on the test dataset**. A detailed analysis of precision and recall is shown below along with the corresponding confusion matrices:
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/svmaccuracy.PNG)
<p float="left">
  <img src="https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/svmconfusionmatrix.png" width="400" />
  <img src="https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/svmconfusionmatrix2.png" width="400" />
</p>
The labels 0,1,2,3 and 5 represent labels Wake,N1,N2,N3 and REM sleep stages respectively. The SVM classifies most of the samples as N2, followed by the wake stage. These two labels also have the highest precision and recall. A reason for this could be the dataset itself which has these two labels in the most abundance causing the classifier to be slighlty biased towards these two labels. This is complimented by the fact that label 1 (N1) is least prevalant in the dataset and is also classified the least by the classifier in the testing set. The overall accuracy of 54.23% is 34.23% above random and any potential improvements could require more efficent kernels or even totally different classifiers.

## K Nearest Neighbour Classifier:
The KNN classifier classifies a sample based on its proximity to samples of different classes in its vicinity. It is a popular clustering algorithm and has been used for sleep stage classification as well [3]. The most important hyperparameter to be trained here is the number of neighbours to be considered. If the number of neighbours is too small, it could lead to overfitting and a loss of generality in the dataset. The cross validation sheme used here is similar to the one articulated for the SVM. The variation in accuracy with the number of neighbours is given below:
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/KNNcv.png)

An optimum K_neighbours of 21 was chosen and used on the testing dataset.

### Performance Metrics of KNN:
**The KNN algorithm achieved an accuracy of 52.22% on the test dataset**. 
This is slightly lower than that achieved by SVM but not significantly so. A detailed look at the confusion matrices plotted below shows the classifer heavily favours label 2 and label 0. Again this is expected due to the imbalance of labels in the original dataset as explained above. 
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/knnaccuracy.PNG)
<p float="left">
  <img src="https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/KNNconfusion.png" width="400" />
  <img src="https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/KNNconfusionnormal.png" width="400" />
</p>

# Random Forest Ensemble for Predicting Sleep Cycle Stages with EEG Signals
[Code (Jupyter Notebook)](https://github.com/fkarimzadeh6/CX4240_project/blob/Nihad-Ljubuncic/RF_with_kfold.ipynb)

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

## Conclusion
* Of all machine learning algorithms, our most accurate model was Random Forest, with an average accuracy of 80%
* Use of these machine learning algorithms could streamline data acquisition and interpretation for sleep studies

## Future work
* Choosing epoch equal to 30 sec in not optimal. Future work would be finding better way to devide data into stages with different length. 


## References:
1. V.  Bajaj  and  R.  B.  Pachori,  “Automatic  classification  of  sleep  stages based on the time-frequency  image of EEG signals,” Comput. Methods Programs Biomed. , vol. 112, no. 3, pp. 320–328, 2013.
2. L. Fraiwan, K. Lweesy, N. Khasawneh, M. Fraiwan, H. Wenz, H. Dickhaus, et al. Classification of sleep stages using multi-wavelet time frequency entropy and lda Methods Inf. Med., 49 (3) (2010), p. 230
3. http://www.cs.columbia.edu/~mcollins/courses/6998-2012/notes/perc.converge.pdf
4. Lajnef, Tarek, et al . "Learning machines and sleeping brains: automatic sleep stage classification using
decision-tree multi-class support vector machines." Journal of neuroscience methods 250 (2015): 94-105
5. Aboalayon, Khald, et al. "Sleep stage classification using EEG signal analysis: a comprehensive survey and new investigation." Entropy 18.9 (2016): 272.
  
  
 
