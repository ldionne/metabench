# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

# This test makes sure that using the PEAK_MEMORY aspect with metabench_add_chart
# produces a graph of the peak memory usage. The test does not actually check
# anything; this must be done by manual inspection. Since we compile the same
# code several times over, the peak memory usage should be consistent.

cmake_minimum_required(VERSION 3.1)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../..")
include(metabench)

metabench_add_dataset(dummy "dummy.cpp.erb" "[1, 2, 3, 4, 5]")
metabench_add_chart(check ASPECT PEAK_MEMORY DATASETS dummy)
