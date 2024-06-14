# Install script for directory: D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/flutter/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/runner/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/desktop_webview_window/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/flutter_tts/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/sqlite3_flutter_libs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/url_launcher_windows/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/webview_windows/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/buddy_open_ai_chat_bot.exe")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug" TYPE EXECUTABLE FILES "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/runner/buddy_open_ai_chat_bot.exe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/data/icudtl.dat")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/data" TYPE FILE FILES "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/flutter/ephemeral/icudtl.dat")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/flutter_windows.dll")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug" TYPE FILE FILES "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/flutter/ephemeral/flutter_windows.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/desktop_webview_window_plugin.dll;D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/Webview2Loader.dll;D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/flutter_tts_plugin.dll;D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/sqlite3_flutter_libs_plugin.dll;D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/sqlite3.dll;D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/url_launcher_windows_plugin.dll;D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/webview_windows_plugin.dll")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug" TYPE FILE FILES
    "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/desktop_webview_window/desktop_webview_window_plugin.dll"
    "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/flutter/ephemeral/.plugin_symlinks/desktop_webview_window/windows/libs/x64/Webview2Loader.dll"
    "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/flutter_tts/flutter_tts_plugin.dll"
    "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/sqlite3_flutter_libs/sqlite3_flutter_libs_plugin.dll"
    "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/sqlite3_flutter_libs/sqlite3.dll"
    "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/url_launcher_windows/url_launcher_windows_plugin.dll"
    "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/plugins/webview_windows/webview_windows_plugin.dll"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/data/flutter_assets")
  
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/data/flutter_assets")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/data" TYPE DIRECTORY FILES "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/build//flutter_assets")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee]|[Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/data/app.so")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/install/x64-Debug/data" TYPE FILE FILES "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/build/windows/app.so")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
