#!/usr/python

import numpy as np
import cv2

import sys
sys.path.insert(0,'../') # to specify python code exist in another folder
import convolution as conv
np.set_printoptions(threshold=np.inf)


# Function to unpack a cifar database file
# Takes the file path+name as input and return
# a dictitionary data structure
def readDatabase(file):
    import cPickle
    with open(file,'rb') as fo:
        db=cPickle.load(fo)

    return db


# Function to read an image from the cifar database
# Takes a dictionary and the database image number (0 to n) as
# inputs and returns a 32x32 image + its label number
def readImgFromDatabase(db,imgNum):
    img=np.zeros((32,32,3),dtype=int)

    
    temp = db['data'][imgNum].reshape((3,32,32))
    
    img[:,:,0] = temp[0] #red
    img[:,:,1] = temp[1] #blue
    img[:,:,2] = temp[2] #green
    
    """
    # correct output with opencv
    img[:,:,0] = temp[2]
    img[:,:,1] = temp[1]
    img[:,:,2] = temp[0]
    """
    return img,db['labels'][imgNum]


# Function loading into a numpy vector the link
# between image label and its class
# Takes a cifar metadata file (path+name) and return a vector
def readLabelLink(metaDataFile):
    labelVector=readDatabase(metaDataFile)
    
    return labelVector['label_names']
