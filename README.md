# Universum-least-squares-twin-parametric-margin-support-vector-machine

This is implementation of the paper: B. Richhariya, M. Tanveer, Universum least squares twin parametric-margin support vector machine, International Joint Conference on Neural Networks (IJCNN) 2020, Glasgow (UK).

Description of files:

main.m: selecting parameters of ULSTPMSVM using k fold cross-validation. One can select parameters c, v, mu, and e to be used in grid-search method.

ULSTPMSVM.m: implementation of ULSTPMSVM algorithm. Takes parameters c, v, mu, and e, and training data and test data, and provides accuracy obtained and running time.

For reproducing the results of the ULSTPMSVM algorithm, we have made a newd folder containing a sample dataset. One can simply run the main.m file to check the obtained results on this sample dataset. To run experiments on more datasets, simply add datasets in the newd folder and run main.m file. The code has been tested on Windows 10 with MATLAB R2017a.

This code is for non-commercial and academic use only. Please cite the following paper if you are using this code.

Reference: B. Richhariya, M. Tanveer, Universum least squares twin parametric-margin support vector machine, International Joint Conference on Neural Networks (IJCNN) 2020, Glasgow (UK).

For further details regarding working of algorithm, please refer to the paper.

If further information is required you may contact on: phd1701241001@iiti.ac.in.
