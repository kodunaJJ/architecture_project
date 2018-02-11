#ifndef CONVOLUTION_TYPE
#define CONVOLUTION_TYPE



#include "ac_fixed.h"
#include "ac_channel.h"


//#include "/home/yawen/Bureau/3A/projet_arch/shared/include/ac_fixed.h"
//#include "/home/yawen/Bureau/3A/projet_arch/shared/include/ac_channel.h"



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

typedef ac_fixed<8,3,true,AC_RND_INF,AC_SAT> Kernel_coef1_type;

typedef ac_fixed<8,3,true,AC_RND_INF,AC_SAT> bias_type;
typedef ac_fixed<12,6,true,AC_TRN,AC_SAT> conv_out_type;





//convLayer1Out_dataType add_bias_hw(convLayer1Out_dataType pixel,biasLayer1_weightDataType bias);
//convLayer1Out_dataType relu_hw(convLayer1Out_dataType pixel_in);
//void convolution_2D_hw(Kernel_coef1_type kernel[KERNEL_SIZE*KERNEL_SIZE], Image_in_conv1_type image[IMG_SIZE*IMG_SIZE], ac_channel<conv_out_type> &image_out);
//void convolution_3D_hw( kernelLayer1_weightDataType[CNNCONVLAYER_CHANNEL_IN_NUM*KERNELCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE],imageNorm_dataType[IMG_SIZE*IMG_SIZE*CNNCONVLAYER_CHANNEL_IN_NUM],convLayer1Out_dataType[IMG_SIZE*IMG_SIZE*KERNEL_SIZE*KERNEL_SIZE]);

void convolution_hw(Kernel_coef1_type kernel[CNNCONVLAYER_CHANNEL_IN_NUM*KERNELCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE], Image_in_conv1_type image[IMG_SIZE*IMG_SIZE*CNNCONVLAYER_CHANNEL_IN_NUM],conv_out_type image_out[IMG_SIZE*IMG_SIZE*KERNEL_SIZE*KERNEL_SIZE],bias_type bias[KERNELCONVLAYER_CHANNEL_IN_NUM]);





#endif // CONVOLUTION_TYPE

