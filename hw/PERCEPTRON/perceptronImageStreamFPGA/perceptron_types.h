#ifndef __PERCEPTRON_TYPES_H__
#define __PERCEPTRON_TYPES_H__

#include "ac_fixed.h"
#include "ac_channel.h"
#include "constant.h"

/* data format size constant */

#define DATA_IN_WIDTH 10 // to find
#define DATA_IN_INT_WIDTH 6

#define PERCEPTRON_WEIGHT_WIDTH 8
#define PERCEPTRON_WEIGHT_INT_WIDTH 1

#define DATA_OUT_WIDTH 16 // to find
#define DATA_OUT_INT_WIDTH 7

#define INTERNAL_PROD_WIDTH (DATA_IN_WIDTH+PERCEPTRON_WEIGHT_WIDTH-1-2)
#define INTERNAL_PROD_INT_WIDTH (DATA_IN_INT_WIDTH+PERCEPTRON_WEIGHT_INT_WIDTH-1-2)

#define INTERNAL_SUM_WIDTH (INTERNAL_PROD_WIDTH) 
#define INTERNAL_SUM_INT_WIDTH (INTERNAL_PROD_INT_WIDTH+4)

#define PERCEPTRON_BIAS_WIDTH 8
#define PERCEPTRON_BIAS_INT_WIDTH 3


/* OTHER CONSTANT */

#define RESULT_SIZE 10

/* CNN ALGORITHM dataType definition */

typedef ac_fixed<DATA_IN_WIDTH,DATA_IN_INT_WIDTH,true,AC_TRN,AC_SAT> perceptronDataIn_type;
typedef ac_fixed<PERCEPTRON_WEIGHT_WIDTH,PERCEPTRON_WEIGHT_INT_WIDTH,true,AC_RND_INF,AC_SAT> perceptronWeight_type;
typedef ac_fixed<DATA_OUT_WIDTH,DATA_OUT_INT_WIDTH,true,AC_TRN,AC_SAT> perceptronDataOut_type;
typedef ac_fixed<INTERNAL_PROD_WIDTH,INTERNAL_PROD_INT_WIDTH,true,AC_TRN,AC_SAT> perceptronInternProd_type;
typedef ac_fixed<INTERNAL_SUM_WIDTH,INTERNAL_SUM_INT_WIDTH,true,AC_TRN,AC_SAT> perceptronInternSum_type;
typedef ac_fixed<PERCEPTRON_BIAS_WIDTH,PERCEPTRON_BIAS_INT_WIDTH,true,AC_RND_INF,AC_SAT> perceptronBias_type;
typedef ac_int<8,false> perceptronInternCnt_type;

/* FUNCTION PROTOTYPE */

/*void perceptronHW(ac_channel<perceptronDataIn_type> &dataIn,
  perceptronWeight_type perceptronWeight[FCLAYER_SIZE],
  ac_channel<perceptronDataOut_type> &dataOut);*/

/*void perceptronHW(perceptronDataIn_type *dataIn,
                  perceptronWeight_type *perceptronWeight,
                  perceptronDataOut_type *dataOut,
		  perceptronBias_type *biasWeight);*/

void perceptron_v2_HW(perceptronDataIn_type dataIn[RESHAPE_SIZE],
		      perceptronWeight_type perceptronWeight[FCLAYER_SIZE],
		      perceptronBias_type biasWeight[FCLAYER_CHANNELNUM],
		      perceptronDataOut_type dataOut[FCLAYER_CHANNELNUM]);

/*void perceptronREF(double *dataIn,
                   double *perceptronWeight,
                   double *dataOut,
		   double *biasWeight);*/

void perceptron_v2_REF(double &dataIn,
                   double perceptronWeight[FCLAYER_SIZE],
		       double biasWeight[FCLAYER_CHANNELNUM],
		       double *dataOut);

void top(bool &testOut,bool &errorInject);

#endif


