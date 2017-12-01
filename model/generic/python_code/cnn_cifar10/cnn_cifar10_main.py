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


#********************* ALGORITHM PARAMETERS*************************#

cifar10_DatabasePath = "../../../../../../image_database/cifar10/cifar10_ppm_image/"
img_in_name = "1a.ppm"
#img_out_folder = "../../image/test/"
#img_out_name = "img_test_2_out.ppm"


#!!!!!!!!!!!! KERNEL PARAMETERS !!!!!!!!!!!!!#
convLayer1_channelNum=64
convLayer2_channelNum=32
convLayer3_channelNum=20
kernelConvSize=5
kernelImageChannelConvLayer1=3
kernelImageChannelConvLayer2=64
kernelImageChannelConvLayer3=32

#!!!!!!!!!!! POOLING PARAMETERS !!!!!!!!!!!!!#
poolingSize=3
poolingStride=2
poolingType='max'
poolingMode='SAME'

# Loading image database 
imgIn = imgOp.imgOpen(img_in_folder,img_in_name)
imgIn_info = imgOp.getImgInfo(imgIn)
cnnInputLayerMatrix = imgOp.img2nparray(imgIn)


#***********************************************************************************#
#                                ALGORITHM START                                    #
#***********************************************************************************#



#************************ CONV LAYER 1 *************************#

# Kernel parameters init process
kernel=np.zeros((kernelImageChannelConvLayer1,convLayer1_channelNum,kernelConvSize,kernelConvSize))
wload.initKernel(kernel,convLayer1_channelNum,1,kernelImageChannelConvLayer1)

# First convolution layer processing (conv + pooling + relu)


#print(kernel)

cnnConv1LayerMatrix=re.RELU_3D(conv.convolution_RGB(cnnInputLayerMatrix,kernel))
#print('cnnConv1LayerMatrix = ',cnnConv1LayerMatrix)
cnnConv1LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolingSize,poolingStride,poolType)#to complete

#print('ConvLayer1 (reshape) = ',cnnConv1LayerMatrix)

# conv layer 2 kernel init

kernelConvLayer2=np.zeros((kernelImageChannelConvLayer2,convLayer2_channelNum,kernelConvSize,kernelConvSize))
initKernel(kernelConvLayer2,convLayer2_channelNum,2,kernelImageChannelConvLayer2)

# Second convolution layer processing (conv + pooling + relu)

cnnConv2LayerMatrix=re.RELU_3D(conv.convolution_RGB(cnnConv1LayerMatrix,kernelConvLayer2))
cnnConv2LayerMatrix=pool.pooling(cnnConv2LayerMatrix,poolingSize,poolingStride,poolType)#to complete


# conv layer 3 kernel init

kernelConvLayer3=np.zeros((kernelImageChannelConvLayer3,convLayer3_channelNum,kernelConvSize,kernelConvSize))
initKernel(kernelConvLayer3,convLayer3_channelNum,3,kernelImageChannelConvLayer3)

# Third convolution layer processing (conv + pooling + relu)

cnnConv3LayerMatrix=re.RELU_3D(conv.convolution_RGB(cnnConv2LayerMatrix,kernelConvLayer3))
cnnConv3LayerMatrix=pool.pooling(cnnConv3LayerMatrix,poolingSize,poolingStride,poolType)#to complete


# Fully connected Layer processing

# layer vector(3*3*20,10)

fcVectorLayer=np.zeros((180,10))

initVector(fcVectorLayer,1)

cnnConv3LayerReshape=rshape.reshape(cnnConv3LayerMatrix)
#print('FullyConnectedLayer0 (reshape) = ',cnnConv2LayerReshape)
cnnFullyConnectedLayer=matmult.matrixMult_CHn(cnnConv3LayerReshape,fcVectorLayer)

outputVector=smax.softmax(cnnFullyConnectedLayer)

print(outputVector)



#***********************************************************************************#
#                                ALGORITHM END                                      #
#***********************************************************************************#
