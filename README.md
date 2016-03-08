## Metabench <a target="_blank" href="https://travis-ci.org/ldionne/metabench">![Travis status][badge.Travis]</a>
> A simple framework for compile-time benchmarks


### Overview
Metabench is a single, self-contained CMake module making it easy to create
compile-time benchmarks. Compile-time benchmarks are benchmarks that, instead
of measuring the actual performance of C++ code, measure the performance of
compiling that code. Writing benchmarks of this kind is very useful for C++
programmers writing metaprogramming-heavy libraries, which are known to cause
long compilation times. Metabench was designed to be very simple to use, while
still allowing fairly complex benchmarks to be written.

### Dependencies
Metabench requires [CMake][] 3.0 or higher. It also requires [Ruby][] 2.1 or
higher along with the [Progressbar][] and [Tilt][] gems.

### Usage
To use Metabench, make sure you have the dependencies listed above and simply
drop the `metabench.cmake` file somewhere in your CMake search path for modules.
Then, use `include(metabench)` to include the module in your CMake file, and
`metabench_add_benchmark` to add a new compile-time benchmark. For example, a
minimal CMake file using Metabench would look like:

```CMake
# Make sure Metabench can be found when writing include(metabench)
list(APPEND CMAKE_MODULE_PATH "path/to/metabench/directory")

# Actually include the module
include(metabench)

# Add a new benchmark
metabench_add_benchmark(path.to.benchmark "path/to/benchmark")
```

This will create a target named `path.to.benchmark`, which, when run, will
gather data for the benchmark located in the `path/to/benchmark` directory.
But what's a _benchmark_ for Metabench? For Metabench, a benchmark is a
_directory_ with the following layout:

```
some_directory/
    chart.json
    file1.cpp
    ...
    fileN.cpp
```

The `.cpp` files are files whose compilation time will be benchmarked, and
the `chart.json` file is a file that controls how the `.cpp` files will be
benchmarked, exactly what benchmarking data will be gathered, and how we will
visualize the benchmark data as a chart. However, these files are not just
normal JSON or `.cpp` files. Instead, they are [ERB templates][ERB] used to
generate actual JSON and `.cpp` files.

#### The principle
Benchmarking the compilation time of a single `.cpp` file is rather useless,
because one could simply run the compiler and time that single execution instead.
What is really useful is to have a means of running variations of the same
`.cpp` file automatically. For example, we might be interested in benchmarking
the compilation time for creating a `std::tuple` with many elements in it. To
do so, we could write the following test case:

```c++
int main() { auto tuple = std::make_tuple(1, 2, 3, 4, 5); }
```

We would run the compiler and time the compilation, and then change the test
case by augmenting the number of elements in the tuple:

```c++
int main() { auto tuple = std::make_tuple(1, 2, 3, 4, 5, 6, 7, 8, 9, 10); }
```

We would measure the compilation time for this file, and repeat the process
until satisfactory data has been gathered. This tedious task of generating
different (but obviously related) `.cpp` files and running the compiler to
gather timings is what the Metabench module automates. It does this by
assuming that the `.cpp` files are written using the ERB template system,
and it generates a family of `.cpp` files from that template. It then
compiles these files and gathers benchmark data from these compilations.

Concretely, you start by writing a `.cpp` file (say `std_tuple.cpp`) that may
contain ERB markup:

```c++
#include <tuple>

int main() {
   auto tuple = std::make_tuple(<%= (1..n).to_a.join(', ') %>);
}
```

Code contained inside `<%= ... %>` is just normal Ruby code. When the file
will be rendered, the contents of `<%= ... %>` will be replaced with the
result of evaluating this Ruby code, which will look like:

```c++
#include <tuple>

int main() {
   auto tuple = std::make_tuple(1, 2, 3, ..., n);
}
```

What happens is that Metabench will generate the `.cpp` file for different
values of `n`, and will gather benchmark data for each of these values. The
values of `n` that should be considered are specified in the `chart.json` file.
This file, as outlined above, controls how the `.cpp` files are rendered and
how the data can be visualized as a chart.

TODO: Finish this

This is it for basic usage! Note that the `example/` directory contains a
fully working minimal example of using Metabench to create a benchmark.

### History
Metabench was initially developed inside the [Boost.Hana][] library as a
mean to benchmark compile-time algorithms. After seeing that a self-standing
framework would be useful to the general C++ community, I decided to extract
it into its own project.


<!-- Links -->
[badge.Travis]: https://travis-ci.org/ldionne/metabench.svg?branch=master
[Boost.Hana]: http://github.com/boostorg/hana
[CMake]: http://www.cmake.org
[ERB]: http://en.wikipedia.org/wiki/ERuby
[Progressbar]: https://rubygems.org/gems/ruby-progressbar
[Ruby]: https://www.ruby-lang.org/en/
[Tilt]: https://rubygems.org/gems/tilt
