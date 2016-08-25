# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets hetero insert hana map hana.map.cpp.erb "(0..50).step(10).to_a + (100..500).step(100).to_a")
add_dataset(datasets hetero insert hana set hana.set.cpp.erb "(0..50).step(10).to_a + (100..500).step(100).to_a")

add_chart(hetero insert DATASETS ${datasets})
