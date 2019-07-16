# Supervised Learning after Feature Extraction
[Code (Jupyter Notebook)](https://nbviewer.jupyter.org/github/fkarimzadeh6/CX4240_project/blob/Nael/clustering_top_v2.ipynb)
### Dataset
The original dataset consists of 16330 samples, 1633 each from 10 different subjects. Each sample is accompanied by a label (N1, N2, N3, N4 and REM) denoted by 0,1,2,3,4 respectively. The dataset is trimmed to eliminate the first 833 samples which consists entirely of a single label (0). This would have biased the dataset heavily towards a single label. The trimmed dataset now consists of 8330 samples each with 7 features. The following charts shows the distribution of various labels within the dataset. The dataset contains the most of the N2 stage as is expected in a standard sleeping pattern of a subject:

<p align="center">
  <img width="460" height="300" src="https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/pie.png">
</p>

### Perceptron Algorithm 
The Perceptron learning algorithm is a linear classifer that assigns weights to features of a sample to generate a hyperplane. The plane  is then updated based on any wrong classifications. This continues until the weights converge to an optimum solution (the average loss changes by less than a tolerance between successive iterations). The perceptron algorithm is guaranteed to converge, provided the dataset is linearly separable. 
![image](https://github.com/fkarimzadeh6/CX4240_project/blob/Nael/pics/Capture.PNG)

An example of the change in the hyperplane as the weights are updated is demonstrated below:
<p align="center">
  <img width="460" height="350" src="https://upload.wikimedia.org/wikipedia/commons/a/aa/Perceptron_training_without_bias.gif">
</p>


```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/fkarimzadeh6/CX4240_project/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
