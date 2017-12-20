#include "../inc/cifar_database_op.hpp"
#include "../inc/constant.hpp"
#include <string>
#include <iostream>
#include <fstream>

int main(){

  std::cout << "stating main prog" << std::endl;
  /*cifarDatabase<unsigned int> db;
    db.cifarFolderPath="../../../../../image_database/cifar10/cifar-10-batches-bin/";
    db.cifarFileName="data_batch_1.bin";

    db.loadDatabase();
    std::cout << "database successfully loaded ??" << std::endl;
    unsigned char testImg =0;
    for(int i=0;i<10;i++){
    testImg=db.imgDatabaseData[i].imgData[0];
    std::cout <<  testImg << std::endl;
    }
  */

  /***** test image reading *****/

  std::string cifarFolderPath="../../../../../image_database/cifar10/cifar-10-batches-bin/";
  std::string cifarFileName="data_batch_1.bin";
  std::string file = cifarFolderPath+cifarFileName;
  std::ifstream cifarFile;

  cifarImage<unsigned int> imgIn;

  cifarFile.open(file.c_str(),ifstream::in | ifstream::binary);

  if(cifarFile.good()){
    std::cout << "LOADING DATABASE" << std::endl;
    for(int j=0;j<3;j++){
      imgIn.loadImage(cifarFile);

      std::cout << "image label" << imgIn.cifarImageLabel << std::endl;

      for(int i=0;i<CIFAR_IMAGE_BYTES_SIZE;i++){
        std::cout << imgIn.imgData[i] << std::endl;
      }
    }
  }
  else{
    std::cerr << "Error while opening cifar database file \n";
  }
  cifarFile.close();
  return 0;
}
