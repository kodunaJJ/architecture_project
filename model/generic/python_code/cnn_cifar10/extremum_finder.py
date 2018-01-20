#! /usr/bin/python3.5
import sys
sys.path.insert(0,'../') # to specify python code exist in another folder
import img_op as imgOp
import convolution as conv
import numpy as np
np.set_printoptions(threshold=np.inf) # to forced full print of numpy array
import RELU as re
import pooling_op as pool
import reshape as rshape
import matrix_multiply as matmult
import softmax as smax
import cnn_weight_loadFromFile as wload
import cifarDatabase_op as cifarDb
import add_bias as bias
import adaptation_image as normal


cifar10_DatabasePath = "../../../../../../image_database/cifar10/cifar-10-batches-py/"
cifar10_DatabaseFileName="test_batch"

imgClassPredicted=0
imgReadClass=0
missPredictionNum=0
totalImgRead=0

#!!!!!!!!!!!! KERNEL PARAMETERS !!!!!!!!!!!!!#
convLayer1_channelNum=64
convLayer2_channelNum=32
convLayer3_channelNum=20
kernelConvSize=3
kernelImageChannelConvLayer1=3
kernelImageChannelConvLayer2=64
kernelImageChannelConvLayer3=32

#!!!!!!!!!!! POOLING PARAMETERS !!!!!!!!!!!!!#
poolingHeight=3
poolingWidth=3
poolingStride=2
poolingType='max'
poolingMode='SAME'
poolingPos='false' #before RELU (true) or not

# Loading image database 
db=cifarDb.readDatabase(cifar10_DatabasePath+cifar10_DatabaseFileName)

# Allocating bias matrix + kernel + fcLayer Matrix
biasConvLayer1=np.zeros((1,1,convLayer1_channelNum))
biasConvLayer2=np.zeros((1,1,convLayer2_channelNum))
biasConvLayer3=np.zeros((1,1,convLayer3_channelNum))

kernelConvLayer1=np.zeros((kernelImageChannelConvLayer1,convLayer1_channelNum,
                           kernelConvSize,kernelConvSize))
kernelConvLayer2=np.zeros((kernelImageChannelConvLayer2,convLayer2_channelNum,
                           kernelConvSize,kernelConvSize))
kernelConvLayer3=np.zeros((kernelImageChannelConvLayer3,convLayer3_channelNum,
                           kernelConvSize,kernelConvSize))

biasFClayer=np.zeros((1,10))

fcVectorLayer=np.zeros((180,10))


# Loading weights
"""
weightFilename='CNN_coeff_'+str(kernelConvSize)+'x'+str(kernelConvSize)+'_mod.txt'

wload.loadWeightFromFile(weightFilename,kernelConvLayer1,kernelConvLayer2,
                         kernelConvLayer3,biasConvLayer1,biasConvLayer2,
                         biasConvLayer3,fcVectorLayer,biasFClayer)

print('WEIGHT EXTREMUM')
print('kernel conv 1 (min/max/avg)')
print(kernelConvLayer1.min(),kernelConvLayer1.max(),np.average(kernelConvLayer1))
print('kernel conv 2 (min/max/avg)')
print(kernelConvLayer2.min(),kernelConvLayer2.max(),np.average(kernelConvLayer2))
print('kernel conv 3 (min/max/avg)')
print(kernelConvLayer3.min(),kernelConvLayer3.max(),np.average(kernelConvLayer3))
print('fully connected layer matrix')
print(fcVectorLayer.min(),fcVectorLayer.max(),np.average(fcVectorLayer))



"""
imgNormMin=np.zeros((1,10000))
imgNormMax=np.zeros((1,10000))
imgNormAvg=np.zeros((1,10000))

print('Start calculation')

for num in range (0,10000):

    imgIn=cifarDb.readImgFromDatabase(db,num)
    cnnInputLayerMatrix = imgIn[0]
    imgReadClass=imgIn[1]

    #******************Image Normalisation*********************#
    cnnInputLayerMatrix1=normal.adapatation_imag(cnnInputLayerMatrix)
    imgNormMax[0,num]=cnnInputLayerMatrix1.max()
    imgNormMin[0,num]=cnnInputLayerMatrix1.min()
    imgNormAvg[0,num]=np.average(cnnInputLayerMatrix1)
    print('p',num+1)

print('End calculation')
print('RESULTS (min/max/avg)')
print(imgNormMin.min(),imgNormMax.max(),np.average(imgNormAvg))

