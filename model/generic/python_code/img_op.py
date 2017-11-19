#!/usr/bin/python3.5

from PIL import Image
import numpy as np

# Function to open an image file 
def imgOpen(imgFolderPath, imgName):
    print("Opening image %s from %s"%(imgName,imgFolderPath))
    return Image.open(imgFolderPath+imgName)


# Function to write an image from a numpy 3-D array
def imgSave(matrix, colorFormat, imgFolderPath, imgName):
    print("Saving image %s to %s"%(imgName,imgFolderPath))
    img_out = Image.fromarray(matrix,colorFormat)
    img_out.save(imgFolderPath+imgName)

# Function to create a numpy matrix (3-D) from an image file
def img2nparray(img):
    return np.array(img)

# Function to get some image info (width / height)
def getImgInfo(img):
    return (img.size[0],img.size[1])
    
    


    
    
