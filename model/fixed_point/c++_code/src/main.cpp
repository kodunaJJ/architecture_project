#include "../inc/cifar_database_op.hpp"
#include "../inc/cnn_weight_file_op.hpp"
#include "../inc/constant.hpp"
#include "../inc/perceptron.hpp"
#include "../inc/pooling.hpp"
#include "../inc/cnn_weight_dataType.hpp"
#include "../inc/image_normalize.hpp"
#include "../inc/weight.hpp"
#include "../inc/convoulution.h"
#include "../inc/reshape.hpp"
#include <string>
#include <iostream>
#include <fstream>
#include <algorithm>

#include "../ac_types-stable/include/ac_fixed.h"
#include "../inc/cnn_datatype.hpp"
/*
typedef float inputVector_dataType;
typedef float fcLayerVector_dataType;
typedef float outPutValue_dataType;
typedef float internalProduct_dataType;
typedef float internalSum_dataType;
*/



float accuracy(cifarImage<unsigned int> &imgIn,
	       unsigned int imgClassPredicted,int *goodPredictionNum,
	       int *totalImgRead){
  int buffer=*goodPredictionNum;
  if(imgClassPredicted == imgIn.cifarImageLabel){
    //*goodPredictionNum++;
    buffer++;
  }
  *goodPredictionNum=buffer;
  //return (float)(*goodPredictionNum)/(float)(*totalImgRead+1)*100;
  return (float)(buffer)/(float)(*totalImgRead+1)*100;
}
template <typename outPutValue_dataType>
void predictedClassFinder(outPutValue_dataType *perceptronOutVector,
			  unsigned int *predictedImg){
*predictedImg=max_element(perceptronOutVector,perceptronOutVector+
			  FCLAYER_CHANNELNUM+1)-perceptronOutVector;  
}

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
  /*float padVal=0;
  float poolingTestInput[MAXPOOL_LAYER2_OUT_SIZE*MAXPOOL_LAYER2_OUT_SIZE*
			 KERNELCONVLAYER1_CHANNEL_IN_NUM];
    float layer1Out[3*3*3];*/
    
    // fixed datatype test 
      ac_fixed<9, 7, false> padVal=0;
  ac_fixed<9, 7, false> poolingTestInput[MAXPOOL_LAYER2_OUT_SIZE*
					 MAXPOOL_LAYER2_OUT_SIZE*
					 KERNELCONVLAYER1_CHANNEL_IN_NUM];
    ac_fixed<9, 7, false> layer1Out[3*3*3];
  for(int i=0;i<MAXPOOL_LAYER2_OUT_SIZE*MAXPOOL_LAYER2_OUT_SIZE*
	KERNELCONVLAYER1_CHANNEL_IN_NUM;i++){
    poolingTestInput[i]= (float)i/3.0;
  }

  for(int i=0;i<6*6*3;i++){
      std::cout << "poolingInput "<<poolingTestInput[i] << std::endl;
  }
  maxPooling(poolingTestInput, MAXPOOL_LAYER2_OUT_SIZE,
	     KERNELCONVLAYER1_CHANNEL_IN_NUM, layer1Out,padVal);

  for(int i=0;i<3*3*3;i++){
    std::cout << layer1Out[i] << std::endl;
  }
  
  /* // TEST PERCEPTRON LAYER START
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
  } // TEST PERCEPTRON LAYER END
*/
  /* // TEST OF PREDICTED IMAGE CLASS FINDER
      for(int i=0;i<FCLAYER_CHANNELNUM;i++){
       result[i]=10-i;
       std::cout << "result init" << result[i]<< std::endl;
  }
      result[5]=20;
      unsigned int predictedImgClass=0;

      predictedClassFinder(result,&predictedImgClass);
 
 std::cout << "predicted class = " << predictedImgClass << std::endl;
      */
    
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



int cnn_main_double(){
  std::cout << "stating main prog" << std::endl;
  /* image database path */
    std::string cifarFolderPath="../../../../../../../image_database/cifar10/cifar-10-batches-bin/";
    /* image database name */
  std::string cifarFileName="data_batch_1.bin";
  /* string concatenation to use ifstream open() */
  std::string file = cifarFolderPath+cifarFileName;
  /* "file pointer" to image database file */
  std::ifstream cifarFile;

  /* same thing as image database but for algorithm weight */ 
  /*std::string weightFilePath="./";
  std::string weightFileName="CNN_coeff_3x3_mod.txt";
  std::string wfile=weightFilePath+weightFileName;
  std::ifstream weightFile;*/

  /* file where to store accuracy value */
  std::string resultsFilePath="../../results/";
  std::string resultsFileName="accuracyDATA_fixed.txt";
  std::string rfile=resultsFilePath+resultsFileName;
  std::ofstream resultsFile;


    /* CIFAR DATABASE IMAGE */ 
  cifarImage<unsigned int> imgIn;

  /* CNN WEIGHT TABLES (float) */
  double kernel_ConvLayer1[KERNELCONVLAYER1_SIZE];
  //double kernel_ConvLayer2[KERNELCONVLAYER2_SIZE];
  // double kernel_ConvLayer3[KERNELCONVLAYER3_SIZE];
  double bias_ConvLayer1[BIASCONVLAYER1_SIZE];
  //double bias_ConvLayer2[BIASCONVLAYER2_SIZE];
  //double bias_ConvLayer3[BIASCONVLAYER3_SIZE];
  //double bias_fcLayer[BIASFCLAYER_SIZE];
  //double fcLayer[FCLAYER_SIZE];


    /* INTERMEDIARY STAGE TABLES */
  
  imageNorm_dataType imgNorm[NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CIFAR_DB_IMAGE_COLOR];
  convLayer1Out_dataType convLayer1_out[NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER1_CHANNELNUM];
  poolingLayer1_DataType maxPoolLayer1_out[NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER1_CHANNELNUM/4];
  
  convLayer2Out_dataType convLayer2_out[NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER2_CHANNELNUM/4];
  poolingLayer2_DataType maxPoolLayer2_out[NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER2_CHANNELNUM/16];
  convLayer3Out_dataType convLayer3_out[NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER3_CHANNELNUM/16];
  poolingLayer3_DataType maxPoolLayer3_out[NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER3_CHANNELNUM/64];
  poolingLayer3_DataType reshape_out[RESHAPE_SIZE];
  fcLayerOut_dataType perceptron_out[FCLAYER_CHANNELNUM];


  unsigned int prediction=0;
  int goodPredictionNum=0;
  float accurate=0;
  int imgTotal=1;
  std::cout.precision(10); /* set float display */

  /* loading weight */
  /*loadWeightFromFile(wfile, kernel_ConvLayer1, kernel_ConvLayer2,
			kernel_ConvLayer3, fcLayer, bias_ConvLayer1,
			bias_ConvLayer2, bias_ConvLayer3, bias_fcLayer);*/

  /*std::cout << "returned to main after loading weight" << std::endl;*/

  /*for(int idx=0;idx<BIASCONVLAYER1_SIZE;idx++){
    std::cout<<"bias weight =" << bias_fcLayer[idx] << " " << idx << std::endl;
  }*/
  std::cout << "done printing weight" << std::endl;
  /* open database file */
  
  cifarFile.open(file.c_str(), std::ifstream::in | std::ifstream::binary);
  resultsFile.open(rfile.c_str(), std::ofstream::out);
  /*std::cout << "opened cifarFile" << std::endl;*/
  for(int imgReadNum=0;imgReadNum<imgTotal;imgReadNum++){
    
  
    if(cifarFile.good() && resultsFile.good()){

    /* if opening successful load one image */
    //std::cout << "LOADING IMAGE FROM DATABASE" << std::endl;

    imgIn.loadImage(cifarFile);
    
  }
  else{
    std::cerr << "Error while opening cifar database file or writing results \n";
    cifarFile.close();
    resultsFile.close();
    return 1;
  }


  imageNorm<unsigned int,imageNorm_dataType>(imgIn.imgData, imgNorm, 32,32, 3, 24, 24, 3, 2.25);

  /************ FIRST LAYER **************/
  convolution_3D_fixed<kernelLayer1_weightDataType,imageNorm_dataType,convLayer1Out_dataType,
		 conv2DLayer1InternSum_dataType,biasLayer1_weightDataType,convLayer1InternProd_dataType,
		 convLayer1InternOut_dataType>
    ((kernelLayer1_weightDataType*)kernel_ConvLayer1_fixed, imgNorm, convLayer1_out,
     (biasLayer1_weightDataType*)bias_ConvLayer1_fixed,KERNELCONVLAYER1_CHANNEL_IN_NUM,
     CONVLAYER1_CHANNELNUM,NORMALIZED_IMAGE_SIZE,KERNELCONV_SIZE,resultsFile);
  //while(1);
  
  //while(1);
  for(int i=0;i<NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER1_CHANNELNUM;i++){
    //std::cout<<"pixel image conv 1 " << imgReadNum << " pixel n° " << i << " "<< convLayer1_out[i] << std::endl;
    //convLayer1_out_double[i]=convLayer1_out[i].to_double();
    //std::cout<<"pixel image conv 1 " << imgReadNum << " pixel n° " << i << " "<< convLayer1_out_double[i] << std::endl;
        resultsFile<<"pixel image conv 1 " << imgReadNum << " pixel n° " << i << " "<< convLayer1_out[i] << std::endl;
  }
  
  /*std::cout<<"first conv done" << std::endl;*/
  maxPooling<poolingLayer1_DataType>((poolingLayer1_DataType*)convLayer1_out, NORMALIZED_IMAGE_SIZE, CONVLAYER1_CHANNELNUM, maxPoolLayer1_out,0);

  /*for(int i=0;i<NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER1_CHANNELNUM/4;i++){
    //std::cout<<"pixel image maxpool 1 " << imgReadNum << " pixel n° " << i << " "<< maxPoolLayer1_out[i] << std::endl;
    //buffer[i]=maxPoolLayer1_out[i].to_double();
    std::cout<<"pixel image maxpool 1 " << imgReadNum << " pixel n° " << i << " "<< maxPoolLayer1_out_double[i] << std::endl;
  }*/
    /************ SECOND LAYER **************/
  convolution_3D_fixed<kernelLayer2_weightDataType,poolingLayer1_DataType,convLayer2Out_dataType,
		 conv2DLayer2InternSum_dataType,biasLayer2_weightDataType,convLayer2InternProd_dataType,
		 convLayer2InternOut_dataType>
    ((kernelLayer2_weightDataType*)kernel_ConvLayer2_fixed, maxPoolLayer1_out,convLayer2_out,
     (biasLayer2_weightDataType*)bias_ConvLayer2_fixed,KERNELCONVLAYER2_CHANNEL_IN_NUM,CONVLAYER2_CHANNELNUM,
     NORMALIZED_IMAGE_SIZE/2,KERNELCONV_SIZE,resultsFile);


  
  /*for(int i=0;i<NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER2_CHANNELNUM/4;i++){
    std::cout<<"pixel image conv 2 " << imgReadNum << " pixel n° " << i << " "<< convLayer2_out[i] << std::endl;
  }*/
  maxPooling<poolingLayer2_DataType>((poolingLayer2_DataType*)convLayer2_out, NORMALIZED_IMAGE_SIZE/2, CONVLAYER2_CHANNELNUM, maxPoolLayer2_out,0);

  /*for(int i=0;i<NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER2_CHANNELNUM/16;i++){
    std::cout<<"pixel image maxpool 2 " << imgReadNum << " pixel n° " << i << " "<< maxPoolLayer2_out[i] << std::endl;
  }*/

    /************ THIRD LAYER **************/
  convolution_3D_fixed<kernelLayer3_weightDataType,poolingLayer2_DataType,convLayer3Out_dataType,
		       conv2DLayer3InternSum_dataType,biasLayer3_weightDataType,convLayer3InternProd_dataType,
		       convLayer3Out_dataType>
    ((kernelLayer3_weightDataType*)kernel_ConvLayer3_fixed, maxPoolLayer2_out,convLayer3_out,
     (biasLayer3_weightDataType*)bias_ConvLayer3_fixed,KERNELCONVLAYER3_CHANNEL_IN_NUM,CONVLAYER3_CHANNELNUM,
     NORMALIZED_IMAGE_SIZE/4,KERNELCONV_SIZE,resultsFile);

  /*for(int i=0;i<NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER3_CHANNELNUM/16;i++){
    std::cout<<"pixel image conv 3 " << imgReadNum << " pixel n° " << i << " "<< convLayer3_out[i] << std::endl;
  }*/

  /*for(int idx=0;idx<NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE/16*3;idx++){
    convLayer3_out[idx]=(double)idx;
  }*/
  
  maxPooling<poolingLayer3_DataType>((poolingLayer3_DataType*)convLayer3_out, 6, 20, maxPoolLayer3_out,0);


  for(int i=0;i<NORMALIZED_IMAGE_SIZE*NORMALIZED_IMAGE_SIZE*CONVLAYER3_CHANNELNUM/64;i++){
    //std::cout<<"pixel image conv maxpool 3 " << imgReadNum << " pixel n° " << i << " "<< maxPoolLayer3_out[i] << std::endl;
    resultsFile<<"pixel image conv maxpool 3 " << imgReadNum << " pixel n° " << i << " "<< maxPoolLayer3_out[i] << std::endl;
  }

  /*for(int idx=0;idx<180;idx++){
    //maxPoolLayer3_out[idx]=imgReadNum;
    maxPoolLayer3_out[idx]=1;
  }*/

  /*maxPoolLayer3_out[0]=1;
  maxPoolLayer3_out[1]=1;*/

  reshape<poolingLayer3_DataType>(maxPoolLayer3_out,reshape_out);

  //reshape<double>(maxPoolLayer3_out_double,reshape_out_double);
  for(int idx=0;idx<180;idx++){
    //maxPoolLayer3_out[idx]=imgReadNum;
    //reshape_out[idx]=1;
    //std::cout<<"pixel image conv reshape " << imgReadNum << " pixel n° " << idx << " "<< reshape_out[idx] << std::endl;
    //resultsFile<<"pixel image conv reshape " << imgReadNum << " pixel n° " << idx << " "<< reshape_out[idx] << std::endl;
  }

  /************** PERCEPTRON **************/
  perceptron_fixed<poolingLayer3_DataType,fcLayer_weightDataType,fcLayerOut_dataType,
		   fcLayerInternalProduct_dataType,fcLayerInternalSum_dataType,biasfcLayer_weightDataType,
		   fcLayerBiasSum_dataType>
    (reshape_out, (fcLayer_weightDataType*)fcLayer_fixed,perceptron_out,
     (biasfcLayer_weightDataType*)bias_fcLayer_fixed);


  //std::cout<<"perceptron value"<<std::endl;
  for(int i=0;i<FCLAYER_CHANNELNUM;i++){
    //std::cout<<perceptron_out[i]<<std::endl;
    //perceptron_out_double[i]=perceptron_out[i].to_double();
    //resultsFile<<perceptron_out[i]<<std::endl;
  }

  /*************** PREDICTION *************/

  predictedClassFinder<fcLayerOut_dataType>(perceptron_out,&prediction);
  //predictedClassFinder<double>(perceptron_out_double,&prediction);
  /************** ACCURACY CALCULATION + DISPLAY **********/
  accurate=accuracy(imgIn,prediction,&goodPredictionNum,&imgReadNum);
    
    std::cout<<"ACCURACY = " << accurate << std::endl;
    std::cout<<"Progression = " << imgReadNum+1 << "/" << imgTotal << std::endl;
    //resultsFile << imgReadNum << ',' << accurate << std::endl;
    //std::cout<<"image class = " << imgIn.cifarImageLabel << "predicted class = " << prediction << std::endl;
  }
   
  cifarFile.close();
  resultsFile.close();
  return 0;
  

  
}

int main(){

  int testStatus=0;
  //testStatus=main4test();
  testStatus=cnn_main_double();
  if (testStatus){
    std::cout << "test error" << std::endl;
    return 1;
  }
  
  return 0;
}
