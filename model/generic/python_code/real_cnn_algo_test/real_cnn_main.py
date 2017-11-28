#! /usr/bin/python3.5


# cnn algorithm implementation

import sys
sys.path.insert(0,'../')
import img_op as imgOp
import convolution as conv
import numpy as np
import RELU as re
#import pooling_op as pool
import reshape as rshape
import matrix_multiply as matmult
import softmax as smax


def initKernel(kernel,channelNum,convLayerID):
    kernelBuff=np.zeros((5,5))
    for i in range (0,channelNum):
        kernelBuff=np.loadtxt('convLayer'+str(convLayerID)
                                            +'_kernel_'+str(i))
        kernel[0,i,:,:]=kernelBuff
    return kernel


img_in_folder = "../../../image/test/"
img_in_name = "test1.ppm"
#img_out_folder = "../../image/test/"
#img_out_name = "img_test_2_out.ppm"

#kernel_test = np.loadtxt('convLayer1_kernel_0')

kernel_test=np.zeros((1,16,5,5))

kernel_test=initKernel(kernel_test,5,1)

print(kernel_test)

while 1:
    toto=1

imgIn = imgOp.imgOpen(img_in_folder,img_in_name)
imgIn_info = imgOp.getImgInfo(imgIn)
cnnInputLayerMatrix = imgOp.img2nparray(imgIn)

# Kernel parameters init process
kernel=np.zeros((1,16,5,5))

initKernel(kernel,5,1)


# First convolution layer processing (conv + pooling + relu)
cnnConv1LayerMatrix=np.zeros((cnnInputLayerMatrix.shape[0],cnnInputLayerMatrix.shape[2],1))
cnnConv1LayerMatrix=re.RELU_3D(conv.convolution_nb_kernel(cnnInputLayerMatrix,kernel))
cnnConv1LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolType='max')

# New kernel init porcess ???

kernelConvLayer2=np.zeros((1,36,5,5))

initKernel(kernelConvLayer2,5,1)

# Second convolution layer processing (conv + pooling + relu)
cnnConv2LayerMatrix=np.zeros((cnnInputLayerMatrix.shape[0],cnnInputLayerMatrix.shape[2],1))
cnnConv2LayerMatrix=re.RELU_3D(conv.convolution_nb_kernel(cnnInputLayerMatrix,kernelConvLayer2))
cnnConv2LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolType='max')


# Fully connected Layer processing
