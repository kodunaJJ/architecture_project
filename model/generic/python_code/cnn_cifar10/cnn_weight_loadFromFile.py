#!/usr/python

import numpy as np
np.set_printoptions(threshold=np.inf) # to forced full print of numpy array

"""
# Function to load filter parameters into kernel
# channelNum --> number of filter in the conv layer
# convLayerID --> number of the conv layer (first=1, second=2, ...)
def initKernel(fileName,kernel,channelNum,imageChannel):

    # Load filter value from file 3D kernel
    for i in range (0,channelNum):
            kernel[0,i,:,:]=np.loadtxt(fileName)
    # Duplicate 3D kernel for each imageChannel
    for i in range(1,imageChannel):
        kernel[i,:,:,:]=kernel[0,:,:,:]


        
# Function to load vector parameters from file
def initVector(FileName,vector,fcLayerID):
    vector[:,:]=np.loadtxt('fullyConnectedLayer'+str(fcLayerID))
"""


def readBiasesFromFile(fp,posInFile,matrix,channelNum,matrixDimension=3):
    
    coeffReadCount=0
    lineRead=fp.readline() 
    fp.read(1)
    posInFile= fp.tell()
    while coeffReadCount < channelNum:
        
        lineRead=fp.readline()
        posInFile=fp.tell()
        lineSplit=lineRead.strip().split()
        lineValueNum=len(lineSplit)
        if lineValueNum <6:
            lineValueNum-=1
              
        for i in range(0,lineValueNum):
            if matrixDimension == 3:
                matrix[0,0,coeffReadCount+i]=float(lineSplit[i])
            elif matrixDimension == 2:
                matrix[0,coeffReadCount+i]=float(lineSplit[i])
                
            else:
                print('/!\/!\/!\/!\ INVALID MATRIX DIMENSION /!\/!\/!\/!\ ')
        coeffReadCount+=6
    
def readKernelChannelValueFromFile(fp,posInFile,kernel,channelNum,ImageChannelPos,
                                   kernelHeightPos,kernelWitdhPos):
    coeffReadCount=0
    #lineRead=fp.readline()
    #print(lineRead)
    #print('toto=',fp.read(5))
    fp.read(5)
    posInFile= fp.tell()
    while coeffReadCount < channelNum:
        
        lineRead=fp.readline()
        #print(lineRead)
        posInFile=fp.tell()
        lineSplit=lineRead.strip().split()
        lineValueNum=len(lineSplit)
        if lineValueNum > 4:
            lineValueNum=4
              
        for i in range(0,lineValueNum):
            #kernel[ImageChannelPos,coeffReadCount+i,kernelHeightPos,kernelWitdhPos]=float(lineSplit[i])
            kernel[kernelHeightPos,kernelWitdhPos,ImageChannelPos,coeffReadCount+i]=float(lineSplit[i])
        coeffReadCount+=4

def readFClayerChannelValueFromFile(fp,posInFile,fcMatrix,matrixHeightPos,fcMatrixWidth):
    coeffReadCount=0
    #lineRead=fp.readline()
    #print(lineRead)
    #print('toto=',fp.read(5))
    fp.read(3)
    posInFile= fp.tell()
    while coeffReadCount < fcMatrixWidth:
        
        lineRead=fp.readline()
        #print(lineRead)
        posInFile=fp.tell()
        lineSplit=lineRead.strip().split()
        lineValueNum=len(lineSplit)
        if (lineValueNum > 2) and (coeffReadCount >=8):
            lineValueNum=2
              
        for i in range(0,lineValueNum):
            fcMatrix[matrixHeightPos,coeffReadCount+i]=float(lineSplit[i])
        coeffReadCount+=4
    
        
def initkernelFromFile(fp,posInFile,kernel):
    """
    ImageChannelNum=kernel.shape[0]
    channelNum=kernel.shape[1]
    kernelSize=kernel.shape[2]
    """
    
    ImageChannelNum=kernel.shape[2]
    channelNum=kernel.shape[3]
    kernelSize=kernel.shape[0]
    
    lineRead=fp.readline()
    #print(lineRead)
    
    for kerHeightPos in range(0,kernelSize):
        if kerHeightPos !=0:
            #print(fp.readline())
            fp.readline()
        for kerWidthPos in range(0,kernelSize):
            if kerWidthPos !=0 :
                #print('tata',fp.readline())
                fp.readline()
            for imgChannelPos in range(0,ImageChannelNum):
                readKernelChannelValueFromFile(fp,posInFile,kernel,channelNum,
                                               imgChannelPos,kerHeightPos,kerWidthPos)
                #print('finished reading channel weight')
                
def initFClayerFromFile(fp,posInFile,fcMatrix):
    
    fcMatrixWidth=fcMatrix.shape[1]
    matrixHeight=fcMatrix.shape[0]
    
    lineRead=fp.readline()
    #print(lineRead)
    
    for matrixHeightPos in range(0,matrixHeight):
        readFClayerChannelValueFromFile(fp,posInFile,fcMatrix,matrixHeightPos,fcMatrixWidth)
                #print('finished reading channel weight')

def loadWeightFromFile(fileName,kernelConvLayer1,kernelConvLayer2,kernelConvLayer3,biasConvLayer1,
                       biasConvLayer2,biasConvLayer3,fcLayerMatrix,biasfcLayer):
    fp=open(fileName,'r')
    posInFile=0
    convLayer1_ChannelNum=kernelConvLayer1.shape[3]
    convLayer2_ChannelNum=kernelConvLayer2.shape[3]
    convLayer3_ChannelNum=kernelConvLayer3.shape[3]
    fcLayerChannelNum=biasfcLayer.shape[1]
    
    # ConvLayer 1 weight loading
    print('LOADING CONVOLUTION LAYER 1 WEIGHT')
    readBiasesFromFile(fp,posInFile,biasConvLayer1,convLayer1_ChannelNum)
    initkernelFromFile(fp,posInFile,kernelConvLayer1)

    # ConvLayer 2 weight loading 
    print('LOADING CONVOLUTION LAYER 2 WEIGHT')
    readBiasesFromFile(fp,posInFile,biasConvLayer2,convLayer2_ChannelNum)
    initkernelFromFile(fp,posInFile,kernelConvLayer2)

    # ConvLayer 3 weight loading
    print('LOADING CONVOLUTION LAYER 3 WEIGHT')
    readBiasesFromFile(fp,posInFile,biasConvLayer3,convLayer3_ChannelNum)
    initkernelFromFile(fp,posInFile,kernelConvLayer3)

    # FullyConnectedLayer
    print('LOADING FULLY CONNECTED LAYER WEIGHT')
    readBiasesFromFile(fp,posInFile,biasfcLayer,fcLayerChannelNum,2)
    initFClayerFromFile(fp,posInFile,fcLayerMatrix)

    print('FINISHED LOADING WEIGHT')
