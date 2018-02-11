#ifndef RELU_H
#define RELU_H


#include <iostream>
//#include "/home/yawen/Bureau/3A/projet_arch/shared/include/ac_fixed.h"

template <typename image_Datatype_out>
image_Datatype_out relu(image_Datatype_out pixel_in){

  if (pixel_in > 0)
    {
        return pixel_in;
    }
    else
    {
        return 0;
    }

}



#endif // RELU_H
