#include "imgNorm.hpp"
#include "weight.hpp"
#include <fstream>
#include <iomanip>
#include <iostream>
#include "convLayer1Contant.hpp"
#include "convLayer1.hpp"
#include "cnn_datatype.hpp"
#include "weight.hpp"
#include "imgNorm.hpp"
using namespace std;
#include "mc_scverify.h"

CCS_MAIN(int argc, char *argv) {

  cout << "CONVOLUTION LAYER 1 TEST BENCH START"<<std::endl;
  ofstream OUTPUT_DATA_REF("convLayer1_DataREF.txt");
  ofstream OUTPUT_DATA_HW("convLayer1_DataHW.txt");
  double imgOut[IMG_SIZE*IMG_CHANNEL_OUT];
  
  kernelLayer1_weightDataType kernel1_fixed[KERNEL_SIZE*IMG_CHANNEL_IN*IMG_CHANNEL_OUT];
  imageNorm_dataType imgNorm_fixed[IMG_SIZE*IMG_CHANNEL_IN];
  convLayer1Out_dataType imgOut_fixed[IMG_SIZE*IMG_CHANNEL_OUT];
  biasLayer1_weightDataType bias_fixed[IMG_CHANNEL_OUT];


  for(int i=0;i<IMG_SIZE*IMG_CHANNEL_IN;i++){
    imgNorm_fixed[i]=imgNorm[i];
  }

  for(int i=0;i<KERNEL_SIZE*IMG_CHANNEL_IN*IMG_CHANNEL_OUT;i++){
    kernel1_fixed[i]=kernel_ConvLayer1[i];
  }
  
  for(int i=0;i<IMG_CHANNEL_OUT;i++){
    bias_fixed[i]=bias_ConvLayer1[i];
  }
  cout << "init done"<<std::endl;

  convolution3D_REF((double*) kernel_ConvLayer1,(double*) imgNorm,imgOut,
  (double*)bias_ConvLayer1);

  cout << "conv REF done"<<std::endl;

  for(int i=0;i<IMG_SIZE*IMG_CHANNEL_OUT;i++){
    OUTPUT_DATA_REF << "pixel n°" << i << ", " << imgOut[i] <<endl;
  }

  cout << "conv REF dat write done"<<std::endl;
  
CCS_DESIGN(convolution3D_HW)(kernel1_fixed,imgNorm_fixed,imgOut_fixed,
bias_fixed);
  cout << "conv HW done"<<std::endl;

  

    for(int i=0;i<IMG_SIZE*IMG_CHANNEL_OUT;i++){
    OUTPUT_DATA_HW << "pixel n°" << i << ", " << imgOut_fixed[i] <<endl;
  }

    cout << "TEST BENCH END"<<std::endl;

    OUTPUT_DATA_HW.close();
    OUTPUT_DATA_REF.close();

    CCS_RETURN(0);
}
