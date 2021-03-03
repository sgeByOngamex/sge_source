# A list of exe/dlls to be installed in the binary directory.
set(INSTALL_RUNTIME_TARGETS
	SDL2
	sge_core
	mdlconvlib
	sge_engine
	sge_editor
)

# A list of static libraries(or lib files for dlls) to be installed in the lib diretroy.
set(INSTALL_LIBRARIES_TARGETS
	SDL2
	BulletDynamics
	BulletCollision
	LinearMath
	imgui
	mdlconvlib
	sge_utils
	sge_renderer
	sge_core
	sge_engine
)

if(SGE_REND_API STREQUAL "OpenGL")
	list(APPEND INSTALL_LIBRARIES_TARGETS glew)
endif()

# Runtimes (*.exe, *.dll, *.so and so on)
INSTALL(TARGETS ${INSTALL_RUNTIME_TARGETS} RUNTIME DESTINATION $<CONFIG>/binaries/)	

# Lib files (*.lib, *.a and so on)
INSTALL(TARGETS ${INSTALL_LIBRARIES_TARGETS} ARCHIVE DESTINATION $<CONFIG>/lib/)	

# imgui headers.
INSTALL (
    DIRECTORY ${CMAKE_SOURCE_DIR}/libs_ext/imgui/imgui
    DESTINATION include/imgui
    FILES_MATCHING PATTERN "*.h*")

# Bullet3 headers.
INSTALL (
    DIRECTORY ${CMAKE_SOURCE_DIR}/libs_ext/bullet/bullet3/src/
    DESTINATION include/bullet3
    FILES_MATCHING PATTERN "*.h*")

# glew headers.
if(SGE_REND_API STREQUAL "OpenGL")
	INSTALL (
		DIRECTORY ${CMAKE_SOURCE_DIR}/libs_ext/glew/
		DESTINATION include
		FILES_MATCHING PATTERN "*.h*")
endif()

# Install sge_utils headers.
INSTALL (
    DIRECTORY ${CMAKE_SOURCE_DIR}/libs/sge_utils/src/
    DESTINATION include
    FILES_MATCHING PATTERN "*.h*" PATTERN "*.inl")

# Install sge_renderer headers.
INSTALL (
    DIRECTORY ${CMAKE_SOURCE_DIR}/libs/sge_renderer/src/
    DESTINATION include
    FILES_MATCHING PATTERN "*.h*")

# Install sge_core headers and its assets.
INSTALL (
    DIRECTORY ${CMAKE_SOURCE_DIR}/libs/sge_core/src/
    DESTINATION include
    FILES_MATCHING PATTERN "*.h*")
	
INSTALL (
    DIRECTORY ${CMAKE_SOURCE_DIR}/libs/sge_core/core_shaders/
    DESTINATION $<CONFIG>/binaries/core_shaders)
	
# Install sge_engine headers and its assets.
INSTALL (
    DIRECTORY ${CMAKE_SOURCE_DIR}/libs/sge_engine/src/
    DESTINATION include
    FILES_MATCHING PATTERN "*.h*")

INSTALL (
    DIRECTORY ${CMAKE_SOURCE_DIR}/libs/sge_engine/assets/
    DESTINATION $<CONFIG>/binaries/assets)
	
## SDL2 Header files
#file(GLOB SGE_SDL2_INCLUDE_FILES ${SDL2_SOURCE_DIR}/include/*.h)
#file(GLOB SGE_SDL2_BIN_INCLUDE_FILES ${SDL2_BINARY_DIR}/include/*.h)
#foreach(_FNAME ${SGE_SDL2_BIN_INCLUDE_FILES})
#  get_filename_component(_INCNAME ${_FNAME} NAME)
#  list(REMOVE_ITEM SGE_SDL2_INCLUDE_FILES ${SDL2_SOURCE_DIR}/include/${_INCNAME})
#endforeach()
#list(APPEND SGE_SDL2_INCLUDE_FILES ${SGE_SDL2_BIN_INCLUDE_FILES})
#install(FILES ${SGE_SDL2_INCLUDE_FILES} DESTINATION include/SDL2)
