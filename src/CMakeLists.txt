find_program(LLVM_CONFIG NAMES llvm-config REQUIRED)

execute_process(COMMAND ${LLVM_CONFIG} --includedir
    OUTPUT_VARIABLE LLVM_INCLUDE_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND ${LLVM_CONFIG} --cxxflags
    OUTPUT_VARIABLE LLVM_CXXFLAGS_RAW
    OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND ${LLVM_CONFIG} --libfiles all
    OUTPUT_VARIABLE LLVM_LIBFILES_RAW
    OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND ${LLVM_CONFIG} --system-libs
    OUTPUT_VARIABLE LLVM_SYSLIBS_RAW
    OUTPUT_STRIP_TRAILING_WHITESPACE)

separate_arguments(LLVM_CXXFLAGS UNIX_COMMAND ${LLVM_CXXFLAGS_RAW})
separate_arguments(LLVM_LIBFILES UNIX_COMMAND ${LLVM_LIBFILES_RAW})
separate_arguments(LLVM_SYSLIBS  UNIX_COMMAND ${LLVM_SYSLIBS_RAW})

add_executable(kal
    Lexer.cpp
    Parser.cpp
    CodeGen.cpp
    main.cpp
)

set_target_properties(kal PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin
)

target_include_directories(kal PRIVATE
    ${CMAKE_SOURCE_DIR}/include
    ${LLVM_INCLUDE_DIR}
)

target_compile_options(kal PRIVATE ${LLVM_CXXFLAGS})

target_link_libraries(kal PRIVATE
    -Wl,--start-group
    ${LLVM_LIBFILES}
    -Wl,--end-group
    ${LLVM_SYSLIBS}
)
