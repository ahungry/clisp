dnl Copyright (C) 1993-2002 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

dnl From Bruno Haible, Marcus Daniels.

AC_PREREQ(2.13)

AC_DEFUN([CL_ELOOP],
[AC_REQUIRE([AC_PROG_CC])dnl
AC_CACHE_CHECK(for ELOOP, cl_cv_decl_eloop, [
if test $cross_compiling = no; then
cat > conftest.c <<EOF
#include "confdefs.h"
#include <stdlib.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <errno.h>
#include <stdio.h>
#ifdef ELOOP
int main () { printf("ELOOP\n"); exit(0); }
#else
extern int errno;
#define foo "conflink"
#define foobar "conflink/somefile"
int main()
{ /* If a system goes into an endless loop on this, it must be really broken. */
  if (symlink(foo,foo)<0) exit(1);
  if (unlink(foobar)>=0) { unlink(foo); exit(1); }
  printf("%d\n",errno); unlink(foo); exit(0);
}
#endif
EOF
AC_TRY_EVAL(ac_link)
cl_cv_decl_ELOOP=`./conftest`
if test "$cl_cv_decl_ELOOP" = "ELOOP"; then
  cl_cv_decl_eloop=yes
else
  cl_cv_decl_eloop="$cl_cv_decl_ELOOP"
fi
else
AC_EGREP_CPP(yes,[
#include <stdlib.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <errno.h>
#include <stdio.h>
#ifdef ELOOP
yes
#endif
],
cl_cv_decl_eloop=yes,
cl_cv_decl_eloop=no)
cl_cv_decl_ELOOP="ELOOP"
fi
rm -f conftest*
])
AC_DEFINE_UNQUOTED(ELOOP_VALUE,$cl_cv_decl_ELOOP)
])
