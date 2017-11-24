#!/usr/bin/python3
import numpy as np
import img_op as imgOp


def convolution_2D(image,kernel):
    #print("2D")
   # print(kernel)
    #print(kernel.shape)
    #print(image.shape)
    image_x_max=image.shape[1]
    image_y_max=image.shape[0]

    kernel_x=kernel.shape[1]
    kernel_y=kernel.shape[0]
    image_add_zero=np.zeros(( image_y_max+kernel_y-1, image_x_max+kernel_x-1))
	
    #print(image_add_zero.shape)
    image_add_zero[0:image_y_max,0:image_x_max]=image

    
    calcul=np.zeros((kernel_y,kernel_x))
    new_image=np.zeros((image_y_max,image_x_max))

    for num in range(0,image_y_max):
        for num2 in range(0,image_x_max):
            calcul=kernel*image_add_zero[num:num+kernel_y,num2:num2+kernel_x]
            new_image[num,num2]=calcul.sum()
	   

    return new_image







def convolution_nb_kernel(image,kernel):
	#print("in convulution nb lernel")
	#print(image)
	image_x_max=image.shape[1]
	image_y_max=image.shape[0]
	nb_kernel_matrice=image.shape[2]
	nb_kernel_ker=kernel.shape[0]
	new_image=np.zeros((image_y_max,image_x_max,nb_kernel_ker*nb_kernel_matrice))

	for num in range(0,nb_kernel_ker):
		for num2 in range(0,nb_kernel_matrice):
			new_image[:,:,num*num2]=convolution_2D(image[:,:,num2],kernel[num,:,:])
	
	return new_image








def convolution_RGB(image,kernel):
	#print("k")
	#print(image)
	#print(kernel)
	image_x_max=image.shape[1]
	image_y_max=image.shape[0]
	nb_kernel=kernel.shape[1]
	image_r=np.zeros((image_y_max,image_x_max,1))
	image_g=np.zeros((image_y_max,image_x_max,1))
	image_b=np.zeros((image_y_max,image_x_max,1))
	#print(image_r[:,:].shape)
	#print(image[:,:,0].shape)
	image_r[:,:,0]=image[:,:,0]
	image_g[:,:,0]=image[:,:,1]
	image_b[:,:,0]=image[:,:,2]
	new_image_r=np.zeros((image_y_max,image_x_max,nb_kernel))
	new_image_g=np.zeros((image_y_max,image_x_max,nb_kernel))
	new_image_b=np.zeros((image_y_max,image_x_max,nb_kernel))

	new_image_r=convolution_nb_kernel(image_r,kernel[0,:,:,:])

	new_image_g=convolution_nb_kernel(image_g,kernel[1,:,:,:])
	new_image_b=convolution_nb_kernel(image_b,kernel[2,:,:,:])
	new_image=np.zeros((image_y_max,image_x_max,nb_kernel))


	new_image[0:image_y_max,0:image_x_max,0:nb_kernel]=new_image_r[0:image_y_max,0:image_x_max,0:nb_kernel]+new_image_g[0:image_y_max,0:image_x_max,0:nb_kernel]+new_image_b[0:image_y_max,0:image_x_max,0:nb_kernel]

	return new_image




#kernel2=np.arange(9).reshape(1,3,3)
#matrice=np.arange(45).reshape(3,3,5)


#out=convolution_nb_kernel(matrice,kernel2)

#print(out)













	
	
