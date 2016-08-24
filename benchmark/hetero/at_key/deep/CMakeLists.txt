# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets hetero at_key.deep fusion map   fusion.map.cpp.erb "(0..50).step(10).to_a + [75, 100]" ENV "{range: (0..100).to_a}")
add_dataset(datasets hetero at_key.deep hana   map   hana.map.cpp.erb   "(0..50).step(10).to_a + [75, 100]" ENV "{range: (0..100).to_a}")
add_dataset(datasets hetero at_key.deep hana   tuple hana.tuple.cpp.erb "(0..50).step(10).to_a + [75, 100]" ENV "{range: (0..100).to_a}")

add_chart(hetero at_key-deep DATASETS ${datasets})
