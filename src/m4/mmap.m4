dnl -*- Autoconf -*-
dnl Copyright (C) 1993-2010, 2017 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

dnl From Bruno Haible, Marcus Daniels, Sam Steingold.

AC_PREREQ([2.57])

AC_DEFUN([CL_MMAP],
[
  AC_BEFORE([$0], [CL_MUNMAP])
  AC_BEFORE([$0], [CL_MPROTECT])
  AC_CHECK_HEADER([sys/mman.h], [], [no_mmap=1])
  if test -z "$no_mmap"; then
    AC_CHECK_FUNC([mmap], [], [no_mmap=1])
    if test -z "$no_mmap"; then
      AC_DEFINE([HAVE_MMAP],,[have <sys/mmap.h> and the mmap() function])
      dnl Test whether mmap with MAP_FIXED works.
      dnl We cannot expect that it works at *all* addresses that we try,
      dnl because every platform has a different address space layout.
      dnl Therefore here we try whether it works at least for *some* addresses.
      dnl The determination of the mmapable address ranges is done later.
      AC_CACHE_CHECK([for mmap at fixed addresses], [cl_cv_func_mmap_fixed],
        [mmap_prog_1='
           #include <stdlib.h>
           #ifdef HAVE_UNISTD_H
            #include <unistd.h>
           #endif
           #include <fcntl.h>
           #include <sys/types.h>
           #include <sys/mman.h>
           int main ()
           {
           '
         mmap_prog_2='
             {
               unsigned long my_size = 32768; /* hope that 32768 is a multiple of the page size */
               unsigned int successful_calls = 0;
               unsigned long addr;
               for (addr = 0x01230000UL;;)
                 {
                   if (mmap((void*)(addr & -my_size),my_size,PROT_READ|PROT_WRITE,flags|MAP_FIXED,fd,0) != (void*)-1)
                     {
                       /* Require at least 2 successful mmap calls.  This avoids
                          spurious success on HP-UX IA-64 with 32-bit ABI. */
                       if (++successful_calls >= 2)
                         exit(0);
                     }
                   {
                     unsigned long next_addr = (unsigned long)((double)addr * 1.94);
                     if (next_addr <= addr) break;
                     addr = next_addr;
                   }
                 }
               exit(1);
             }
           }
           '
         succeeded=
         AC_TRY_RUN(GL_NOCRASH[
           $mmap_prog_1
             int flags = MAP_ANON | MAP_PRIVATE;
             int fd = -1;
             nocrash_init();
           $mmap_prog_2
           ],
           [succeeded="$succeeded"${succeeded:+,}"MAP_ANON"],
           [],
           [: # When cross-compiling, don't assume anything.])
         AC_TRY_RUN(GL_NOCRASH[
           $mmap_prog_1
             int flags = MAP_ANONYMOUS | MAP_PRIVATE;
             int fd = -1;
             nocrash_init();
           $mmap_prog_2
           ],
           [succeeded="$succeeded"${succeeded:+,}"MAP_ANONYMOUS"],
           [],
           [: # When cross-compiling, don't assume anything.])
         AC_TRY_RUN(GL_NOCRASH[
           $mmap_prog_1
             #ifndef MAP_FILE
              #define MAP_FILE 0
             #endif
             int flags = MAP_FILE | MAP_PRIVATE;
             int fd = open("/dev/zero",O_RDONLY,0666);
             if (fd<0) exit(1);
             nocrash_init();
           $mmap_prog_2
           ],
           [succeeded="$succeeded"${succeeded:+,}"/dev/zero"],
           [],
           [: # When cross-compiling, don't assume anything.])
         if test -n "$succeeded"; then
           cl_cv_func_mmap_fixed="yes ($succeeded)"
         else
           cl_cv_func_mmap_fixed=no
         fi
        ])
      succeeded=`echo "$cl_cv_func_mmap_fixed" | LC_ALL=C tr '()' ',,'`
      case "$succeeded" in
        yes*,MAP_ANON,* )
          AC_DEFINE([HAVE_MMAP_ANON],,[<sys/mman.h> defines MAP_ANON and mmaping with MAP_FIXED | MAP_ANON works])
          ;;
      esac
      case "$succeeded" in
        yes*,MAP_ANONYMOUS,* )
          AC_DEFINE([HAVE_MMAP_ANONYMOUS],,[<sys/mman.h> defines MAP_ANONYMOUS and mmaping with MAP_FIXED | MAP_ANONYMOUS works])
          ;;
      esac
      case "$succeeded" in
        yes*,/dev/zero,* )
          AC_DEFINE([HAVE_MMAP_DEVZERO],,[mmaping of the special device /dev/zero with MAP_FIXED works])
          ;;
      esac
    fi
  fi

  case "$cl_cv_func_mmap_fixed" in
    yes*)
      dnl For SINGLEMAP_MEMORY and the TYPECODES object representation:
      dnl Test which is the highest bit number < 63 (or < 31) at which the kernel
      dnl allows us to mmap memory with MAP_FIXED. That is, try
      dnl   0x4000000000000000 -> 62
      dnl   0x2000000000000000 -> 61
      dnl   0x1000000000000000 -> 60
      dnl   ...
      dnl and return the highest bit number for which mmap succeeds.
      dnl Don't need to test bit 63 (or 31) because we use it as garcol_bit in TYPECODES.
      AC_CACHE_CHECK([for highest bit number which can be included in mmaped addresses],
        [cl_cv_func_mmap_highest_bit],
        [AC_TRY_RUN([
           #include <stdlib.h>
           #ifdef HAVE_UNISTD_H
            #include <unistd.h>
           #endif
           #include <fcntl.h>
           #include <sys/types.h>
           #include <sys/mman.h>
           #ifndef MAP_FILE
            #define MAP_FILE 0
           #endif
           #ifndef MAP_VARIABLE
            #define MAP_VARIABLE 0
           #endif
           int
           main ()
           {
             unsigned int my_size = 32768; /* hope that 32768 is a multiple of the page size */
             int pos;
             for (pos = 8*sizeof(void*)-2; pos > 0; pos--)
               {
                 unsigned long address = (unsigned long)1 << pos;
                 if (address < 4096)
                   break;
                 #ifdef __ia64__
                 /* On IA64 in 64-bit mode, the executable sits at 0x4000000000000000.
                    An mmap call to this address would either crash the program (on Linux)
                    or fail (on HP-UX). */
                 if (pos == 62)
                   continue;
                 #endif
                 #ifdef __arm__
                 /* On Linux/arm64 with CC="arm-linux-gnueabihf-gcc-4.8",
                    some shared libraries may sit at 0x40000000. An mmap call to
                    this address may crash the program. */
                 if (pos == 30)
                   address += 0x01000000UL;
                 #endif
                 {
                   char *p;
                   #if defined HAVE_MMAP_ANON
                     p = (char *) mmap ((void*)address, my_size, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE | MAP_ANON | MAP_VARIABLE, -1, 0);
                   #elif defined HAVE_MMAP_ANONYMOUS
                     p = (char *) mmap ((void*)address, my_size, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_VARIABLE, -1, 0);
                   #elif defined HAVE_MMAP_DEVZERO
                     int zero_fd = open("/dev/zero", O_RDONLY, 0666);
                     if (zero_fd < 0)
                       return 1;
                     p = (char *) mmap ((void*)address, my_size, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE | MAP_FILE | MAP_VARIABLE, zero_fd, 0);
                   #else
                     ??
                   #endif
                   if (p != (char*) -1)
                     /* mmap succeeded. */
                     return pos;
                 }
               }
             return 0;
           }
           ],
           [cl_cv_func_mmap_highest_bit=none],
           [cl_cv_func_mmap_highest_bit=$?
            case "$cl_cv_func_mmap_highest_bit" in
              0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 ) dnl Most likely a compiler error code.
                cl_cv_func_mmap_highest_bit=none ;;
            esac
           ],
           [cl_cv_func_mmap_highest_bit="guessing none"])
        ])
      case "$cl_cv_func_mmap_highest_bit" in
        *none) value='-1' ;;
        *) value="$cl_cv_func_mmap_highest_bit" ;;
      esac
      ;;
    *)
      value='-1'
      ;;
  esac
  AC_DEFINE_UNQUOTED([MMAP_FIXED_ADDRESS_HIGHEST_BIT], [$value],
    [Define to the highest bit number that can be included in mmaped addresses.])
])
