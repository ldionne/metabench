# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets dataset.type.count_if.brigand.list brigand.list.cpp.erb    "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets dataset.type.count_if.meta.list    meta.list.cpp.erb       "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets dataset.type.count_if.metal.list   metal.list.cpp.erb      "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets dataset.type.count_if.mpl.list     mpl.list.cpp.erb        "(0..50).step(10)")
add_dataset(datasets dataset.type.count_if.mpl.vector   mpl.vector.cpp.erb      "(0..50).step(10)")

add_chart(benchmark.type.count_if DATASETS ${datasets})
