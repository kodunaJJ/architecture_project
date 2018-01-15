#ifndef _RESHAPE_HPP__
#define _RESHAPE_HPP__

#include "constant.hpp"

template<typename reshape_dataType>
void reshape(reshape_dataType *imgIn,reshape_dataType *imgOut){

  int offset=MAXPOOL_LAYER3_OUT_SIZE*MAXPOOL_LAYER3_OUT_SIZE;
  for(int i=0;i<offset;i++){
    for(int j=0;j<CONVLAYER3_CHANNELNUM;j++){
      imgOut[i*CONVLAYER3_CHANNELNUM+j]=imgIn[j*offset+i];
    }
    
  }
}

#endif
