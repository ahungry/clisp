# Werte der Bytecodes (256 St�ck):

# (1) Konstanten
BYTECODE(cod_nil)
BYTECODE(cod_push_nil)
BYTECODE(cod_t)
BYTECODE(cod_const)
# (2) statische Variablen
BYTECODE(cod_load)
BYTECODE(cod_loadi)
BYTECODE(cod_loadc)
BYTECODE(cod_loadv)
BYTECODE(cod_loadic)
BYTECODE(cod_store)
BYTECODE(cod_storei)
BYTECODE(cod_storec)
BYTECODE(cod_storev)
BYTECODE(cod_storeic)
# (3) dynamische Variablen
BYTECODE(cod_getvalue)
BYTECODE(cod_setvalue)
BYTECODE(cod_bind)
BYTECODE(cod_unbind1)
BYTECODE(cod_unbind)
BYTECODE(cod_progv)
# (4) Stackoperationen
BYTECODE(cod_push)
BYTECODE(cod_pop)
BYTECODE(cod_skip)
BYTECODE(cod_skipi)
BYTECODE(cod_skipsp)
# (5) Programmflu� und Spr�nge
BYTECODE(cod_skip_ret)
BYTECODE(cod_skip_retgf)
BYTECODE(cod_jmp)
BYTECODE(cod_jmpif)
BYTECODE(cod_jmpifnot)
BYTECODE(cod_jmpif1)
BYTECODE(cod_jmpifnot1)
BYTECODE(cod_jmpifatom)
BYTECODE(cod_jmpifconsp)
BYTECODE(cod_jmpifeq)
BYTECODE(cod_jmpifnoteq)
BYTECODE(cod_jmpifeqto)
BYTECODE(cod_jmpifnoteqto)
BYTECODE(cod_jmphash)
BYTECODE(cod_jmphashv)
BYTECODE(cod_jsr)
BYTECODE(cod_jmptail)
# (6) Environments und Closures
BYTECODE(cod_venv)
BYTECODE(cod_make_vector1_push)
BYTECODE(cod_copy_closure)
# (7) Funktionsaufrufe
BYTECODE(cod_call)
BYTECODE(cod_call0)
BYTECODE(cod_call1)
BYTECODE(cod_call2)
BYTECODE(cod_calls1)
BYTECODE(cod_calls2)
BYTECODE(cod_callsr)
BYTECODE(cod_callc)
BYTECODE(cod_callckey)
BYTECODE(cod_funcall)
BYTECODE(cod_apply)
# (8) optionale und Keyword-Argumente
BYTECODE(cod_push_unbound)
BYTECODE(cod_unlist)
BYTECODE(cod_unliststern)
BYTECODE(cod_jmpifboundp)
BYTECODE(cod_boundp)
BYTECODE(cod_unbound_nil)
# (9) Behandlung mehrerer Werte
BYTECODE(cod_values0)
BYTECODE(cod_values1)
BYTECODE(cod_stack_to_mv)
BYTECODE(cod_mv_to_stack)
BYTECODE(cod_nv_to_stack)
BYTECODE(cod_mv_to_list)
BYTECODE(cod_list_to_mv)
BYTECODE(cod_mvcallp)
BYTECODE(cod_mvcall)
# (10) BLOCK
BYTECODE(cod_block_open)
BYTECODE(cod_block_close)
BYTECODE(cod_return_from)
BYTECODE(cod_return_from_i)
# (11) TAGBODY
BYTECODE(cod_tagbody_open)
BYTECODE(cod_tagbody_close_nil)
BYTECODE(cod_tagbody_close)
BYTECODE(cod_go)
BYTECODE(cod_go_i)
# (12) CATCH und THROW
BYTECODE(cod_catch_open)
BYTECODE(cod_catch_close)
BYTECODE(cod_throw)
# (13) UNWIND-PROTECT
BYTECODE(cod_uwp_open)
BYTECODE(cod_uwp_normal_exit)
BYTECODE(cod_uwp_close)
BYTECODE(cod_uwp_cleanup)
# (14) HANDLER-BIND
BYTECODE(cod_handler_open)
BYTECODE(cod_handler_begin_push)
# (15) einige Funktionen
BYTECODE(cod_not)
BYTECODE(cod_eq)
BYTECODE(cod_car)
BYTECODE(cod_cdr)
BYTECODE(cod_cons)
BYTECODE(cod_symbol_function)
BYTECODE(cod_svref)
BYTECODE(cod_svset)
BYTECODE(cod_list)
BYTECODE(cod_liststern)
# (16) kombinierte Operationen
BYTECODE(cod_nil_push)
BYTECODE(cod_t_push)
BYTECODE(cod_const_push)
BYTECODE(cod_load_push)
BYTECODE(cod_loadi_push)
BYTECODE(cod_loadc_push)
BYTECODE(cod_loadv_push)
BYTECODE(cod_pop_store)
BYTECODE(cod_getvalue_push)
BYTECODE(cod_jsr_push)
BYTECODE(cod_copy_closure_push)
BYTECODE(cod_call_push)
BYTECODE(cod_call1_push)
BYTECODE(cod_call2_push)
BYTECODE(cod_calls1_push)
BYTECODE(cod_calls2_push)
BYTECODE(cod_callsr_push)
BYTECODE(cod_callc_push)
BYTECODE(cod_callckey_push)
BYTECODE(cod_funcall_push)
BYTECODE(cod_apply_push)
BYTECODE(cod_car_push)
BYTECODE(cod_cdr_push)
BYTECODE(cod_cons_push)
BYTECODE(cod_list_push)
BYTECODE(cod_liststern_push)
BYTECODE(cod_nil_store)
BYTECODE(cod_t_store)
BYTECODE(cod_load_storec)
BYTECODE(cod_calls1_store)
BYTECODE(cod_calls2_store)
BYTECODE(cod_callsr_store)
BYTECODE(cod_load_cdr_store)
BYTECODE(cod_load_cons_store)
BYTECODE(cod_load_inc_store)
BYTECODE(cod_load_dec_store)
BYTECODE(cod_load_car_store)
BYTECODE(cod_call1_jmpif)
BYTECODE(cod_call1_jmpifnot)
BYTECODE(cod_call2_jmpif)
BYTECODE(cod_call2_jmpifnot)
BYTECODE(cod_calls1_jmpif)
BYTECODE(cod_calls1_jmpifnot)
BYTECODE(cod_calls2_jmpif)
BYTECODE(cod_calls2_jmpifnot)
BYTECODE(cod_callsr_jmpif)
BYTECODE(cod_callsr_jmpifnot)
BYTECODE(cod_load_jmpif)
BYTECODE(cod_load_jmpifnot)
BYTECODE(cod_load_car_push)
BYTECODE(cod_load_cdr_push)
BYTECODE(cod_load_inc_push)
BYTECODE(cod_load_dec_push)
BYTECODE(cod_const_symbol_function)
BYTECODE(cod_const_symbol_function_push)
BYTECODE(cod_const_symbol_function_store)
BYTECODE(cod_apply_skip_ret)
BYTECODE(cod_funcall_skip_retgf)
# (17) Kurzcodes
BYTECODE(cod_load0)
BYTECODE(cod_load1)
BYTECODE(cod_load2)
BYTECODE(cod_load3)
BYTECODE(cod_load4)
BYTECODE(cod_load5)
BYTECODE(cod_load6)
BYTECODE(cod_load7)
BYTECODE(cod_load8)
BYTECODE(cod_load9)
BYTECODE(cod_load10)
BYTECODE(cod_load11)
BYTECODE(cod_load12)
BYTECODE(cod_load13)
BYTECODE(cod_load14)
#if 0
BYTECODE(cod_load15)
BYTECODE(cod_load16)
BYTECODE(cod_load17)
BYTECODE(cod_load18)
BYTECODE(cod_load19)
BYTECODE(cod_load20)
BYTECODE(cod_load21)
#endif
BYTECODE(cod_load_push0)
BYTECODE(cod_load_push1)
BYTECODE(cod_load_push2)
BYTECODE(cod_load_push3)
BYTECODE(cod_load_push4)
BYTECODE(cod_load_push5)
BYTECODE(cod_load_push6)
BYTECODE(cod_load_push7)
BYTECODE(cod_load_push8)
BYTECODE(cod_load_push9)
BYTECODE(cod_load_push10)
BYTECODE(cod_load_push11)
BYTECODE(cod_load_push12)
BYTECODE(cod_load_push13)
BYTECODE(cod_load_push14)
BYTECODE(cod_load_push15)
BYTECODE(cod_load_push16)
BYTECODE(cod_load_push17)
BYTECODE(cod_load_push18)
BYTECODE(cod_load_push19)
BYTECODE(cod_load_push20)
BYTECODE(cod_load_push21)
BYTECODE(cod_load_push22)
BYTECODE(cod_load_push23)
BYTECODE(cod_load_push24)
BYTECODE(cod_const0)
BYTECODE(cod_const1)
BYTECODE(cod_const2)
BYTECODE(cod_const3)
BYTECODE(cod_const4)
BYTECODE(cod_const5)
BYTECODE(cod_const6)
BYTECODE(cod_const7)
BYTECODE(cod_const8)
BYTECODE(cod_const9)
BYTECODE(cod_const10)
BYTECODE(cod_const11)
BYTECODE(cod_const12)
BYTECODE(cod_const13)
BYTECODE(cod_const14)
BYTECODE(cod_const15)
BYTECODE(cod_const16)
BYTECODE(cod_const17)
BYTECODE(cod_const18)
BYTECODE(cod_const19)
BYTECODE(cod_const20)
#if 0
BYTECODE(cod_const21)
BYTECODE(cod_const22)
BYTECODE(cod_const23)
BYTECODE(cod_const24)
#endif
BYTECODE(cod_const_push0)
BYTECODE(cod_const_push1)
BYTECODE(cod_const_push2)
BYTECODE(cod_const_push3)
BYTECODE(cod_const_push4)
BYTECODE(cod_const_push5)
BYTECODE(cod_const_push6)
BYTECODE(cod_const_push7)
BYTECODE(cod_const_push8)
BYTECODE(cod_const_push9)
BYTECODE(cod_const_push10)
BYTECODE(cod_const_push11)
BYTECODE(cod_const_push12)
BYTECODE(cod_const_push13)
BYTECODE(cod_const_push14)
BYTECODE(cod_const_push15)
BYTECODE(cod_const_push16)
BYTECODE(cod_const_push17)
BYTECODE(cod_const_push18)
BYTECODE(cod_const_push19)
BYTECODE(cod_const_push20)
BYTECODE(cod_const_push21)
BYTECODE(cod_const_push22)
BYTECODE(cod_const_push23)
BYTECODE(cod_const_push24)
BYTECODE(cod_const_push25)
BYTECODE(cod_const_push26)
BYTECODE(cod_const_push27)
BYTECODE(cod_const_push28)
BYTECODE(cod_const_push29)
#if 0
BYTECODE(cod_const_push30)
BYTECODE(cod_const_push31)
BYTECODE(cod_const_push32)
#endif
BYTECODE(cod_store0)
BYTECODE(cod_store1)
BYTECODE(cod_store2)
BYTECODE(cod_store3)
BYTECODE(cod_store4)
BYTECODE(cod_store5)
BYTECODE(cod_store6)
BYTECODE(cod_store7)
#if 0
BYTECODE(cod_store8)
BYTECODE(cod_store9)
BYTECODE(cod_store10)
BYTECODE(cod_store11)
BYTECODE(cod_store12)
BYTECODE(cod_store13)
BYTECODE(cod_store14)
BYTECODE(cod_store15)
BYTECODE(cod_store16)
BYTECODE(cod_store17)
BYTECODE(cod_store18)
BYTECODE(cod_store19)
BYTECODE(cod_store20)
BYTECODE(cod_store21)
#endif
