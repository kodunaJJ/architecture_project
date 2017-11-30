#!/usr/bin/python3.5

import numpy as np
import math

# Function taken on https://stackoverflow.com/questions/37674306/what-is-the-difference-between-same-and-valid-padding-in-tf-nn-max-pool-of-t
def getPaddings(pad_along_height,pad_along_width):
    # if even.. easy..
    if pad_along_height%2 == 0:
        pad_top = pad_along_height / 2
        pad_bottom = pad_top
    # if odd
    else:
        pad_top = np.floor( pad_along_height / 2 )
        pad_bottom = np.floor( pad_along_height / 2 ) +1
    # check if width padding is odd or even
    # if even.. easy..
    if pad_along_width%2 == 0:
        pad_left = pad_along_width / 2
        pad_right= pad_left
    # if odd
    else:
        pad_left = np.floor( pad_along_width / 2 )
        pad_right = np.floor( pad_along_width / 2 ) +1
        #
    return pad_top,pad_bottom,pad_left,pad_right


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


# Function to realise a max-pooling of size (poolSize,poolSize)
# with a stride of poolstride
# slight modification on poolMatrixOut height and width calculation

def maxPooling_mod(matrix,poolSize=2,poolStride=2):
    matrixWidth = matrix.shape[0]
    matrixHeight = matrix.shape[1]
    channelNum = matrix.shape[2]
    #channelNum = 1
    poolMatrixOutHeight= math.ceil(float(matrixHeight-poolSize+1)/float(poolStride))
    poolMatrixOutWidth= math.ceil(float(matrixWidth-poolSize+1)/float(poolStride))
    poolMatrixOut = np.zeros((int(poolMatrixOutHeight),
                              int(poolMatrixOutWidth),channelNum))

    for channel in range (0,channelNum):    
        for column in range (0,matrixHeight-(poolSize-1),poolStride):
            for row in range (0,matrixWidth-(poolSize-1),poolStride):
                for pRow in range (0,poolSize):
                    for pColumn in range (0,poolSize):
                        if poolMatrixOut[int(row/poolStride)][int(column/poolStride)][channel] < matrix[row+pColumn][column+pRow][channel]:
                            poolMatrixOut[int(row/poolStride)][int(column/poolStride)][channel] = matrix[row+pColumn][column+pRow][channel]

    return poolMatrixOut


# Function to realise a generic max-pooling of size (poolSizeHeight,poolSizeWidth)
# with a stride of poolstride
"""
def maxPoolingGeneric(matrix,poolHeight=2,poolWidth=2,poolStride=2,pool_OpType, poolBeforeRELU='true'):
    matrixWidth = matrix.shape[1]
    matrixHeight = matrix.shape[0]
    channelNum = matrix.shape[2]
    #channelNum = 1
    if pool_OpType == 'valid':
        poolMatrixOutHeight= math.ceil(float(matrixHeight-poolHeight+1)/float(poolStride))
        poolMatrixOutWidth= math.ceil(float(matrixWidth-poolWidth+1)/float(poolStride))
    elif pool_OpType == 'same':
        poolMatrixOutHeight= math.ceil(float(matrixHeight+1)/float(poolStride))
        poolMatrixOutWidth= math.ceil(float(matrixWidth-poolWidth+1)/float(poolStride))
        pad_along_height= (poolMatrixOutHeight-1)*poolStride + poolHeight - matrixHeight
        pad_along_width= (poolMatrixOutWidth-1)*poolStride + poolWidth - matrixWidth

        pad_top,pad_bottom,pad_left,pad_right=getPaddings(pad_along_height,pad_along_width)
    
    else:
        print("/!\/!\/!\ UNKNOWN POOLING OPERATION TYPE /!\ /!\ /!\ ")
        print("/!\/!\/!\ taking valid type /!\ /!\ /!\ ")

    if poolBeforeRELU:
        matrixPadded= np.zeros((matrixHeight+(pad_top+pad_bottom),matrixWidth+(pad_left+pad_right),channelNum))
    else:
        matrixPadded= np.array([matrixHeight+(pad_top+pad_bottom),matrixWidth+(pad_left+pad_right),channelNum])
        matrixPadded.fill(-inf)
        
    matrixPadded[pad_top:pad_top+matrixHeight,pad_left:pad_left+matrixWidth]=matrix
        
    poolMatrixOut = np.zeros((int(poolMatrixOutHeight),
                              int(poolMatrixOutWidth),channelNum))

    matrixPaddedWidth = matrixPadded.shape[1]
    matrixPaddedHeight = matrixPadded.shape[0]

    for channel in range (0,channelNum):    
        for column in range (0,matrixPaddedWidth-(poolSize-1),poolStride):
            for row in range (0,matrixPaddedHeight-(poolSize-1),poolStride):
                for pRow in range (0,poolSize):
                    for pColumn in range (0,poolSize):
                        if poolMatrixOut[int(row/poolStride)][int(column/poolStride)][channel] < matrixPadded[row+pColumn][column+pRow][channel]:
                            poolMatrixOut[int(row/poolStride)][int(column/poolStride)][channel] = matrixPadded[row+pColumn][column+pRow][channel]

    return poolMatrixOut
"""
    
    


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
        return maxPooling_mod(matrix,poolSize,poolStride)
    elif poolType == 'avg':
        return avgPooling(matrix,poolSize,poolStride)
    else:
        print("/!\/!\/!\ WRONG POOLING TYPE /!\ /!\ /!\ ")
      
