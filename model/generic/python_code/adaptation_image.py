#!/usr/bin/python3
import numpy as np
import math
import img_op as imgOp


"""
FOR DEBUG

"""
def normalize(image):
    #print('ImageIn px 1',image[0,0,0])
    image = image[4:28,4:28,:]
    mean = float(np.sum(image))/1728
    #print('meanSum',np.sum(image))
    #print('sigmaSum',np.sum(np.power((image - mean), 2)))
    variance = math.sqrt(np.sum(np.power((image - mean), 2))/1728)
    normalized_image = (image - mean)/max(variance, 1/math.sqrt(1728))
    #print(normalized_image)
    #print('mean',mean)
    #print('sigma',variance)
     
    return np.clip(normalized_image,-3,3) 


def adapatation_imag(image):
	imag_y_max=image.shape[0]
	imag_x_max=image.shape[1]
	imag_NB_pixel=image.shape[2]
	#u=np.zeros((imag_NB_pixel))	
	#sigma=np.zeros((imag_NB_pixel))
	carre=np.zeros((imag_x_max*imag_y_max,imag_NB_pixel))
	new_image=np.zeros((imag_y_max,imag_x_max,imag_NB_pixel))
	new_image_out=np.zeros((24,24,imag_NB_pixel))
	u=(image[:,:,:].sum())/(imag_x_max*imag_y_max*imag_NB_pixel)
	for num in range (0,imag_NB_pixel):
		

		for num2 in range(0,imag_y_max):
			for num3 in range(0,imag_x_max):
				carre[num2*imag_x_max+num3,num]=math.pow(image[num2,num3,num]-u,2)
	sigma=math.sqrt((carre.sum())/(imag_x_max*imag_y_max*imag_NB_pixel))
	
	for num in range (0,imag_NB_pixel):	
		for y in range(0,imag_y_max):
			for x in range(0,imag_x_max):
				if sigma > (1/math.sqrt(imag_x_max*imag_y_max*imag_NB_pixel)):
					if((image[y,x,num]-u)/sigma)>1:
						new_image[y,x,num]=1
					elif((image[y,x,num]-u)/sigma)<-1:
						new_image[y,x,num]=-1
					else:
						new_image[y,x,num]=((image[y,x,num]-u)/sigma)
				
				else:
                                
					if(image[y,x,num]-u)/(1/math.sqrt(imag_x_max*imag_y_max*imag_NB_pixel))>1:
						new_image[y,x,num]=1
					elif(image[y,x,num]-u)/(1/math.sqrt(imag_x_max*imag_y_max*imag_NB_pixel))<-1:
						new_image[y,x,num]=-1
					else:
						new_image[y,x,num]=(image[y,x,num]-u)/(1/math.sqrt(imag_x_max*imag_y_max*imag_NB_pixel))
				        
                                        #new_image[y,x,num]=(image[y,x,num]-u)/(1/math.sqrt(imag_x_max*imag_y_max))*100
		

	#n=int((imag_y_max-24)/2)
	#new_image_out=new_image[n-1:24+(n-1),n-1:24+(n-1),:]
        new_image_out=new_image[:,:,:]
	return new_image_out










				
