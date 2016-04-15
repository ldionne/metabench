# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

# Same test as `add_dataset_base_dataset`, but with a base dataset whose range
# is different (but includes) the original dataset.

cmake_minimum_required(VERSION 3.1)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../..")
include(metabench)

metabench_add_dataset(base "base.cpp.erb" "[0, 1, 2, 3, 4, 5]")
metabench_add_dataset(dummy "dummy.cpp.erb" "[1, 2, 3]" BASE_DATASET base)
metabench_add_chart(check DATASETS dummy)
