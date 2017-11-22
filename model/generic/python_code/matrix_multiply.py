#!/usr/bin/python3.5

import numpy as np



def matrixMult(vectorIn,vector):
    vectorInLength = vectorIn.shape[0]
    vectorLength = vector.shape[1]
    vectorOut = np.zeros((1,vectorLength))

    for i in range(0,vectorLength):
        for j in range(0,vectorInLength):
            vectorOut[0][i] += vectorIn[j][0]*vector[0][i]
    return vectorOut




    
