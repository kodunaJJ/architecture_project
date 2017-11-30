#! /usr/bin/python3.5


# cnn algorithm implementation

import sys
sys.path.insert(0,'../')
import img_op as imgOp
import convolution as conv
import numpy as np
import RELU as re
import pooling_op as pool
import reshape as rshape
import matrix_multiply as matmult
import softmax as smax


# Function to load filter parameters into kernel
# channelNum --> number of filter in the conv layer
# convLayerID --> number of the conv layer (first=1, second=2, ...)
def initKernel(kernel,channelNum,convLayerID,imageChannel):

    # Load filter value from file 3D kernel
    for i in range (0,channelNum):
            kernel[0,i,:,:]=np.loadtxt('convLayer'+str(convLayerID)
                                       +'_kernel_'+str(i))
    # Duplicate 3D kernel for each imageChannel
    for i in range(1,imageChannel):
        kernel[i,:,:,:]=kernel[0,:,:,:]
# Function to load vector parameters from file
def initVector(vector,fcLayerID):
    vector[:,:]=np.loadtxt('fullyConnectedLayer'+str(fcLayerID))

img_in_folder = "./database/ppm/"
img_in_name = "1a.ppm"
#img_out_folder = "../../image/test/"
#img_out_name = "img_test_2_out.ppm"
convLayer1_channelNum=16
convLayer2_channelNum=36
kernelConvSize=5
kernelImageChannelConvLayer1=3
kernelImageChannelConvLayer2=16

# Loading image database
imgIn = imgOp.imgOpen(img_in_folder,img_in_name)
imgIn_info = imgOp.getImgInfo(imgIn)
cnnInputLayerMatrix = imgOp.img2nparray(imgIn)

# Kernel parameters init process
kernel=np.zeros((kernelImageChannelConvLayer1,convLayer1_channelNum,kernelConvSize,kernelConvSize))
initKernel(kernel,convLayer1_channelNum,1,kernelImageChannelConvLayer1)
print(kernel.shape)
print(kernel)
# First convolution layer processing (conv + pooling + relu)
poolingSizeConvLayer1=2
poolingStrideConvLayer1=2

cnnConv1LayerMatrix=re.RELU_3D(conv.convolution_nb_kernel(cnnInputLayerMatrix,kernel))
cnnConv1LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolingSizeConvLayer1,poolingStrideConvLayer1,poolType='max')
print(cnnConv1LayerMatrix.shape)


# conv layer 2 kernel init

kernelConvLayer2=np.zeros((kernelImageChannelConvLayer2,convLayer2_channelNum,kernelConvSize,kernelConvSize))

initKernel(kernelConvLayer2,convLayer2_channelNum,2,kernelImageChannelConvLayer2)

# Second convolution layer processing (conv + pooling + relu)
poolingSizeConvLayer2=2
poolingStrideConvLayer2=2

cnnConv2LayerMatrix=re.RELU_3D(conv.convolution_nb_kernel(cnnConv1LayerMatrix,kernelConvLayer2))
cnnConv2LayerMatrix=pool.pooling(cnnConv2LayerMatrix,poolingSizeConvLayer2,poolingStrideConvLayer2,poolType='max')


# Fully connected Layer1 processing

#first layer vector(7*7*36,128)

initVector(fcVectorLayer1,1)

cnnConv2LayerReshape=rshape.reshape(cnnConv2LayerMatrix)
cnnFullyConnectedLayer1=matmul.matrixMult_CHn(cnnConv2LayerReshape,fcVectorLayer1)

#second layer vector(128,10)
initVector(fcVectorLayer2,2)

cnnFullyConnectedLayer2=matmul.matrixMult_CHn(cnnFullyConnectedLayer1,fcVectorLayer2)

outputVector=smax.softmax(cnnFullyConnectedLayer2)

print(outputVector)
