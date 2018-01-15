#include "perceptron_types.hpp"


/* FUNCTION TO MULTIPLY A VECTOR AND 1 COLUMN OF A MATRIX */
/*
  void vectorMult(double *vectorIn,
  double *fcVector,
  double *valueOut,unsigned char channelNum){
  double sumValue=0;
  double productValue=0;
  MULT_OP:for(int i=0;i<RESHAPE_SIZE;i++){
  productValue=vectorIn[i]*fcVector[i*FCLAYER_CHANNELNUM+channelNum];
  sumValue+=productValue; /* to be careful when using fixed type */

/*}
 *valueOut=(sumValue);
 }
*/

/* FUNCTION TO REALISE LAYER CALCULATION */
/*
  void perceptronREF(double *dataIn,
  double perceptronWeight[FCLAYER_SIZE],
  double *dataOut, unsigned char channelNum){

  PERCEP_CALC:for(int i=0; i < FCLAYER_CHANNELNUM;i++){
  vectorMult(dataIn, perceptronWeight, dataOut+i,i);
  }
  }
*/


/* test for HLS Syntesis */

void perceptronREF(double *dataIn, double *perceptronWeight, double *dataOut,
		   double *biasWeight){

 PERCEP_CALC:for(int channelNum=0; channelNum < FCLAYER_CHANNELNUM;channelNum++){
    double sumValue=0;
    double productValue=0;
  MULT_OP:for(int i=0;i<RESHAPE_SIZE;i++){
      productValue=dataIn[i]*perceptronWeight[i*FCLAYER_CHANNELNUM+channelNum];
      sumValue+=productValue; /* to be careful when using fixed type */
    }
    dataOut[channelNum]=sumValue+biasWeight[channelNum];
  }
}

void perceptron_v2_REF(double &dataIn,
                   double perceptronWeight[FCLAYER_SIZE],
                   double dataOutReg[RESULT_SIZE],
		       double biasWeight[FCLAYER_CHANNELNUM],
		       double *dataOut){

    static double accReg[FCLAYER_CHANNELNUM];
  static int pixelCnt=0;
  static int transfertNum=0;

  PROD_ACC:for(int i=0;i<FCLAYER_CHANNELNUM;i++){
      accReg[i]+=perceptronWeight[i+pixelCnt*FCLAYER_CHANNELNUM]*dataIn;
    }
    pixelCnt++;


  if(pixelCnt == 180){
  BIAS_ADD:for(int i=0;i<FCLAYER_CHANNELNUM;i++){
      dataOut[i]=accReg[i]+biasWeight[i];
      accReg[i]=0;
    }
  
    *dataOut=dataOut[transfertNum];
    pixelCnt=0;
    transfertNum++;
  }

  if(transfertNum>=10){
    transfertNum=0;
  }
}