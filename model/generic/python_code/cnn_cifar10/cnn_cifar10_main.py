#! /usr/bin/python3.5


# cnn algorithm implementation
# cifar10 trained algorithm

import sys
sys.path.insert(0,'../') # to specify python code exist in another folder
import img_op as imgOp
import convolution as conv
import numpy as np
np.set_printoptions(threshold=np.inf) # to force full print of numpy array
import RELU as re
import pooling_op as pool
import reshape as rshape
import matrix_multiply as matmult
import softmax as smax
import cnn_weight_loadFromFile as wload
import cifarDatabase_op as cifarDb
import add_bias as bias
import adaptation_image as normal


def accuracy(imgClassPredicted,imgReadClass,goodPredictionNum,totalImageRead):
    if imgClassPredicted == imgReadClass:
        goodPredictionNum+=1
    
    accuracy=float((goodPredictionNum))/float (totalImageRead)
    return accuracy,goodPredictionNum
    

#********************* ALGORITHM PARAMETERS*************************#

cifar10_DatabasePath = "../../../../../../image_database/cifar10/cifar-10-batches-py/"
cifar10_DatabaseFileName="test_batch"

imgClassPredicted=0
imgReadClass=0
goodPredictionNum=0
totalImgRead=0
totalImg=1000
accuracyCalc=(0,0)

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

"""
kernelConvLayer1=np.zeros((kernelImageChannelConvLayer1,convLayer1_channelNum,
                           kernelConvSize,kernelConvSize))
kernelConvLayer2=np.zeros((kernelImageChannelConvLayer2,convLayer2_channelNum,
                           kernelConvSize,kernelConvSize))
kernelConvLayer3=np.zeros((kernelImageChannelConvLayer3,convLayer3_channelNum,
                           kernelConvSize,kernelConvSize))
"""

kernelConvLayer1=np.zeros((kernelConvSize,kernelConvSize,kernelImageChannelConvLayer1,convLayer1_channelNum))
kernelConvLayer2=np.zeros((kernelConvSize,kernelConvSize,kernelImageChannelConvLayer2,convLayer2_channelNum))
kernelConvLayer3=np.zeros((kernelConvSize,kernelConvSize,kernelImageChannelConvLayer3,convLayer3_channelNum))

biasFClayer=np.zeros((1,10))

fcVectorLayer=np.zeros((180,10))


# Loading weights

weightFilename='CNN_coeff_'+str(kernelConvSize)+'x'+str(kernelConvSize)+'_mod.txt'

wload.loadWeightFromFile(weightFilename,kernelConvLayer1,kernelConvLayer2,
                         kernelConvLayer3,biasConvLayer1,biasConvLayer2,
                         biasConvLayer3,fcVectorLayer,biasFClayer)
print(kernelConvLayer1.shape)
#****************************************************************************#
#                                ALGORITHM START                             #
#****************************************************************************#


# for each image in the database

for num in range (0,totalImg):

	# reading image from database
    imgIn=cifarDb.readImgFromDatabase(db,num)
    cnnInputLayerMatrix = imgIn[0]
    imgReadClass=imgIn[1]

	#******************Image Normalisation*********************#
    cnnInputLayerMatrix1=normal.adapatation_imag(cnnInputLayerMatrix)
        #cnnInputLayerMatrix1=np.random.rand(24,24,3)
        #cnnInputLayerMatrix1*=2
        #cnnInputLayerMatrix1+=-1
        #cnnInputLayerMatrix1.fill(16)
        """
	print(cnnInputLayerMatrix1.max())

	print(kernelConvLayer1.max())
	print(kernelConvLayer2.max())
	print(kernelConvLayer3.max())
        """
	#************************ CONV LAYER 1 *************************#

	# First convolution layer processing (conv + pooling + relu)


	#print(kernel)

    cnnConv1LayerMatrix=re.RELU_3D(bias.add_bias(conv.convolution_RGB(cnnInputLayerMatrix1,kernelConvLayer1),biasConvLayer1[0,0,:]))
	#print("cnnConv1LayerMatrix = ")
	#print(cnnConv1LayerMatrix)
        #print('convLayer1 output',cnnConv1LayerMatrix.shape)
    cnnConv1LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolingHeight,
                                     poolingWidth,poolingStride,
                                     poolingMode,poolingType,poolingPos)
	#print(cnnConv1LayerMatrix.shape)
        #cnnConv1LayerMatrix/=10
        #print(cnnConv1LayerMatrix.max())
	# Second convolution layer processing (conv + pooling + relu)
        #print('convLayer1 output',cnnConv1LayerMatrix.shape)
    cnnConv2LayerMatrix=re.RELU_3D(bias.add_bias(conv.convolution_RGB(cnnConv1LayerMatrix,kernelConvLayer2),biasConvLayer2[0,0,:]))
    cnnConv2LayerMatrix=pool.pooling(cnnConv2LayerMatrix,poolingHeight,
                                     poolingWidth,poolingStride,
                                     poolingMode,poolingType,poolingPos)
	#print(cnnConv2LayerMatrix.shape)
        #cnnConv2LayerMatrix/=4000
        #print(cnnConv2LayerMatrix.max())

	# Third convolution layer processing (conv + pooling + relu)

    cnnConv3LayerMatrix=re.RELU_3D(bias.add_bias(conv.convolution_RGB(cnnConv2LayerMatrix,kernelConvLayer3),biasConvLayer3[0,0,:]))
    cnnConv3LayerMatrix=pool.pooling(cnnConv3LayerMatrix,poolingHeight,
                                     poolingWidth,poolingStride,
                                     poolingMode,poolingType,poolingPos)
        #cnnConv3LayerMatrix/=10
	#print(cnnConv3LayerMatrix.max())

	# Fully connected Layer processing

	# layer vector(3*3*20,10)
        

    cnnConv3LayerReshape=rshape.reshape(cnnConv3LayerMatrix)
	#print('FullyConnectedLayer0 (reshape) = ',cnnConv2LayerReshape)
    cnnFullyConnectedLayer=matmult.matrixMult_CHn(cnnConv3LayerReshape,fcVectorLayer)

        #print(cnnFullyConnectedLayer.max())
        #print('output vector \n',cnnFullyConnectedLayer)
	#outputVector=smax.softmax(cnnFullyConnectedLayer)

	#print(outputVector)

	#print('Image label = ',imgReadClass)
        #print('Predicted class =', cnnFullyConnectedLayer.argmax())
        
    totalImgRead+=1
    imgClassPredicted=cnnFullyConnectedLayer.argmax()
        #print('ImgClass = ',imgReadClass)
        #print('ImgClassPredicted ',imgClassPredicted)
        #print('Correct prediction Number = ',accuracyCalc[1])
    print('Algorithm results :')
    accuracyCalc = accuracy(imgClassPredicted,imgReadClass,accuracyCalc[1],totalImgRead)
    print('--> accuracy = ',accuracyCalc[0])
    print('--> progression = ',totalImgRead,totalImg)
    
#****************************************************************************#
#                                ALGORITHM END                               #
#****************************************************************************#
