#ifndef ADD_BIAS_H
#define ADD_BIAS_H


template <typename image_Datatype,typename bias_type>
image_Datatype add_bias(image_Datatype pixel,bias_type bias){

  // std::cout<<"in bias = "<<pixel<<std::endl;
   //std::cout<<"out bias = "<<pixel+bias<<std::endl;

    return pixel+bias;


}




#endif // ADD_BIAS_H
