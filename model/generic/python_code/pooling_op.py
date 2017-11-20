#!/usr/bin/python3.5

import numpy as np

# Function to realise a max-pooling of size (poolSize,poolSize)
# with a stride of poolstride

def maxPooling(matrix,poolSize,poolStride):
    matrixWidth = matrix.shape[0]
    matrixHeight = matrix.shape[1]
    #channelNum = matrix.shape[3]
    channelNum = 1
    poolMatrixOut = np.zeros((int(matrixWidth/poolStride),
                              int(matrixHeight/poolStride),channelNum))

    print(matrix.shape)
    print(poolMatrixOut.shape)
    print(matrixWidth,matrixHeight)

    for i in range (0,matrixHeight-(poolSize-1),poolStride):
        for j in range (0,matrixWidth-(poolSize-1),poolStride):
            for k in range (0,poolSize):
                for l in range (0,poolSize):
                    if poolMatrixOut[int(j/poolStride)][int(i/poolStride)][0] < matrix[j+l][i+k][0]:
                        poolMatrixOut[int(j/poolStride)][int(i/poolStride)][0] = matrix[j+l][i+k][0]

    return poolMatrixOut
                
                        
    
    
