#ifndef __IMAGE_NORMALIZE_H__
#define __IMAGE_NORMALIZE_H__

#include <math.h>
#include <iostream>

template <typename pixelDataType, typename imageNorm_dataType>
  void imageNorm(pixelDataType *imgIn, imageNorm_dataType *imgNormalized,
                 int imgIn_width, int imgIn_height, int imgIn_channelNum,
                 int imgNorm_width, int imgNorm_height,
                 int imgNorm_channelNum, int clipValue){
  //std::cout <<"new table created" <<std::endl;
  int row_start_idx=(imgIn_height-imgNorm_height)/2;
  int column_start_idx=(imgIn_width-imgNorm_width)/2;
  double mu=0;
  double sigma=0;

  //int idxDebug=0;
  double *imgNorm=new double[imgNorm_height*imgNorm_width*imgNorm_channelNum];

  for(int idx=0;idx<imgNorm_height*imgNorm_width*imgNorm_channelNum;idx++){
    imgNorm[idx]=0;
  }

  /*std::cout <<"imgIn = " << imgIn[0] <<std::endl;
  std::cout <<"rowStartidx = " << row_start_idx <<std::endl;
  std::cout <<"columnStartidx = " << column_start_idx <<std::endl;*/
  for(int channel=0; channel<imgIn_channelNum;channel++){
    for(int row=row_start_idx;row<imgNorm_height+row_start_idx;row++){
      for(int column=column_start_idx;column<imgNorm_width+column_start_idx;column++){
        /* loading imgNorm */
        imgNorm[((row-row_start_idx)*imgNorm_height+
                 (column-column_start_idx))+channel*imgNorm_width*imgNorm_height]=imgIn[(row*imgIn_height+column)+
                                                                         channel*imgIn_width*imgIn_height];
        /* sum all pixel value for mean calculation*/
        mu+=imgNorm[((row-row_start_idx)*imgNorm_height+
                     (column-column_start_idx))+channel*imgNorm_width*imgNorm_height];
	/*std::cout <<"imgIn = " << imgIn[(row*imgIn_height+column)+channel*imgIn_width*imgNorm_height] <<std::endl;
	std::cout <<"imgNorm = " << imgNorm[((row-row_start_idx)*imgNorm_height+
					     (column-column_start_idx))+channel*imgNorm_width*imgNorm_height] <<std::endl;
	std::cout <<"mean = " << mu <<std::endl;
	std::cout <<"iter num = " << idxDebug <<std::endl;
	idxDebug++;*/
      }
    }
  }
  
  // std::cout <<"meanSum = " << mu <<std::endl;
  mu/=imgNorm_height*imgNorm_width*imgNorm_channelNum;
  //std::cout <<"mean = " << mu <<std::endl;
  for(int channel=0; channel<imgNorm_channelNum;channel++){
    for(int row=0; row<imgNorm_height;row++){
      for(int column=0; column<imgNorm_width;column++){
        /* sigma calc */
        sigma+=(imgNorm[(row*imgNorm_height+column)+channel*imgNorm_width*imgNorm_height]-mu)*
          (imgNorm[(row*imgNorm_height+column)+channel*imgNorm_width*imgNorm_height]-mu);
      }
    }
  }
  //std::cout <<"sigmaSum = " << sigma <<std::endl;
  sigma=sqrt(((double)1/(double)(imgNorm_height*imgNorm_width*imgNorm_channelNum))*sigma);
  //std::cout <<"sigma = " << sigma <<std::endl;

  double r=(double)1/sqrt(imgNorm_height*imgNorm_width*imgNorm_channelNum);

  //std::cout <<"1/sqrt(N) = " << r <<std::endl;
  if(sigma<r){
    sigma=r;
  }

  for(int channel=0; channel<imgNorm_channelNum;channel++){
    for(int row=0; row<imgNorm_height;row++){
      for(int column=0; column<imgNorm_width;column++){
        /* imageNorm calc + crop */
        r=(imgNorm[(row*imgNorm_height+column)+channel*imgNorm_width*imgNorm_height]-mu)/sigma;
        if(r<(-clipValue)){
          imgNormalized[(row*imgNorm_height+column)+channel*imgNorm_width*imgNorm_height]=(-clipValue);
        }
        else if(r>clipValue){
          imgNormalized[(row*imgNorm_height+column)+channel*imgNorm_width*imgNorm_height]=clipValue;
        }
        else{
          imgNormalized[(row*imgNorm_height+column)+channel*imgNorm_width*imgNorm_height]=r;
        }
      }
    }
  }
  //delete [] imgNorm;
}

#endif
