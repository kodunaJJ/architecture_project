#include "perceptron_types.hpp"
#include "perceptron_weight_double.h"
#include <fstream>
#include <iostream>
#include <iomanip>
#include "constant.hpp"
using namespace std ;
#include "mc_scverify.h"


CCS_MAIN(int argc, char *argv) {

  cout<< "PERCEPTRON TESTBENCH START" << endl;

  ofstream INPUT_DATA("perceptronDataIn.txt");
  ofstream OUTPUT_DATA("perceptronDataOut.txt");

  /* perceptron data input for test */
  double testbenchDataIn[RESHAPE_SIZE];
  double dataREF_out[FCLAYER_CHANNELNUM];

  extern perceptronDataOut_type *dataHW_out;
  extern perceptronDataIn_type *dataHW_in;

  /* perceptron weight in fixed format */
  perceptronWeight_type weight_fixed[PERCEPTRON_WEIGHT_NUM];

  /*static ac_channel<perceptronDataIn_type> dataIn;
    static ac_channel<perceptronDataOut_type> dataOut;*/

  double double_in,double_out;
  double fixed_out;
  double worst_error = 0;
  double diff;

  perceptronDataOut_type channel_read = 0;


  /* init input data for test */
  for(int i=0;i<RESHAPE_SIZE;i++){
    testbenchDataIn[i]=1;
    dataHW_in[i]=testbenchDataIn[i];
  }

  /* convert weight in double format to fixed */
  for(int i=0;i<PERCEPTRON_WEIGHT_NUM;i++){
    weight_fixed[i]=perceptron_double[i];
  }

    /* reference output caculation */
    perceptronREF(testbenchDataIn, perceptron_double, dataREF_out);

    INPUT_DATA << dataREF_out.to_int() << endl;

    CCS_DESIGN(perceptronHW)(dataHW_in, weight_fixed, dataHW_out);

      channel_read = data_out.read();
      // compare with double precision reference
      fixed_out = channel_read.to_double();
      diff = fixed_out - double_out;
      diff = (diff<0) ? -diff : diff;
      worst_error = (diff > worst_error) ? diff : worst_error;
      OUTPUT_SIGNAL << channel_read.to_int() << endl;
    }


  INPUT_SIGNAL.close();
  OUTPUT_SIGNAL.close();
  CCS_RETURN(0);

}
