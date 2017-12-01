#!/usr/bin/python3.5

import numpy as np
import math as math


def softmax(vector):
    #sum of vector value calculation
    vectorLength = vector.shape[1]
    vectorSum = 0
    vectorOut = np.zeros((1,vectorLength))
    for i in range(0,vectorLength):
        vectorOut[0][i] = math.exp(vector[0][i])
        vectorSum += vectorOut[0][i]
        
    # Output vector calculation
    return vectorOut/vectorSum
  
        

    
    
