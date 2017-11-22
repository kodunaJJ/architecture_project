#!/usr/bin/python3
import numpy as np


def RELU_1D(x):
	if x>0:
		return x
	else:
		return 0


def RELU_2D(image):
	image_x_max=image.shape[1]
	image_y_max=image.shape[0]
	new_image=np.zeros((image_y_max,image_x_max))


	for num in range(0,image_y_max):
        	for num2 in range(0,image_x_max):

		     
            	     new_image[num,num2]=RELU_1D(image[num,num2])

	return new_image



def RELU_3D(image):
	image_x_max=image.shape[1]
	image_y_max=image.shape[0]
	image_nb_kernel=image.shape[2]
	new_image=np.zeros((image_y_max,image_x_max,image_nb_kernel))
	for num in range(0,image_nb_kernel):
		new_image[:,:,num]=RELU_2D(image[:,:,num])

	return new_image





kernel=np.array([1,-1,0,-8,9,-9,10,-11,0,-1,11,12,13,14,15,-6,17,18]).reshape(3,3,2)#image(y,x,nb_rgb)

print(kernel)
new_image=RELU_3D(kernel)

print("new")
print(new_image)


