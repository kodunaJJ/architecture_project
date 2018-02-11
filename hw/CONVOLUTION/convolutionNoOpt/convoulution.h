#ifndef CONVOULUTION_H
#define CONVOULUTION_H

//#include"add_bias.h"
//#include"relu.h"
#include"convolution_type.h"
#include <iostream>

using namespace std;

void convolution_2D(double *kernel, double *image, double* image_out)
{

    double* image_Add_zero = new double[(IMG_SIZE+2)*(IMG_SIZE+2)];

  double out1 = 0;


    for(int i=0;i<(IMG_SIZE+2)*(IMG_SIZE+2);i++)
    {
        image_Add_zero[i]=0;


    }

    for(int i=1;i<IMG_SIZE+1;i++)
    {
        for(int j = 1; j<IMG_SIZE+1; j++)
        {
            //cout<<"add zero"<<endl;

            image_Add_zero[i*(IMG_SIZE+2)+j]=image[(i-1)*(IMG_SIZE)+j-1];
           // cout<<image_Add_zero[i*(IMG_SIZE+2)+j]<<endl;
          //  cout<< image_Add_zero[i*(IMG_SIZE+2)+j]<<endl;
            //cout<<image_Add_zero[i*(IMG_SIZE+1)+j+1]<<endl;


        }
    }



    for(int i =0; i<IMG_SIZE;i++)
    {
        for(int a = 0; a <IMG_SIZE;a++)
        {

            out1=0;

            for(int j = 0; j <KERNEL_SIZE; j++)
            {
                for(int b = 0 ; b < KERNEL_SIZE; b++)
                {


                    out1 =  kernel[j*KERNEL_SIZE+b]*image_Add_zero[(i+j)*(IMG_SIZE+2)+a+b]+out1;
                   // out1 =  image_Add_zero[(i+j)*(IMG_SIZE+2)+a+b]+out1;
                    //cout<<"here"<<endl;

                }


            }

           // cout<<"after filtre pixel= " <<i*IMG_SIZE+a<<endl;
            //cout<<"out1"<<endl;
            //cout<<out1<<endl;
            // image_out[i*IMG_SIZE+a]=relu<double>(add_bias<double>(out1,bias));
            image_out[i*IMG_SIZE+a]=out1;

        }

    }
      delete[] image_Add_zero;

    //return image_out;

}















//double*
void convolution_3D(double *kernel, double *image,double* image_out, double* bias){

    double** kernel1;//=new double[KERNELCONVLAYER_CHANNEL_IN_NUM*CNNCONVLAYER_CHANNEL_IN_NUM][KERNEL_SIZE*KERNEL_SIZE] ; //[KERNELCONVLAYER_CHANNEL_IN_NUM*CNNCONVLAYER_CHANNEL_IN_NUM][KERNEL_SIZE*KERNEL_SIZE];
    kernel1 = new double*[CNNCONVLAYER_CHANNEL_IN_NUM];

    for(int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; ++i)
        kernel1[i] = new double[KERNEL_SIZE*KERNEL_SIZE];

    double** image1;// [CNNCONVLAYER_CHANNEL_IN_NUM][IMG_SIZE*IMG_SIZE];
    image1 = new double* [CNNCONVLAYER_CHANNEL_IN_NUM];
    for(int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; ++i)
        image1[i] = new double[IMG_SIZE*IMG_SIZE];


    double** image1_out;// [CNNCONVLAYER_CHANNEL_IN_NUM][IMG_SIZE*IMG_SIZE];
    image1_out = new double* [CNNCONVLAYER_CHANNEL_IN_NUM];
    for(int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; ++i)
        image1_out[i] = new double[IMG_SIZE*IMG_SIZE];

    double* out=new double[IMG_SIZE*IMG_SIZE*KERNELCONVLAYER_CHANNEL_IN_NUM];
   // double* image_out=new double [IMG_SIZE*IMG_SIZE*KERNELCONVLAYER_CHANNEL_IN_NUM];




   for (int i=0;i < KERNELCONVLAYER_CHANNEL_IN_NUM;i++)
    {
       //cout<<"nb kernel ="<< i <<endl;

        for(int j =0; j < CNNCONVLAYER_CHANNEL_IN_NUM; j++)
        {
            //cout <<"nb image ="<< j << endl;
            //cout<<"image"<<endl;
           //cout<<j<<endl;

            for(int a =0; a < KERNEL_SIZE*KERNEL_SIZE; a++ )
            {

               kernel1[j][a]=kernel[i* CNNCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE+j* KERNEL_SIZE*KERNEL_SIZE+a];
                //kernel1[j][a]=kernel[a];

               //cout<<"a=" << a << endl;
                //cout<<"kernel"<<endl;

                 //cout<<kernel1[j][a]<<endl;

            }

            for (int b = 0 ; b < IMG_SIZE*IMG_SIZE ; b++)
            {
                image1[j][b]=image[IMG_SIZE*IMG_SIZE*j+b];
                //cout<<"image"<< endl;
                //cout<<image1[j][b]<<endl;
            }


       convolution_2D(kernel1[j],image1[j], image1_out[j]);



           for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
           {


                out[i*IMG_SIZE*IMG_SIZE+c]=image1_out[j][c]+ out[i*IMG_SIZE*IMG_SIZE+c];
                //cout<<"out_conv2D="<<image1_out[j][c]<<endl;
               //cout<<"sommme= " << out[i*IMG_SIZE*IMG_SIZE+c]<<endl;

               // image_out[i*IMG_SIZE*IMG_SIZE+c]=out[i*IMG_SIZE*IMG_SIZE+c];
                //image_out[i*IMG_SIZE*IMG_SIZE+c]=relu<double>(add_bias<double>(out[i*IMG_SIZE*IMG_SIZE+c],bias[i]));

           }

        }

        for(int c=0; c<IMG_SIZE*IMG_SIZE; c++)
        {
        //image_out[i*IMG_SIZE*IMG_SIZE+c]=out[i*IMG_SIZE*IMG_SIZE+c],bias[i];
        //image_out[i*IMG_SIZE*IMG_SIZE+c]=relu(add_bias(out[i*IMG_SIZE*IMG_SIZE+c],bias[i]));
        
        image_out[i*IMG_SIZE*IMG_SIZE+c]=out[i*IMG_SIZE*IMG_SIZE+c];
        }
    }

   for (int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; i++)
        delete[] kernel1[i];
     delete[] kernel1;

   for (int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; i++)
        delete[] image1[i];
     delete[] image1;
   for (int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; i++)
        delete[] image1_out[i];
     delete[] image1_out;

   delete[] out;


    //return image_out;


}

#endif // CONVOULUTION_H
