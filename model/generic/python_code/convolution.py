#!/usr/bin/python3
import numpy as np
import img_op as imgOp


def convolution_2D(image,kernel):
    #print(image)
    #print(kernel)
    image_x_max=image.shape[1]
    image_y_max=image.shape[0]
    ##print("x=",image_x_max)
    ##print("y=",image_y_max)
    kernel_x=kernel.shape[1]
    kernel_y=kernel.shape[0]
    image_add_zero=np.zeros(( image_y_max+kernel_y-1, image_x_max+kernel_x-1))
    image_add_zero[0:image_y_max,0:image_x_max]=image
    #print(image_add_zero)
    
    calcul=np.zeros((kernel_y,kernel_x))
    new_image=np.zeros((image_y_max,image_x_max))

    for num in range(0,image_y_max):
        for num2 in range(0,image_x_max):
            calcul=kernel*image_add_zero[num:num+kernel_y,num2:num2+kernel_x]
	    #print("sum is",calcul.sum(),"num=",num,"num2=",num2)
            new_image[num,num2]=calcul.sum()
	   

    #print(new_image)
    return new_image



def convolution_rgb(image,kernel):
	#image=np.arange(45).reshape(3,5,3)
	#kernel=np.array([1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0]).reshape(3,3,3)

	#print(kernel)
	#print("icic")
	#print(image)
	#img_out_folder = "../image/test/"
	#img_out_name = "img_test_2_out.ppm"
	image_x_max=image.shape[1]
	image_y_max=image.shape[0]
	image_r=np.zeros((image_y_max,image_x_max))
	image_g=np.zeros((image_y_max,image_x_max))
	image_b=np.zeros((image_y_max,image_x_max))
	image_r=image[:,:,0]
	image_g=image[:,:,1]
	image_b=image[:,:,2]
		#print(image_r)
		#print(image_g)
		#print(image_b)
		#convolution_rgb(image,kernel)
	new_image_r=np.zeros((image_y_max,image_x_max))
	new_image_g=np.zeros((image_y_max,image_x_max))
	new_image_b=np.zeros((image_y_max,image_x_max))
	new_image_r=convolution_2D(image_r,kernel[0,:,:])
	new_image_g=convolution_2D(image_g,kernel[1,:,:])
	new_image_b=convolution_2D(image_b,kernel[2,:,:])
	#new_image_2=np.zeros((image_y_max,image_x_max,3))
	#new_image_2[:,:,0]=new_image_r
	#new_image_2[:,:,1]=new_image_g
	#new_image_2[:,:,2]=new_image_b
	#print("new")
	#print(new_image_2)
	#imgOp.imgSave(new_image_2,'RGB',img_out_folder,img_out_name)
	new_image=np.zeros((image_y_max,image_x_max))

	new_image[0:image_y_max,0:image_x_max]=new_image_r[0:image_y_max,0:image_x_max]+new_image_g[0:image_y_max,0:image_x_max]+new_image_b[0:image_y_max,0:image_x_max]

	return new_image








def convolution_nb_kernel(image,kernel):


	image_x_max=image.shape[1]
	image_y_max=image.shape[0]
	nb_kernel=kernel.shape[0]
	print(nb_kernel)
	new_image=np.zeros((image_y_max,image_x_max,nb_kernel))


	for num in range(0,nb_kernel):
		new_image[:,:,num]=convolution_rgb(image[:,:,:],kernel[num,:,:,:])

	return new_image















	
	
