# Copyright Bruno Dutra 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets dataset.type.any.brigand.list  brigand.list.cpp.erb    "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets dataset.type.any.meta.list     meta.list.cpp.erb       "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets dataset.type.any.metal.list    metal.list.cpp.erb      "(0..50).step(10).to_a + (100..500).step(100).to_a")

add_chart(benchmark.type.any DATASETS ${datasets})
