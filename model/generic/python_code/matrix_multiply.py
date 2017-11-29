#!/usr/bin/python3.5

import numpy as np

def matrixMult(vectorIn,vector):
    vectorInLength = vectorIn.shape[0]
    #vectorLength = vector.shape[1]
    vectorLength = vector.shape[0]
    vectorOut = np.zeros((1,vectorLength))

    for i in range(0,vectorLength):
        for j in range(0,vectorInLength):
            vectorOut[0][i] += vectorIn[j][0]*vector[i]
    return vectorOut

def matrixMultSum(vectorMatrix):
    vectorMatrixHeight=vectorMatrix.shape[0]
    vectorMatrixWidth=vectorMatrix.shape[1]
    vectorSum=np.zeros((1,vectorMatrix.shape[1]))
    
    for column in range(0,vectorMatrixWidth):
        for row in range(0,vectorMatrixHeight):
            vectorSum[0][column]+=vectorMatrix[row][column]

    return vectorSum
            

def matrixMult_CHn(vectorIn,fcVector):
    matrixVectorBuff=np.zeros((fcVector.shape[0],fcVector.shape[1]))
    vectorBuff=np.zeros((1,fcVector.shape[1]))
    vectorOut=np.zeros((1,fcVector.shape[1]))
    channelNum=fcVector.shape[0]

    
    for i in range(0,channelNum):
        vectorBuff=np.copy(fcVector[i,:])
        matrixVectorBuff[i,:]=matrixMult(vectorIn,vectorBuff)

    vectorOut=matrixMultSum(matrixVectorBuff)
    return vectorOut



    
