add_library(asteroid-weather main.cpp resources.qrc)
set_target_properties(asteroid-weather PROPERTIES PREFIX "")

target_link_libraries(asteroid-weather PUBLIC
	AsteroidApp)

install(TARGETS asteroid-weather
	DESTINATION ${CMAKE_INSTALL_LIBDIR})
