#ifndef _CNN_WEIGHT_FILE_OP_HPP
#define _CNN_WEIGHT_FILE_OP_HPP


#include <iostream>
#include <string>
#include <fstream>
#include "../inc/constant.hpp"


class cnnWeightFile{
public:
  std::string folderPath;
  std::string fileName;

  cnnWeightFile();
  void loadWeightFile();
  ~cnnWeightFile();
};


#endif
