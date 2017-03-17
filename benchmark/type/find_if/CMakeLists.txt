# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

set(datasets)
add_dataset(datasets type find_if brigand list                 brigand.list.cpp.erb              15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type find_if hana    std_integer_sequence hana.std_integer_sequence.cpp.erb 15 "(0..50).step(10).to_a + (100..200).step(50).to_a")
add_dataset(datasets type find_if kvasir  list                 kvasir.list.cpp.erb               15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type find_if meta    list                 meta.list.cpp.erb                 15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type find_if metal   list                 metal.list.cpp.erb                15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type find_if mp11    list                 mp11.list.cpp.erb                 15 "(0..50).step(10).to_a + (100..500).step(50).to_a")
add_dataset(datasets type find_if mpl     list                 mpl.list.cpp.erb                  20 "(0..50).step(10)")
add_dataset(datasets type find_if mpl     vector               mpl.vector.cpp.erb                15 "(0..50).step(10)")

add_chart(type find_if DATASETS ${datasets})
