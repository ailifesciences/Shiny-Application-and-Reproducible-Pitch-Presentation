Breast Cancer Tumor Class Prediction App
========================================================
author: S De Majumdar
date: 01.07.2020
autosize: true

Overview
========================================================

Breast cancer (BC) is one of the most common cancers among women worldwide, representing the majority of new cancer cases and cancer-related deaths according to global statistics, making it a significant public health problem in today's society.

An early diagnosis can improve the prognosis and promote timely clinical treatment thus increasing the chance of survival significantly. Also, an accurate classification of benign tumors can prevent from unnecessary treatments. Thus, the correct diagnosis and classification of tumors into malignant or benign groups is important. Because of its unique advantages in critical features detection from complex datasets, machine learning (ML) is widely recognized as the methodology of choice in BC pattern classification and forecast modelling.


Building a Classification model
========================================================
The goal is to classify whether the breast cancer is benign or malignant. To achieve this machine learning classification methods have been applied to fit a function that can predict the discrete class of new input.

- Breast Cancer dataset is obtained from mlBench R package.
- Different Classification models were tested.
- Random Forest Classification algorithm gives the best results.
- The application is designed using the Random Forest Classification Model.


Classification model code
========================================================


```r
library(mlbench)
data('BreastCancer')
# Loading data and processing
BreastCancer <- BreastCancer[!is.na(BreastCancer$Bare.nuclei),]
BreastCancer <- BreastCancer[,2:11]
# Classification model
library(caret) #Package has functions for training and plotting models
library(rpart)     #Package has function to implement tree algorithm
library(randomForest) #Package has Random Forest Algorithm
library(reshape2)

inTrain <- createDataPartition(BreastCancer$Class, p=0.7,list = FALSE) 
traindata <- BreastCancer[inTrain,]
testdata <- BreastCancer[-inTrain,]
model_rf <- randomForest(Class ~ ., data = traindata, importance=TRUE, ntree = 10)
predict_rf <- predict(model_rf, newdata=testdata)
summary(cars)
```

Stacked plot of the predictors of the dataset
========================================================

<img src="Breast Cancer Prediction App-figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />