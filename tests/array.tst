
(FORMAT T "~%Erzeuge ein Feld mit doppeltgenauen Zahlen~%")   NIL

(EQUALP (SETQ DA1 (MAKE-ARRAY (QUOTE (4 2 3)) :INITIAL-CONTENTS (QUOTE
(
((1.0D0 2.0D0 3.0D0) (4.0D0 5.0D0 6.0D0))
((7.0D0 8.0D0 9.0D0) (10.0D0 11.0D0 12.0D0))
((13.0D0 14.0D0 15.0D0) (16.0D0 17.0D0 18.0D0))
((19.0D0 20.0D0 21.0D0) (22.0D0 23.0D0 24.0D0)))) :ELEMENT-TYPE
(QUOTE DOUBLE-FLOAT)))
'#3A(((1.0D0 2.0D0 3.0D0)(4.0D0 5.0D0 6.0D0))((7.0D0 8.0D0 9.0D0)(10.0D0
11.0D0
12.0D0))((13.0D0 14.0D0 15.0D0)(16.0D0 17.0D0 18.0D0))((19.0D0 20.0D0
21.0D0)(
22.0D0 23.0D0 24.0D0))))   T

(AREF DA1 0 0 0)   1.0D0

(AREF DA1 0 0 1)   2.0D0

(AREF DA1 0 0 2)   3.0D0

(AREF DA1 0 1 0)   4.0D0

(AREF DA1 0 1 1)   5.0D0

(AREF DA1 0 1 2)   6.0D0

(AREF DA1 1 0 0)   7.0D0

(AREF DA1 1 0 1)   8.0D0

(AREF DA1 1 0 2)   9.0D0

(AREF DA1 1 1 0)   10.0D0

(AREF DA1 1 1 1)   11.0D0

(AREF DA1 1 1 2)   12.0D0

(AREF DA1 2 0 0)   13.0D0

(AREF DA1 2 0 1)   14.0D0

(AREF DA1 2 0 2)   15.0D0

(AREF DA1 2 1 0)   16.0D0

(AREF DA1 2 1 1)   17.0D0

(AREF DA1 2 1 2)   18.0D0

(AREF DA1 3 0 0)   19.0D0

(AREF DA1 3 0 1)   20.0D0

(AREF DA1 3 0 2)   21.0D0

(AREF DA1 3 1 0)   22.0D0

(AREF DA1 3 1 1)   23.0D0

(AREF DA1 3 1 1)   23.0D0

(FORMAT T "~%Erzeuge ein Feld mit einfachgenauen Zahlen~%")   NIL

(EQUALP (SETQ FA1 (MAKE-ARRAY (QUOTE (4 2 3)) :INITIAL-CONTENTS (QUOTE
(
((1.0 2.0 3.0) (4.0 5.0 6.0)) ((7.0 8.0 9.0) (10.0 11.0 12.0))
((13.0 14.0 15.0) (16.0 17.0 18.0)) ((19.0 20.0 21.0) (22.0 23.0 24.0))))

:ELEMENT-TYPE (QUOTE SINGLE-FLOAT)))
'#3A(((1.0 2.0 3.0)(4.0 5.0 6.0))((7.0 8.0 9.0)(10.0 11.0 12.0))((13.0
14.0 15.0)(
16.0 17.0 18.0))((19.0 20.0 21.0)(22.0 23.0 24.0))))   T

(AREF FA1 0 0 0)   1.0

(AREF FA1 0 0 1)   2.0

(AREF FA1 0 0 2)   3.0

(AREF FA1 0 1 0)   4.0

(AREF FA1 0 1 1)   5.0

(AREF FA1 0 1 2)   6.0

(AREF FA1 1 0 0)   7.0

(AREF FA1 1 0 1)   8.0

(AREF FA1 1 0 2)   9.0

(AREF FA1 1 1 0)   10.0

(AREF FA1 1 1 1)   11.0

(AREF FA1 1 1 2)   12.0

(AREF FA1 2 0 0)   13.0

(AREF FA1 2 0 1)   14.0

(AREF FA1 2 0 2)   15.0

(AREF FA1 2 1 0)   16.0

(AREF FA1 2 1 1)   17.0

(AREF FA1 2 1 2)   18.0

(AREF FA1 3 0 0)   19.0

(AREF FA1 3 0 1)   20.0

(AREF FA1 3 0 2)   21.0

(AREF FA1 3 1 0)   22.0

(AREF FA1 3 1 1)   23.0

(AREF FA1 3 1 1)   23.0

(FORMAT T "~%Limits fuer Felder~%")   NIL

(let ((s (prin1-to-string ARRAY-RANK-LIMIT )))
  (or #+XCL (equal s "256")
      #+CLISP (equal s "4294967296") #+CLISP (equal s "65536")
      #+AKCL (equal s "64") #+GCL (equal s "63")
      #+ALLEGRO (equal s "65536")
      #+CMU (equal s "65529")
      #-(or XCL CLISP AKCL ALLEGRO CMU) "UNKNOWN"
) )
T

(let ((s (prin1-to-string ARRAY-DIMENSION-LIMIT )))
  (or #+XCL (equal s "17920")
      #+AKCL (equal s "16777216") #+GCL (equal s "2147483647")
      #+CLISP (equal s (prin1-to-string (1+ most-positive-fixnum)))
      #+ALLEGRO (equal s "16777216")
      #+CMU (equal s "536870911")
      #-(or XCL CLISP AKCL ALLEGRO CMU) "UNKNOWN"
) )
T

(let ((s (prin1-to-string ARRAY-TOTAL-SIZE-LIMIT )))
  (or #+XCL (equal s "17920")
      #+AKCL (equal s "16777216")
      #+CLISP (equal s (prin1-to-string (1+ most-positive-fixnum)))
      #+ALLEGRO (equal s "16777216")
      #+CMU (equal s "536870911")
      #-(or XCL CLISP AKCL ALLEGRO CMU) "UNKNOWN"
) )
T

(FORMAT T "~%Erzeuge einen einfachen (simple) Vector~%")   NIL

(EQUALP (SETQ SV (VECTOR (QUOTE A) (QUOTE B) (QUOTE C) 1.0S0 3.7D0
4.1))
'#(A B C 1.0S0 3.7D0 4.1))   T

(SVREF SV 0)   A

(SVREF SV 1)   B

(SVREF SV 2)   C

(SVREF SV 3)   1.0S0

(SVREF SV 4)   3.7D0

(FORMAT T "~%Pruefe Setzen eines Elements~%")   NIL

(SETF (SVREF SV 0) (QUOTE TEST))   TEST

(EQUALP SV '#(TEST B C 1.0S0 3.7D0 4.1))   T

(FORMAT T "~%Test Array-Element-Typ ... DA2 nicht def.~%")   NIL

(ARRAY-ELEMENT-TYPE SV)   T

(ARRAY-ELEMENT-TYPE DA1)
#+(or XCL ALLEGRO CMU) DOUBLE-FLOAT #+CLISP T #+AKCL LONG-FLOAT
#-(or XCL CLISP AKCL ALLEGRO CMU) UNKNOWN

(FORMAT T "~%Test Rang~%")   NIL

(ARRAY-RANK DA1)   3

(ARRAY-RANK FA1)   3

(FORMAT T "~%Test der einzelnen Dimensionen~%")   NIL

(ARRAY-DIMENSION DA1 0)   4

(ARRAY-DIMENSION DA1 1)   2

(ARRAY-DIMENSION DA1 2)   3

(ARRAY-DIMENSION DA1 3)   ERROR

(FORMAT T "~%Erzeuge ein 0-dim. Feld (Pseudoscalar) mit Inhalt mod
5~%")   NIL

(PROGN (SETQ ZERO (MAKE-ARRAY (QUOTE NIL) :ELEMENT-TYPE (QUOTE (MOD
5)))) T)   T

(ARRAY-RANK ZERO)   0

(SETF (AREF ZERO) 4)   4

(SETF (AREF ZERO) 1.0)   #+(or XCL CLISP AKCL ALLEGRO CMU) ERROR #-(or XCL CLISP AKCL ALLEGRO CMU) UNKNOWN

(FORMAT T "~%Erzeuge ein 3-dim gen. Feld~%")   NIL

(EQUALP (SETQ A1 (MAKE-ARRAY (QUOTE (4 2 3)) :INITIAL-CONTENTS (QUOTE

(((A B C) (1 2 3)) ((D E F) (3 1 2)) ((G H I) (2 3 1)) ((J K L) (0
0 0))))))
'#3A(((A B C)(1 2 3))((D E F)(3 1 2))((G H I)(2 3 1))((J K L)(0 0 0))))
  T

(AREF A1 0 0 0)   A

(AREF A1 0 0 1)   B

(AREF A1 0 0 2)   C

(AREF A1 0 1 0)   1

(AREF A1 0 1 1)   2

(AREF A1 0 1 2)   3

(AREF A1 1 0 0)   D

(AREF A1 1 0 1)   E

(AREF A1 1 0 2)   F

(AREF A1 1 1 0)   3

(AREF A1 1 1 1)   1

(AREF A1 1 1 2)   2

(AREF A1 2 0 0)   G

(AREF A1 2 0 1)   H

(AREF A1 2 0 2)   I

(AREF A1 2 1 0)   2

(AREF A1 2 1 1)   3

(AREF A1 2 1 2)   1

(AREF A1 3 0 0)   J

(AREF A1 3 0 1)   K

(AREF A1 3 0 2)   L

(AREF A1 3 1 0)   0

(AREF A1 3 1 1)   0

(AREF A1 3 1 1)   0

(FORMAT T "~%Erzeuge ein 2-dim adj.Feld, das ueberlagert wird ~%")
  NIL

(PROGN (SETQ M (MAKE-ARRAY (QUOTE (4 4)) :ADJUSTABLE T :INITIAL-CONTENTS
(QUOTE (
(ALPHA BETA GAMMA DELTA) (EPSILON ZETA ETA THETA) (IOTA KAPPA LAMBDA
MU)
(NU XI OMICRON PI))))) T)   T

(AREF M 0 0)   ALPHA

(AREF M 0 1)   BETA

(AREF M 0 2)   GAMMA

(AREF M 0 3)   DELTA

(AREF M 1 0)   EPSILON

(AREF M 1 1)   ZETA

(AREF M 1 2)   ETA

(AREF M 1 3)   THETA

(AREF M 2 0)   IOTA

(AREF M 2 1)   KAPPA

(AREF M 2 2)   LAMBDA

(AREF M 2 3)   MU

(AREF M 3 0)   NU

(AREF M 3 1)   XI

(AREF M 3 2)   OMICRON

(AREF M 3 3)   PI

(FORMAT T "~%Erzeuge Ueberl. der Zeilen ~%")   NIL

(equalp (SETQ MD0 (MAKE-ARRAY 4 :DISPLACED-TO M))   '#(ALPHA BETA GAMMA
DELTA)) t

(equalp (SETQ MD1 (MAKE-ARRAY 4 :DISPLACED-TO M :DISPLACED-INDEX-OFFSET
4))
'#(EPSILON ZETA ETA THETA)) t


(equalp (SETQ MD2 (MAKE-ARRAY 4 :DISPLACED-TO M :DISPLACED-INDEX-OFFSET
8))
'#(IOTA KAPPA LAMBDA MU)) t


(FORMAT T "~%Adjustiere Feld m~%")   NIL

(PROGN (ADJUST-ARRAY M (QUOTE (3 5)) :INITIAL-ELEMENT (QUOTE BAZ))
T)   T

(AREF M 0 0)   ALPHA

(AREF M 0 1)   BETA

(AREF M 0 2)   GAMMA

(AREF M 0 3)   DELTA

(AREF M 0 4)   BAZ

(AREF M 1 0)   EPSILON

(AREF M 1 1)   ZETA

(AREF M 1 2)   ETA

(AREF M 1 3)   THETA

(AREF M 1 4)   BAZ

(AREF M 2 0)   IOTA

(AREF M 2 1)   KAPPA

(AREF M 2 2)   LAMBDA
(FORMAT T "~%Teste Zusammenspiel der Schluesselworte~%")   NIL

(PROGN (SETQ DV (MAKE-ARRAY 10 :ELEMENT-TYPE (QUOTE DOUBLE-FLOAT)
:INITIAL-CONTENTS
(QUOTE (0.0D0 1.0D0 2.0D0 3.0D0 4.0D0 5.0D0 6.0D0 7.0D0 8.0D0 9.0D0))))
T)   T
#| ***************************************************************************

(SETQ DVE (MAKE-ARRAY (QUOTE (2 2)) :ELEMENT-TYPE (QUOTE DOUBLE-FLOAT)

:INITIAL-CONTENTS (QUOTE ((1.0D0 2.0D0) (3.0D0 4.0D0 5.0D0)))))   ERROR

(SETQ DVE (MAKE-ARRAY (QUOTE (2 2)) :ELEMENT-TYPE (QUOTE DOUBLE-FLOAT)

:INITIAL-CONTENTS (QUOTE
((1.0D0 2.0D0) (3.0D0 4.0D0) :DISPLACED-TO DV :DISPLACED-INDEX-OFFSET
8))))   ERROR

(SETQ DVE (MAKE-ARRAY (QUOTE (2 2)) :ELEMENT-TYPE (QUOTE DOUBLE-FLOAT)

:INITIAL-CONTENTS (QUOTE ((1.0D0 2.0D0) (3.0D0 4.0D0))) :DISPLACED-TO
DV
:DISPLACED-INDEX-OFFSET 8))   ERROR

(SETQ DVE (MAKE-ARRAY (QUOTE (2 2)) :ELEMENT-TYPE (QUOTE DOUBLE-FLOAT)

:DISPLACED-TO DV :DISPLACED-INDEX-OFFSET 8))   ERROR

***************************************************************************|#

(AREF DV 0)   0.0D0

(AREF DV 1)   1.0D0

(AREF DV 2)   2.0D0

(AREF DV 3)   3.0D0

(AREF DV 4)   4.0D0

(AREF DV 5)   5.0D0

(AREF DV 6)   6.0D0

(AREF DV 7)   7.0D0

(AREF DV 8)   8.0D0

(AREF DV 9)   9.0D0

(SETF (AREF DV 5) -5.0D0)   -5.0D0

(FORMAT T "~%Definiere Testfkt fuer Indices~%")   NIL

(DEFUN ARRAY-INDEX-TEST (A &REST SUBS) (UNLESS
(APPLY (FUNCTION ARRAY-IN-BOUNDS-P) A SUBS)
(RETURN-FROM ARRAY-INDEX-TEST (QUOTE ERROR))) (=
(APPLY (FUNCTION ARRAY-ROW-MAJOR-INDEX) A SUBS) (APPLY (FUNCTION +)
(MAPLIST
(FUNCTION (LAMBDA (X Y) (* (CAR X) (APPLY (FUNCTION *) (CDR Y)))))
SUBS
(ARRAY-DIMENSIONS A)))))   ARRAY-INDEX-TEST

(ARRAY-INDEX-TEST (MAKE-ARRAY (QUOTE (5 4 3 2 1))) 4 2 2 1 0)   T

(ARRAY-INDEX-TEST (MAKE-ARRAY (QUOTE (5 4 3 2 1))) 3 4 2 1 2)   ERROR

(FORMAT T "~%Test Bitfelder ~%")   NIL

(SETQ BVZERO (MAKE-ARRAY 100 :ELEMENT-TYPE (QUOTE BIT) :INITIAL-ELEMENT
0))
#*0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

(SETQ BVONE (MAKE-ARRAY 100 :ELEMENT-TYPE (QUOTE BIT) :INITIAL-ELEMENT
1))
#*1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

(SETQ BV3 (MAKE-ARRAY 100 :ELEMENT-TYPE (QUOTE BIT) :INITIAL-ELEMENT
0))
#*0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

(SETQ BV2 (MAKE-ARRAY 100 :ELEMENT-TYPE (QUOTE BIT) :INITIAL-ELEMENT
0))
#*0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

(SETQ BV1 (MAKE-ARRAY 100 :ELEMENT-TYPE (QUOTE BIT) :INITIAL-ELEMENT
0))
#*0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

(FORMAT T "~%Setze Bitfelder ~%")   NIL

(DOTIMES (I 50 BV1) (SETF (SBIT BV1 (* I 2)) 1))
#*1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010

(DOTIMES (I 50 BV2) (SETF (BIT BV2 (* I 2)) 1))
#*1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010

(EQUALP BV1 BV2)   T
(DOTIMES (I 25 BV3) (SETF (SBIT BV3 (* I 4)) 1))
#*1000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000

(BIT-AND BV1 BV3)
#*1000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000

(BIT-IOR BV1 BV3)
#*1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010

(BIT-XOR BV1 BV3)
#*0010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010

(BIT-EQV BV1 BV3)
#*1101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101

(BIT-NAND BV1 BV3)
#*0111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111

(BIT-ANDC1 BV1 BV3)
#*0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

(BIT-ANDC2 BV1 BV3)
#*0010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010

(BIT-ORC1 BV1 BV3)
#*1101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101

(BIT-ORC2 BV1 BV3)
#*1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

(BIT-NOT BV1)
#*0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101

(BIT-NOT BVZERO)
#*1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

(BIT-NOT BVONE)
#*0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

(FORMAT T "~%Teste Operationen mit Fillpointern ~%")   NIL

(MAKE-ARRAY (QUOTE (3 4 5)) :FILL-POINTER T)   ERROR

(equalp (MAKE-ARRAY 5 :FILL-POINTER 5)
        #+(or XCL CMU) '#(0 0 0 0 0) #-(or XCL CMU) '#(nil nil nil nil nil))
T

(MAKE-ARRAY 5 :FILL-POINTER -5)   ERROR

(FORMAT T "~%Allgem. Vector mit Fillpointer ~%")   NIL

(PROGN (SETQ VMF (MAKE-ARRAY 5 :FILL-POINTER 0)) T)   T

(FILL-POINTER VMF)   0

(VECTOR-PUSH (QUOTE A) VMF)   0

(FILL-POINTER VMF)   1

(VECTOR-PUSH (QUOTE B) VMF)   1

(VECTOR-PUSH (QUOTE C) VMF)   2

(VECTOR-PUSH (QUOTE D) VMF)   3

(VECTOR-PUSH (QUOTE E) VMF)   4

(VECTOR-PUSH (QUOTE VOLL) VMF)   NIL

(VECTOR-POP VMF)   E

(VECTOR-POP VMF)   D

(VECTOR-POP VMF)   C

(VECTOR-POP VMF)   B

(VECTOR-POP VMF)   A

(VECTOR-POP VMF)   ERROR

(FORMAT T "~%Adjustabler allgem. Vector mit Fillpointer~%")   NIL

(PROGN (SETQ VMFA (MAKE-ARRAY 5 :FILL-POINTER 0 :ADJUSTABLE T)) T)
  T

(FILL-POINTER VMFA)   0

(VECTOR-PUSH-EXTEND (QUOTE A) VMFA)   0

(FILL-POINTER VMFA)   1

(VECTOR-PUSH-EXTEND (QUOTE B) VMFA)   1

(VECTOR-PUSH-EXTEND (QUOTE C) VMFA)   2

(VECTOR-PUSH-EXTEND (QUOTE D) VMFA)   3

(VECTOR-PUSH-EXTEND (QUOTE E) VMFA)   4

(VECTOR-PUSH-EXTEND (QUOTE VOLL) VMFA)   5

(VECTOR-POP VMFA)   VOLL

(VECTOR-POP VMFA)   E

(VECTOR-POP VMFA)   D

(VECTOR-POP VMFA)   C

(VECTOR-POP VMFA)   B

(VECTOR-POP VMFA)   A

(FORMAT T "~%Doppeltgen. Vector mit Fillpointer ~%")   NIL

(PROGN
(SETQ VMFD (MAKE-ARRAY 5 :FILL-POINTER 0 :ELEMENT-TYPE (QUOTE DOUBLE-FLOAT)))
T)   T

(FILL-POINTER VMFD)   0

(VECTOR-PUSH 0.0D0 VMFD)   0

(FILL-POINTER VMFD)   1

(VECTOR-PUSH 1.0D0 VMFD)   1

(VECTOR-PUSH 2.0D0 VMFD)   2

(VECTOR-PUSH 3.0D0 VMFD)   3

(VECTOR-PUSH 4.0D0 VMFD)   4

(VECTOR-PUSH 5.0D0 VMFD)   NIL

(VECTOR-POP VMFD)   4.0D0

(VECTOR-POP VMFD)   3.0D0

(VECTOR-POP VMFD)   2.0D0

(VECTOR-POP VMFD)   1.0D0

(VECTOR-POP VMFD)   0.0D0

(VECTOR-POP VMFD)   ERROR

(FORMAT T "~%Doppeltgen. adjust. Vector mit Fillpointer ~%")   NIL

(PROGN (SETQ VMFAD
(MAKE-ARRAY 5 :FILL-POINTER 0 :ELEMENT-TYPE (QUOTE DOUBLE-FLOAT) :ADJUSTABLE
T))
T)   T

(FILL-POINTER VMFAD)   0

(VECTOR-PUSH-EXTEND 0.0D0 VMFAD)   0

(FILL-POINTER VMFAD)   1

(VECTOR-PUSH-EXTEND 1.0D0 VMFAD)   1

(VECTOR-PUSH-EXTEND 2.0D0 VMFAD)   2

(VECTOR-PUSH-EXTEND 3.0D0 VMFAD)   3

(VECTOR-PUSH-EXTEND 4.0D0 VMFAD)   4

(VECTOR-PUSH-EXTEND 5.0D0 VMFAD)   5

(VECTOR-POP VMFAD)   5.0D0

(VECTOR-POP VMFAD)   4.0D0

(VECTOR-POP VMFAD)   3.0D0

(VECTOR-POP VMFAD)   2.0D0

(VECTOR-POP VMFAD)   1.0D0

(VECTOR-POP VMFAD)   0.0D0

(VECTOR-PUSH-EXTEND 5.0S0 VMFAD)
#+(or XCL GCL ALLEGRO CMU) ERROR #+(or CLISP (and AKCL (not GCL))) 0
#-(or XCL CLISP AKCL ALLEGRO CMU) UNKNOWN

