cmake_minimum_required(VERSION 3.8)
project(rvl_robot_description)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)

install(
  DIRECTORY 
    config 
    launch 
    models 
    xacro
  DESTINATION 
    share/${PROJECT_NAME}
)

ament_export_dependencies(${THIS_PACKAGE_INCLUDE_DEPENDS})

if(BUILD_TESTING)
  find_package(ament_cmake_pytest REQUIRED)
  ament_add_pytest_test(robot_urdf_xacro tests/test_robot_urdf_xacro.py)
  ament_add_pytest_test(view_robot_launch tests/test_view_robot_launch.py)
endif()

ament_package()
