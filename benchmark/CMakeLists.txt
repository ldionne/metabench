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
        ExternalProject_Add(Brigand EXCLUDE_FROM_ALL 1
            URL https://github.com/edouarda/brigand/archive/master.zip
            TIMEOUT 120
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
        ExternalProject_Add(Hana EXCLUDE_FROM_ALL 1
            URL https://github.com/ldionne/hana/archive/develop.zip
            TIMEOUT 120
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
        ExternalProject_Add(Meta EXCLUDE_FROM_ALL 1
            URL https://github.com/ericniebler/meta/archive/master.zip
            TIMEOUT 120
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
        ExternalProject_Add(Metal EXCLUDE_FROM_ALL 1
            URL https://github.com/brunocodutra/metal/archive/master.zip
            TIMEOUT 120
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

macro(add_dataset datasets dataset path_to_template range)
    set(_required_features)
    set(_dependencies)
    set(_enabled OFF)
    set(_median_of 1)

    if(${dataset} MATCHES "brigand\\.")
        set(_enabled ${METABENCH_BRIGAND})
        list(APPEND _required_features
            cxx_alias_templates
            cxx_decltype
            cxx_static_assert
            cxx_variadic_templates
            # TODO: Complete this
        )
        list(APPEND _dependencies Brigand)
    elseif(${dataset} MATCHES "fusion\\.")
        set(_enabled ${METABENCH_FUSION})
        set(_median_of 3)
    elseif(${dataset} MATCHES "hana\\.")
        set(_enabled ${METABENCH_HANA})
        list(APPEND _required_features
            cxx_alias_templates
            cxx_auto_type
            cxx_constexpr
            cxx_decltype
            cxx_decltype_auto
            cxx_defaulted_move_initializers
            cxx_delegating_constructors
            cxx_deleted_functions
            cxx_generic_lambdas
            cxx_inheriting_constructors
            cxx_inline_namespaces
            cxx_local_type_template_args
            cxx_reference_qualified_functions
            cxx_relaxed_constexpr
            cxx_right_angle_brackets
            cxx_rvalue_references
            cxx_trailing_return_types
            cxx_user_literals
            cxx_variable_templates
            cxx_variadic_macros
            cxx_variadic_templates
        )
        list(APPEND _dependencies Hana)
    elseif(${dataset} MATCHES "meta\\.")
        set(_enabled ${METABENCH_META})
        list(APPEND _required_features
            cxx_alias_templates
            # TODO: Complete this
        )
        list(APPEND _dependencies Meta)
    elseif(${dataset} MATCHES "metal\\.")
        set(_enabled ${METABENCH_METAL})
        list(APPEND _required_features
            cxx_alias_templates
            # TODO: Complete this
        )
        list(APPEND _dependencies Metal)
    elseif (${dataset} MATCHES "mpl\\.")
        set(_enabled ${METABENCH_MPL})
        set(_median_of 3)
    elseif (${dataset} MATCHES "std\\.")
        set(_enabled ON)
    else()
        message(FATAL_ERROR
            "The dataset named '${dataset}' does not appear to benchmark any "
            "known metaprogramming library."
        )
    endif()

    set(_all_cxx_features_supported ON)
    foreach(_feature IN LISTS _required_features)
        if (NOT "${_feature}" MATCHES "${CMAKE_CXX_COMPILE_FEATURES}")
            set(_all_cxx_features_supported OFF)
            break()
        endif()
    endforeach()

    if (${_enabled} AND ${_all_cxx_features_supported})
        string(REGEX REPLACE "[^.]+[.][^.]+[.][^.]+[.](.*)" "\\1" name ${dataset})
        metabench_add_dataset(${dataset} ${path_to_template} ${range} NAME ${name} MEDIAN_OF ${_median_of})
        if (_dependencies)
            add_dependencies(${dataset} ${_dependencies})
        endif()
        list(APPEND ${datasets} ${dataset})
    endif()

    unset(_required_features)
    unset(_dependencies)
    unset(_enabled)
    unset(_median_of)
    unset(_all_cxx_features_supported)
endmacro()

set(cxx_flag -ftemplate-depth=5000)
check_cxx_compiler_flag(${cxx_flag} HAS_FTEMPLATE_DEPTH)
if(HAS_FTEMPLATE_DEPTH)
    add_compile_options(${cxx_flag})
endif()

file(GLOB benchmark_dirs
    LIST_DIRECTORIES true
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    "hetero/*" "type/*"
)

add_custom_target(benchmarks)
foreach(benchmark_dir ${benchmark_dirs})
    add_subdirectory(${benchmark_dir})
endforeach()
