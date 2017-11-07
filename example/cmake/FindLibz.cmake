# - Try to find libz
# Once done, this will define
#
# LIBZ_FOUND - system has libz
# LIBZ_LIBRARIES - link these to use libz

include(FindPackageHandleStandardArgs)

find_library(LIBZ_LIBRARY libz.a PATHS ${LIBZ_LIBRARYDIR})

find_package_handle_standard_args(libz DEFAULT_MSG LIBZ_LIBRARY)

mark_as_advanced(LIBZ_LIBRARY)

set(LIBZ_LIBRARIES ${LIBZ_LIBRARY})
