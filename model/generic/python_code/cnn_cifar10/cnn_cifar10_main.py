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
import time

def accuracy(imgClassPredicted,imgReadClass,goodPredictionNum,totalImageRead):
    if imgClassPredicted == imgReadClass:
        goodPredictionNum+=1
    
    accuracy=float((goodPredictionNum))/float(totalImageRead)*100.0
    return accuracy,goodPredictionNum
    

#********************* ALGORITHM PARAMETERS*************************#

cifar10_DatabasePath = "../../../../../../image_database/cifar10/cifar-10-batches-py/"
cifar10_DatabaseFileName="test_batch"

imgClassPredicted=0
imgReadClass=0
goodPredictionNum=0
totalImgRead=0
totalImg=50
accuracyCalc=(0,0)

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
poolingPos='true' #before RELU (true) or not

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
""""
for channel in range(0,64):
    for imgChannel in range(0,3):
        for row in range(0,kernelConvSize):
            for column in range(0,kernelConvSize):
                print(kernelConvLayer1[row,column,imgChannel,channel])
"""

##########saving xeight to txt file
kernelSave=np.zeros(3*3*3*64)
idx=0
for channel in range(0,64):
    for imgChannel in range(0,3):
        for row in range(0,kernelConvSize):
            for column in range(0,kernelConvSize):
                kernelSave[idx]=kernelConvLayer1[row,column,imgChannel,channel]
                idx+=1
#np.savetxt('./weightDataFile/kernelConvLayer1.txt', kernelSave,fmt='%1.13f', delimiter=',',newline=',')
#np.savetxt('./weightDataFile/biasConvLayer3.txt', biasConvLayer3.reshape(20),fmt='%1.13f', delimiter=',',newline=',')
#np.savetxt('./weightDataFile/biasFCLayer.txt', biasFClayer.reshape(10),fmt='%1.13f', delimiter=',',newline=',') 
#np.savetxt('./weightDataFile/biasConvLayer1.txt', biasConvLayer1.reshape(64),fmt='%1.13f', delimiter=',',newline=',')
#np.savetxt('./weightDataFile/biasConvLayer2.txt', biasConvLayer2.reshape(32),fmt='%1.13f', delimiter=',',newline=',')
#np.savetxt('./weightDataFile/fcVectorLayer.txt', fcVectorLayer.reshape(1800),fmt='%1.13f', delimiter=',',newline=',') 
""""
fclayerWeightSum=np.zeros((1,10))
for i in range(0,10):
    for j in range(0,180):
        fclayerWeightSum[0,i]+=fcVectorLayer[j,i]

print('fcSum = ',fclayerWeightSum)
"""
"""
idx=0
for i in range(0,20):
    for j in range (0,32):
        for k in range(0,3):
            for l in range(0,3):
                #print(kernelConvLayer3[k,l,j,i])
                print("%lf , %d" %(kernelConvLayer3[k,l,j,i], idx))
                idx+=1
"""


#print(fcVectorLayer.min(),fcVectorLayer.max())
#****************************************************************************#
#                                ALGORITHM START                             #
#****************************************************************************#
maxConvLayer1Output=np.zeros(150)
maxConvLayer2Output=np.zeros(150)
maxConvLayer3Output=np.zeros(150)
# for each image in the database

for num in range (0,totalImg):

    # reading image from database
    imgIn=cifarDb.readImgFromDatabase(db,num)
    cnnInputLayerMatrix = imgIn[0]
    imgReadClass=imgIn[1]

    #print(cnnInputLayerMatrix)

    #******************Image Normalisation*********************#
    #n=int((cnnInputLayerMatrix.shape[0]-24)/2)
    #cnnInputLayerMatrix=cnnInputLayerMatrix[n-1:24+(n-1),n-1:24+(n-1),:]
    #cnnInputLayerMatrix1=normal.adapatation_imag(cnnInputLayerMatrix)
    cnnInputLayerMatrix1=normal.normalize(cnnInputLayerMatrix)
    #print(cnnInputLayerMatrix1.min(),cnnInputLayerMatrix1.max())
    #print cnnInputLayerMatrix1
    #while 1:
        #toto=1
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

    """
    idx1=0
    for imgChannel in range(0,64):
        for row in range(0,24):
            for column in range(0,24):
                print("%f , %d" %(cnnConv1LayerMatrix[row,column,imgChannel], idx1))
                idx1+=1
     """
    
    #print('min/max convLayer1 output')
    #print(cnnConv1LayerMatrix.max())
    cnnConv1LayerMatrix=pool.pooling(cnnConv1LayerMatrix,poolingHeight,
                                     poolingWidth,poolingStride,
                                     poolingMode,poolingType,poolingPos)
    """
    idx1=0
    for imgChannel in range(0,64):
        for row in range(0,12):
            for column in range(0,12):
                print("%f , %d" %(cnnConv1LayerMatrix[row,column,imgChannel], idx1))
                idx1+=1
"""
    
    #print(cnnConv1LayerMatrix.shape)
        #cnnConv1LayerMatrix/=10
        #print(cnnConv1LayerMatrix.max())

    #************************ CONV LAYER 2 *************************#
    
    # Second convolution layer processing (conv + pooling + relu)
        #print('convLayer1 output',cnnConv1LayerMatrix.shape)
    cnnConv2LayerMatrix=re.RELU_3D(bias.add_bias(conv.convolution_RGB(cnnConv1LayerMatrix,kernelConvLayer2),biasConvLayer2[0,0,:]))
    """
    idx1=0
    for imgChannel in range(0,32):
        for row in range(0,12):
            for column in range(0,12):
                print("%f , %d" %(cnnConv2LayerMatrix[row,column,imgChannel], idx1))
                idx1+=1
    """
    #print('max convLayer2 output')
    #print(cnnConv2LayerMatrix.max())
    cnnConv2LayerMatrix=pool.pooling(cnnConv2LayerMatrix,poolingHeight,
                                     poolingWidth,poolingStride,
                                     poolingMode,poolingType,poolingPos)

    """
    idx1=0
    for imgChannel in range(0,32):
        for row in range(0,6):
            for column in range(0,6):
                print("%f , %d" %(cnnConv2LayerMatrix[row,column,imgChannel], idx1))
                idx1+=1
    """
    

	#print(cnnConv2LayerMatrix.shape)
        #cnnConv2LayerMatrix/=4000
        #print(cnnConv2LayerMatrix.max())
    #************************ CONV LAYER 3 *************************#

    # Third convolution layer processing (conv + pooling + relu)

    cnnConv3LayerMatrix=re.RELU_3D(bias.add_bias(conv.convolution_RGB(cnnConv2LayerMatrix,kernelConvLayer3),biasConvLayer3[0,0,:]))
    #print('min/max convLayer3 output')
    #print(cnnConv3LayerMatrix.max())
    """    
    idx1=0
    for imgChannel in range(0,20):
        for row in range(0,6):
            for column in range(0,6):
                print("%f , %d" %(cnnConv3LayerMatrix[row,column,imgChannel], idx1))
                idx1+=1
    """
    
    cnnConv3LayerMatrix=pool.pooling(cnnConv3LayerMatrix,poolingHeight,
                                     poolingWidth,poolingStride,
                                     poolingMode,poolingType,poolingPos)

        #cnnConv3LayerMatrix/=10
	#print(cnnConv3LayerMatrix.max())

    #************************ FULLY CONNECTED LAYER  *************************#
    
    # Fully connected Layer processing

    # layer vector(3*3*20,10)
    """
    idx1=0
    for imgChannel in range(0,20):
        for row in range(0,3):
            for column in range(0,3):
                print("%f , %d" %(cnnConv3LayerMatrix[row,column,imgChannel], idx1))
                idx1+=1
    """
    
        

    cnnConv3LayerReshape=rshape.reshape(cnnConv3LayerMatrix)
    """
    idx1=0
    for i in range(0,180):
        print("%f , %d" %(cnnConv3LayerReshape[0,i], idx1))
        #cnnConv3LayerReshape[0,i]=1
        idx1+=1
    """
    
    
    """
    cnnConv3LayerReshape[0,0]=1
    cnnConv3LayerReshape[0,1]=1
    """
	#print('FullyConnectedLayer0 (reshape) = ',cnnConv2LayerReshape)
    cnnFullyConnectedLayer=matmult.matrixMult_CHn(cnnConv3LayerReshape,fcVectorLayer)+biasFClayer[0,:]
        #print(cnnFullyConnectedLayer.max())
    #print('output vector \n',cnnFullyConnectedLayer)
    #outputVector=smax.softmax(cnnFullyConnectedLayer+biasFClayer[0,:])

    #print(outputVector, outputVector.sum())

	#print('Image label = ',imgReadClass)
        #print('Predicted class =', cnnFullyConnectedLayer.argmax())
    totalImgRead+=1
    #imgClassPredicted=cnnFullyConnectedLayer.nanargmax()
    
    imgClassPredicted=np.nanargmax(cnnFullyConnectedLayer)
    print('ImgClass = ',imgReadClass)
    print('ImgClassPredicted ',imgClassPredicted)
    #print(cnnFullyConnectedLayer)
    #print('Correct prediction Number = ',accuracyCalc[1])
    print('Algorithm results :')
    accuracyCalc = accuracy(imgClassPredicted,imgReadClass,accuracyCalc[1],totalImgRead)
    print("--> accuracy = %f (prc)" %accuracyCalc[0])
    print('--> progression = %d/%d' %(totalImgRead,totalImg))
    
    
#****************************************************************************#
#                                ALGORITHM END                               #
#****************************************************************************#
