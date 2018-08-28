# Copyright Bruno Dutra 2017
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets type join brigand list   brigand.list.cpp.erb 1 "[1] + (10..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type join kvasir  list   kvasir.list.cpp.erb  1 "[1] + (10..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type join meta    list   meta.list.cpp.erb    1 "[1] + (10..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type join metal   list   metal.list.cpp.erb   1 "[1] + (10..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type join mp11    list   mp11.list.cpp.erb    1 "[1] + (10..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type join tmp     list   tmp.list.cpp.erb     1 "[1] + (10..50).step(10).to_a + (100..500).step(50).to_a")

add_chart(type join DATASETS ${datasets})
