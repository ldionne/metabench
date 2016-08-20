# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

# Fusion is broken on VS 12.0
if (METABENCH_FUSION AND NOT (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC" AND
                              CMAKE_CXX_COMPILER_VERSION VERSION_LESS "19"))
    find_package(Boost QUIET)
    if (Boost_FOUND)
        message(STATUS "Local Fusion installation found - Boost ${Boost_VERSION}")
        function(Fusion_add_dataset dataset)
            if(${dataset} MATCHES "\\.list")
                set(color "hsl(292, 35%, 47%)")
            elseif(${dataset} MATCHES "\\.vector")
                set(color "hsl(292, 35%, 59%)")
            elseif(${dataset} MATCHES "\\.set")
                set(color "hsl(292, 35%, 71%)")
            elseif(${dataset} MATCHES "\\.map")
                set(color "hsl(292, 35%, 83%)")
            else()
                message(FATAL_ERROR "Unknown datatype ${dataset}")
            endif()
            metabench_add_dataset(${dataset} ${ARGN} COLOR ${color} MEDIAN_OF 3)
            target_include_directories(${dataset} PUBLIC ${Boost_INCLUDE_DIRS})
        endfunction()
    else()
        message(STATUS "No local Boost installation found - Fusion will be unavailable.")
    endif()
endif()

if (NOT COMMAND Fusion_add_dataset)
    function(Fusion_add_dataset)
    endfunction()
endif()
