file_list=''
mod_list=''
if test -f postgresql.c; then
  file_list="$file_list"' postgresql.o'
  mod_list="$mod_list"' postgresql'
fi
make clisp-module CC="${CC}" CFLAGS="${CFLAGS}" INCLUDES="$absolute_linkkitdir"
NEW_FILES="$file_list"
NEW_LIBS="$file_list -lpq -lcrypt"
NEW_MODULES="$mod_list"
TO_LOAD='postgresql'
