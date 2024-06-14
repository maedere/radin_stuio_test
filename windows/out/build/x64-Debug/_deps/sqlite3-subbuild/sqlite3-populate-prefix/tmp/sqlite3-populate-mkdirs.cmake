# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-src"
  "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-build"
  "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-subbuild/sqlite3-populate-prefix"
  "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-subbuild/sqlite3-populate-prefix/tmp"
  "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-subbuild/sqlite3-populate-prefix/src/sqlite3-populate-stamp"
  "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-subbuild/sqlite3-populate-prefix/src"
  "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-subbuild/sqlite3-populate-prefix/src/sqlite3-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-subbuild/sqlite3-populate-prefix/src/sqlite3-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "D:/flutter_projects/buddy_open_ai_chat_bot/buddy_open_ai_chat_bot/windows/out/build/x64-Debug/_deps/sqlite3-subbuild/sqlite3-populate-prefix/src/sqlite3-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
