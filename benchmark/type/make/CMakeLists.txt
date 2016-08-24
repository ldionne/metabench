# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets type make brigand list brigand.list.cpp.erb "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets type make hana types   hana.types.cpp.erb   "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets type make meta list    meta.list.cpp.erb    "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets type make metal list   metal.list.cpp.erb   "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets type make mpl list     mpl.list.cpp.erb     "(0..50).step(10).to_a")
add_dataset(datasets type make mpl vector   mpl.vector.cpp.erb   "(0..50).step(10).to_a")

add_chart(type make DATASETS ${datasets})
