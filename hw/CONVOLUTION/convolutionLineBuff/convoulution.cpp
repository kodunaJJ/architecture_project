#include "convoulution.h"



#include <iostream>




using namespace std;

double relu(double pixel_in){

    if (pixel_in > 0)
    {
        return pixel_in;
    }
    else
    {
        return 0;
    }

}



double add_bias(double pixel,double bias){


    return pixel+bias;


}







void convolution_3D(Kernel_coef1_type *kernel, Image_in_conv1_type *image,conv_out_type* image_out, bias_type* bias){


     Kernel_coef1_type* kernel_in = new  Kernel_coef1_type[KERNEL_SIZE*KERNEL_SIZE];
     //double* image_in = new  double [IMG_SIZE*IMG_SIZE];
     Image_in_conv1_type* image_in_add_zero= new Image_in_conv1_type[(IMG_SIZE+2)*(IMG_SIZE+2)];
   conv_out_type* image1_out = new conv_out_type[IMG_SIZE*IMG_SIZE];
    conv_out_type* out = new conv_out_type[IMG_SIZE*IMG_SIZE];
     Image_in_conv1_type* registre = new Image_in_conv1_type[(IMG_SIZE+2)*2+3];
     int indix =0;
     int indixC=(IMG_SIZE+2)*2+2;
     int ligne = 0;
     

     //cout<<"initialiser le mémoire pour image à 0"<<endl;
      for(int i=0;i<(IMG_SIZE+2)*(IMG_SIZE+2);i++)
      {
          image_in_add_zero[i]=0;

      }



     for (int i=0;i < KERNELCONVLAYER_CHANNEL_IN_NUM;i++)
     {
        //cout<<"numéro de kernel = "<<i<<endl;
         for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
         {

             out[c]=0;
         }

         for(int j =0; j < CNNCONVLAYER_CHANNEL_IN_NUM; j++)
         {
             //cout<<"numéro de image = "<< j <<endl;



             //cout<<"load kernel"<<endl;
             for(int a =0; a < KERNEL_SIZE*KERNEL_SIZE; a++ )
             {

                kernel_in[a]=kernel[i* CNNCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE+j* KERNEL_SIZE*KERNEL_SIZE+a];

             }

            /* for (int b = 0 ; b < IMG_SIZE*IMG_SIZE ; b++)
             {
                 image_in_add_zero[b]=image[IMG_SIZE*IMG_SIZE*j+b];

             }*/

            //cout<<"load image"<<endl;
             for(int h=1;h<IMG_SIZE+1;h++)
             {
                 for(int f= 1; f<IMG_SIZE+1; f++)
                 {


                     image_in_add_zero[h*(IMG_SIZE+2)+f]=image[IMG_SIZE*IMG_SIZE*j+(h-1)*IMG_SIZE+f-1];
                    // cout<<"dans image_add_0 "<<image_in_add_zero[h*(IMG_SIZE+2)+f]<<endl;
                 }
             }

           // cout<<"registrre à décalage"<<endl;
             ligne=0;

             for(int c =0; c< (IMG_SIZE+2)*(IMG_SIZE+2); c++)
             {



                   for(int b = 0;b <(IMG_SIZE+2)*2+2 ; b++)
                      {


                            registre[b] = registre[b+1];

                          }
                   registre[(IMG_SIZE+2)*2+2]=image_in_add_zero[c];



             if(c>((IMG_SIZE+2)*2+1))
             {

                 /*if(c%((IMG_SIZE+2)*2+2)<24||c%((IMG_SIZE+2)*2+2)>25&&c%((IMG_SIZE+2)*2+2)<50||c%((IMG_SIZE+2)*2+2)>51)
                 {

                     if(c%((IMG_SIZE+2)*2+2)<24)

                     {
                         indix=c-((IMG_SIZE+2)*2+2);
                     }
                     else if (c%((IMG_SIZE+2)*2+2)>25&&c%((IMG_SIZE+2)*2+2)<50)

                     {
                          indix=c-(IMG_SIZE+2)*2-4;
                     }
                     else
                     {
                         indix=c-(IMG_SIZE+2)*2-6;
                     }
                                cout<<"indix = " <<c-((IMG_SIZE+2)*2+2)<<endl;

                               /*  image1_out[indix] = kernel_in[0]*registre[0]
                                              +kernel_in[1]*registre[1]
                                              +kernel_in[2]*registre[2]
                                              +kernel_in[3]*registre[IMG_SIZE+2]
                                              +kernel_in[4]*registre[IMG_SIZE+3]
                                              +kernel_in[5]*registre[IMG_SIZE+4]
                                              +kernel_in[6]*registre[2*(IMG_SIZE+2)]
                                              +kernel_in[7]*registre[2*(IMG_SIZE+2)+1]
                                              +kernel_in[8]*registre[2*(IMG_SIZE+2)+2];*/
             //}


                 if((c-((IMG_SIZE+2)*2+2))>ligne*(IMG_SIZE+2)||(c-((IMG_SIZE+2)*2+2))==ligne*(IMG_SIZE+2))
                 {
                     ligne++;
                 }

                 //cout<<"ligne= "<<ligne<<endl;

                 if((c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)<24||(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)>25&&(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)<50||(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)>51)
                 {

                 indix=c-((IMG_SIZE+2)*2+2)-2*(ligne-1);
                 //cout<<"indix = " <<indix<<endl;

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




              for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
              {
                // inter_val = out[c];

                  out[c]=image1_out[c]+out[c];

              }
         }

         for(int c=0; c<IMG_SIZE*IMG_SIZE; c++)
         {
         //image_out[i*IMG_SIZE*IMG_SIZE+c]=out[i*IMG_SIZE*IMG_SIZE+c],bias[i];
        // image_out[i*IMG_SIZE*IMG_SIZE+c]=relu(add_bias(out[c],bias[i]));
            image_out[i*IMG_SIZE*IMG_SIZE+c]=out[c];
         }

     }


     delete[]kernel_in;
     delete[]image_in_add_zero;
     delete[]registre;
     delete[]image1_out;
     delete[]out;




}




void convolution_3D_double(double *kernel, double *image,double* image_out, double* bias){


     double* kernel_in = new  double [KERNEL_SIZE*KERNEL_SIZE];
     //double* image_in = new  double [IMG_SIZE*IMG_SIZE];
     double* image_in_add_zero= new double[(IMG_SIZE+2)*(IMG_SIZE+2)];
    double* image1_out = new double[IMG_SIZE*IMG_SIZE];
     double* out = new double[IMG_SIZE*IMG_SIZE];
     double* registre = new double[(IMG_SIZE+2)*2+3];
     int indix =0;
     int indixC=(IMG_SIZE+2)*2+2;
     int ligne = 0;


     cout<<"initialiser le mémoire pour image à 0"<<endl;
      for(int i=0;i<(IMG_SIZE+2)*(IMG_SIZE+2);i++)
      {
          image_in_add_zero[i]=0;

      }



     for (int i=0;i < KERNELCONVLAYER_CHANNEL_IN_NUM;i++)
     {
        cout<<"numéro de kernel = "<<i<<endl;
         for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
         {

             out[c]=0;
         }

         for(int j =0; j < CNNCONVLAYER_CHANNEL_IN_NUM; j++)
         {
             cout<<"numéro de image = "<< j <<endl;



             cout<<"load kernel"<<endl;
             for(int a =0; a < KERNEL_SIZE*KERNEL_SIZE; a++ )
             {

                kernel_in[a]=kernel[i* CNNCONVLAYER_CHANNEL_IN_NUM*KERNEL_SIZE*KERNEL_SIZE+j* KERNEL_SIZE*KERNEL_SIZE+a];

             }


            cout<<"load image"<<endl;
             for(int h=1;h<IMG_SIZE+1;h++)
             {
                 for(int f= 1; f<IMG_SIZE+1; f++)
                 {


                     image_in_add_zero[h*(IMG_SIZE+2)+f]=image[IMG_SIZE*IMG_SIZE*j+(h-1)*IMG_SIZE+f-1];
                    // cout<<"dans image_add_0 "<<image_in_add_zero[h*(IMG_SIZE+2)+f]<<endl;
                 }
             }

           // cout<<"registrre à décalage"<<endl;
             ligne=0;

             for(int c =0; c< (IMG_SIZE+2)*(IMG_SIZE+2); c++)
             {



                   for(int b = 0;b <(IMG_SIZE+2)*2+2 ; b++)
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

                 //cout<<"ligne= "<<ligne<<endl;

                 if((c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)<24||(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)>25&&(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)<50||(c-((IMG_SIZE+2)*2+2))-(IMG_SIZE+2)*(ligne-1)>51)
                 {

                 indix=c-((IMG_SIZE+2)*2+2)-2*(ligne-1);
                 cout<<"indix = " <<indix<<endl;

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




              for(int c = 0; c < IMG_SIZE*IMG_SIZE; c++)
              {
                // inter_val = out[c];

                  out[c]=image1_out[c]+out[c];

              }
         }

         for(int c=0; c<IMG_SIZE*IMG_SIZE; c++)
         {
         //image_out[i*IMG_SIZE*IMG_SIZE+c]=out[i*IMG_SIZE*IMG_SIZE+c],bias[i];
        // image_out[i*IMG_SIZE*IMG_SIZE+c]=relu(add_bias(out[c],bias[i]));
            image_out[i*IMG_SIZE*IMG_SIZE+c]=out[c];
         }

     }


     delete[]kernel_in;
     delete[]image_in_add_zero;
     delete[]registre;
     delete[]image1_out;
     delete[]out;




}




