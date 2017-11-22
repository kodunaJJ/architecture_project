#!/usr/bin/python3.5

import numpy as np
import math as math


def softmax(vector):
    #sum of vector value calculation
    vectorLength = vector.shape[0]
    vectorSum = 0
    vectorOut = np.zeros((vectorLength))
    for i in range(0,vectorLength):
        vectorOut[i] = math.exp(vector[i])
        vectorSum += vectorOut[i]
        
    # Output vector calculation
    return vectorOut/vectorSum
  
        

    
    
