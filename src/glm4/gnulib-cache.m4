# Copyright (C) 2002-2011 Free Software Foundation, Inc.
#
# This file is free software, distributed under the terms of the GNU
# General Public License.  As a special exception to the GNU General
# Public License, this file may be distributed as part of a program
# that contains a configuration script generated by Autoconf, under
# the same distribution terms as the rest of that program.
#
# Generated by gnulib-tool.
#
# This file represents the specification of how gnulib-tool is used.
# It acts as a cache: It is written and read by gnulib-tool.
# In projects that use version control, this file is meant to be put under
# version control, like the configure.ac and various Makefile.am files.


# Specification in the form of a command-line invocation:
#   gnulib-tool --import --dir=. --lib=libgnu --source-base=src/gllib --m4-base=src/glm4 --doc-base=doc --tests-base=tests --aux-dir=src/build-aux --avoid=xalloc-die --no-conditional-dependencies --no-libtool --macro-prefix=gl --no-vc-files accept alloca-opt arpa_inet bind close connect environ errno fd-hook fnmatch-gnu getloadavg getpagesize getpeername getsockname getsockopt gettext gettimeofday gnu-make havelib host-cpu-c-abi inet_ntop inet_pton ioctl libsigsegv link-follow listen localcharset lstat mkdtemp mkfifo mknod mkstemp mktime netinet_in no-c++ nocrash readlink recv recvfrom regex select send sendto setenv setsockopt shutdown socket socketlib sockets socklen stat stdbool stdint stdlib streq strerror_r-posix strftime strptime strverscmp sys_select sys_time sys_uio sys_wait uname uniname/uniname unistd unitypes uniwidth/width unsetenv

# Specification in the form of a few gnulib-tool.m4 macro invocations:
gl_LOCAL_DIR([])
gl_MODULES([
  accept
  alloca-opt
  arpa_inet
  bind
  close
  connect
  environ
  errno
  fd-hook
  fnmatch-gnu
  getloadavg
  getpagesize
  getpeername
  getsockname
  getsockopt
  gettext
  gettimeofday
  gnu-make
  havelib
  host-cpu-c-abi
  inet_ntop
  inet_pton
  ioctl
  libsigsegv
  link-follow
  listen
  localcharset
  lstat
  mkdtemp
  mkfifo
  mknod
  mkstemp
  mktime
  netinet_in
  no-c++
  nocrash
  readlink
  recv
  recvfrom
  regex
  select
  send
  sendto
  setenv
  setsockopt
  shutdown
  socket
  socketlib
  sockets
  socklen
  stat
  stdbool
  stdint
  stdlib
  streq
  strerror_r-posix
  strftime
  strptime
  strverscmp
  sys_select
  sys_time
  sys_uio
  sys_wait
  uname
  uniname/uniname
  unistd
  unitypes
  uniwidth/width
  unsetenv
])
gl_AVOID([ xalloc-die])
gl_SOURCE_BASE([src/gllib])
gl_M4_BASE([src/glm4])
gl_PO_BASE([])
gl_DOC_BASE([doc])
gl_TESTS_BASE([tests])
gl_LIB([libgnu])
gl_MAKEFILE_NAME([])
gl_MACRO_PREFIX([gl])
gl_PO_DOMAIN([])
gl_WITNESS_C_DOMAIN([])
gl_VC_FILES([false])
