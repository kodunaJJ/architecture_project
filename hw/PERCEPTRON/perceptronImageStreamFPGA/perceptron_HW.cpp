#include "perceptron_types.h"


void perceptron_v2_HW(perceptronDataIn_type dataIn[RESHAPE_SIZE],
		      perceptronWeight_type perceptronWeight[FCLAYER_SIZE],
		      perceptronBias_type biasWeight[FCLAYER_CHANNELNUM],
		      perceptronDataOut_type dataOut[FCLAYER_CHANNELNUM]){

  static perceptronInternSum_type accReg[FCLAYER_CHANNELNUM];
  //static perceptronDataOut_type dataOutReg[RESULT_SIZE];
  //static perceptronInternCnt_type pixelCnt=0;
  //static perceptronDataIn_type pixelDataIn;

  
 MAIN_LOOP:for(int pxNum=0;pxNum<RESHAPE_SIZE;pxNum++){
  PROD_ACC:for(int i=0;i<FCLAYER_CHANNELNUM;i++){
      accReg[i]+=perceptronWeight[i+pxNum*FCLAYER_CHANNELNUM]*dataIn[pxNum];
    }
    //pixelCnt++;
  }

  //if(pixelCnt == 180){
  BIAS_ADD:for(int i=0;i<FCLAYER_CHANNELNUM;i++){
      dataOut[i]=accReg[i]+biasWeight[i];
      accReg[i]=0;
    }
  /*OUT_UPDATE:for(int i=0;i<RESULT_SIZE;i++){
      dataOut.write(dataOutReg[i]);
    }*/
  // pixelCnt=0;
  //}
}

