#! /usr/bin/python3.5


# cnn algorithm implementation


import img_op as imgOp
import numpy as np

img_in_folder = "../../image/test/"
img_in_name = "img_test_1_out.ppm"

img_out_folder = "../../image/test/"
img_out_name = "img_test_1_out.ppm"


imgIn = imgOp.imgOpen(img_in_folder,img_in_name)

imgIn_info = imgOp.getImgInfo(imgIn)

cnnLayer1Matrix = imgOp.img2nparray(imgIn)

cnnLayer = imgOp.img2nparray(cnnLayer1Matrix)
print(cnnLayer1Matrix[0][0])
print(imgIn_info)
print (cnnLayer[0][0])

imgOp.imgSave(cnnLayer,'RGB',img_out_folder,img_out_name)
