#include "perceptronFPGA_DATA.h"
#include "perceptron_types.h"

#pragma hls_design top
void top(bool &testOut,bool &errorInject){
  static perceptronDataOut_type perceptronOut[PERCEPTRON_CHANNELNUM];

  testOut=1;

  perceptron_v2_HW(reshapeOutTest,perceptronFixedWeight,perceptronFixedBias,perceptronOut);

  if(errorInject){
    perceptronOut[3]=1;
  }

 test_loop:for(int i=0;i<PERCEPTRON_CHANNELNUM;i++){
    
    if((perceptronOut[i]-perceptronExpectedOuput[i] < -0.05)||(perceptronOut[i]-perceptronExpectedOuput[i])>0.05){
      testOut=0;
    }
  }
  
}

