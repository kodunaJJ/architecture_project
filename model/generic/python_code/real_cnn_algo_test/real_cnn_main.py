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
def initKernel(kernel,channelNum,convLayerID):
    for i in range (0,channelNum):
        kernel[0,i,:,:]=np.loadtxt('convLayer'+str(convLayerID)
                                            +'_kernel_'+str(i))

def initVector(vector,fcLayerID):
    vector[:,:]=np.loadtxt('fullyConnectedLayer'+str(fcLayerID))

img_in_folder = "./database/ppm/"
img_in_name = "1a.ppm"
#img_out_folder = "../../image/test/"
#img_out_name = "img_test_2_out.ppm"
convLayer1_channelNum=16
convLayer2_channelNum=36
kernelConvSize=5

# Loading image database
imgIn = imgOp.imgOpen(img_in_folder,img_in_name)
imgIn_info = imgOp.getImgInfo(imgIn)
cnnInputLayerMatrix = imgOp.img2nparray(imgIn)

# Kernel parameters init process
kernel=np.zeros((1,convLayer1_channelNum,kernelConvSize,kernelConvSize))
initKernel(kernel,convLayer1_channelNum,1)


# First convolution layer processing (conv + pooling + relu)
cnnConv1LayerMatrix=np.zeros((cnnInputLayerMatrix.shape[0],cnnInputLayerMatrix.shape[2],1))
cnnConv1LayerMatrix=re.RELU_3D(conv.convolution_nb_kernel(cnnInputLayerMatrix,kernel))
cnnConv1LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolType='max')

# conv layer 2 kernel init

kernelConvLayer2=np.zeros((1,36,5,5))

initKernel(kernelConvLayer2,5,1)

# Second convolution layer processing (conv + pooling + relu)
cnnConv2LayerMatrix=np.zeros((cnnInputLayerMatrix.shape[0],cnnInputLayerMatrix.shape[2],1))
cnnConv2LayerMatrix=re.RELU_3D(conv.convolution_nb_kernel(cnnInputLayerMatrix,kernelConvLayer2))
cnnConv2LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolType='max')


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
