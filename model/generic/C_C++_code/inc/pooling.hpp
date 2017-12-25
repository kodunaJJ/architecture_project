#ifndef _POOLING_HPP
#define _POOLING_HPP

#include "constant.hpp"
#include <iostream>

/* find max value in a MAXPOOL_BLOCK_SIZE array */
template <typename pooling_DataType>
void maxFinder(pooling_DataType *poolBlockIn,pooling_DataType *valueOut){

  pooling_DataType maxValue=poolBlockIn[0];

  for(int i=0;i<MAXPOOL_BLOCK_SIZE;i++){

    if(maxValue < poolBlockIn[i]){
      maxValue=poolBlockIn[i];
    }
  }
  *valueOut=maxValue;
}


/* Fetch max pool data and realise a padding with padding value */
template <typename pooling_DataType>
void fillPoolBlock(pooling_DataType *dataIn,pooling_DataType *block,
                   pooling_DataType paddingValue, int heightPos,int widthPos,
                   int padAlongHeight,int padAlongWidth,
                   const char dataInSize){
  if((padAlongHeight == 0) && (padAlongWidth == 0)){
    for(int i=0;i<MAXPOOL_SIZE;i++){ /* loop on height */
      for(int j=0;j<MAXPOOL_SIZE;j++){ /* loop on width */
        block[i*MAXPOOL_SIZE+j]=dataIn[(heightPos+i)*dataInSize+(widthPos+j)];
	/*std::cout << "block index = " << (heightPos+i)*dataInSize+(widthPos+j)
		  <<std::endl;*/
      }
    }
  }
  else if((padAlongHeight == 1) && (padAlongWidth == 0)){
    for(int i=0;i<MAXPOOL_SIZE;i++){ /* loop on height */
      for(int j=0;j<MAXPOOL_SIZE;j++){ /* loop on width */
        if(j < MAXPOOL_SIZE-1){
          block[i*MAXPOOL_SIZE+j]=dataIn[(heightPos+i)*dataInSize+(widthPos+j)];
        }
        else{
          block[i*MAXPOOL_SIZE+j]=paddingValue;
        }

      }
      //block[i*MAXPOOL_SIZE+MAXPOOL_STRIDE]=paddingValue;
    }
  }
  else if((padAlongHeight == 0) && (padAlongWidth == 1)){
    for(int i=0;i<MAXPOOL_SIZE;i++){ /* loop on height */
      block[i*MAXPOOL_SIZE+MAXPOOL_STRIDE]=paddingValue;
      for(int j=0;j<MAXPOOL_SIZE;j++){ /* loop on width */
        if(i <MAXPOOL_SIZE-1){
          block[i*MAXPOOL_SIZE+j]=dataIn[(heightPos+i)*dataInSize+(widthPos+j)];
        }
        else{
          block[i*MAXPOOL_SIZE+j]=paddingValue;
        }

      }
    }
  }
  else{
    for(int i=0;i<MAXPOOL_SIZE;i++){ /* loop on height */
      block[i*MAXPOOL_SIZE+MAXPOOL_STRIDE]=paddingValue;
      for(int j=0;j<MAXPOOL_SIZE;j++){ /* loop on width */
        if((i <MAXPOOL_SIZE-1) && (j <MAXPOOL_SIZE-1)){
          block[i*MAXPOOL_SIZE+j]=dataIn[(heightPos+i)*dataInSize+(widthPos+j)];
        }
        else{
          block[i*MAXPOOL_SIZE+j]=paddingValue;
        }

      }
    }
  }

}


template <typename pooling_DataType>
void maxPooling(pooling_DataType *dataIn, const char dataInSize,
                const char dataInChannelNum,pooling_DataType *dataOut,
                pooling_DataType paddingValue){

  pooling_DataType poolBlock[MAXPOOL_BLOCK_SIZE];
  int dataInSizeSq=dataInSize*dataInSize;
  int padAlongHeight=0;
  int padAlongWidth=0;
  for(int channelPos=0;channelPos<dataInChannelNum;channelPos++){
    for(int heightPos=0;heightPos<(dataInSize+MAXPOOL_PADDING_VALUE)-
          (MAXPOOL_SIZE-1);heightPos+=MAXPOOL_STRIDE){
      if(heightPos+MAXPOOL_SIZE>dataInSize){
	padAlongWidth=1;
      }
      else{
	padAlongWidth=0;
      }
      for(int widthPos=0;widthPos<(dataInSize+MAXPOOL_PADDING_VALUE)-
            (MAXPOOL_SIZE-1);widthPos+=MAXPOOL_STRIDE){
	      if(widthPos+MAXPOOL_SIZE>dataInSize){
	padAlongHeight=1;
      }
      else{
	padAlongHeight=0;
      }
	fillPoolBlock(dataIn+(dataInSizeSq*channelPos),poolBlock,
		      paddingValue,heightPos,widthPos,padAlongHeight,
		      padAlongWidth,dataInSize);
	/*for(int i =0;i<MAXPOOL_BLOCK_SIZE;i++){
	std::cout << "blockIn n°"<< heightPos << ","<< widthPos << " "
		  << poolBlock[i]<< std::endl;
	}*/
	maxFinder(poolBlock,dataOut+((heightPos*dataInSize/2+widthPos)/2+
				     channelPos*dataInSizeSq/4));
	/*std::cout<< "store index = " << (heightPos*dataInSize/2+widthPos)/2+
	  channelPos*dataInSizeSq/4 << std::endl;*/

      }
    }
  }
}


#endif
