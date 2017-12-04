#! /usr/bin/python3.5


# cnn algorithm implementation
# cifar10 trained algorithm

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


def accuracy(imgClassPredicted,imgReadClass,missPredictionNum,totalImageRead):
    if imgClassPredicted != imgReadClass:
        missPredictionNum+=1

    accuracy=(totalImageRead-missPredictionNum)/totalImageRead
    return accuracy
    

#********************* ALGORITHM PARAMETERS*************************#

cifar10_DatabasePath = "../../../../../../image_database/cifar10/cifar-10-batches-py/"
cifar10_DatabaseFileName="data_batch_1"

imgClassPredicted=0
imgReadClass=0
missPredictionNum=0
totalImgRead=0

#!!!!!!!!!!!! KERNEL PARAMETERS !!!!!!!!!!!!!#
convLayer1_channelNum=64
convLayer2_channelNum=32
convLayer3_channelNum=20
kernelConvSize=5
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

weightFilename='CNN_coeff_'+str(kernelConvSize)+'x'+str(kernelConvSize)+'_mod.txt'

wload.loadWeightFromFile(weightFilename,kernelConvLayer1,kernelConvLayer2,kernelConvLayer3,
                         biasConvLayer1,biasConvLayer2,biasConvLayer3,fcVectorLayer,biasFClayer)


#***********************************************************************************#
#                                ALGORITHM START                                    #
#***********************************************************************************#


# for each image in the database ???????



# reading image from database
imgIn=cifarDb.readImgFromDatabase(db,0)
cnnInputLayerMatrix = imgIn[0]
imgReadClass=imgIn[1]


#************************ CONV LAYER 1 *************************#

# First convolution layer processing (conv + pooling + relu)


#print(kernel)

cnnConv1LayerMatrix=re.RELU_3D(conv.convolution_RGB(cnnInputLayerMatrix,kernelConvLayer1))
#print('cnnConv1LayerMatrix = ',cnnConv1LayerMatrix)
cnnConv1LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolingHeight,poolingWidth,
                                 poolingStride,poolingMode,poolingType,poolingPos)
print(cnnConv1LayerMatrix.shape)


# Second convolution layer processing (conv + pooling + relu)

cnnConv2LayerMatrix=re.RELU_3D(conv.convolution_RGB(cnnConv1LayerMatrix,kernelConvLayer2))
cnnConv2LayerMatrix=pool.pooling(cnnConv2LayerMatrix,poolingHeight,poolingWidth,
                                 poolingStride,poolingMode,poolingType,poolingPos)
print(cnnConv2LayerMatrix.shape)

# Third convolution layer processing (conv + pooling + relu)

cnnConv3LayerMatrix=re.RELU_3D(conv.convolution_RGB(cnnConv2LayerMatrix,kernelConvLayer3))
cnnConv3LayerMatrix=pool.pooling(cnnConv3LayerMatrix,poolingHeight,poolingWidth,
                                 poolingStride,poolingMode,poolingType,poolingPos)
print(cnnConv3LayerMatrix.shape)

# Fully connected Layer processing

# layer vector(3*3*20,10)


cnnConv3LayerReshape=rshape.reshape(cnnConv3LayerMatrix)
#print('FullyConnectedLayer0 (reshape) = ',cnnConv2LayerReshape)
cnnFullyConnectedLayer=matmult.matrixMult_CHn(cnnConv3LayerReshape,fcVectorLayer)

cnnFullyConnectedLayer+=biasFClayer

outputVector=smax.softmax(cnnFullyConnectedLayer)

print(outputVector)


"""
print('Algorithm results :')

print('--> accuracy = %f',accuracy(imgClassPredicted,imgReadClass,missPredictionNum,totalImgRead))
print('--> progression = %d/%d',totalImgRead,totalImg)
"""

#***********************************************************************************#
#                                ALGORITHM END                                      #
#***********************************************************************************#
