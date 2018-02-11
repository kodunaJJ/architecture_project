#include "convoulution.h"
#include "FPGA_test_DATA.h"
#include "convolution_type.h"
#include "FPGA_test_DATA_double.h"
#include <fstream>
#include <iomanip>
#include "mc_scverify.h"


CCS_MAIN(int argc, char **argv)
{


    ofstream OUTPUT_DATA_fix("out_fix.txt");
    ofstream OUTPUT_DATA_hw("out_hw.txt");
    ofstream OUTPUT_DATA_db("out_db.txt");

    static conv_out_type image_out[(IMG_SIZE)*(IMG_SIZE)*KERNELCONVLAYER_CHANNEL_IN_NUM];
    static double image_out_db[(IMG_SIZE)*(IMG_SIZE)*KERNELCONVLAYER_CHANNEL_IN_NUM];
    static bias_type bias[KERNELCONVLAYER_CHANNEL_IN_NUM];
    static double bias_db[KERNELCONVLAYER_CHANNEL_IN_NUM];
    static conv_out_type image_out_hw[(IMG_SIZE)*(IMG_SIZE)*KERNELCONVLAYER_CHANNEL_IN_NUM];

     bias[0]=0;
     bias[1]=0;
     bias[2]=0;
     bias[3]=0;
    convolution_3D(kernel_ConvLayer1_fixed,image_hw,image_out,bias);
    convolution_3D_double(kernel_ConvLayer1_db,image_db,image_out_db,bias_db);
    CCS_DESIGN(convolution_hw(kernel_ConvLayer1_fixed,image_hw,image_out_hw,bias));


        for(int i = 0; i <(IMG_SIZE)*(IMG_SIZE)*KERNELCONVLAYER_CHANNEL_IN_NUM; i++)

        {

             OUTPUT_DATA_fix<<image_out[i] <<endl;
             OUTPUT_DATA_db<<image_out_db[i] <<endl;
             OUTPUT_DATA_hw<<image_out_hw[i]<<endl;

        }





CCS_RETURN(0);
}
