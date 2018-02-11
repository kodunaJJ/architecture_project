#ifndef CONVOLUTION_TYPE
#define CONVOLUTION_TYPE



#include "ac_fixed.h"
#include "ac_channel.h"
#include "mc_scverify.h"



#define N_pixel 57

#define DATA_WIDTH 8// 16-bit coefficients with rounding to +/- infinity are needed for +/- 0.5 LSB accuracy against floating point
// Feel free to change this to trade off area vs precision
#define COEFF_WIDTH 16
#define KERNEL_SIZE 3
#define IMG_SIZE 24


#define KERNELCONVLAYER_CHANNEL_IN_NUM 64
#define CNNCONVLAYER_CHANNEL_IN_NUM  3



// This headroom determines the additional accuracy of the accumulator. Here we make it full precision for numerical safety


typedef ac_fixed<8,3,true,AC_RND_INF,AC_SAT> Image_in_conv1_type ;
typedef ac_fixed<DATA_WIDTH,10,true,AC_RND_INF,AC_SAT> Image_in_conv2_type ;
typedef ac_fixed<DATA_WIDTH,10,true,AC_RND_INF,AC_SAT> Image_in_conv3_type ;
typedef ac_fixed<8,3,true,AC_RND_INF,AC_SAT> Kernel_coef1_type;
typedef ac_fixed<DATA_WIDTH,10,true,AC_RND_INF,AC_SAT> Kernel_coef2_type;
typedef ac_fixed<DATA_WIDTH,10,true,AC_RND_INF,AC_SAT> Kernel_coef3_type;
typedef ac_fixed<8,3,true,AC_RND_INF,AC_SAT> bias_type;
typedef ac_fixed<12,6,true,AC_TRN,AC_SAT> conv_out_type;
typedef ac_fixed<13,4,true,AC_TRN,AC_SAT> conv_internProd_type;
typedef ac_fixed<13,6,true,AC_TRN,AC_SAT> conv2D_sum_type;
typedef ac_fixed<15,8,true,AC_TRN,AC_SAT> convIntern_out_type;





//void add_bias_hw(ac_channel<Image_in_conv1_type> pixel,bias_type bias,ac_channel<conv_out_type> out_bias);
//void relu_hw(ac_channel<Image_in_conv1_type> pixel_in,ac_channel<conv_out_type> relu_out);
//void convolution_2D_hw(Kernel_coef1_type kernel[KERNEL_SIZE*KERNEL_SIZE], Image_in_conv1_type image[IMG_SIZE*IMG_SIZE], ac_channel<conv_out_type> &image_out);
void convolution_3D_hw(Kernel_coef1_type kernel[CNNCONVLAYER_CHANNEL_IN_NUM*KERNELCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE], Image_in_conv1_type image[IMG_SIZE*IMG_SIZE*CNNCONVLAYER_CHANNEL_IN_NUM],conv_out_type image_out[IMG_SIZE*IMG_SIZE*KERNEL_SIZE*KERNEL_SIZE]);








#endif // CONVOLUTION_TYPE

