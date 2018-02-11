#ifndef CONVOULUTION_H
#define CONVOULUTION_H

/*#include"add_bias.h"
#include"relu.h"*/
#include"convolution_type.h"

using namespace std;




/*void add_bias_hw(ac_channel<Image_in_conv1_type> pixel,bias_type bias,ac_channel<conv_out_type> out_bias){


    out_bias.write(pixel.read()+bias);


}





void relu_hw(ac_channel<Image_in_conv1_type> pixel_in,ac_channel<conv_out_type> relu_out){

    if (pixel_in.read() > 0)
    {
        relu_out.write(pixel_in.read());
    }
    else
    {
        relu_out.write(0);
    }

}
*/




void convolution_2D_hw(Kernel_coef1_type kernel[KERNEL_SIZE*KERNEL_SIZE], Image_in_conv1_type image[IMG_SIZE*IMG_SIZE], convIntern_out_type image_out[IMG_SIZE*IMG_SIZE]){

    static Image_in_conv1_type image_Add_zero[(IMG_SIZE+2)*(IMG_SIZE+2)];

  static conv2D_sum_type out1 = 0;
  static conv_out_type inter_val=0;
  static conv_internProd_type prod=0;


    CLEAR_IMG_PADDED:for(int i=0;i<(IMG_SIZE+2)*(IMG_SIZE+2);i++)
    {
        image_Add_zero[i]=0;


    }

    FILL_IMG_PADDED:for(int i=1;i<IMG_SIZE+1;i++)
    {
        for(int j = 1; j<IMG_SIZE+1; j++)
        {


            image_Add_zero[i*(IMG_SIZE+2)+j]=image[(i-1)*(IMG_SIZE)+j-1];


        }
    }



    CONV2D_MAIN_LOOP:for(int i =0; i<IMG_SIZE;i++)
    {
        for(int a = 0; a <IMG_SIZE;a++)
        {

            out1=0;

            for(int j = 0; j <KERNEL_SIZE; j++)
            {
                CONV2D_MAC_LOOP:for(int b = 0 ; b < KERNEL_SIZE; b++)
                {

		    prod=kernel[j*KERNEL_SIZE+b]*image_Add_zero[(i+j)*(IMG_SIZE+2)+a+b];
                    out1 +=  prod;


                }


            }

            image_out[i*IMG_SIZE+a]=out1;

        }

    }
      //delete[] image_Add_zero;

    //return image_out;

}








#pragma hls_design top


void convolution_3D_hw(Kernel_coef1_type kernel[CNNCONVLAYER_CHANNEL_IN_NUM*KERNELCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE], Image_in_conv1_type image[IMG_SIZE*IMG_SIZE*CNNCONVLAYER_CHANNEL_IN_NUM],conv_out_type image_out[IMG_SIZE*IMG_SIZE*KERNEL_SIZE*KERNEL_SIZE])
{


     static Kernel_coef1_type  kernel_in[KERNEL_SIZE*KERNEL_SIZE];
     static Image_in_conv1_type image_in[IMG_SIZE*IMG_SIZE];
     static convIntern_out_type image1_out[IMG_SIZE*IMG_SIZE];
     static convIntern_out_type out[IMG_SIZE*IMG_SIZE];
     static convIntern_out_type inter_val;


     MAIN_LOOP:for (int i=0;i < KERNELCONVLAYER_CHANNEL_IN_NUM;i++)
     {

         CLEAR_MEM:for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
         {

             out[c]=0;
         }

         IMG_CHANNEL_LOOP:for(int j =0; j < CNNCONVLAYER_CHANNEL_IN_NUM; j++)
         {

             KERNEL_CPY:for(int a =0; a < KERNEL_SIZE*KERNEL_SIZE; a++ )
             {

                kernel_in[a]=kernel[i* CNNCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE+j* KERNEL_SIZE*KERNEL_SIZE+a];

             }

             IMG_CPY:for (int b = 0 ; b < IMG_SIZE*IMG_SIZE ; b++)
             {
                 image_in[b]=image[IMG_SIZE*IMG_SIZE*j+b];

             }


             convolution_2D_hw(kernel_in,image_in,image1_out);
              CONV3D_MAC_LOOP:for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
              {
                 inter_val = out[c];

                  out[c]=image1_out[c]+inter_val;

              }
         }

         IMG_OUT_CPY:for(int c=0; c<IMG_SIZE*IMG_SIZE; c++)
         {
         //image_out[i*IMG_SIZE*IMG_SIZE+c]=out[i*IMG_SIZE*IMG_SIZE+c],bias[i];
         image_out[i*IMG_SIZE*IMG_SIZE+c]=out[c];
         }

     }
}







#endif // CONVOULUTION_H

