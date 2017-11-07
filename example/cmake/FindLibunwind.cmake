# - Try to find libunwind
# Once done, this will define
#
# LIBUNWIND_FOUND - system has libunwind
# LIBUNWIND_LIBRARIES - link these to use libunwind

include(FindPackageHandleStandardArgs)

find_library(LIBUNWIND_LIBRARY unwind
  PATHS ${LIBUNWIND_LIBRARYDIR})

find_package_handle_standard_args(libunwind DEFAULT_MSG LIBUNWIND_LIBRARY)

mark_as_advanced(LIBUNWIND_LIBRARY)

set(LIBUNWIND_LIBRARIES ${LIBUNWIND_LIBRARY})
