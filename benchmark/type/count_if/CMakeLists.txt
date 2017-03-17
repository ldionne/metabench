# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets type count_if brigand list   brigand.list.cpp.erb 15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type count_if kvasir  list   kvasir.list.cpp.erb  15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type count_if meta    list   meta.list.cpp.erb    15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type count_if metal   list   metal.list.cpp.erb   15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type count_if mpl     list   mpl.list.cpp.erb     50 "(0..50).step(10)")
add_dataset(datasets type count_if mpl     vector mpl.vector.cpp.erb   30 "(0..50).step(10)")

add_chart(type count_if DATASETS ${datasets})
