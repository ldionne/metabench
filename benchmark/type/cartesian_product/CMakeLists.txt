# Copyright Bruno Dutra 2017
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets type cartesian_product kvasir  list   kvasir.list.cpp.erb  1 "(0..50).step(10).to_a + (100..200).step(50).to_a")
add_dataset(datasets type cartesian_product meta    list   meta.list.cpp.erb    1 "(0..50).step(10).to_a + (100..100).step(50).to_a")
add_dataset(datasets type cartesian_product metal   list   metal.list.cpp.erb   1 "(0..50).step(10).to_a + (100..400).step(50).to_a")
add_dataset(datasets type cartesian_product mp11    list   mp11.list.cpp.erb    1 "(0..50).step(10).to_a + (100..100).step(50).to_a")

add_chart(type cartesian_product DATASETS ${datasets})
