cmake_minimum_required(VERSION 3.1.0)

project(ImgMatch)


# Image implementation options: Qt or OpenCV. Uncomment only one!
#set (IMAGEIMP OCVIMAGE_8UC3)
set (IMAGEIMP QTIMAGE_RGB24)


# Which modules are enabled
set (MOD_SCALE TRUE)
set (MOD_OCV_SIFT FALSE)


if (MOD_OCV_SIFT)
  # MOD_OCV_SIFT requires OCVIMAGE
  set (IMAGEIMP OCVIMAGE_8UC3)
endif (MOD_OCV_SIFT)


# Set OpenCV installation location, if needed
if (${IMAGEIMP} MATCHES "OCVIMAGE")
  if (MINGW)
    set(OpenCV_DIR "D:/OpenCV/2.4.13.6/mingw530_32/install")
  elseif (MSVC)
    #set(OpenCV_DIR "D:/OpenCV/2.4.13.6/vs2015/install")
    set(OpenCV_DIR "D:/OpenCV/3.4.2/vs2015/install")
  endif (MINGW)

  find_package(OpenCV REQUIRED)
endif (${IMAGEIMP} MATCHES "OCVIMAGE")


# Set Qt location if needed
if (MINGW)
  set(Qt5Core_DIR "D:/Qt/5.9.6/mingw53_32")
elseif (MSVC)
  set(Qt5Core_DIR "D:/Qt/5.9.6/msvc2015_64")
endif (MINGW)

find_package (Qt5Core QUIET)
if (Qt5Core_FOUND)
  message(STATUS "Using Qt5")
  find_package(Qt5 COMPONENTS Core Widgets Gui REQUIRED)
else (Qt5Core_FOUND)
  # Look for Qt4
  # find_package(Qt4 REQUIRED)
  message(FATAL_ERROR "Qt5 not found!")
endif (Qt5Core_FOUND)


# Enable or disable logging. Log file is in bin directory.
set (ENABLE_LOG TRUE)


# Use C++ standard (98, 11, 14)
set (CMAKE_CXX_STANDARD 11)
set (CXX_EXTENSIONS OFF)


# Default build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif(NOT CMAKE_BUILD_TYPE)


add_definitions(-D${IMAGEIMP})

if (ENABLE_LOG)
  add_definitions(-DENABLE_LOG)
endif (ENABLE_LOG)


set(INSTALL_DIR ${CMAKE_SOURCE_DIR}/bin)
set(COMMON_DIR  ${CMAKE_SOURCE_DIR}/common)
set(IMAGE_DIR   ${CMAKE_SOURCE_DIR}/image)
set(MODULES_DIR ${CMAKE_SOURCE_DIR}/modules)


add_subdirectory(common)
add_subdirectory(image)
add_subdirectory(modules)
add_subdirectory(qtui)
