#!/usr/bin/python3
import numpy as np

def convolution(image,kernel):
    print(image)
    print(kernel)
    image_x_max=image.shape[1]
    image_y_max=image.shape[0]
    print("x=",image_x_max)
    print("y=",image_y_max)
    kernel_x=kernel.shape[1]
    kernel_y=kernel.shape[0]
    image_add_zero=np.zeros(( image_y_max+2, image_x_max+2))
    image_add_zero[1:image_y_max+1,1:image_x_max+1]=image
    print(image_add_zero)
    calcul=np.zeros((kernel_y,kernel_x))
    new_image=np.zeros((image_y_max,image_x_max))

    for num in range(0,3):
        for num2 in range(0,5):
            calcuk=kernel*image_add_zero[num:num+3,num2:num2+3]
            print("sum is",calcul.sum(),"num=",num,"num2=",num2 )
            new_image[num,num2]=calcul.sum();

    print(new_image)
    #return new_image





image=np.arange(15).reshape(3, 5)
kernel=np.array([0,0,0,0,1,0,0,0,0]).reshape(3,3)
print("icic")
convolution(image,kernel)







	
	
