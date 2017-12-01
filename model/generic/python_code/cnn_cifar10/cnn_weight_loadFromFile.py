#!/usr/python


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
