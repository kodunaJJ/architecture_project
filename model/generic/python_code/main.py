#! /usr/bin/python3.5


# cnn algorithm implementation


import img_op as imgOp
import convolution as conv
import numpy as np
import RELU as re

img_in_folder = "../../image/test/"
img_in_name = "test1.ppm"
#img_out_folder = "../image/test/"
#img_out_name = "img_test_2_out.ppm"

##img_out_folder = "../image/test/"
##img_out_name = "img_test_2_out.ppm"


imgIn = imgOp.imgOpen(img_in_folder,img_in_name)

imgIn_info = imgOp.getImgInfo(imgIn)

cnnLayer1Matrix = imgOp.img2nparray(imgIn)

cnnLayer = imgOp.img2nparray(cnnLayer1Matrix)
print(cnnLayer1Matrix[0,0,:])
print(imgIn_info)
print (cnnLayer[0][0])

kernel=np.zeros((1,3,3,3))

#garder que le rouge
kernel[0,0]=np.array([1,-5,1,7,-8,0,0,0,0]).reshape(3,3)
kernel[0,1]=np.array([1,0,0,0,0,-8,0,0,0]).reshape(3,3)
kernel[0,2]=np.array([1,0,0,7,0,0,0,0,0]).reshape(3,3)

#garder que le vert
#kernel[1,1]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)
#kernel[1,0]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)
#kernel[1,2]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)

#garder que le bleu
#kernel[2,2]=np.array([0.11,0.11,0.11,0.11,0.11,0.11,0.11,0.11,0.11]).reshape(3,3)
#kernel[2,1]=[0,0,0,0,0,0,0,0,0]
#kernel[2,0]=[0,0,0,0,0,0,0,0,0]

#print(kernel[0])
#kernel=np.array([1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0]).reshape(2,3,3,3)


new_image=np.zeros((cnnLayer1Matrix.shape[0],cnnLayer1Matrix.shape[2],1))
new_image=re.RELU_3D(conv.convolution_nb_kernel(cnnLayer1Matrix,kernel))



print("before relu")
print(conv.convolution_nb_kernel(cnnLayer1Matrix,kernel))
print("after relu")
print(new_image)


print("test_image")
print(cnnLayer1Matrix)

#print(new_image)


#imgOp.imgSave(cnnLayer1Matrix,'RGB',img_out_folder,img_out_name)
