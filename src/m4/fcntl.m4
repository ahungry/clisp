dnl Copyright (C) 1993-2002 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

dnl From Bruno Haible, Marcus Daniels.

AC_PREREQ(2.13)

AC_DEFUN([CL_FCNTL],
[CL_PROTO([fcntl], [
for x in 'int arg' '...'; do
if test -z "$have_fcntl"; then
CL_PROTO_TRY([
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <fcntl.h>
], [int fcntl (int fd, int cmd, $x);], [int fcntl();], [
if test "$x" = "..."; then
cl_cv_fcntl_arg3="..."
else
cl_cv_fcntl_arg3="int"
fi
have_fcntl=1])
fi
done
], [extern int fcntl (int, int, $cl_cv_fcntl_arg3);])
if test "$cl_cv_fcntl_arg3" = "..."; then
AC_DEFINE(FCNTL_DOTS)
fi
])
