#! /usr/bin/python3.5


# cnn algorithm implementation


import img_op as imgOp
import convolution as conv
import numpy as np

img_in_folder = "../image/test/"
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
kernel[0,0]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)
kernel[0,1]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)
kernel[0,2]=np.array([1,0,0,0,0,0,0,0,0]).reshape(3,3)

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


new_image=np.zeros((cnnLayer1Matrix.shape[0],cnnLayer1Matrix.shape[2],2))
new_image=conv.convolution_nb_kernel(cnnLayer1Matrix,kernel)






if(np.array_equal(new_image[0,0,:],cnnLayer1Matrix[0,0,:])):
	print("egale")
else:
	print("not egale")


print("test_image")
print(cnnLayer1Matrix)

#print(new_image)


#imgOp.imgSave(cnnLayer1Matrix,'RGB',img_out_folder,img_out_name)
