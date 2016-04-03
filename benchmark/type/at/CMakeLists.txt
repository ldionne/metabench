# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(datasets)
add_dataset(datasets dataset.type.at.brigand.list   brigand.list.cpp.erb    "(1..500).step(10)")
add_dataset(datasets dataset.type.at.hana.types     hana.types.cpp.erb      "(1..500).step(10)")
add_dataset(datasets dataset.type.at.meta.list      meta.list.cpp.erb       "(1..500).step(10)")
add_dataset(datasets dataset.type.at.metal.list     metal.list.cpp.erb      "(1..500).step(10)")
add_dataset(datasets dataset.type.at.mpl.list       mpl.list.cpp.erb        "(1..50).step(1)")
add_dataset(datasets dataset.type.at.mpl.vector     mpl.vector.cpp.erb      "(1..50).step(1)")

metabench_add_benchmark(benchmark.type.at DATASETS ${datasets} FILENAME index)
add_dependencies(benchmarks benchmark.type.at)
