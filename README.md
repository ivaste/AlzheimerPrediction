<h1 align="center"> Alzheimer Prediction <\h1>
Given a MRI (Magnetic Resonance Image) of the human brain, returns the probability of contracting Alzheimer's disease in the coming years. 

![structure](https://github.com/ivaste/AlzheimerPrediction/blob/master/Documentation/Problem.jpg?raw=true)

## Table of Contents
- [Overview](#overview)
- [Usage](#usage)
- [Contributing](#contributing)
- [Team](#team)
- [License](#license)

## Overview
<p style='text-align: justify;'>The early diagnosis of Alzheimer’s Disease (AD) and its prodromal form, Mild Cognitive Impairment (MCI), has been the subject of extensive research in recent years. Some recent studies have shown promising results in the diagnosis of AD and MCI using structural Magnetic Resonance Imaging (MRI) scans. In this paper, we propose the use of a Convolutional Neural Network (CNN) in the detection of AD and MCI. In particular, we used the 27-layered AlexNet for the binary classification on the Alzheimer’s Disease Neuroimaging Initiative (ADNI) dataset in a such particular way that allow us to achieve an overall accuracy up to 75% and outperform several classifiers from other studies.
We tried 4 different methods:</p>
- [Method 1](https://github.com/ivaste/AlzheimerPrediction/tree/master/Method%201)
- [Method 2](https://github.com/ivaste/AlzheimerPrediction/tree/master/Method%202)
- [Method 3](https://github.com/ivaste/AlzheimerPrediction/tree/master/Method%203)
- [Method 4](https://github.com/ivaste/AlzheimerPrediction/tree/master/Method%204)
<!--
## Todo

- [x] Code for Load Dataset
- [x] Code for Split Dataset in Train and Test
- [x] Code for Test on Test Set
- [x] Code for Train on the entire Train Set
- [x] Code for Cross fold validation
- [x] Code for Saving metrics and trained models
- [x] Code for different Axis
- [x] Code for Changing problem quickly
- [x] Method 1: for each axis compose a picture with the x,x,x slices
	- [x] CN vs MCIc: Code
	- [x] CN vs MCIc: Explore Hyperparameters on x-axis
	- [x] CN vs MCIc: Explore Hyperparameters on y-axis
	- [x] CN vs MCIc: Explore Hyperparameters on z-axis
	- [x] CN vs AD: Code
	- [x] CN vs AD: Explore Hyperparameters on x-axis
	- [x] CN vs AD: Explore Hyperparameters on y-axis
	- [x] CN vs AD: Explore Hyperparameters on z-axis
	- [x] MCInc vs MCIc: Code
	- [x] MCInc vs MCIc: Explore Hyperparameters on x-axis
	- [x] MCInc vs MCIc: Explore Hyperparameters on y-axis
	- [x] MCInc vs MCIc: Explore Hyperparameters on z-axis
- [x] Method 2: for each axis compose a picture with the x-k,x and x+k slices
	- [x] CN vs MCIc: Code
	- [x] CN vs MCIc: Explore Hyperparameters on x-axis
	- [x] CN vs MCIc: Explore Hyperparameters on y-axis
	- [x] CN vs MCIc: Explore Hyperparameters on z-axis
	- [x] CN vs AD: Code
	- [x] CN vs AD: Explore Hyperparameters on x-axis
	- [x] CN vs AD: Explore Hyperparameters on y-axis
	- [x] CN vs AD: Explore Hyperparameters on z-axis
	- [x] MCInc vs MCIc: Code
	- [x] MCInc vs MCIc: Explore Hyperparameters on x-axis
	- [x] MCInc vs MCIc: Explore Hyperparameters on y-axis
	- [x] MCInc vs MCIc: Explore Hyperparameters on z-axis
- [x] Method 3: Pick the middle axis of each MRI
	- [x] CN vs MCIc: Code
	- [x] CN vs MCIc: Explore Hyperparameters
	- [x] CN vs AD: Code
	- [x] CN vs AD: Explore Hyperparameters
	- [x] MCInc vs MCIc: Code
	- [x] MCInc vs MCIc: Explore Hyperparameters
- [x] Method 4: For each MRI choose 100 Voxels, for each voxel pick the x,y,z 32x32 slices
	- [x] CN vs MCIc: Code
	- [x] CN vs MCIc: Explore Hyperparameters
	- [x] CN vs AD: Code
	- [x] CN vs AD: Explore Hyperparameters
	- [x] MCInc vs MCIc: Code
	- [x] MCInc vs MCIc: Explore Hyperparameters

-->
## Usage
Just download the code and the dataset from this repo and execute it with MATLAB.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## Team
| <a href="https://stefanoivancich.com" target="_blank">**Stefano Ivancich**</a> | <a href="https://github.com/TyllanDrake" target="_blank">**Luca Masiero**</a> |
| :---: |:---:|
| [![Stefano Ivancich](https://avatars1.githubusercontent.com/u/36710626?s=200&v=4)](https://stefanoivancich.com)    | [![Luca Masiero](https://avatars1.githubusercontent.com/u/48916928?s=200&v=4?s=200)](https://github.com/TyllanDrake) |
| <a href="https://github.com/ivaste" target="_blank">`github.com/ivaste`</a> | <a href="https://github.com/TyllanDrake" target="_blank">`github.com/TyllanDrake`</a> |

## License
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
