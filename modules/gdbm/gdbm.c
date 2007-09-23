/*
 * GDBM - The GNU database manager
 * <http://www.gnu.org/software/gdbm/>
 * Copyright (C) 2007 Masayuki Onjo
 * GPL2
 */

#include "clisp.h"
#include "config.h"

#ifdef HAVE_STRING_H
# include <string.h>
#endif

#if defined(HAVE_GDBM_H)
# include <gdbm.h>
#elif defined(HAVE_GDBM_GDBM_H)
# include <gdbm/gdbm.h>
#else
# error No GDBM headers!
#endif

DEFMODULE(gdbm,"GDBM");

nonreturning_function(static, error_gdbm, (void)) {
  pushSTACK(`GDBM::GDBM-ERROR`);
  pushSTACK(`:MESSAGE`);
  pushSTACK(asciz_to_string(gdbm_strerror(gdbm_errno), GLO(foreign_encoding)));
  pushSTACK(`"~A: ~A"`);
  pushSTACK(TheSubr(subr_self)->name);
  pushSTACK(asciz_to_string(gdbm_strerror(gdbm_errno), GLO(foreign_encoding)));
  funcall(L(error_of_type), 6);
  NOTREACHED;
}

DEFUN(GDBM::GDBM-VERSION,)
{
  VALUES1(asciz_to_string(gdbm_version, GLO(foreign_encoding)));
}

DEFCHECKER(gdbm_open_read_write, prefix=GDBM, READER WRITER WRCREAT NEWDB)
DEFCHECKER(gdbm_open_option, prefix=GDBM, SYNC NOLOCK FAST)
DEFUN(GDBM::GDBM-OPEN, name &key :BLOCKSIZE :READ-WRITE :OPTION :MODE)
{
  GDBM_FILE gdbm;
  int mode = check_uint_defaulted(STACK_0, 0644);
  int rw_opt1 = missingp(STACK_1) ? 0 : gdbm_open_option(STACK_1);
  int rw_opt2 = missingp(STACK_2) ? GDBM_WRCREAT
    : gdbm_open_read_write(STACK_2);
  int rw = rw_opt1 | rw_opt2;
  int bsize = check_uint_defaulted(STACK_3, 512);
  void (*fatal)() = NULL;
  object path = STACK_4;

  skipSTACK(5);

  if (!stringp(path)) {
    VALUES1(NIL);
  } else {
    with_string_0(stringp(path) ? (object)path : physical_namestring(path),
                  GLO(pathname_encoding), name, {
        begin_system_call();
        gdbm = gdbm_open(name, bsize, rw, mode, fatal);
        end_system_call();
      });
    if (gdbm != NULL) {
      pushSTACK(allocate_fpointer(gdbm));
      funcall(`GDBM::MAKE-GDBM`, 1);
      pushSTACK(value1);        /* save */
      pushSTACK(STACK_0); pushSTACK(``GDBM::GDBM-CLOSE``);
      funcall(L(finalize),2);
      VALUES1(popSTACK());      /* restore */
    } else {
      error_gdbm();
    }
  }
}

/* can trigger GC */
static GDBM_FILE check_gdbm (object gdbm)
{
  gdbm = check_classname(gdbm, `GDBM::GDBM`);
  return nullp(TheStructure(gdbm)->recdata[1]) ? NULL
    : (GDBM_FILE)TheFpointer(TheStructure(gdbm)->recdata[1])->fp_pointer;
}

DEFUN(GDBM:GDBM-CLOSE, dbf)
{
  GDBM_FILE dbf = check_gdbm(STACK_0);
  if (dbf) {
    gdbm_close(dbf);
    TheStructure(STACK_0)->recdata[1] = NIL;
    VALUES1(T);
  } else {
    VALUES1(NIL);
  }
  skipSTACK(1);
}

#define with_gdbm_key(key_obj, var, statement) \
  if (stringp(key_obj)) { \
    with_string_0(key_obj, GLO(foreign_encoding), var, statement); \
  } else if (vectorp(key_obj)) { \
    char* var; int var##_len; \
    if (!bit_vector_p(Atype_8Bit,key_obj)) { \
      pushSTACK(key_obj); pushSTACK(GLO(type_uint8_vector)); \
      funcall(L(coerce),2); \
      if (!bit_vector_p(Atype_8Bit,value1)) { NOTREACHED; } \
      key_obj = value1; \
    } \
    var = &TheSbvector(key_obj)->data[0]; var##_len = vector_length(key_obj); \
    statement; \
  } else NOTREACHED;


DEFCHECKER(gdbm_store_flag, prefix=GDBM, REPLACE INSERT);
DEFUN(GDBM:GDBM-STORE, dbf key content &key FLAG)
{
  GDBM_FILE dbf = check_gdbm(STACK_3);
  int flag = missingp(STACK_0) ? GDBM_REPLACE : gdbm_store_flag(STACK_0);
  object content_obj = STACK_1;
  object key_obj = STACK_2;
  object array = NIL;
  int binary_p=0, string_p = stringp(content_obj);
  datum key, content;
  skipSTACK(4);

  if (!string_p) {
    array = check_vector(content_obj);
    if (!bit_vector_p(Atype_8Bit,array)) {
      pushSTACK(array); pushSTACK(GLO(type_uint8_vector));
      funcall(L(coerce),2);
      if (!bit_vector_p(Atype_8Bit,value1)) { NOTREACHED; }
      array = value1;
    }
    binary_p = 1;
  }

  if (dbf && (string_p || binary_p)) {
    with_gdbm_key(key_obj, ks, {
	key.dptr = ks;
	key.dsize = ks_len;
	if (binary_p) {
	  content.dptr = (char*)&TheSbvector(array)->data[0];
	  content.dsize = vector_length(array);
	  VALUES_IF(!gdbm_store(dbf, key, content, flag));
	} else {
	  with_string_0(content_obj, GLO(foreign_encoding), cs, {
	      content.dptr = cs;
	      content.dsize = cs_len;
	      VALUES_IF(!gdbm_store(dbf, key, content, flag));
	    });
	}
      });
  } else {
    VALUES1(NIL);
  }
}

DEFUN(GDBM:GDBM-FETCH, dbf key &key BINARY)
{
  GDBM_FILE dbf = check_gdbm(STACK_2);
  object binary = popSTACK();
  int binary_p = !missingp(binary);
  object key_obj = popSTACK();
  datum key, ret;
  skipSTACK(1);                 /* drop dbf */

  if (dbf) {
    with_gdbm_key(key_obj, ks, {
	key.dptr = ks;
	key.dsize = ks_len;
	ret = gdbm_fetch(dbf, key);
	if (ret.dptr == NULL) {
	  VALUES1(NIL);
	} else {
	  if (!binary_p) {
	    VALUES1(n_char_to_string(ret.dptr, ret.dsize,
				     GLO(foreign_encoding)));
	  } else {
	    object vector = allocate_bit_vector(Atype_8Bit,ret.dsize);
	    int i = 0;
	    for (i=0;i<ret.dsize;i++)
	      TheSbvector(vector)->data[i] = ret.dptr[i];
	    VALUES1(vector);
	  }
	  free(ret.dptr);
	}
      });
  } else {
    VALUES1(NIL);
  }
}

DEFUN(GDBM:GDBM-DELETE, dbf key)
{
  GDBM_FILE dbf = check_gdbm(STACK_1);
  object key_obj = popSTACK();
  datum key;
  skipSTACK(1);                 /* drop dbf */

  if (dbf) {
    with_gdbm_key(key_obj, ks, {
	key.dptr = ks;
	key.dsize = ks_len;
	if (gdbm_delete(dbf, key) == -1) {
	  VALUES1(NIL);
	} else {
	  VALUES1(T);
	}
      });
  } else {
    VALUES1(NIL);
  }
}

/* convert datum to Lisp string and release memory in datum
 can trigger GC */
static object datum_to_object (datum d, int binary) {
  if (d.dptr == NULL) return NIL;
  else if (binary==0) {
    object o = n_char_to_string(d.dptr, d.dsize, GLO(foreign_encoding));
    free(d.dptr);
    return o;
  } else {
    object o = allocate_bit_vector(Atype_8Bit,d.dsize);
    int i = 0;
    for (i=0;i<d.dsize;i++)
      TheSbvector(o)->data[i] = d.dptr[i];
    free(d.dptr);
    return o;
  }
}

DEFUN(GDBM:GDBM-FIRSTKEY, dbf &key BINARY)
{
  int binary_p = !missingp(STACK_0);
  GDBM_FILE dbf = check_gdbm(STACK_1);

  skipSTACK(2);

  if (dbf) {
    VALUES1(datum_to_object(gdbm_firstkey(dbf),binary_p));
  } else {
    VALUES1(NIL);
  }
}

DEFUN(GDBM:GDBM-NEXTKEY, dbf key &key BINARY)
{
  int binary_p = !missingp(STACK_0);
  object key_obj = STACK_1;
  GDBM_FILE dbf = check_gdbm(STACK_2);
  datum key;
  skipSTACK(3);                 /* drop dbf */

  if (dbf) {
    with_gdbm_key(key_obj, ks, {
        key.dptr = ks;
        key.dsize = ks_len;
	VALUES1(datum_to_object(gdbm_nextkey(dbf, key),binary_p));
      });
  } else {
    VALUES1(NIL);
  }
}

DEFUN(GDBM:GDBM-REORGANIZE, dbf)
{
  GDBM_FILE dbf = check_gdbm(popSTACK());

  if (dbf) {
    int status = gdbm_reorganize(dbf);
    if (status == -1) {
      error_gdbm();
    } else {
      VALUES1(T);
    }
  } else {
    VALUES1(NIL);
  }
}


DEFUN(GDBM:GDBM-SYNC, dbf)
{
  GDBM_FILE dbf = check_gdbm(popSTACK());

  if (dbf) {
    gdbm_sync(dbf);
    VALUES1(T);
  } else {
    VALUES1(NIL);
  }
}

DEFUN(GDBM:GDBM-EXISTS, dbf key)
{
  GDBM_FILE dbf = check_gdbm(STACK_1);
  object key_obj = popSTACK();
  datum key;
  skipSTACK(1);                 /* drop dbf */

  if (dbf) {
    with_gdbm_key(key_obj, ks, {
	key.dptr = ks;
	key.dsize = ks_len;
	if (gdbm_exists(dbf, key)) {
	  VALUES1(T);
	} else {
	  VALUES1(NIL);
	}
      });
  } else {
    VALUES1(NIL);
  }
}

DEFCHECKER(gdbm_setopt_option, prefix=GDBM, CACHESIZE FASTMODE SYNCMODE \
           CENTFREE COALESCEBLKS)
DEFUN(GDBM:GDBM-SETOPT, dbf option value)
{
  GDBM_FILE dbf = check_gdbm(STACK_2);
  int option = gdbm_setopt_option(STACK_1);
  object value = STACK_0;
  skipSTACK(3);

  if (dbf) {
    int v;
    switch (option) {
      case GDBM_CACHESIZE:
        v = I_to_sint(check_sint(value)); break;
      case GDBM_FASTMODE: case GDBM_SYNCMODE:
      case GDBM_CENTFREE: case GDBM_COALESCEBLKS:
        v = nullp(value) ? 0 : 1; break;
      default: NOTREACHED;
    }
    if (gdbm_setopt(dbf, option, &v, sizeof(int)) == -1) {
      error_gdbm();
    } else {
      VALUES1(T);
    }
  } else {
    VALUES1(NIL);
  }
}
