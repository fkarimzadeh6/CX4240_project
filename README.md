# Supervised Learning after Feature Extraction
[Code (Jupyter Notebook)](https://nbviewer.jupyter.org/github/fkarimzadeh6/CX4240_project/blob/Nael/clustering_top_v2.ipynb)
## Dataset
The original dataset consists of 16330 samples, 1633 each from 10 different subjects. Each sample is accompanied by a label (N1, N2, N3, N4 and REM) denoted by 0,1,2,3,4 respectively. The dataset is trimmed to eliminate the first 833 samples which consists entirely of a single label (0). This would have biased the dataset heavily towards a single label. The trimmed dataset now consists of 8330 samples each with 7 features. The following charts shows the distribution of various labels within the dataset. The dataset contains the most of the N2 stage as is expected in a standard sleeping pattern of a subject:

![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/pie.png)

## Perceptron Algorithm 
The Perceptron learning algorithm is a linear classifer that assigns weights to features of a sample to generate a hyperplane. The plane  is then updated based on any wrong classifications. This continues until the weights converge to an optimum solution (the average loss changes by less than a tolerance between successive iterations). The perceptron algorithm is guaranteed to converge, provided the dataset is linearly separable[1]. 

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
Support Vector machines have been used to classify EEG signals in several previous research works[2]. Lajnef *et al* have so far demonstrated one of the best result on EEG classifcation. Their endevor focused on the the use of a dendogram based multi class SVM that achieved an overall accuracy of 92%. Our work focuses on the classical one-vs-one multiclass classification using SVM, employing different kernels. As mentioned before, the dataset does not appear to be linearly separable and therefore requires non-linear kernels for SVM. For our current study, we resorted to the Radiul Basis Function kernel and optimized the hyperparameters associated with it.

### Cross Validation and Hyperparamters
For this work, we chose to optimize two hyper parameters: gamma (for regulairzation) and C (penalty paramter for the error function). The optimization of parameters was done using a 5-fold cross validation on the traininng dataset. The training dataset consisted of 90% of the original dataset, while the remaining 10% was left for testing. The scoring metric upon which the cross_validation was judged was the average accuracy of prediction. 
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/svmflowchart.PNG)

### Hyperparameter, C
The parameter 'C' is the penalty parameter for error in an SVM and determines the degree of softness of an SVM. A lower value of C allows some support vectors to be placed on the wrong side of the margin, therby trading error in training for more robustness and stability in the model overall. A high value of C hardens the SVM, allowing little missclassification. For detailed explanation [click here](https://chrisalbon.com/machine_learning/support_vector_machines/svc_parameters_using_rbf_kernel/). 
The variation in accuracy with changes in C is shown. The graph shows a maxima for C at around 0.8, showing the SVM to be somwhat soft in nature. Hardening the SVM with high C values shows drastic decline in accuracy, as if expected due to a hit on the robustness of the model as a whole. 
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/C.png)

### Hyperparameter, gamma:
The gamma parameter determines the spread of the RBF kernel. It can be thought of as the inverse of the radius of influence of the samples that are considered to be support vectors by the kernel. A small value of gamma forces teh kernel to adopt a somewhat linear shape, redcuing its curvature. A high vlaue of gamma makes the kernel a bit more non-linear, often allowing islands of decision boundaries to be generated. For detailed explanation [click here](https://chrisalbon.com/machine_learning/support_vector_machines/svc_parameters_using_rbf_kernel/).
The variation of accuracy across gamma is plotted below, showing a local maxima at gamma = 3. While it is possible that this maxima is just a local maxima and another global maxima may exist, time and computation restrictions prevented us from boradening the search space for this parameter.
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/gamma.png)
### Performance metrics of SVM:
**The SVM with an RBF kernel and optimized hyperparameters achieved an accuracy of 54.23% on the test dataset**. A detailed analysis of precision and recall is shown below along with the corresponding confusion matrices:
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/svmaccuracy.png)
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

## References:
1. http://www.cs.columbia.edu/~mcollins/courses/6998-2012/notes/perc.converge.pdf
2. Lajnef, Tarek, et al . "Learning machines and sleeping brains: automatic sleep stage classification using
decision-tree multi-class support vector machines." Journal of neuroscience methods 250 (2015): 94-105
3. Aboalayon, Khald, et al. "Sleep stage classification using EEG signal analysis: a comprehensive survey and new investigation." Entropy 18.9 (2016): 272.


### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/fkarimzadeh6/CX4240_project/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
