#############################################################################
# FBXSDK_TARGET - used to import the external prebuild FBX SDK libraries
# and correctly link them to our tergets.
# The tricky one is IMPORTED_LOCATION_NOOPT as it is just release withuot
# any optimizations
#############################################################################
cmake_minimum_required(VERSION 2.8)

# Create an imported target for FBX SDK binaries.
add_library(FBXSDK_TARGET STATIC IMPORTED)
add_library(FBXSDK_XML_TARGET STATIC IMPORTED)
add_library(FBXSDK_ZLIB_TARGET STATIC IMPORTED)
if(WIN32)
	# Windows platform.
	set_target_properties(FBXSDK_TARGET PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${SGE_FBX_SDK_DIR}/include"
		
		IMPORTED_LOCATION_RELEASE        "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/libfbxsdk-md.lib"
		IMPORTED_LOCATION_RELWITHDEBINFO "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/libfbxsdk-md.lib"
		IMPORTED_LOCATION_NOOPT          "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/libfbxsdk-md.lib"
		IMPORTED_LOCATION_DEBUG          "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/debug/libfbxsdk-md.lib")
		
	set_target_properties(FBXSDK_XML_TARGET PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${SGE_FBX_SDK_DIR}/include"
		
		IMPORTED_LOCATION_RELEASE        "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/libxml2-md.lib"
		IMPORTED_LOCATION_RELWITHDEBINFO "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/libxml2-md.lib"
		IMPORTED_LOCATION_NOOPT          "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/libxml2-md.lib"
		IMPORTED_LOCATION_DEBUG          "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/debug/libxml2-md.lib")
		
	set_target_properties(FBXSDK_ZLIB_TARGET PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${SGE_FBX_SDK_DIR}/include"
		
		IMPORTED_LOCATION_RELEASE        "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/zlib-md.lib"
		IMPORTED_LOCATION_RELWITHDEBINFO "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/zlib-md.lib"
		IMPORTED_LOCATION_NOOPT          "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/release/zlib-md.lib"
		IMPORTED_LOCATION_DEBUG          "${SGE_FBX_SDK_DIR}/lib/vs2017/x64/debug/zlib-md.lib")
else()
	# Linux platform.
	target_link_libraries(FBXSDK_TARGET PROPERTIES 
		INTERFACE_INCLUDE_DIRECTORIES "${SGE_FBX_SDK_DIR}/include"
		
		IMPORTED_LOCATION_RELEASE        "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libfbxsdk.a"
		IMPORTED_LOCATION_RELWITHDEBINFO "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libfbxsdk.a"
		IMPORTED_LOCATION_NOOPT          "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libfbxsdk.a"
		IMPORTED_LOCATION_DEBUG          "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/debug/libfbxsdk.a")

	set_target_properties(FBXSDK_XML_TARGET PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${SGE_FBX_SDK_DIR}/include"
		
		IMPORTED_LOCATION_RELEASE        "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libxml2.lib"
		IMPORTED_LOCATION_RELWITHDEBINFO "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libxml2.lib"
		IMPORTED_LOCATION_NOOPT          "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libxml2.lib"
		IMPORTED_LOCATION_DEBUG          "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/debug/libxml2.lib")
		
	set_target_properties(FBXSDK_ZLIB_TARGET PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${SGE_FBX_SDK_DIR}/include"
		
		IMPORTED_LOCATION_RELEASE        "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libzlib.lib"
		IMPORTED_LOCATION_RELWITHDEBINFO "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libzlib.lib"
		IMPORTED_LOCATION_NOOPT          "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/release/libzlib.lib"
		IMPORTED_LOCATION_DEBUG          "${SGE_FBX_SDK_DIR}/lib/gcc4/x64/debug/libzlib.lib")
endif()

#############################################################################
# MDLCONVLIB_SRC
#############################################################################
add_dir_rec_2(MDLCONVLIB_SRC "./src" 3)
add_library(mdlconvlib SHARED ${MDLCONVLIB_SRC})
target_compile_definitions(mdlconvlib PRIVATE SGE_MDLCONVLIB_BUILDING_DLL=1)
target_include_directories(mdlconvlib PUBLIC "./src")
target_link_libraries(mdlconvlib sge_core)
target_link_libraries(mdlconvlib FBXSDK_TARGET FBXSDK_XML_TARGET FBXSDK_ZLIB_TARGET)
if(NOT WIN32)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
	target_link_libraries(mdlconvlib ${CMAKE_PTHREAD_LIBS})
endif()
sgePromoteWarningsOnTarget(mdlconvlib)






