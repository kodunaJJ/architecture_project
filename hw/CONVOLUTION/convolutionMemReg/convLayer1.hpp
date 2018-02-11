#ifndef _CONVLAYER1_HPP_
#define _CONVLAYER1_HPP_

#include "convLayer1Contant.hpp"
#include "cnn_datatype.hpp"


void pixelCalcREF(double kernel[KERNEL_SIZE],double imgPixels[KERNEL_SIZE],
		  double *newPixelVal);

void pixelCalcREF_simple(double kernel[KERNEL_SIZE],
			 double LineReg1[KERNEL_SHAPE],
			 double LineReg2[KERNEL_SHAPE],
                         double LineReg3[KERNEL_SHAPE],double *newPixelVal);

void convolution2D_REF(double kernel[KERNEL_SIZE],
		       double imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)],
		       double *imgOut,bool firstChannel,bool lastChannel);

void convolution2D_REF_simple(double kernel[KERNEL_SIZE],
			      double imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)],
			      double *imgOut,bool &firstChannel,
			      bool &lastChannel,double *bias);


void convolution3D_REF(double kernel[KERNEL_SIZE*IMG_CHANNEL_IN*IMG_CHANNEL_OUT],
                       double imgIn[IMG_SIZE*IMG_CHANNEL_IN],
		       double imgOut[IMG_SIZE*IMG_CHANNEL_OUT],
		       double bias[IMG_CHANNEL_OUT]);



void pixelCalcHW(kernelLayer1_weightDataType kernel[KERNEL_SIZE],
		 imageNorm_dataType imgPixels[KERNEL_SIZE],
		 conv2DLayer1InternSum_dataType *newPixelVal);

void pixelCalcHW_simple(kernelLayer1_weightDataType kernel[KERNEL_SIZE],
			imageNorm_dataType LineReg1[KERNEL_SHAPE],
			imageNorm_dataType LineReg2[KERNEL_SHAPE],
			imageNorm_dataType LineReg3[KERNEL_SHAPE],
			conv2DLayer1InternSum_dataType *newPixelVal);


void convolution2D_HW(kernelLayer1_weightDataType kernel[KERNEL_SIZE],
		      imageNorm_dataType imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)],
		      convLayer1Out_dataType*imgOut,bool firstChannel,bool lastChannel);


void convolution2D_HW_simple(kernelLayer1_weightDataType kernel[KERNEL_SIZE],
			     imageNorm_dataType imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)],convLayer1Out_dataType *imgOut,
			     bool &firstChannel,bool &lastChannel, biasLayer1_weightDataType *bias);

void convolution3D_HW(kernelLayer1_weightDataType kernel[KERNEL_SIZE*IMG_CHANNEL_IN*IMG_CHANNEL_OUT],imageNorm_dataType imgIn[IMG_SIZE*IMG_CHANNEL_IN],
		      convLayer1Out_dataType imgOut[IMG_SIZE*IMG_CHANNEL_OUT],
		      biasLayer1_weightDataType bias[IMG_CHANNEL_OUT]);

#endif
