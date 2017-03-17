# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets type sort brigand list   brigand.list.cpp.erb 1 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type sort kvasir  list   kvasir.list.cpp.erb  1 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type sort meta    list   meta.list.cpp.erb    1 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type sort metal   list   metal.list.cpp.erb   1 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type sort mp11    list   mp11.list.cpp.erb    1 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type sort mpl     list   mpl.list.cpp.erb     1 "(0..20).step(10).to_a")
add_dataset(datasets type sort mpl     vector mpl.vector.cpp.erb   1 "(0..20).step(10).to_a")

add_chart(type sort DATASETS ${datasets})
