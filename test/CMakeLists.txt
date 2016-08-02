# Copyright Louis Dionne 2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)

# Each unit test is a small, self-contained CMake project with a `check` target
# and possibly CTest targets. This might look a bit odd, because we're using
# CMake to run CMake, but we do this instead of using `add_subdirectory` to
# make sure each test is run in its own "sandbox".

file(GLOB test_dirs
    LIST_DIRECTORIES true
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    "*"
)
foreach(dir ${test_dirs})
    if (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${dir}/CMakeLists.txt)
        continue()
    endif()

    string(REPLACE " " "_" target test.${dir})
    add_custom_target(${target}
        COMMAND ${CMAKE_COMMAND} -E remove_directory "${dir}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${dir}"
        COMMAND ${CMAKE_COMMAND} -E chdir "${dir}"
                ${CMAKE_COMMAND} ${CMAKE_CURRENT_SOURCE_DIR}/${dir} -G${CMAKE_GENERATOR}
        COMMAND ${CMAKE_COMMAND} --build "${dir}" --target check
        COMMAND ${CMAKE_COMMAND} -E chdir "${dir}"
                ${CMAKE_CTEST_COMMAND} --output-on-failure
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        VERBATIM USES_TERMINAL
    )

    add_test(NAME ${target}
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${target}
    )
    set_target_properties(${target} PROPERTIES FOLDER "tests")
endforeach()
