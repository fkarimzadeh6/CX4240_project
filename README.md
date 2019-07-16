# Automatic Annotation of EEG signals for different stages of a sleep cycle using Machine Learning
## Foroozan Karimzadeh, Nael Mizanur Rahman, Nihad Ljubuncic


# Problem Definition and Motivation:
During  the  past  decades,  a  great  body  of research   has   been   devoted   to   automatic   sleep   stage scoring using the electroencephalogram (EEG). According to the AASM manual, each of the five stages is defined below and also illustrated in Fig. 1: ![Image](https://github.com/fkarimzadeh6/CX4240_project/blob/master/Figure/Stage.jpg) Fig.1. This figure illustrates Wake, N1, N2, N3, REM stages, from top to bottom panels, respectively.

-W: Awake state (stage W) is characterized by alpha or faster frequency bands occupying more than 50% of the epoch, frequent eye movements and high EMG tone.

-N1: Stage N1 is scored when alpha occupies more than 50% of epoch while theta activity, slow rolling eye movements and vertex waves are evident.

-N2: Stage N2 is scored when sleep spindles or K-complexes (less than 3 min apart) are noted.

-N3: Stage N3 is characterized by delta activity detected in over 20% of the epoch length.

-REM: Upon sleep scoring an epoch is marked as REM when saw-tooth waves along with rapid eye movements as well as lowest EMG signals are observed through each epoch.

  Automatically and accurate classification of sleep stages from EEG signals are critical due to two reasons:
  - First, the fact that these information will be used for dioagnosing different sleep disorders.  
  - Second, manual sleep scoring is a time-consuming process for an expert which is prone to human error. 
  
  However, the results are not yet satisfactory to be used as a standard procedure  in  clinical  studies.In  this  project, we have investigated different machine learning algorithms to automatically classify sleep stages and compared the results.
  
# Sleep Stage Classification   
  The overal process for sleep stage scoring consists of three steps which are explained below: 
  1. Preprocessing
  2. Feature Extraction
  3. Classification 
  
  ![Image](https://github.com/fkarimzadeh6/CX4240_project/blob/master/Figure/SleepStageProcess.PNG)
  
## Data:
  
  publicly available sleep datasets provided by [PhysioBank](http://physionet.org/physiobank/database/sleep-edfx/) has been employed in this study to assess the proposed methods. The utilized set is the SleepEDF Database contains ten healthy subjects without any sleep-related medication. The PSGs include EEG, EOG and EMG signals of healthy young subjects within the age range of 21-35. The EEG has been sampled at 100 Hz, divided into 30 s epochs and manually annotated. The annotationsconsist of sleep stages including W, R, N1, N2, N3. For this study, the single-channel Pz-Oz is used according to former studies [21], [34], as it has been suggested that deeper sleep
stages are better detected (visually) in this channel. The overal percentage of each stage in our dataset are illustrated in figure 3.

## Preprocessing:

  To enhance the EEG signal quality, a preprocessing step is required. Given a raw input EEG signal, a band-pass filter (Butterworth of order eight) with pass-band bandwidth of 0.5–40 Hz is applied. We also remove the movement noises by using this range, as these noise usually accure at much higher frequency.
  
## Feature Extraction: 

  Contineous wavelet transform (CWT) is used to represent EEG signals into the time-frequency domain \cite{LFraiwan3}. We employed mother wavelets of Daubechies (db20) with center frequency of 0.67. After passing the EEGs through wavelet's filters, entropy of each filtered signal is determined according to Eq.~\ref{eq31} for each of the frequency bands shown in Table~\ref{tab01}. Moreover, Beta band is divided into two sub-bands with frequencies of $ 13-22 $ and $ 22-35 Hz $; therefore, 7 frequency bands are totally considered. 
	
	\begin{equation}
		\label{eq31}
		Ent=-\Sigma_{i=1}^n p_i log p_i
	\end{equation}
	where $ p $ is the histogram distribution of wavelet coefficients in each band with $ n $ bins.
	
	These entropy values are arranged in a feature vector for each epoch. Therefore, by calculating the entropy in seven frequency bands for CWT, a feature vector consists of 7 elements for each epoch is formed and continued for the entire EEG signals. The sleep stage classification process is ended by feeding these features to classifier.
  
  
 

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/fkarimzadeh6/CX4240_project/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
