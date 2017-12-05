#!/usr/bin/python3
import numpy as np
import img_op as imgOp

def add_bias(image,bias):
	img_y_max=image.shape[0]
	img_x_max=image.shape[1]
	img_nb_canal=image.shape[2]
	new_image=np.zeros((img_y_max,img_x_max,img_nb_canal))

	for num1 in range (0,img_nb_canal):
		new_image[:,:,num1]=bias[num1]+image[:,:,num1]
				

	return new_image






