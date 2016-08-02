# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

cmake_minimum_required(VERSION 3.1)

project(Metabench CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(metabench)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
enable_testing()

add_subdirectory(benchmark)
add_subdirectory(example)
add_subdirectory(test)
