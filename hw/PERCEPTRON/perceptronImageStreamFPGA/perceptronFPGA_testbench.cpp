#include "perceptron_types.h"
#include "mc_scverify.h"
#include <iostream>

CCS_MAIN(int argc, char *argv){

  std::cout << "TESTBENCH STARTED" << std::endl;

  bool testOut=false;
  bool errorInject=false;
  
  for(int i=0;i<2;i++){

CCS_DESIGN(top)(testOut,errorInject);
  
  if(testOut==true){
    std::cout<<"TEST_PASSED" <<std::endl;
  }
  else{
    std::cout<<"TEST_FAILED" <<std::endl;
  }
  errorInject=true;
  }
  CCS_RETURN(0);
}

