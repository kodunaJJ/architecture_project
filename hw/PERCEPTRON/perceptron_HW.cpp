#include "perceptron_types.hpp"

#pragma hls_design_top



/*
  void vectorMult(ac_channel<perceptronDataIn_type> &vectorIn,
  perceptronWeight_type perceptronWeight[FCLAYER_SIZE] fcVector,
  ac_channel<perceptronDataOut_type> &valueOut,
  unsigned char channelNum){

  perceptronInternSum_type sumValue=0;
  perceptronInternProd_type productValue=0;

  PERCEPTRON_MULT_OP:for(int i=0;i<RESHAPE_SIZE;i++){
  productValue=vectorIn.read()*fcVector[i*FCLAYER_CHANNELNUM+channelNum];
  sumValue+=productValue; /* to be careful when using fixed type */
/* }
   valueOut.write(sumValue);
   }


   /* FUNCTION TO REALISE LAYER CALCULATION */
/*void perceptronHW(ac_channel<perceptronDataIn_type> &dataIn,
  perceptronWeight_type perceptronWeight[FCLAYER_SIZE],
  ac_channel<perceptronDataOut_type> &dataOut,
  unsigned char channelNum){

  if(dataIn.available(1)){
  /*PERCEPTRON:for(int i=0; i < FCLAYER_CHANNELNUM;i++){
  vectorMult(dataIn, perceptronWeight, dataOut,channelNum);
  //}
  }

  }*/

/*const perceptronDataIn_type dataHW_in[RESHAPE_SIZE];
const perceptronDataOut_type dataHW_out[FCLAYER_CHANNELNUM];*/

/*void perceptronHW(perceptronDataIn_type *dataIn,perceptronWeight_type *perceptronWeight,
                  perceptronDataOut_type *dataOut,perceptronBias_type *biasWeight){

  static ac_channel<perceptronDataIn_type> dataInBus;
  static ac_channel<perceptronWeight_type> weightBus;
  static ac_channel<perceptronDataOut_type> dataOutBus;
  static ac_channel<perceptronBias_type> dataBiasBus;
  
 PERCEP_CALC:for(int channelNum=0; channelNum < FCLAYER_CHANNELNUM;channelNum++){
    perceptronDataOut_type sumValue=0;
    perceptronInternProd_type productValue=0;
    perceptronBias_type biasValue;

  MULT_OP:for(int i=0;i<RESHAPE_SIZE;i++){
      dataInBus.write(dataIn[i]);
      weightBus.write(perceptronWeight[i*FCLAYER_CHANNELNUM+channelNum]);
      
      productValue=dataInBus.read()*weightInBus.read();
      sumValue+=productValue; /* to be careful when using fixed type */
/*}
    dataBiasBus.write(biasWeight[channelNum]);
    biasValue=dataBiasBus.read();
    sumValue+=biasValue;
    dataOutBus.write(sumValue);
    dataOut[channelNum]=dataBus.read();
  }
}*/


void perceptron_v2_HW(ac_channel<perceptronDataIn_type> &dataIn,
		      perceptronWeight_type perceptronWeight[FCLAYER_SIZE],
		      perceptronBias_type biasWeight[FCLAYER_CHANNELNUM],
		      ac_channel<perceptronDataOut_type> &dataOut){

  static perceptronInternSum_type accReg[FCLAYER_CHANNELNUM];
  static perceptronDataOut_type dataOutReg[RESULT_SIZE];
  static perceptronInternCnt_type pixelCnt=0;
  static perceptronDataIn_type pixelDataIn;

  if(dataIn.available(1)){
    pixelDataIn=dataIn.read();
  PROD_ACC:for(int i=0;i<FCLAYER_CHANNELNUM;i++){
      accReg[i]+=perceptronWeight[i+(int)pixelCnt*FCLAYER_CHANNELNUM]*pixelDataIn;
    }
    pixelCnt++;
  }

  if(pixelCnt == 180){
  BIAS_ADD:for(int i=0;i<FCLAYER_CHANNELNUM;i++){
      dataOutReg[i]=accReg[i]+biasWeight[i];
      accReg[i]=0;
    }
  OUT_UPDATE:for(int i=0;i<RESULT_SIZE;i++){
      dataOut.write(dataOut[i]);
    }
    pixelCnt=0;
  }
}
