#ifndef _CNN_WEIGHT_DATATYPE_HPP
#define _CNN_WEIGHT_DATATYPE_HPP


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




#endif
