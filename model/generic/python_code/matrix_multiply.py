#!/usr/bin/python3.5

import numpy as np

# Function to calculate the product between vectorIn a (1,n) shape
# vector and vector a (n,1) shape vector
# the result is stored by vectorSum and returned 
def matrixMult(vectorIn,vector):
    vectorInLength = vectorIn.shape[1]
    vectorSum = 0

    for i in range(0,vectorInLength):
            vectorSum += vectorIn[0][i]*vector[i]
    return vectorSum
"""
def matrixMultSum(vectorMatrix):
    vectorMatrixHeight=vectorMatrix.shape[0]
    vectorMatrixWidth=vectorMatrix.shape[1]
    vectorSum=np.zeros((1,vectorMatrix.shape[1]))
    
    for column in range(0,vectorMatrixWidth):
        for row in range(0,vectorMatrixHeight):
            vectorSum[0][column]+=vectorMatrix[row][column]

    return vectorSum
"""            
# Function to calculate the product between vectorIn a (1,n) shape
# vector and fcVector a (n,m) shape matrix containing the fully connected
# layer coefficient
# the result is stored in vectorOut a (1,m) shape vector and returned 
def matrixMult_CHn(vectorIn,fcVector):
    vectorOut=np.zeros((1,fcVector.shape[1]))
    channelNum=fcVector.shape[1]

    
    for i in range(0,channelNum):
        vectorBuff=np.copy(fcVector[:,i])
        vectorOut[0][i]=matrixMult(vectorIn,vectorBuff))
        
    return vectorOut

