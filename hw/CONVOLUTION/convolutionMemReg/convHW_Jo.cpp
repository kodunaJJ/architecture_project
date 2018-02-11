#include <iostream>
#include <fstream>
#include "cnn_datatype.hpp"
#include "convLayer1Contant.hpp"
/*
  #define KERNEL_SIZE 9
  #define KERNEL_SHAPE 3
  #define IMG_SIZE (3*3)
  #define IMG_SHAPE 3
  #define IMG_CHANNEL_IN 3
  #define IMG_CHANNEL_OUT 2
*/

void pixelCalcHW(kernelLayer1_weightDataType kernel[KERNEL_SIZE],imageNorm_dataType imgPixels[KERNEL_SIZE],conv2DLayer1InternSum_dataType *newPixelVal){

  static convLayer1InternProd_dataType prod=0;
  static conv2DLayer1InternSum_dataType acc=0;

  for(int i=0;i<KERNEL_SIZE;i++){
    prod=kernel[i]*imgPixels[i];
    acc+=prod;
  }
  *newPixelVal=acc;
  acc=0;
}

void pixelCalcHW_simple(kernelLayer1_weightDataType kernel[KERNEL_SIZE],imageNorm_dataType LineReg1[KERNEL_SHAPE],imageNorm_dataType LineReg2[KERNEL_SHAPE],
                        imageNorm_dataType LineReg3[KERNEL_SHAPE],conv2DLayer1InternSum_dataType *newPixelVal){

  static convLayer1InternProd_dataType prod1=0;
  static convLayer1InternProd_dataType prod2=0;
  static convLayer1InternProd_dataType prod3=0;
  static conv2DLayer1InternSum_dataType acc=0;

  for(int i=0;i<KERNEL_SHAPE;i++){
    prod1=kernel[i]*LineReg1[i];
    prod2=kernel[i+KERNEL_SHAPE]*LineReg2[i];
    prod3=kernel[i+KERNEL_SHAPE*2]*LineReg3[i];
    acc=prod1+prod2+prod3+acc;
  }
  *newPixelVal=acc;
  acc=0;
}

void convolution2D_HW(kernelLayer1_weightDataType kernel[KERNEL_SIZE],imageNorm_dataType imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)],
                      convLayer1Out_dataType*imgOut,bool firstChannel,bool lastChannel){

  static imageNorm_dataType imgPixel[KERNEL_SIZE];
  static convLayer1InternOut_dataType imgConv2DOut[IMG_SIZE];
  static conv2DLayer1InternSum_dataType newPixelVal=0;

  /* init img block buffer */


  for(int row=0; row<IMG_SHAPE;row++){

    for(int blockNum=0;blockNum<3;blockNum++){
      /* shift reg by 2 */
      for(int shiftIdx=0;shiftIdx<2;shiftIdx++){
        for(int blockPos=0;blockPos<3;blockPos++){
          if(blockPos==2){
            imgPixel[blockNum*KERNEL_SHAPE+blockPos]=imgPadded[(row+blockNum)*(IMG_SHAPE+2)+shiftIdx+1];
          }
          else{
            imgPixel[blockNum*KERNEL_SHAPE+blockPos]=imgPixel[blockNum*KERNEL_SHAPE+blockPos+1];
          }

        }
      }

    }

    for(int column = 0; column <IMG_SHAPE;column++)
      {

        pixelCalcHW(kernel, imgPixel, &newPixelVal);
        //pixelCalcHW_simple(kernel, Line1Reg,Line2Reg,Line3Reg,&newPixelVal);
        /* where to store data */
        if(firstChannel && !lastChannel){
          imgConv2DOut[row*IMG_SHAPE+column]=newPixelVal;
        }
        else if(lastChannel && !firstChannel){
          imgOut[row*IMG_SHAPE+column]=imgConv2DOut[row*IMG_SHAPE+column]+newPixelVal;
          // add bias and RELU here
        }
        else{
          imgConv2DOut[row*IMG_SHAPE+column]+=newPixelVal;
        }

        /* prepare next iteration */
        if(column < (IMG_SHAPE-1)){
          for(int blockNum=0;blockNum<3;blockNum++){
            /* shift reg by 1 */
            for(int blockPos=0;blockPos<3;blockPos++){
              if(blockPos==2){
                imgPixel[blockNum*KERNEL_SHAPE+blockPos]=imgPadded[(row+blockNum)*(IMG_SHAPE+2)+column+3];
              }
              else{
                imgPixel[blockNum*KERNEL_SHAPE+blockPos]=imgPixel[blockNum*KERNEL_SHAPE+blockPos+1];
              }
            }
          }
        }
      }
  }
}



void convolution2D_HW_simple(kernelLayer1_weightDataType kernel[KERNEL_SIZE],
                             imageNorm_dataType imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)],
                             convLayer1Out_dataType *imgOut,
                             bool &firstChannel,bool &lastChannel,
			     biasLayer1_weightDataType *bias){


  static imageNorm_dataType line1Reg[KERNEL_SHAPE];
  static imageNorm_dataType line2Reg[KERNEL_SHAPE];
  static imageNorm_dataType line3Reg[KERNEL_SHAPE];

  static convLayer1InternOut_dataType imgConv2DOut[IMG_SIZE];
  static conv2DLayer1InternSum_dataType newPixelVal=0;
  static convLayer1InternOut_dataType biasSum=0;

  /* init img block buffer */


  CONV2D_MAIN_LOOP:for(int row=0; row<IMG_SHAPE;row++){

    SHIFT_REG_NEW_LINE_MAIN:for(int shiftIdx=0;shiftIdx<2;shiftIdx++){
      for(int idx=0;idx<KERNEL_SHAPE;idx++){
        if(idx==2){
          line1Reg[idx]=imgPadded[(row)*(IMG_SHAPE+2)+shiftIdx+1];
          line2Reg[idx]=imgPadded[(row+1)*(IMG_SHAPE+2)+shiftIdx+1];
          line3Reg[idx]=imgPadded[(row+2)*(IMG_SHAPE+2)+shiftIdx+1];
        }
        else{
          line1Reg[idx]=line1Reg[idx+1];
          line2Reg[idx]=line2Reg[idx+1];
          line3Reg[idx]=line3Reg[idx+1];
        }
      }
    }

    CONV2D_COLUMN_LOOP:for(int column = 0; column <IMG_SHAPE;column++)
      {
        //pixelCalcHW(kernel, imgPixel, &newPixelVal);
        pixelCalcHW_simple(kernel, line1Reg,line2Reg,line3Reg,&newPixelVal);
        /* where to store data */
        if(firstChannel && !lastChannel){
          imgConv2DOut[row*IMG_SHAPE+column]=newPixelVal;
        }
        else if(lastChannel && !firstChannel){
	  biasSum=*bias+imgConv2DOut[row*IMG_SHAPE+column]+newPixelVal;
       
	  if(biasSum < 0){
	    biasSum = 0;
	  }
	  imgOut[row*IMG_SHAPE+column]=(convLayer1Out_dataType)biasSum;
	  //imgOut[row*IMG_SHAPE+column]=imgConv2DOut[row*IMG_SHAPE+column]+newPixelVal;
         
        }
        else{
          imgConv2DOut[row*IMG_SHAPE+column]+=newPixelVal;
        }

        /* prepare next iteration */
        if(column < (IMG_SHAPE-1)){
           SHIFT_REG_NEW_PIXEL_MAIN:for(int idx=0;idx<KERNEL_SHAPE;idx++){
            if(idx==2){
              line1Reg[idx]=imgPadded[(row)*(IMG_SHAPE+2)+3+column];
              line2Reg[idx]=imgPadded[(row+1)*(IMG_SHAPE+2)+3+column];
              line3Reg[idx]=imgPadded[(row+2)*(IMG_SHAPE+2)+3+column];
            }
            else{
              line1Reg[idx]=line1Reg[idx+1];
              line2Reg[idx]=line2Reg[idx+1];
              line3Reg[idx]=line3Reg[idx+1];
            }
          }
        }
      }
  }
}


#pragma hls_design top
void convolution3D_HW(kernelLayer1_weightDataType kernel[KERNEL_SIZE*IMG_CHANNEL_IN*IMG_CHANNEL_OUT],
                      imageNorm_dataType imgIn[IMG_SIZE*IMG_CHANNEL_IN],
                      convLayer1Out_dataType imgOut[IMG_SIZE*IMG_CHANNEL_OUT],
		      biasLayer1_weightDataType bias[IMG_CHANNEL_OUT]){

  static kernelLayer1_weightDataType kernel2D[KERNEL_SIZE];
  static imageNorm_dataType imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)];
  static bool firstChannel=true;
  static bool lastChannel=false;


  CONV3D_MAIN_LOOP:for(int channelOutPos=0;channelOutPos<IMG_CHANNEL_OUT;channelOutPos++){
     CONV3D_CHANNEL_IN_LOOP:for(int channelInPos=0;channelInPos<IMG_CHANNEL_IN;channelInPos++){
      /* fill padded image */ /*padding image OK */
       FILL_PADDED_IMG_MAIN_LOOP:for(int row=0;row<(IMG_SHAPE+2);row++){
        for(int column=0;column<(IMG_SHAPE+2);column++){
          if( (row==0) || (row==IMG_SHAPE+1)){
            imgPadded[row*(IMG_SHAPE+2)+column]=0;
          }
          else if((column==0) || (column==IMG_SHAPE+1)){
            imgPadded[row*(IMG_SHAPE+2)+column]=0;
          }
          else{
            imgPadded[row*(IMG_SHAPE+2)+column]=imgIn[channelInPos*IMG_SIZE+(row-1)*IMG_SHAPE+(column-1)];
          }
        }

      }

      /* fill kernel2D */ /* copy seems OK */
      FILL_KERNEL_LOOP:for(int i=0;i<KERNEL_SIZE;i++){
        kernel2D[i]=kernel[channelOutPos*IMG_CHANNEL_IN*KERNEL_SIZE+channelInPos*KERNEL_SIZE+i];
      }

      /* first & last channel signal generation */
      if(channelInPos==0){
        firstChannel=true;
        lastChannel=false;
      }
      else if(channelInPos==IMG_CHANNEL_IN-1){
        lastChannel=true;
        firstChannel=false;
      }
      else{
        firstChannel=false;
        lastChannel=false;
      }
      //convolution2D_HW(kernel2D, imgPadded, imgOut+channelOutPos*IMG_SIZE, firstChannel,lastChannel);
      convolution2D_HW_simple(kernel2D, imgPadded, imgOut+channelOutPos*IMG_SIZE, firstChannel,lastChannel,bias+channelOutPos);
    }
  }
}
