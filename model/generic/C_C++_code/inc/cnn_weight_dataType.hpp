#ifndef _CNN_WEIGHT_DATATYPE_HPP
#define _CNN_WEIGHT_DATATYPE_HPP

#include <fstream>
#include <iostream>
#include "constant.hpp"
/*
template <typename weightDataType>
class kernel{
public:
  unsigned char kernelHeight;
  unsigned char channelInNum;
  unsigned char channelNum;
  unsigned int kernelSize;
  weightDataType *kernelWeight;

  kernel(unsigned char height,unsigned char channelInNum,
	 unsigned char ChannelNum);
  void init_kernel();
  ~kernel();
};

template <typename weightDataType>
class bias{
public:
  unsigned char channelNum;  
  weightDataType *biasWeight;

  bias(unsigned char size);
  void init_bias();
  ~bias();
};
*/

template <typename kernel_weightDataType>
void init_kernel(std::ifstream weight_fs, kernel_weightDataType *kernel,
		 const unsigned char kernel_size,
		 const unsigned char kernel_channelInNum,
		 const unsigned char kernel_channel);

template <typename bias_weightDataType>
void init_bias(std::ifstream weight_fs, bias_weightDataType *bias,
	       const unsigned char bias_size);


template <typename fcLayer_weightDataType>
void init_fcLayer(std::ifstream weight_fs, fcLayer_weightDataType *fcLayer,
		  const unsigned char fcLayer_size);






#endif
