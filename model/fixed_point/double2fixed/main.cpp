#include "FPGA_test_DATA.h"
#include "ac_fixed.h"
#include <iostream>
#include <fstream>
#include <iomanip>

int main(){

  std::ofstream result("tot.txt");

  for(int i=0;i<24*24*64;i++){
    result << image_out_ref[i] << std::endl;
  }

  result.close();

  return 0;
  
}
