#!/usr/python

import numpy as np
np.set_printoptions(threshold=np.inf) # to forced full print of numpy array


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



def readBiasesFromFile(fp,posInFile,matrix,channelNum):
    
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
            matrix[0,0,coeffReadCount+i]=float(lineSplit[i])
        coeffReadCount+=6
    
def readKernelChannelValueFromFile(fp,posInFile,kernel,channelNum,ImageChannelPos,
                                   kernelHeightPos,kernelWitdhPos):
    coeffReadCount=0
    #lineRead=fp.readline()
    #print(lineRead)
    print('toto=',fp.read(5))
    posInFile= fp.tell()
    while coeffReadCount < channelNum:
        
        lineRead=fp.readline()
        print(lineRead)
        posInFile=fp.tell()
        lineSplit=lineRead.strip().split()
        lineValueNum=len(lineSplit)
        if lineValueNum > 4:
            lineValueNum-=4
              
        for i in range(0,lineValueNum):
            kernel[ImageChannelPos-1,coeffReadCount+i,kernelHeightPos-1,kernelWitdhPos-1]=float(lineSplit[i])
        coeffReadCount+=4
    
def initkernelFromFile(fp,posInFile,kernel):
    ImageChannelNum=kernel.shape[0]+1
    channelNum=kernel.shape[1]
    kernelSize=kernel.shape[2]+1
    lineRead=fp.readline()
    print(lineRead)
    
    for kerHeightPos in range(1,kernelSize):
        if kerHeightPos !=1:
            print('titi',fp.readline())
        for kerWidthPos in range(1,kernelSize):
            if kerWidthPos !=1 :
                print('tata',fp.readline())
            for imgChannelPos in range(1,ImageChannelNum):
                readKernelChannelValueFromFile(fp,posInFile,kernel,channelNum,
                                               imgChannelPos,kerHeightPos,kerWidthPos)
                print('finished reading channel weight')
    


fp=open('CNN_coeff_5x5_mod.txt','r')
matrix=np.zeros((1,1,64))
kernel=np.zeros((3,64,5,5))
posInFile=0

readBiasesFromFile(fp,posInFile,matrix,64)
print(matrix)

#readKernelChannelValueFromFile(fp,posInFile,kernel,64,1,1,1)
initkernelFromFile(fp,posInFile,kernel)
print('kernel read', kernel)
