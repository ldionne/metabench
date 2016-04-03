# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(datasets)
add_dataset(datasets dataset.hetero.at.fusion.list      fusion.list.cpp.erb         "(1..50).step(1)")
add_dataset(datasets dataset.hetero.at.fusion.vector    fusion.vector.cpp.erb       "(1..50).step(1)")
add_dataset(datasets dataset.hetero.at.hana.basic_tuple hana.basic_tuple.cpp.erb    "(1..500).step(10)")
add_dataset(datasets dataset.hetero.at.hana.tuple       hana.tuple.cpp.erb          "(1..500).step(10)")
add_dataset(datasets dataset.hetero.at.std.tuple        std.tuple.cpp.erb           "(1..100).step(10)")

metabench_add_benchmark(benchmark.hetero.at DATASETS ${datasets} FILENAME index)
add_dependencies(benchmarks benchmark.hetero.at)
