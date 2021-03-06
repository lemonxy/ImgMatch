#ifndef __MODOCVSIFT_H__
#define __MODOCVSIFT_H__

#include "ImgMatch.h"
#include "Image.h"
#include <opencv2/core/core.hpp>
#include <opencv2/features2d/features2d.hpp>
#include <opencv2/nonfree/features2d.hpp>
#include <opencv2/nonfree/nonfree.hpp>


class ModOcvSIFT : public ImgMatch
{
  public:

    ~ModOcvSIFT();

    virtual float Compare( const std::string& img1path, const std::string& img2path );

  private:

    cv::SiftFeatureDetector mSiftDetector;
    std::map<std::string, cv::Mat> mDescriptorsCache;
};


#endif // __MODOCVSIFT_H__
