# Method 4

- The architecture we propose here is based on the following image extraction operation: for a given voxel point, three patches of MRI 32x32 are extracted from the three planes, concatenated into a three-channel picture and resized in order to match the input size of the neural network.
- The final architecture is given by extracting 100 pictures from 100 voxels of the MRI, fed each of them into our pretrained AlexNet, then combine the outputs with a weighted sum method.
- To train the CNN AlexNet we extracted 100 pictures from each MRI and perform some data augmentation.

![structure](https://github.com/ivaste/AlzheimerPrediction/blob/master/Documentation/Method4Code.png?raw=true)
