dnl Copyright (C) 1993-2002 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

dnl From Bruno Haible, Marcus Daniels.

AC_PREREQ(2.13)

AC_DEFUN([CL_EXECV],
[changequote(,)dnl
brackets='[]'
changequote([,])dnl
CL_PROTO([execv], [
for z in '' 'const'; do
for y in '' 'const'; do
for x in '' 'const'; do
if test -z "$have_execv"; then
AC_TRY_COMPILE([
#include <stdlib.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
]AC_LANG_EXTERN[
#if defined(__STDC__) || defined(__cplusplus)
int execv ($x char* path, $y char* $z argv$brackets);
#else
int execv();
#endif
], [],
cl_cv_proto_execv_arg1="$x"
cl_cv_proto_execv_arg2a="$y"
cl_cv_proto_execv_arg2b="$z"
have_execv=1)
fi
done
done
done
], [extern int execv ($cl_cv_proto_execv_arg1 char*, $cl_cv_proto_execv_arg2a char* $cl_cv_proto_execv_arg2b$brackets);])
AC_DEFINE_UNQUOTED(EXECV_CONST,$cl_cv_proto_execv_arg1)
AC_DEFINE_UNQUOTED(EXECV1_CONST,$cl_cv_proto_execv_arg2a)
AC_DEFINE_UNQUOTED(EXECV2_CONST,$cl_cv_proto_execv_arg2b)
])
