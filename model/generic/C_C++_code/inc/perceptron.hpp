#ifndef _PERCEPTRON_HPP
#define _PERCEPTRON_HPP

#include "constant.hpp"
#include <iostream>


/* FUNCTION TO MULTIPLY A VECTOR AND 1 COLUMN OF A MATRIX */
template <typename inputVector_dataType, typename fcLayerVector_dataType,
	  typename outPutValue_dataType,typename internalProduct_dataType,
	  typename internalSum_dataType, typename bias_dataType>
void vectorMult(inputVector_dataType *vectorIn,
		fcLayerVector_dataType *fcVector,
		outPutValue_dataType *valueOut,unsigned char channelNum,
		bias_dataType*bias){
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
    /*std::cout << "fcVector index  = " << i*FCLAYER_CHANNELNUM+channelNum << std::endl;*/
    sumValue+=productValue; /* to be careful when using fixed type */
    
  }
  *valueOut=static_cast<outPutValue_dataType>(sumValue+bias[channelNum]);
}


/* FUNCTION TO REALISE LAYER CALCULATION */
template <typename inputVector_dataType, typename fcLayerVector_dataType,
	  typename outPutValue_dataType,typename internalProduct_dataType,
	  typename internalSum_dataType,typename bias_dataType>
void perceptron(inputVector_dataType *vectorIn,
		fcLayerVector_dataType *fcVector,
		outPutValue_dataType *perceptronOutVector,bias_dataType *bias){
  for(int i=0; i < FCLAYER_CHANNELNUM;i++){

    //vectorMult(vectorIn, fcVector, perceptronOutVector+i,i);
    vectorMult<inputVector_dataType,fcLayerVector_dataType,outPutValue_dataType,
	       internalProduct_dataType, internalSum_dataType>
      (vectorIn, fcVector, perceptronOutVector+i,i);

  }
}

#endif
