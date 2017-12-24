#ifndef _PERCEPTRON_HPP
#define _PERCEPTRON_HPP

#include "constant.hpp"
#include <iostream>

template <typename inputVector_dataType, typename fcLayerVector_dataType,
	  typename outPutValue_dataType,typename internalProduct_dataType,
	  typename internalSum_dataType>
void vectorMult(inputVector_dataType *vectorIn,
		fcLayerVector_dataType *fcVector,
		outPutValue_dataType *valueOut,unsigned char channelNum){
  internalSum_dataType sumValue=0;
  internalProduct_dataType productValue=0;
  for(int i=0;i<RESHAPE_SIZE;i++){
    productValue=(internalProduct_dataType)vectorIn[i]*
      (internalProduct_dataType)fcVector[i*FCLAYER_CHANNELNUM+channelNum];
    /*std::cout << "vectorIn value = " << vectorIn[i] <<
      "fcVector value = "<< fcVector[i*FCLAYER_CHANNELNUM+channelNum]<< std::endl;
     std::cout << "vectorIn value = " << vectorIn[i] <<
      "fcVector value = "<< fcVector[i*FCLAYER_CHANNELNUM+channelNum]<< std::endl;
    std::cout << "procduct value = " << productValue << std::endl;*/
    std::cout << "fcVector index  = " << i*FCLAYER_CHANNELNUM+channelNum << std::endl;
    sumValue+=productValue; /* to be careful when using fixed type */
    
  }
  *valueOut=static_cast<outPutValue_dataType>(sumValue);
}


template <typename inputVector_dataType, typename fcLayerVector_dataType,
	  typename outPutValue_dataType,typename internalProduct_dataType,
	  typename internalSum_dataType>
void perceptron(inputVector_dataType *vectorIn,
		fcLayerVector_dataType *fcVector,
		outPutValue_dataType *perceptronOutVector){
  for(int i=0; i < FCLAYER_CHANNELNUM;i++){

    //vectorMult(vectorIn, fcVector, perceptronOutVector+i,i);
    vectorMult<inputVector_dataType,fcLayerVector_dataType,outPutValue_dataType,
	       internalProduct_dataType, internalSum_dataType>
      (vectorIn, fcVector, perceptronOutVector+i,i);

  }
}

#endif
