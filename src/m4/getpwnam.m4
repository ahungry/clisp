dnl Copyright (C) 1993-2002 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

dnl From Bruno Haible, Marcus Daniels.

AC_PREREQ(2.13)

AC_DEFUN([CL_GETPWNAM],
[CL_PROTO([getpwnam], [
CL_PROTO_CONST([
#include <stdlib.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <pwd.h>
], [struct passwd * getpwnam (char* name);], [struct passwd * getpwnam();],
cl_cv_proto_getpwnam_arg1)
], [extern struct passwd * getpwnam ($cl_cv_proto_getpwnam_arg1 char*);])
AC_DEFINE_UNQUOTED(GETPWNAM_CONST,$cl_cv_proto_getpwnam_arg1)
])
