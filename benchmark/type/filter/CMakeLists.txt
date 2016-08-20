# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets dataset.type.filter.brigand.list  brigand.list.cpp.erb   "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets dataset.type.filter.meta.list  meta.list.cpp.erb   "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets dataset.type.filter.metal.list metal.list.cpp.erb  "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets dataset.type.filter.mpl.list   mpl.list.cpp.erb    "(0..50).step(10)")
add_dataset(datasets dataset.type.filter.mpl.vector mpl.vector.cpp.erb  "(0..50).step(10)")

add_chart(benchmark.type.filter DATASETS ${datasets})
