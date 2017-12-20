#ifndef CIFARDATABASE_OP_HPP
#define CIFARDATABASE_OP_HPP

#include <iostream>
#include <string>
#include <fstream>
#include "constant.hpp"




template <typename pixelDataType>
class cifarImage {
public:
  pixelDataType imgData[CIFAR_IMAGE_BYTES_SIZE];
  unsigned int cifarImageLabel;
  cifarImage();
  void loadImage(std::ifstream &fs);
  ~cifarImage();
};

/* supprimer la classe database on charge image par image */

template <typename databaseDataType>
class cifarDatabase: public cifarImage<databaseDataType> {

public:
  std::string cifarFolderPath;
  std::string cifarFileName;
  cifarImage<databaseDataType> imgDatabaseData[CIFAR_DB_IMAGE_NUMBER];
  char cifarImageLabel[CIFAR_DB_IMAGE_NUMBER];
  std::string cifarClassLabel[CIFAR_NUMBER_OF_CLASS];

  cifarDatabase();
  void loadDatabase();
  ~cifarDatabase();
};

using namespace std;

template <typename pixelDataType>
cifarImage<pixelDataType>::cifarImage(){}

template <typename pixelDataType>
cifarImage<pixelDataType>::~cifarImage(){}

template <typename pixelDataType>
void cifarImage<pixelDataType>::loadImage(std::ifstream &fs){
  unsigned int byteReadCount=0;
  char valueRead=0;

  fs.read(&valueRead,1);
  cifarImageLabel=static_cast<unsigned int>(valueRead);
  
  for(byteReadCount=0;byteReadCount<CIFAR_IMAGE_BYTES_SIZE;byteReadCount++){
    fs.readsome(&valueRead,1);
    imgData[byteReadCount]=static_cast<pixelDataType>((static_cast<unsigned char>(valueRead)));
  }
}

template <typename databaseDataType>
cifarDatabase<databaseDataType>::cifarDatabase(){}

template <typename databaseDataType>
cifarDatabase<databaseDataType>::~cifarDatabase(){}

template <typename databaseDataType>
void cifarDatabase<databaseDataType>::loadDatabase(){
  ifstream cifarFile;
  string file=cifarFolderPath+cifarFileName;
  
  cifarFile.open(file.c_str(),
                 ifstream::in | ifstream::binary);
  
  if(cifarFile.good()){
    unsigned int imgReadCount=0;
    cifarImage<databaseDataType> imgRead;
    char trash;
    std::cout << "LOADING DATABASE" << std::endl;

    for(imgReadCount=0;imgReadCount<CIFAR_DB_IMAGE_NUMBER;imgReadCount++){
      imgRead.loadImage(cifarFile);
      imgDatabaseData[imgReadCount]=imgRead;
      cifarFile.read(cifarImageLabel+imgReadCount,1); /* read image label */
      cifarFile.read(&trash,1); /* skiping newline character */
    }
    std::cout << "FINISHED LOADING DATABASE" << std::endl;
  }
  else{
    std::cerr << "Error while opening cifar database file \n";
  }

}


#endif
