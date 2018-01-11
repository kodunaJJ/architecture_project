#ifndef __PERCEPTRON_TYPES_H__
#define __PERCEPTRON_TYPES_H__

#include "ac_fixed.h"
#include "ac_channel.h"
#include "constant.hpp"

/* data format size constant */

#define DATA_IN_WIDTH 16 // to find
#define DATA_IN_INT_WIDTH 10

#define PERCEPTRON_WEIGHT_WIDTH 8
#define PERCEPTRON_WEIGHT_INT_WIDTH 0

#define DATA_OUT_WIDTH 16 // to find
#define DATA_OUT_INT_WIDTH 10

#define INTERNAL_PROD_WIDTH (DATA_IN_WIDTH+PERCEPTRON_WEIGHT_WIDTH)
#define INTERNAL_PROD_INT_WIDTH (DATA_IN_INT_WIDTH+PERCEPTRON_WEIGHT_INT_WIDTH)

#define INTERNAL_SUM_WIDTH (INTERNAL_PROD_WIDTH+8) // 8 coming from ln(180)/ln(2)
#define INTERNAL_SUM_INT_WIDTH (INTERNAL_PROD_INT_WIDTH+8)

#define PERCEPTRON_BIAS_WIDTH 8
#define PERCEPTRON_BIAS_INT_WIDTH 2


/* OTHER CONSTANT */

#define RESULT_SIZE 10

/* CNN ALGORITHM dataType definition */

typedef ac_fixed<DATA_IN_WIDTH,DATA_IN_INT_WIDTH,false,AC_RND_INF,AC_SAT> perceptronDataIn_type;
typedef ac_fixed<PERCEPTRON_WEIGHT_WIDTH,PERCEPTRON_WEIGHT_INT_WIDTH,true,AC_RND_INF,
                 AC_SAT> perceptronWeight_type;
typedef ac_fixed<DATA_OUT_WIDTH,DATA_OUT_INT_WIDTH,true,AC_RND_INF,AC_SAT> perceptronDataOut_type;
typedef ac_fixed<INTERNAL_PROD_WIDTH,INTERNAL_PROD_INT_WIDTH,true,AC_RND_INF,AC_SAT> perceptronInternProd_type;
typedef ac_fixed<INTERNAL_SUM_WIDTH,INTERNAL_SUM_INT_WIDTH,true,AC_RND_INF,AC_SAT> perceptronInternSum_type;
typedef ac_fixed<PERCEPTRON_BIAS_WIDTH,PERCEPTRON_BIAS_INT_WIDTH,true,AC_RND_INF,AC_SAT> perceptronBias_type;
typedef ac_fixed<8,8,false> perceptronInternCnt_type;

/* FUNCTION PROTOTYPE */

/*void perceptronHW(ac_channel<perceptronDataIn_type> &dataIn,
  perceptronWeight_type perceptronWeight[FCLAYER_SIZE],
  ac_channel<perceptronDataOut_type> &dataOut);*/

void perceptronHW(perceptronDataIn_type *dataIn,
                  perceptronWeight_type *perceptronWeight,
                  perceptronDataOut_type *dataOut,
		  perceptronBias_type *biasWeight);

void perceptron_v2_HW(ac_channel<perceptronDataIn_type> &dataIn,
                  perceptronWeight_type perceptronWeight[FCLAYER_SIZE],
		      ac_channel<perceptronDataOut_type> dataOutReg[RESULT_SIZE],
		      perceptronBias_type biasWeight[FCLAYER_CHANNELNUM],
		      ac_channel<perceptronDataOut_type> &dataOut);

void perceptronREF(double *dataIn,
                   double *perceptronWeight,
                   double *dataOut,
		   double *biasWeight);

void perceptron_v2_REF(double &dataIn,
                   double perceptronWeight[FCLAYER_SIZE],
                   double dataOutReg[RESULT_SIZE],
		       double biasWeight[FCLAYER_CHANNELNUM],
		       double *dataOut);

#endif
