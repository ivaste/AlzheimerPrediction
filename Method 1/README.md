# Method 1
**The production architecture** consist of:
- extract 3 slices from the middle of the MRI, with some gap between them.
- Each slices is copied 3 times to compose a 3-channel RGB picture for each slice extracted.
- These 3 RGB pictures are fed into AlexNet
- Then the 3 prediction are combined with a Weighted Sum method to obtain the final probability.

**The training architecture ** consist of:
- For each MRI in the dataset
 - extract 3 slices from the middle of the MRI, with some gap between them.
 - Each slices is copied 3 times to compose a 3-channel RGB picture for each slice extracted.
- Perform some data augmentation on these RGB pictures to build an augmented dataset
- Finally train AlexNet on the augmented dataset
![structure](https://github.com/ivaste/AlzheimerPrediction/blob/master/Documentation/Method1Code.png?raw=true)
