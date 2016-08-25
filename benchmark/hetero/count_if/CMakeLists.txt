# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets hetero count_if fusion list   fusion.list.cpp.erb   "(0..50).step(10)")
add_dataset(datasets hetero count_if fusion vector fusion.vector.cpp.erb "(0..50).step(10)")
add_dataset(datasets hetero count_if hana   tuple  hana.tuple.cpp.erb    "(0..50).step(10).to_a + (100..500).step(100).to_a")

add_chart(hetero count_if DATASETS ${datasets})
