#ifndef CONVOULUTION_H
#define CONVOULUTION_H

#include <iostream>
//#include "/home/yawen/Bureau/3A/projet_arch/shared/include/ac_fixed.h"


using namespace std;
const unsigned char IMG_SIZE = 3;
const unsigned char KERNEL_SIZE=3;
const unsigned char KERNELCONVLAYER_CHANNEL_IN_NUM = 1;
const unsigned char CNNCONVLAYER_CHANNEL_IN_NUM = 3;

/*
template <typename kernel_weightDataType, typename image_DataType>
image_DataType* convolution_2D(kernel_weightDataType *kernel, image_DataType *image);

template <typename kernel_weightDataType, typename image_DataType>
image_DataType* convolution_3D(kernel_weightDataType *kernel, image_DataType *image);
*/

template <typename kernel_weightDataType, typename image_DataType,typename image_DataType_out>
//image_DataType_out*
void convolution_2D(kernel_weightDataType *kernel, image_DataType *image, image_DataType_out* image_out)
{

    image_DataType* image_Add_zero = new image_DataType[(IMG_SIZE+2)*(IMG_SIZE+2)];

  // image_DataType_out* image_out = new image_DataType_out[(IMG_SIZE)*(IMG_SIZE)];

    for(int i=0;i<(IMG_SIZE+2)*(IMG_SIZE+2);i++)
    {
        image_Add_zero[i]=0;


    }

    for(int i=1;i<IMG_SIZE+1;i++)
    {
        for(int j = 1; j<IMG_SIZE+1; j++)
        {
            image_Add_zero[i*(IMG_SIZE+2)+j]=image[(i-1)*(IMG_SIZE)+j-1];
          //  cout<< image_Add_zero[i*(IMG_SIZE+2)+j]<<endl;
            //cout<<image_Add_zero[i*(IMG_SIZE+1)+j+1]<<endl;


        }
    }



    for(int i =0; i<IMG_SIZE+1;i++)
    {
        for(int a = 0; a <IMG_SIZE+1;a++)
        {
            for(int j = 0; j <KERNEL_SIZE; j++)
            {
                for(int b = 0 ; b < KERNEL_SIZE; b++)
                {
                    // cout<< "kernel"<<endl;
                      //cout<< kernel[j*KERNEL_SIZE+b]<<endl;
                   // image_out[i*IMG_SIZE+a] = 1*kernel[4];
                   image_out[i*IMG_SIZE+a] =  image_DataType_out (kernel[j*KERNEL_SIZE+b]*image_Add_zero[(i+j)*(IMG_SIZE+2)+a+b]+image_out[i*IMG_SIZE+a]);
                    cout<<"here"<<endl;


                }

            }


            //cout<<image_Add_zero[i*(IMG_SIZE+2)+a]<<endl;
        }

    }
      delete[] image_Add_zero;

    //return image_out;

}














template <typename kernel_weightDataType, typename image_DataType,typename image_DataType_out>
//image_DataType_out*
void convolution_3D(kernel_weightDataType *kernel, image_DataType *image,image_DataType_out* image_out){

    kernel_weightDataType** kernel1;//=new kernel_weightDataType[KERNELCONVLAYER_CHANNEL_IN_NUM*CNNCONVLAYER_CHANNEL_IN_NUM][KERNEL_SIZE*KERNEL_SIZE] ; //[KERNELCONVLAYER_CHANNEL_IN_NUM*CNNCONVLAYER_CHANNEL_IN_NUM][KERNEL_SIZE*KERNEL_SIZE];
    kernel1 = new kernel_weightDataType*[KERNELCONVLAYER_CHANNEL_IN_NUM*CNNCONVLAYER_CHANNEL_IN_NUM];

    for(int i = 0; i < KERNELCONVLAYER_CHANNEL_IN_NUM*CNNCONVLAYER_CHANNEL_IN_NUM; ++i)
        kernel1[i] = new kernel_weightDataType[KERNEL_SIZE*KERNEL_SIZE];

    image_DataType** image1;// [CNNCONVLAYER_CHANNEL_IN_NUM][IMG_SIZE*IMG_SIZE];
    image1 = new image_DataType* [CNNCONVLAYER_CHANNEL_IN_NUM];
    for(int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; ++i)
        image1[i] = new image_DataType[IMG_SIZE*IMG_SIZE];


    image_DataType_out** image1_out;// [CNNCONVLAYER_CHANNEL_IN_NUM][IMG_SIZE*IMG_SIZE];
    image1_out = new image_DataType_out* [CNNCONVLAYER_CHANNEL_IN_NUM];
    for(int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; ++i)
        image1_out[i] = new image_DataType_out[IMG_SIZE*IMG_SIZE];

   // image_DataType_out* image_out=new image_DataType_out [IMG_SIZE*IMG_SIZE*KERNELCONVLAYER_CHANNEL_IN_NUM];

//kernel1[1][1]=0;

   for (int i=0;i < KERNELCONVLAYER_CHANNEL_IN_NUM;i++)
    {
        cout<<"nb kernel ="<< i <<endl;

        for(int j =0; j < CNNCONVLAYER_CHANNEL_IN_NUM; j++)
        {
            cout <<"nb image ="<< j << endl;
            //cout<<"image"<<endl;
            //cout<<j<<endl;

            for(int a =0; a < KERNEL_SIZE*KERNEL_SIZE; a++ )
            {

                kernel1[i*CNNCONVLAYER_CHANNEL_IN_NUM+j][a]=kernel[i* CNNCONVLAYER_CHANNEL_IN_NUM+j* KERNEL_SIZE*KERNEL_SIZE+a];
                cout<<"a=" << a << endl;

                 //cout<<kernel1[i*CNNCONVLAYER_CHANNEL_IN_NUM+j][a]<<endl;

            }

            for (int b = 0 ; b < IMG_SIZE*IMG_SIZE ; b++)
            {
                image1[j][b]=image[IMG_SIZE*IMG_SIZE*j+b];
                  cout<<"b=" << b << endl;
                //cout<<image1[j][b]<<endl;
            }

       convolution_2D<kernel_weightDataType,image_DataType,image_DataType_out>(kernel1[i*CNNCONVLAYER_CHANNEL_IN_NUM+j],image1[j],  image1_out[j]);


           for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
           {


               //cout <<"nb pixel= "<< c <<endl;

                image_out[i*IMG_SIZE*IMG_SIZE+c]=image1_out[j][c]+image_out[i*IMG_SIZE*IMG_SIZE+c];

                //cout<<image_out[i*IMG_SIZE*IMG_SIZE+c]<<endl;
           }

        }
    }

   for (int i = 0; i < KERNELCONVLAYER_CHANNEL_IN_NUM*CNNCONVLAYER_CHANNEL_IN_NUM; i++)
        delete[] kernel1[i];
     delete[] kernel1;

   for (int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; i++)
        delete[] image1[i];
     delete[] image1;
   for (int i = 0; i < CNNCONVLAYER_CHANNEL_IN_NUM; i++)
        delete[] image1_out[i];
     delete[] image1_out;


    //return image_out;


}

#endif // CONVOULUTION_H
