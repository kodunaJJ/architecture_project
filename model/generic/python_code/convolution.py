#!/usr/bin/python3
import numpy as np
import img_op as imgOp


def convolution_2D(image,kernel):
    print("2D")
    print(kernel)

    image_x_max=image.shape[1]
    image_y_max=image.shape[0]

    kernel_x=kernel.shape[1]
    kernel_y=kernel.shape[0]
    image_add_zero=np.zeros(( image_y_max+kernel_y-1, image_x_max+kernel_x-1))
    image_add_zero[0:image_y_max,0:image_x_max]=image

    
    calcul=np.zeros((kernel_y,kernel_x))
    new_image=np.zeros((image_y_max,image_x_max))

    for num in range(0,image_y_max):
        for num2 in range(0,image_x_max):
            calcul=kernel*image_add_zero[num:num+kernel_y,num2:num2+kernel_x]
            new_image[num,num2]=calcul.sum()
	   

    return new_image







def convolution_nb_kernel(image,kernel):
	image_x_max=image.shape[1]
	image_y_max=image.shape[0]
	nb_kernel=kernel.shape[0]
	

	new_image=np.zeros((image_y_max,image_x_max,nb_kernel))


	for num in range(0,nb_kernel):
		new_image[:,:,num]=convolution_2D(image,kernel[num,:,:])
	
	return new_image








def convolution_RGB(image,kernel):
	print("k")
	#print(image)
	#print(kernel)
	image_x_max=image.shape[1]
	image_y_max=image.shape[0]
	nb_kernel=kernel.shape[1]
	image_r=np.zeros((image_y_max,image_x_max))
	image_g=np.zeros((image_y_max,image_x_max))
	image_b=np.zeros((image_y_max,image_x_max))
	image_r=image[:,:,0]
	image_g=image[:,:,1]
	image_b=image[:,:,2]
	new_image_r=np.zeros((image_y_max,image_x_max,nb_kernel))
	new_image_g=np.zeros((image_y_max,image_x_max,nb_kernel))
	new_image_b=np.zeros((image_y_max,image_x_max,nb_kernel))

	new_image_r=convolution_nb_kernel(image_r,kernel[0,:,:,:])

	new_image_g=convolution_nb_kernel(image_g,kernel[1,:,:,:])
	new_image_b=convolution_nb_kernel(image_b,kernel[2,:,:,:])
	new_image=np.zeros((image_y_max,image_x_max,nb_kernel))
	new_image_2=np.zeros((image_y_max,image_x_max,3))
	new_image_2[:,:,0]=new_image_r[:,:,0]
	new_image_2[:,:,1]=new_image_b[:,:,0]	
	new_image_2[:,:,2]=new_image_g[:,:,0]

	print("out image")
	print(new_image_2)
	new_image[0:image_y_max,0:image_x_max,0:nb_kernel]=new_image_r[0:image_y_max,0:image_x_max,0:nb_kernel]+new_image_g[0:image_y_max,0:image_x_max,0:nb_kernel]+new_image_b[0:image_y_max,0:image_x_max,0:nb_kernel]

	return new_image

















	
	
