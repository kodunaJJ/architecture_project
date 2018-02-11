#include <iostream>
#include <fstream>
#include "weight.hpp"
#include "imgNorm.hpp"
#include "convLayer1Contant.hpp"
/*#define KERNEL_SIZE 9
#define KERNEL_SHAPE 3
#define IMG_SIZE (3*3)
#define IMG_SHAPE 3
#define IMG_CHANNEL_IN 3
#define IMG_CHANNEL_OUT 2*/


void pixelCalcREF(double kernel[KERNEL_SIZE],double imgPixels[KERNEL_SIZE],double *newPixelVal){

  static double prod=0;
  static double acc=0;

  for(int i=0;i<KERNEL_SIZE;i++){
  prod=kernel[i]*imgPixels[i];
  acc+=prod;
  }
  *newPixelVal=acc;
  acc=0;
  }

void pixelCalcREF_simple(double kernel[KERNEL_SIZE],double LineReg1[KERNEL_SHAPE],double LineReg2[KERNEL_SHAPE],
                         double LineReg3[KERNEL_SHAPE],double *newPixelVal){

  static double prod1=0;
  static double prod2=0;
  static double prod3=0;
  static double acc=0;

  for(int i=0;i<KERNEL_SHAPE;i++){
    prod1=kernel[i]*LineReg1[i];
    prod2=kernel[i+KERNEL_SHAPE]*LineReg2[i];
    prod3=kernel[i+KERNEL_SHAPE*2]*LineReg3[i];
    acc=prod1+prod2+prod3+acc;
  }
  *newPixelVal=acc;
  acc=0;
}

void convolution2D_REF(double kernel[KERNEL_SIZE],double imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)], double *imgOut,
                       bool firstChannel,bool lastChannel){

  static double imgPixel[KERNEL_SIZE];
  /*static double Line1Reg[KERNEL_SHAPE];
    static double Line2Reg[KERNEL_SHAPE];
    static double Line3Reg[KERNEL_SHAPE];*/

  static double imgConv2DOut[IMG_SIZE];
  static double newPixelVal=0;

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
        std::cout << "register bank = " << std::endl;
        for(int i=0;i<KERNEL_SIZE;i++){
          std::cout << imgPixel[i] << '\t';
        }
        std::cout << std::endl;
        pixelCalcREF(kernel, imgPixel, &newPixelVal);
        //pixelCalcREF_simple(kernel, Line1Reg,Line2Reg,Line3Reg,&newPixelVal);
        /* where to store data */
        if(firstChannel && !lastChannel){
          imgConv2DOut[row*IMG_SHAPE+column]=newPixelVal;
        }
        else if(lastChannel && !firstChannel){
          imgOut[row*IMG_SHAPE+column]=imgConv2DOut[row*IMG_SHAPE+column]+newPixelVal;
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



void convolution2D_REF_simple(double kernel[KERNEL_SIZE],double imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)], double *imgOut,
                              bool &firstChannel,bool &lastChannel,
			      double *bias){


  static double line1Reg[KERNEL_SHAPE];
  static double line2Reg[KERNEL_SHAPE];
  static double line3Reg[KERNEL_SHAPE];

  static double imgConv2DOut[IMG_SIZE];
  static double newPixelVal=0;
  static double biasSum=0;

  /* init img block buffer */


  for(int row=0; row<IMG_SHAPE;row++){

    for(int shiftIdx=0;shiftIdx<2;shiftIdx++){
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
      /*std::cout << "register bank = " << std::endl;
        for(int i=0;i<KERNEL_SHAPE;i++){
        std::cout << line2Reg[i] << '\t';
        }
        std::cout << std::endl;*/
    }

    /*std::cout << "register bank 1= " << std::endl;
          for(int i=0;i<KERNEL_SHAPE;i++){
          std::cout << line1Reg[i] << '\t';
          }
          std::cout << std::endl;
          std::cout << "register bank 2= " << std::endl;
          for(int i=0;i<KERNEL_SHAPE;i++){
          std::cout << line2Reg[i] << '\t';
          }
          std::cout << std::endl;
       std::cout << "register bank 3= " << std::endl;
        for(int i=0;i<KERNEL_SHAPE;i++){
          std::cout << line3Reg[i] << '\t';
        }
        std::cout << std::endl;*/
    for(int column = 0; column <IMG_SHAPE;column++)
      {
        /*std::cout << "register bank = " << std::endl;
          for(int i=0;i<KERNEL_SIZE;i++){
          std::cout << imgPixel[i] << '\t';
          }
          std::cout << std::endl;*/
        //pixelCalcREF(kernel, imgPixel, &newPixelVal);
        pixelCalcREF_simple(kernel, line1Reg,line2Reg,line3Reg,&newPixelVal);
        /* where to store data */
        if(firstChannel && !lastChannel){
          imgConv2DOut[row*IMG_SHAPE+column]=newPixelVal;
        }
        else if(lastChannel && !firstChannel){
	  biasSum=*bias+imgConv2DOut[row*IMG_SHAPE+column]+newPixelVal;
	  //std::cout << "px n° " << row*IMG_SHAPE+column << " bias = " << *bias << std::endl;
          //imgOut[row*IMG_SHAPE+column]=imgConv2DOut[row*IMG_SHAPE+column]+newPixelVal;
	  if(biasSum < 0){
	    biasSum = 0;
	  }
	  imgOut[row*IMG_SHAPE+column]=biasSum;
        }
        else{
          imgConv2DOut[row*IMG_SHAPE+column]+=newPixelVal;
        }

        /* prepare next iteration */
	if(column <(IMG_SHAPE-1)){
        for(int idx=0;idx<KERNEL_SHAPE;idx++){
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
        /*std::cout << "register bank 1= " << std::endl;
          for(int i=0;i<KERNEL_SHAPE;i++){
          std::cout << line1Reg[i] << '\t';
          }
          std::cout << std::endl;
          std::cout << "register bank 2= " << std::endl;
          for(int i=0;i<KERNEL_SHAPE;i++){
          std::cout << line2Reg[i] << '\t';
          }
          std::cout << std::endl;*/
        /*std::cout << "register bank 3= " << std::endl;
        for(int i=0;i<KERNEL_SHAPE;i++){
          std::cout << line3Reg[i] << '\t';
        }
        std::cout << std::endl;*/

      }
  }
  /*for(int i=0;i<IMG_SIZE;i++){
    std::cout<<"img2DOut = " << imgConv2DOut[i] << " px n° " << i << std::endl;
  }*/
}



void convolution3D_REF(double kernel[KERNEL_SIZE*IMG_CHANNEL_IN*IMG_CHANNEL_OUT],
                       double imgIn[IMG_SIZE*IMG_CHANNEL_IN],double imgOut[IMG_SIZE*IMG_CHANNEL_OUT],
		       double bias[IMG_CHANNEL_OUT]){

  static double kernel2D[KERNEL_SIZE];
  static double imgPadded[(IMG_SHAPE+2)*(IMG_SHAPE+2)];
  static bool firstChannel=true;
  static bool lastChannel=false;


  for(int channelOutPos=0;channelOutPos<IMG_CHANNEL_OUT;channelOutPos++){
    for(int channelInPos=0;channelInPos<IMG_CHANNEL_IN;channelInPos++){
      /* fill padded image */ /*padding image OK */
      for(int row=0;row<(IMG_SHAPE+2);row++){
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
          //std::cout<<"imgPadded px n° " << row << ' ' << column << "= " << imgPadded[row*(IMG_SHAPE+2)+column]<< std::endl;
        }

      }
      /*for(int i=0;i<(IMG_SHAPE+2)*(IMG_SHAPE+2);i++){
        std::cout<<"imgPadded px n° " <<i << "= " << imgPadded[i]<< std::endl;
        }*/
      /* fill kernel2D */ /* copy seems OK */
      for(int i=0;i<KERNEL_SIZE;i++){
        kernel2D[i]=kernel[channelOutPos*IMG_CHANNEL_IN*KERNEL_SIZE+channelInPos*KERNEL_SIZE+i];
        //std::cout << " kernel n° " << channelOutPos << ','<< channelInPos << ": " << kernel2D[i] <<std::endl;
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
      //convolution2D_REF(kernel2D, imgPadded, imgOut+channelOutPos*IMG_SIZE, firstChannel,lastChannel);
      convolution2D_REF_simple(kernel2D, imgPadded, imgOut+channelOutPos*IMG_SIZE, firstChannel,lastChannel,
			       bias+channelOutPos);
    }
  }
}
