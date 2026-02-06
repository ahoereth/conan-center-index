if(NOT TARGET protobuf::protoc)
    # Locate protoc executable
    ## First check the package folder (handles both native builds and cross-builds
    ## where protoc was copied from the build-context package)
    set(_PROTOC_PACKAGE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../../bin/protoc${CMAKE_EXECUTABLE_SUFFIX}")
    if(EXISTS "${_PROTOC_PACKAGE_PATH}")
        set(PROTOC_PROGRAM "${_PROTOC_PACKAGE_PATH}")
    endif()
    unset(_PROTOC_PACKAGE_PATH)
    ## Workaround for legacy "cmake" generator in case of cross-build
    if(NOT PROTOC_PROGRAM AND CMAKE_CROSSCOMPILING)
        find_program(PROTOC_PROGRAM NAMES protoc PATHS ENV PATH NO_DEFAULT_PATH)
    endif()
    ## Fallback: standard find_program
    if(NOT PROTOC_PROGRAM)
        find_program(PROTOC_PROGRAM NAMES protoc)
    endif()
    get_filename_component(PROTOC_PROGRAM "${PROTOC_PROGRAM}" ABSOLUTE)

    # Give opportunity to users to provide an external protoc executable
    # (this is a feature of official FindProtobuf.cmake)
    set(Protobuf_PROTOC_EXECUTABLE ${PROTOC_PROGRAM} CACHE FILEPATH "The protoc compiler")

    # Create executable imported target protobuf::protoc
    add_executable(protobuf::protoc IMPORTED)
    set_property(TARGET protobuf::protoc PROPERTY IMPORTED_LOCATION ${Protobuf_PROTOC_EXECUTABLE})
endif()
