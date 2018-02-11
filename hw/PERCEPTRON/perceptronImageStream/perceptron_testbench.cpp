#include "perceptron_types.h"
#include "perceptron_weight_double.h"
#include <fstream>
#include <iostream>
#include <iomanip>
#include "constant.h"
using namespace std ;
#include "mc_scverify.h"


CCS_MAIN(int argc, char *argv) {

  cout<< "PERCEPTRON TESTBENCH START" << endl;

  ofstream INPUT_DATA("perceptronDataIn.txt");
  ofstream OUTPUT_DATA("perceptronDataOut.txt");

  /* perceptron data input for test */
  double testbenchDataIn[RESHAPE_SIZE];
  //double dataREF_out[FCLAYER_CHANNELNUM];
  double dataREF_out;
 perceptronDataIn_type dataHW_in[RESHAPE_SIZE];
perceptronDataOut_type dataHW_out[FCLAYER_CHANNELNUM];   

  perceptronWeight_type weight_fixed[PERCEPTRON_WEIGHT_NUM];
  perceptronBias_type bias_fixed[FCLAYER_CHANNELNUM];

  /*static ac_channel<perceptronDataIn_type> dataIn;
    static ac_channel<perceptronDataOut_type> dataOut;*/

  double double_in,double_out;
  double fixed_out;
  double worst_error = 0;
  double diff;

  perceptronDataOut_type channel_read = 0;
  perceptronDataOut_type temp;


  /* init input data for test */
  for(int i=0;i<RESHAPE_SIZE;i++){
    testbenchDataIn[i]=1;
    dataHW_in[i]=testbenchDataIn[i];
  }

  /* convert weight in double format to fixed */
  for(int i=0;i<PERCEPTRON_WEIGHT_NUM;i++){
    weight_fixed[i]=perceptronWeight_double[i];
  }

  for(int i=0;i<FCLAYER_CHANNELNUM;i++){
    bias_fixed[i]=perceptronBias_double[i];
  }

  //for(int i=0;i<RESHAPE_SIZE;i++){

    /* reference output caculation */
    /*perceptron_v2_REF(testbenchDataIn, perceptron_double,
		      perceptronBias_double, &dataREF_out);*/
		      
		      //temp=dataREF_out

    INPUT_DATA << dataREF_out << endl;

    //dataIn.write(dataHW_in[i]);

    CCS_DESIGN(perceptron_v2_HW)(dataHW_in, perceptronWeight_fixed, perceptronBias_fixed,dataHW_out);
	for(int idx=0;idx<FCLAYER_CHANNELNUM;idx++){	
	OUTPUT_DATA << dataHW_out[idx] << endl;
	}
    /*if(dataOut.available(1)){
      channel_read = dataOut.read();
      /// compare with double precision reference
      /*fixed_out = channel_read.to_double();
      diff = fixed_out - double_out;
      diff = (diff<0) ? -diff : diff;
      worst_error = (diff > worst_error) ? diff : worst_error;*/
      //OUTPUT_DATA << channel_read.to_int() << endl;
    //}


  INPUT_DATA.close();
  OUTPUT_DATA.close();
  CCS_RETURN(0);

}
