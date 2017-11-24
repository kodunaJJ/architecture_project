#! /usr/bin/python3.5


# cnn algorithm implementation


import img_op as imgOp
import convolution as conv
import numpy as np
import RELU as re
import pooling_op as pool
import reshape as resha
import matrix_multiply as multi
import time


img_in_folder = "../../image/test/"
img_in_name = "img_test_1.ppm"



imgIn = imgOp.imgOpen(img_in_folder,img_in_name)

imgIn_info = imgOp.getImgInfo(imgIn)

cnnLayer1Matrix = imgOp.img2nparray(imgIn)

cnnLayer = imgOp.img2nparray(cnnLayer1Matrix)
#print(cnnLayer1Matrix[0,0,:])
#print(imgIn_info)
#print (cnnLayer[0][0])


kernel=np.arange(1728).reshape(3,64,3,3)
kernel2=np.arange(9).reshape(1,3,3)

#garder que le rouge
#kernel[0,0]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)
#kernel[1,0]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)
#kernel[2,0]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)


print("start")
print(time.localtime())
new_image=np.zeros((cnnLayer1Matrix.shape[0],cnnLayer1Matrix.shape[2],1))
new_image=re.RELU_3D(conv.convolution_RGB(cnnLayer1Matrix,kernel))

new_image2=pool.pooling(new_image,4,4,'max')

new_image5=re.RELU_3D(conv.convolution_nb_kernel(new_image2,kernel2))
new_image6=pool.pooling(new_image5,4,4,'max')
new_image3=resha.reshape(new_image2)
b=np.zeros((1,1000))
new_image4=multi.matrixMult(new_image3,b)
print("end")
print(time.localtime())



#print("input image")
#print(cnnLayer1Matrix)

#print("somme")
#print(new_image)
#print(new_image.shape)


#print("test")
#print(test_image)
#print(test_image.shape)

#print("max pooling 2")

#print(new_image2)
#print(new_image2.shape)



#print("reshape")

#print(new_image3)
#print(new_image3.shape)


#print("multi")

#print(new_image4)
#print(new_image4.shape)



#imgOp.imgSave(cnnLayer1Matrix,'RGB',img_out_folder,img_out_name)
