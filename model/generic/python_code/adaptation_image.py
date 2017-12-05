#!/usr/bin/python3
import numpy as np
import math
import img_op as imgOp


def adapatation_imag(image):
	imag_y_max=image.shape[0]
	imag_x_max=image.shape[1]
	imag_NB_pixel=image.shape[2]
	u=np.zeros((imag_NB_pixel))	
	sigma=np.zeros((imag_NB_pixel))
	carre=np.zeros((imag_x_max*imag_y_max))
	new_image=np.zeros((imag_y_max,imag_x_max,imag_NB_pixel))
	new_image_out=np.zeros((24,24,imag_NB_pixel))
	for num in range (0,imag_NB_pixel):
		u[num]=(image[:,:,num].sum())/(imag_x_max*imag_y_max)

		for num2 in range(0,imag_y_max):
			for num3 in range(0,imag_x_max):
				carre[num2*imag_x_max+num3]=math.pow(image[num2,num3,num]-u[num],2)
		sigma[num]=math.sqrt((carre.sum())/(imag_x_max*imag_y_max))
		
		for y in range(0,imag_y_max):
			for x in range(0,imag_x_max):
				if sigma[num] > (1/math.sqrt(imag_x_max*imag_y_max)):
					new_image[y,x,num]=((image[y,x,num]-u[num])/sigma[num])
				else:
						new_image[y,x,num]=(image[y,x,num]-u[num])/(1/math.sqrt(imag_x_max*imag_y_max))
				
		

	n=int((imag_y_max-24)/2)
	new_image_out=new_image[n-1:24+(n-1),n-1:24+(n-1),:]
	return new_image_out





				
