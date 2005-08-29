dnl -*- Autoconf -*-
dnl Copyright (C) 1993-2005 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

dnl From Bruno Haible, Marcus Daniels, Sam Steingold, Peter Burwood, Sam Steingold.

AC_PREREQ(2.57)

AC_DEFUN([CL_RUSAGE],
[AC_CHECK_HEADERS(sys/resource.h sys/times.h)dnl
if test $ac_cv_header_sys_resource_h = yes; then
  dnl HAVE_SYS_RESOURCE_H defined
  CL_LINK_CHECK([getrusage], cl_cv_func_getrusage,
[#include <sys/types.h> /* NetBSD 1.0 needs this */
#include <sys/time.h>
#include <sys/resource.h>],
    [struct rusage x; int y = RUSAGE_SELF; getrusage(y,&x); x.ru_utime.tv_sec;])dnl
  if test $cl_cv_func_getrusage = yes; then
    CL_PROTO([getrusage], [
    CL_PROTO_TRY([
#include <stdlib.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <sys/types.h> /* NetBSD 1.0 needs this */
#include <sys/time.h>
#include <sys/resource.h>
],
[int getrusage (int who, struct rusage * rusage);],
[int getrusage();],
[cl_cv_proto_getrusage_arg1="int"],
[cl_cv_proto_getrusage_arg1="enum __rusage_who"])
], [extern int getrusage ($cl_cv_proto_getrusage_arg1, struct rusage *);])dnl
    AC_CACHE_CHECK(whether getrusage works, cl_cv_func_getrusage_works, [
    AC_TRY_RUN([
#include <stdio.h>
#include <sys/types.h> /* NetBSD 1.0 needs this */
#include <sys/time.h>
#include <time.h> /* for time(2) */
#include <sys/resource.h>
int main ()
{
  struct rusage used, prev;
  time_t end = time(NULL)+2;
  int count = 0;

  if ((count = getrusage(RUSAGE_SELF, &prev))) {
    /* getrusage is defined but does not do anything. */
    /*fprintf(stderr,"getrusage failed: return=%d\n",count);*/
    return 1;
  }
  while (time(NULL) < end) {
    count++;
    getrusage(RUSAGE_SELF, &used);
    if ((used.ru_utime.tv_usec != prev.ru_utime.tv_usec)
        || (used.ru_utime.tv_sec != prev.ru_utime.tv_sec)
        || (used.ru_stime.tv_usec != prev.ru_stime.tv_usec)
        || (used.ru_stime.tv_sec != prev.ru_stime.tv_sec)) {
      /*fprintf(stderr,"success after %d runs\n",count);*/
      return 0;
    }
  }
  /* getrusage is defined but does not work. */
  /*fprintf(stderr,"failure after %d runs\n",count);*/
  return 1;
}],
cl_cv_func_getrusage_works=yes,
cl_cv_func_getrusage_works=no,
dnl When cross-compiling, don't assume anything.
cl_cv_func_getrusage_works="guessing no")])
  fi
  if test "$cl_cv_func_getrusage_works" = yes; then
    AC_DEFINE(HAVE_GETRUSAGE,,[have <sys/time.h>, the getrusage() function, the struct rusage type, and <sys/resource.h> defines RUSAGE_SELF])
    AC_DEFINE_UNQUOTED(RUSAGE_WHO_T,$cl_cv_proto_getrusage_arg1,[type of `who' in getrusage() declaration])
  fi
fi
])
