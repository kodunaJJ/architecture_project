#include "../inc/cifar_database_op.hpp"
#include "../inc/cnn_weight_file_op.hpp"
#include "../inc/constant.hpp"
#include "../inc/perceptron.hpp"
#include <string>
#include <iostream>
#include <fstream>

#include "/home/jordan/Documents/Phelma_annee_3/algo2archi/projet/ac_types-stable/include/ac_fixed.h"

typedef float inputVector_dataType;
typedef float fcLayerVector_dataType;
typedef float outPutValue_dataType;
typedef float internalProduct_dataType;
typedef float internalSum_dataType;

int main4test(){
  std::cout << "stating main prog" << std::endl;
  /*cifarDatabase<unsigned int> db;
    db.cifarFolderPath="../../../../../image_database/cifar10/cifar-10-batches-bin/";
    db.cifarFileName="data_batch_1.bin";

    db.loadDatabase();
    std::cout << "database successfully loaded ??" << std::endl;
    unsigned char testImg =0;
    for(int i=0;i<10;i++){
    testImg=db.imgDatabaseData[i].imgData[0];
    std::cout <<  testImg << std::endl;
    }
  */

  /***** test image reading *****/

  std::string cifarFolderPath="../../../../../image_database/cifar10/cifar-10-batches-bin/";
  std::string cifarFileName="data_batch_1.bin";
  std::string file = cifarFolderPath+cifarFileName;
  std::ifstream cifarFile;
  std::string weightFilePath="./";
  std::string weightFileName="CNN_coeff_5x5_mod.txt";
  std::string wfile=weightFilePath+weightFileName;
  std::ifstream weightFile;

  std::string trash;
  /* CIFAR DATABASE IMAGE */ 
  cifarImage<unsigned int> imgIn;

  /* CNN WEIGHT TABLES (float) */
  float kernel_ConvLayer1[KERNELCONVLAYER1_SIZE];
  float kernel_ConvLayer2[KERNELCONVLAYER2_SIZE];
  float kernel_ConvLayer3[KERNELCONVLAYER3_SIZE];
  float bias_ConvLayer1[BIASCONVLAYER1_SIZE];
  float bias_ConvLayer2[BIASCONVLAYER2_SIZE];
  float bias_ConvLayer3[BIASCONVLAYER3_SIZE];
  float bias_fcLayer[BIASFCLAYER_SIZE];
  float fcLayer[FCLAYER_SIZE];

    /* CNN WEIGHT TABLES (fixed) */
  /*float kernel_ConvLayer1_fix[KERNELCONVLAYER1_SIZE];
  float kernel_ConvLayer2_fix[KERNELCONVLAYER2_SIZE];
  float kernel_ConvLayer3_fix[KERNELCONVLAYER3_SIZE];
  float bias_ConvLayer1_fix[BIASCONVLAYER1_SIZE];
  float bias_ConvLayer2_fix[BIASCONVLAYER2_SIZE];
  float bias_ConvLayer3_fix[BIASCONVLAYER3_SIZE];
  float bias_fcLayer_fix[BIASFCLAYER_SIZE];
  ac_fixed<20, 2, true> fcLayer_fix[FCLAYER_SIZE];*/
  
  /* INTERMEDIARY STAGE TABLES */
  float reshape[RESHAPE_SIZE];
  float result[FCLAYER_CHANNELNUM];

  std::cout.precision(10);
  cifarFile.open(file.c_str(),ifstream::in | ifstream::binary);
  

  if(cifarFile.good()){
    std::cout << "LOADING DATABASE" << std::endl;
    /*for(int j=0;j<3;j++){
      imgIn.loadImage(cifarFile);

      std::cout << "image label" << imgIn.cifarImageLabel << std::endl;

      for(int i=0;i<CIFAR_IMAGE_BYTES_SIZE;i++){
        std::cout << imgIn.imgData[i] << std::endl;
      }
    }*/
    imgIn.loadImage(cifarFile);
    
  }
  else{
    std::cerr << "Error while opening cifar database file \n";
    return 1;
  }
  loadWeightFromFile(wfile, kernel_ConvLayer1, kernel_ConvLayer2,
			kernel_ConvLayer3, fcLayer, bias_ConvLayer1,
		     bias_ConvLayer2, bias_ConvLayer3, bias_fcLayer);

  /*for (int i=0; i < BIASFCLAYER_SIZE;i++){
	std::cout << "bias fc layer weight " << bias_fcLayer[i] << std::endl;  
	}*/
  /*for (int i=0;i<FCLAYER_SIZE;i++){
	std::cout << "kernel fc layer  weight " << fcLayer[i] << std::endl;
	if(i%10==0 && i!=0){
	  std::cout <<std::endl;
	}
	       }*/

  for(int i=0;i<RESHAPE_SIZE;i++){
    reshape[i]=1;
  }
      for(int i=0;i<FCLAYER_CHANNELNUM;i++){
       result[i]=0;
  }
          for(int i=0;i<FCLAYER_CHANNELNUM;i++){
      std::cout << result[i]*fcLayer[0] << std::endl;
  }

  //perceptron(reshape,fcLayer,result);
  perceptron<inputVector_dataType, fcLayerVector_dataType,
	     outPutValue_dataType, internalProduct_dataType,
	     internalSum_dataType>
    (reshape,fcLayer,result);

    for(int i=0;i<FCLAYER_CHANNELNUM;i++){
      std::cout << result[i] << std::endl;
  }

  
    
  /*weightFile.open(wfile.c_str(),ifstream::in);
    if(weightFile.good()){*/
      // getline(weightFile,trash);
  // init_bias(weightFile,bias_ConvLayer1,BIASCONVLAYER1_SIZE);
      /*for (int i=0; i < BIASCONVLAYER1_SIZE;i++){
	std::cout << "bias layer 1 weight " << bias_ConvLayer1[i] << std::endl;  
	}*/
      /*init_kernel(weightFile, kernel_ConvLayer1, KERNELCONV_SIZE,
		  KERNELCONVLAYER1_CHANNEL_IN_NUM,CONVLAYER1_CHANNELNUM);
		  init_bias(weightFile,bias_ConvLayer2,BIASCONVLAYER2_SIZE);*/
      /* for (int i=0; i < BIASCONVLAYER2_SIZE;i++){
	std::cout << "bias layer 2 weight " << bias_ConvLayer2[i] << std::endl;  
	}*/
      /*init_kernel(weightFile, kernel_ConvLayer2, KERNELCONV_SIZE,
	KERNELCONVLAYER2_CHANNEL_IN_NUM,CONVLAYER2_CHANNELNUM);*/
      /*for (int i=0;i<KERNELCONVLAYER1_SIZE;i++){
	std::cout << "kernel conv layer 1 weight " << kernel_ConvLayer1[i] << std::endl;
	if(i%24==0 && i!=0){
	  std::cout <<std::endl;
	}
      }*/
  /*for (int i=0;i<KERNELCONVLAYER2_SIZE;i++){
	std::cout << "kernel conv layer 2 weight " << kernel_ConvLayer2[i] << std::endl;
	if(i%24==0 && i!=0){
	  std::cout <<std::endl;
	}
	}*/
  
  
  
  /*}
    else{
      std::cerr << "Error while opening weight file" << std::endl;
      }*/
  cifarFile.close();
  return 0;
}

int cnn_main(){
  std::cout << "stating main prog" << std::endl;
  /* image database path */
    std::string cifarFolderPath="../../../../../image_database/cifar10/cifar-10-batches-bin/";
    /* image database name */
  std::string cifarFileName="data_batch_1.bin";
  /* string concatenation to use ifstream open() */
  std::string file = cifarFolderPath+cifarFileName;
  /* "file pointer" to image database file */
  std::ifstream cifarFile;

  /* same thing as image database but for algorithm weight */ 
  std::string weightFilePath="./";
  std::string weightFileName="CNN_coeff_5x5_mod.txt";
  std::string wfile=weightFilePath+weightFileName;
  std::ifstream weightFile;

    /* CIFAR DATABASE IMAGE */ 
  cifarImage<unsigned int> imgIn;

  /* CNN WEIGHT TABLES (float) */
  float kernel_ConvLayer1[KERNELCONVLAYER1_SIZE];
  float kernel_ConvLayer2[KERNELCONVLAYER2_SIZE];
  float kernel_ConvLayer3[KERNELCONVLAYER3_SIZE];
  float bias_ConvLayer1[BIASCONVLAYER1_SIZE];
  float bias_ConvLayer2[BIASCONVLAYER2_SIZE];
  float bias_ConvLayer3[BIASCONVLAYER3_SIZE];
  float bias_fcLayer[BIASFCLAYER_SIZE];
  float fcLayer[FCLAYER_SIZE];


    /* INTERMEDIARY STAGE TABLES */
  float reshape[RESHAPE_SIZE];
  
  std::cout.precision(10); /* set float display */

  /* loading weight */
    loadWeightFromFile(wfile, kernel_ConvLayer1, kernel_ConvLayer2,
			kernel_ConvLayer3, fcLayer, bias_ConvLayer1,
		     bias_ConvLayer2, bias_ConvLayer3, bias_fcLayer);

  /* open database file */
  cifarFile.open(file.c_str(),ifstream::in | ifstream::binary);
  

  if(cifarFile.good()){

    /* if opening successful load one image */
    std::cout << "LOADING IMAGE FROM DATABASE" << std::endl;

    imgIn.loadImage(cifarFile);
    
  }
  else{
    std::cerr << "Error while opening cifar database file \n";
    return 1;
  }

  /* insert algorithm function */

  
  cifarFile.close();
  return 0;
  

  
}

int main(){

  int testStatus=0;
  testStatus=main4test();
  if (testStatus){
    std::cout << "test error" << std::endl;
    return 1;
  }
  
  return 0;
}
