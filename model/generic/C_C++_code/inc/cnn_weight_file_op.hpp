#ifndef _CNN_WEIGHT_FILE_OP_HPP
#define _CNN_WEIGHT_FILE_OP_HPP


#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <stdlib.h>
#include "constant.hpp"

/*
  class cnnWeightFile{
  public:
  std::string folderPath;
  std::string fileName;

  cnnWeightFile();
  void loadWeightFile();
  ~cnnWeightFile();
  };
*/

/* FUNCTION TO READ KERNEL CHANNEL VALUE */
template <typename kernel_weightDataType>
void init_kernel_channelValue(std::ifstream &weight_fs, kernel_weightDataType *kernel,
                              unsigned char kernel_heightPos,
                              unsigned char kernel_widhtPos,
                              unsigned int kernel_channelInNumPos,
                              const unsigned char kernel_size,
                              const unsigned char kernel_channelInNum,
                              const unsigned char kernel_channel){
  int coeffReadCount=0;
  int index=0;
  char trash[6];
  std::string lineRead;
  std::string value;
  double weightRead=0;
  
  while(coeffReadCount < kernel_channel){
    weight_fs.read(trash,5);
    getline(weight_fs,lineRead);
    std::stringstream line(lineRead);
    while(line >> value){
      weightRead=strtod(value.c_str(),NULL);

      kernel[(kernel_heightPos+kernel_widhtPos+kernel_channelInNumPos)+
             (kernel_size*kernel_size*kernel_channelInNum)*
             (index)]=static_cast<kernel_weightDataType>(weightRead);
      /*if(kernel_channel==32){
	std::cout << "weight read n°" <<coeffReadCount << " = " << weightRead<< "::index = " <<index<< std::endl;

	std::cout << "heightPos" <<static_cast<int>(kernel_heightPos) << "widthPos" <<static_cast<int>(kernel_widhtPos)<< "channelInNumPos" <<static_cast<int>(kernel_channelInNumPos)<< std::endl;

      }*/
      /*std::cout << "kernel index = " <<(kernel_heightPos+kernel_widhtPos+kernel_channelInNumPos)+(kernel_size*kernel_size*kernel_channelInNum)*
             (coeffReadCount+index) << std::endl;*/
      index++;
      if(index > kernel_channel-1){
	break;
      }
    }
    coeffReadCount+=4;
  }

}

/* FUNCTION TO READ AND LOAD KERNEL WEIGHT */
template <typename kernel_weightDataType>
void init_kernel(std::ifstream &weight_fs, kernel_weightDataType *kernel,
                 const unsigned char kernel_size,
                 const unsigned char kernel_channelInNum,
                 const unsigned char kernel_channel){
  std::string trash;
  unsigned char kernelHeightPos=0;
  unsigned char kernelWidthPos=0;
  unsigned int kernelChanelInPos=0;
  unsigned char kernelSizeSq=kernel_size*kernel_size;
  getline(weight_fs,trash);

  for(kernelHeightPos=0;kernelHeightPos < kernelSizeSq;kernelHeightPos+=5){
    if(kernelHeightPos !=0){
      getline(weight_fs,trash);
    }
    for(kernelWidthPos=0;kernelWidthPos < kernel_size;kernelWidthPos++){
          if(kernelWidthPos !=0){
      getline(weight_fs,trash);
    }
	  for(kernelChanelInPos=0;kernelChanelInPos<kernel_channelInNum*kernelSizeSq;
	      kernelChanelInPos+=kernelSizeSq){
	    init_kernel_channelValue(weight_fs, kernel, kernelHeightPos,
				     kernelWidthPos, kernelChanelInPos,
				     kernel_size, kernel_channelInNum,
				     kernel_channel);
	  }
	  
    }
    
    
  }
}

/* FUNCTION TO READ BIAS LAYER WEIGHT */
template <typename bias_weightDataType>
void init_bias(std::ifstream &weight_fs, bias_weightDataType *bias,
               const unsigned char bias_size){
  int coeffReadCount=0;
  int index=0;
  char trash=0;
  std::string lineRead;
  std::string value;
  std::string trashLine;
  double weightRead=0;
  getline(weight_fs,trashLine);
  weight_fs.read(&trash,1);

  while(coeffReadCount<bias_size){
    getline(weight_fs,lineRead);
    std::stringstream line(lineRead);
    while(line >> value){
      weightRead=strtod(value.c_str(),NULL);
      bias[index]=static_cast<bias_weightDataType>(weightRead);
      index++;
    }
    coeffReadCount+=6;
  }
}

/* FUNCTION TO READ PERCEPTRON LAYER WEIGHT */
template <typename fcLayer_weightDataType>
void init_fcLayer(std::ifstream &weight_fs, fcLayer_weightDataType *fcLayer){
  char trash[4];
  int coeffReadCount=0;
  int index=0;
  std::string lineRead;
  std::string value;
  std::string trashLine;
  double weightRead=0;

  getline(weight_fs,trashLine);
  

  while(index < FCLAYER_SIZE){
    weight_fs.read(trash,3);
    getline(weight_fs,lineRead);
    std::stringstream line(lineRead);
    while(line >> value){
      weightRead=strtod(value.c_str(),NULL);
      fcLayer[index]=static_cast<fcLayer_weightDataType>(weightRead);
      index++;
      if(index % 10 == 0){
	break;
      }
    }
    
  }
}



/* FUNCTION TO LOAD WEIGHT FROM FILE */
/* ALL LAYER WEIGHTS ARE TEMPLATED ON A DIFFERENT DATATYPE */
template <typename kernelLayer1_weightDataType,
	  typename kernelLayer2_weightDataType,
	  typename kernelLayer3_weightDataType,
	  typename fcLayer_weightDataType,
	  typename biasLayer1_weightDataType,
	  typename biasLayer2_weightDataType,
	  typename biasLayer3_weightDataType,
	  typename biasfcLayer_weightDataType>

void loadWeightFromFile(std::string filePathName,
			kernelLayer1_weightDataType *kernelConvLayer1,
			kernelLayer2_weightDataType *kernelConvLayer2,
			kernelLayer3_weightDataType *kernelConvLayer3,
			fcLayer_weightDataType *fcLayer,
			biasLayer1_weightDataType *biasConvLayer1,
			biasLayer2_weightDataType *biasConvLayer2,
			biasLayer3_weightDataType *biasConvLayer3,
			biasfcLayer_weightDataType *biasfcLayer){
  
  std::ifstream weightFile;
  std::string trash;
  weightFile.open(filePathName.c_str(),std::ifstream::in);
    if(weightFile.good()){

      std::cout << "LOADING CONVOLUTION LAYER 1 WEIGHT" << std::endl;
      init_bias(weightFile,biasConvLayer1,BIASCONVLAYER1_SIZE);
      /*init_kernel(weightFile, kernelConvLayer1, KERNELCONV_SIZE,
	KERNELCONVLAYER1_CHANNEL_IN_NUM,CONVLAYER1_CHANNELNUM);
      
      std::cout << "LOADING CONVOLUTION LAYER 2 WEIGHT" << std::endl;
      init_bias(weightFile,biasConvLayer2,BIASCONVLAYER2_SIZE);
      init_kernel(weightFile, kernelConvLayer2, KERNELCONV_SIZE,
		  KERNELCONVLAYER2_CHANNEL_IN_NUM,CONVLAYER2_CHANNELNUM);
      
      std::cout << "LOADING CONVOLUTION LAYER 3 WEIGHT" << std::endl;
      init_bias(weightFile,biasConvLayer3,BIASCONVLAYER3_SIZE);
      init_kernel(weightFile, kernelConvLayer3, KERNELCONV_SIZE,
		  KERNELCONVLAYER3_CHANNEL_IN_NUM,CONVLAYER3_CHANNELNUM);

      
      std::cout << "LOADING FULLY CONNECTED LAYER WEIGHT" << std::endl;
      init_bias(weightFile,biasfcLayer,BIASFCLAYER_SIZE);
      init_fcLayer(weightFile,fcLayer);*/

      std::cout << "FINISHED LOADING WEIGHT" << std::endl;
      weightFile.close();
    }
    else{
      std::cerr << "Error could not open weight file" << std::endl;
    }
}
#endif
