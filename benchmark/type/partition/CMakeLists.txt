# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets type partition brigand list   brigand.list.cpp.erb 10 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type partition kvasir  list   kvasir.list.cpp.erb  10 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type partition meta    list   meta.list.cpp.erb    10 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type partition metal   list   metal.list.cpp.erb   10 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type partition mpl     list   mpl.list.cpp.erb     15 "(0..50).step(10).to_a")
add_dataset(datasets type partition mpl     vector mpl.vector.cpp.erb   15 "(0..50).step(10).to_a")

add_chart(type partition DATASETS ${datasets})
