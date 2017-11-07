#  Copyright (c) 2014, Facebook, Inc.
#  All rights reserved.
#
#  This source code is licensed under the BSD-style license found in the
#  LICENSE file in the root directory of this source tree. An additional grant
#  of patent rights can be found in the PATENTS file in the same directory.
#
# - Try to find folly
# This will define
# FOLLY_FOUND
# FOLLY_INCLUDE_DIR
# FOLLY_LIBRARIES

CMAKE_MINIMUM_REQUIRED(VERSION 2.8.7 FATAL_ERROR)

INCLUDE(FindPackageHandleStandardArgs)

FIND_LIBRARY(PROXYGEN_LIBRARY libproxygenlib.a PATHS ${PROXYGEN_LIBRARYDIR})
FIND_LIBRARY(PROXYGEN_SERVER_LIBRARY libproxygenhttpserver.a PATHS ${PROXYGEN_LIBRARYDIR})
FIND_PATH(PROXYGEN_INCLUDE_DIR "proxygen/httpserver/HTTPServer.h" PATHS ${PROXYGEN_INCLUDEDIR})

SET(PROXYGEN_LIBRARIES ${PROXYGEN_SERVER_LIBRARY} ${PROXYGEN_LIBRARY})

FIND_PACKAGE_HANDLE_STANDARD_ARGS(Proxygen
  REQUIRED_ARGS PROXYGEN_INCLUDE_DIR PROXYGEN_LIBRARIES)
