# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

option(METABENCH_BRIGAND    "Benchmark Brigand" ON)
option(METABENCH_FUSION     "Benchmark Fusion"  ON)
option(METABENCH_HANA       "Benchmark Hana"    ON)
option(METABENCH_META       "Benchmark Meta"    ON)
option(METABENCH_METAL      "Benchmark Metal"   ON)
option(METABENCH_MPL        "Benchmark MPL"     ON)

include(ExternalProject)
include(CheckCXXCompilerFlag)

if (METABENCH_FUSION OR METABENCH_MPL)
    find_package(Boost QUIET)
    if (Boost_FOUND)
        message(STATUS "Boost found - version ${Boost_VERSION}")
        include_directories(${Boost_INCLUDE_DIRS})
    else()
        message(WARNING "Boost not found - Fusion and MPL will be unavailable.")
        set(METABENCH_FUSION OFF)
        set(METABENCH_MPL OFF)
    endif()
endif()

if (METABENCH_BRIGAND)
    find_package(Brigand QUIET)
    if (Brigand_FOUND)
        message(STATUS "Brigand found - version ${Brigand_VERSION}")
        #TODO: add directories here
        add_custom_target(Brigand)
    else()
        message(STATUS "Brigand not found - fetching branch master")
        ExternalProject_Add(Brigand
            URL https://github.com/edouarda/brigand/archive/master.zip
            TIMEOUT 10
            PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
            CONFIGURE_COMMAND "" # Disable configure step
            BUILD_COMMAND ""     # Disable build step
            INSTALL_COMMAND ""   # Disable install step
            TEST_COMMAND ""      # Disable test step
            UPDATE_COMMAND ""    # Disable source work-tree update
        )
        ExternalProject_Get_Property(Brigand SOURCE_DIR)
        include_directories(${SOURCE_DIR})
    endif()
endif()

if (METABENCH_HANA)
    find_package(Hana QUIET)
    if (Hana_FOUND)
        message(STATUS "Hana found - version ${Hana_VERSION}")
        include_directories(${Hana_INCLUDE_DIRS})
        add_custom_target(Hana)
    else()
        message(STATUS "Hana not found - fetching branch develop")
        ExternalProject_Add(Hana
            URL https://github.com/ldionne/hana/archive/develop.zip
            TIMEOUT 10
            PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
            CONFIGURE_COMMAND "" # Disable configure step
            BUILD_COMMAND ""     # Disable build step
            INSTALL_COMMAND ""   # Disable install step
            TEST_COMMAND ""      # Disable test step
            UPDATE_COMMAND ""    # Disable source work-tree update
        )
        ExternalProject_Get_Property(Hana SOURCE_DIR)
        include_directories(${SOURCE_DIR}/include)
    endif()
endif()

if (METABENCH_META)
    find_package(Meta QUIET)
    if (Meta_FOUND)
        message(STATUS "Meta found - version ${Meta_VERSION}")
        #TODO: add directories here
        add_custom_target(Meta)
    else()
        message(STATUS "Meta not found - fetching branch master")
        ExternalProject_Add(Meta
            URL https://github.com/ericniebler/meta/archive/master.zip
            TIMEOUT 10
            PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
            CONFIGURE_COMMAND "" # Disable configure step
            BUILD_COMMAND ""     # Disable build step
            INSTALL_COMMAND ""   # Disable install step
            TEST_COMMAND ""      # Disable test step
            UPDATE_COMMAND ""    # Disable source work-tree update
        )
        ExternalProject_Get_Property(Meta SOURCE_DIR)
        include_directories(${SOURCE_DIR}/include)
    endif()
endif()

if (METABENCH_METAL)
    find_package(Metal QUIET)
    if (Metal_FOUND)
        message(STATUS "Metal found - version ${Metal_VERSION}")
        include_directories(${METAL_INCLUDE_DIRS})
        add_custom_target(Metal)
    else()
        message(STATUS "Metal not found - fetching branch master")
        ExternalProject_Add(Metal
            URL https://github.com/brunocodutra/metal/archive/master.zip
            TIMEOUT 10
            PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
            CONFIGURE_COMMAND "" # Disable configure step
            BUILD_COMMAND ""     # Disable build step
            INSTALL_COMMAND ""   # Disable install step
            TEST_COMMAND ""      # Disable test step
            UPDATE_COMMAND ""    # Disable source work-tree update
        )
        ExternalProject_Get_Property(Metal SOURCE_DIR)
        include_directories(${SOURCE_DIR}/include)
    endif()
endif()

function(dependencies_are_satisfied result dataset)
    if(${dataset} MATCHES "brigand\\.")
        set(${result} ${METABENCH_BRIGAND} PARENT_SCOPE)
    elseif(${dataset} MATCHES "fusion\\.")
        set(${result} ${METABENCH_FUSION} PARENT_SCOPE)
    elseif(${dataset} MATCHES "hana\\.")
        set(${result} ${METABENCH_HANA} PARENT_SCOPE)
    elseif(${dataset} MATCHES "meta\\.")
        set(${result} ${METABENCH_META} PARENT_SCOPE)
    elseif(${dataset} MATCHES "metal\\.")
        set(${result} ${METABENCH_METAL} PARENT_SCOPE)
    elseif (${dataset} MATCHES "mpl\\.")
        set(${result} ${METABENCH_MPL} PARENT_SCOPE)
    elseif (${dataset} MATCHES "std\\.")
        set(${result} ON PARENT_SCOPE) # std:: is always available
    else()
        message(FATAL_ERROR
            "The dataset named '${dataset}' does not appear to benchmark any "
            "known metaprogramming library."
        )
    endif()
endfunction()

macro(get_dependencies dataset)
    set(dependencies)
    if(${dataset} MATCHES "brigand\\.")
        set(dependencies Brigand)
    elseif(${dataset} MATCHES "hana\\.")
        set(dependencies Hana)
    elseif(${dataset} MATCHES "meta\\.")
        set(dependencies Meta)
    elseif(${dataset} MATCHES "metal\\.")
        set(dependencies Metal)
    endif()
endmacro()

macro(get_range dataset)
    if (${dataset} MATCHES "fusion\\.")
        set(range "(1..5).to_a + (10..50).step(10).to_a")
    elseif (${dataset} MATCHES "mpl\\.")
        set(range "(1..20).step(2)")
    elseif(${dataset} MATCHES "std\\.")
        set(range "(1..5).to_a + (10..50).step(10).to_a")
    else()
        set(range "(1..5).to_a + (10..50).step(10).to_a + (100..500).step(100).to_a")
    endif()
endmacro()

function(add_benchmarks target branch)
    if (IS_ABSOLUTE ${branch})
        file(RELATIVE_PATH branch ${CMAKE_CURRENT_SOURCE_DIR} ${branch})
    endif()

    if (NOT TARGET ${target})
        add_custom_target(${target})
    endif()

    if (NOT TARGET ${target}.${branch})
        add_custom_target(${target}.${branch})
        add_dependencies(${target} ${target}.${branch})
    endif()

    file(GLOB benchmarks ${branch}/*)
    foreach(benchmark ${benchmarks})
        if(NOT IS_DIRECTORY ${benchmark})
            continue()
        endif()
        file(RELATIVE_PATH benchmark ${CMAKE_CURRENT_SOURCE_DIR}/${branch} ${benchmark})
        set(datasets)
        file(GLOB templates ${branch}/${benchmark}/*.erb)
        foreach(template ${templates})
            file(RELATIVE_PATH template ${CMAKE_CURRENT_SOURCE_DIR}/${branch}/${benchmark} ${template})
            string(REGEX REPLACE "[.]cpp[.]erb$" "" dataset ${template})
            dependencies_are_satisfied(satisfied ${dataset})
            if (${satisfied})
                get_dependencies(${dataset})
                get_range(${dataset})
                list(APPEND datasets ${target}.${branch}.${benchmark}.${dataset})
                metabench_add_dataset(${target}.${branch}.${benchmark}.${dataset} ${branch}/${benchmark}/${template} "${range}")
                if (dependencies)
                    add_dependencies(${target}.${branch}.${benchmark}.${dataset} ${dependencies})
                endif()
            endif()
        endforeach()

        if (datasets)
            metabench_add_benchmark(${target}.${branch}.${benchmark} DATASETS ${datasets})
            add_dependencies(${target}.${branch} ${target}.${branch}.${benchmark})
        endif()
    endforeach()
endfunction()

set(cxx_flag -ftemplate-depth=5000)
check_cxx_compiler_flag(${cxx_flag} HAS_FTEMPLATE_DEPTH)
if(HAS_FTEMPLATE_DEPTH)
    add_compile_options(${cxx_flag})
endif()

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_benchmarks(benchmarks type)
add_benchmarks(benchmarks hetero)
