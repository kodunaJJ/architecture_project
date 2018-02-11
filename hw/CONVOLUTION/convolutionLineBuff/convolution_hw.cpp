#include "convolution_type.h"

#pragma hls_design top

void convolution_hw(Kernel_coef1_type kernel[CNNCONVLAYER_CHANNEL_IN_NUM*KERNELCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE], Image_in_conv1_type image[IMG_SIZE*IMG_SIZE*CNNCONVLAYER_CHANNEL_IN_NUM],conv_out_type image_out[IMG_SIZE*IMG_SIZE*KERNEL_SIZE*KERNEL_SIZE],bias_type bias[KERNELCONVLAYER_CHANNEL_IN_NUM])

{
static Kernel_coef1_type kernel_in[KERNEL_SIZE*KERNEL_SIZE];

static Image_in_conv1_type image_in_add_zero[(IMG_SIZE+2)*(IMG_SIZE+2)];
static conv_out_type image1_out[IMG_SIZE*IMG_SIZE];
static conv_out_type out [IMG_SIZE*IMG_SIZE];
static Image_in_conv1_type registre [(IMG_SIZE+2)*2+3];
int indix =0;
int ligne = 0;


initialiser_zero_padding: for(int i=0;i<(IMG_SIZE+2)*(IMG_SIZE+2);i++)
 {
     image_in_add_zero[i]=0;

 }



start_new_kernel:for (int i=0;i < KERNELCONVLAYER_CHANNEL_IN_NUM;i++)
{

    initialiser_out:for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
    {

        out[c]=0;
    }

   start_new_image: for(int j =0; j < CNNCONVLAYER_CHANNEL_IN_NUM; j++)
    {


        load_kernel_registre:for(int a =0; a < KERNEL_SIZE*KERNEL_SIZE; a++ )
        {

           kernel_in[a]=kernel[i* CNNCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE+j* KERNEL_SIZE*KERNEL_SIZE+a];

        }

        load_image_in_zero_padding_memory:for(int h=1;h<IMG_SIZE+1;h++)
        {
            for(int f= 1; f<IMG_SIZE+1; f++)
            {


                image_in_add_zero[h*(IMG_SIZE+2)+f]=image[IMG_SIZE*IMG_SIZE*j+(h-1)*IMG_SIZE+f-1];
            }
        }

              ligne=0;

       load_image_delayline: for(int c =0; c< (IMG_SIZE+2)*(IMG_SIZE+2); c++)
        {



             shift_delayline: for(int b = 0;b <(IMG_SIZE+2)*2+2 ; b++)
                 {


                       registre[b] = registre[b+1];

                     }
              registre[(IMG_SIZE+2)*2+2]=image_in_add_zero[c];



        if(c>((IMG_SIZE+2)*2+1))
        {

            if((c-((IMG_SIZE+2)*2+2))>ligne*(IMG_SIZE+2)||(c-((IMG_SIZE+2)*2+2))==ligne*(IMG_SIZE+2))
            {
                ligne++;
            }


            if((c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)<24||(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)>25&&(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)<50||(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)>51)
            {

            indix=c-((IMG_SIZE+2)*2+2)-2*(ligne-1);


            image1_out[indix] = kernel_in[0]*registre[0]
                                                          +kernel_in[1]*registre[1]
                                                          +kernel_in[2]*registre[2]
                                                          +kernel_in[3]*registre[IMG_SIZE+2]
                                                          +kernel_in[4]*registre[IMG_SIZE+3]
                                                          +kernel_in[5]*registre[IMG_SIZE+4]
                                                          +kernel_in[6]*registre[2*(IMG_SIZE+2)]
                                                          +kernel_in[7]*registre[2*(IMG_SIZE+2)+1]
                                                          +kernel_in[8]*registre[2*(IMG_SIZE+2)+2];



            }








        }

        }




        sum_out: for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
         {


             out[c]=image1_out[c]+out[c];

         }
    }

   copy_out_in_out_memory: for(int c=0; c<IMG_SIZE*IMG_SIZE; c++)
    {
       image_out[i*IMG_SIZE*IMG_SIZE+c]=out[c];
    }

}


}
