#!/usr/bin/python3.5

import numpy as np

# Function to realise a max-pooling of size (poolSize,poolSize)
# with a stride of poolstride

def maxPooling(matrix,poolSize=2,poolStride=2):
    matrixWidth = matrix.shape[0]
    matrixHeight = matrix.shape[1]
    channelNum = matrix.shape[2]
    #channelNum = 1
    poolMatrixOut = np.zeros((int(matrixWidth/poolStride),
                              int(matrixHeight/poolStride),channelNum))

    for channel in range (0,channelNum):    
        for column in range (0,matrixHeight-(poolSize-1),poolStride):
            for row in range (0,matrixWidth-(poolSize-1),poolStride):
                for pRow in range (0,poolSize):
                    for pColumn in range (0,poolSize):
                        if poolMatrixOut[int(row/poolStride)][int(column/poolStride)][channel] < matrix[row+pColumn][column+pRow][channel]:
                            poolMatrixOut[int(row/poolStride)][int(column/poolStride)][channel] = matrix[row+pColumn][column+pRow][channel]

    return poolMatrixOut


# Function to realise an average-pooling of size (poolSize,poolSize)
# with a stride of poolstride

def avgPooling(matrix,poolSize=2,poolStride=2):
    matrixWidth = matrix.shape[0]
    matrixHeight = matrix.shape[1]
    channelNum = matrix.shape[2]
    #channelNum = 1
    poolMatrixOut = np.zeros((int(matrixWidth/poolStride),
                              int(matrixHeight/poolStride),channelNum))

    for channel in range (0,channelNum):    
        for column in range (0,matrixHeight-(poolSize-1),poolStride):
            for row in range (0,matrixWidth-(poolSize-1),poolStride):
                for pRow in range (0,poolSize):
                    for pColumn in range (0,poolSize):                    
                        poolMatrixOut[int(row/poolStride)][int(column/poolStride)][channel] += matrix[row+pColumn][column+pRow][channel]
                   
    return poolMatrixOut/(poolStride*poolSize)
    
# Function performing the good pooling type depending on poolType string value 
def pooling(matrix,poolSize,poolStride,poolType='max'):
    if poolType == 'max':
        return maxPooling(matrix,poolSize,poolStride)
    elif poolType == 'avg':
        return avgPooling(matrix,poolSize,poolStride)
    else:
        print("/!\/!\/!\ WRONG POOLING OPERATION TYPE /!\ /!\ /!\ ")
      
    
