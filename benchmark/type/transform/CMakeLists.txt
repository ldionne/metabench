# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(datasets)
add_dataset(datasets dataset.type.transform.metal.list    metal.list.cpp.erb  "(0..500).step(10)")
add_dataset(datasets dataset.type.transform.mpl.list      mpl.list.cpp.erb    "(0..50).step(5)")
add_dataset(datasets dataset.type.transform.mpl.vector    mpl.vector.cpp.erb  "(0..50).step(5)")

metabench_add_benchmark(benchmark.type.transform DATASETS ${datasets} FILENAME index)
add_dependencies(benchmarks benchmark.type.transform)
