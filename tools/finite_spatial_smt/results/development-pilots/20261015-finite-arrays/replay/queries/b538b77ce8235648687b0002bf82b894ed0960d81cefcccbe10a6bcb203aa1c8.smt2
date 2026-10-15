; benchmark generated from python API
(set-info :status unknown)
(declare-fun __fsm_owned () (Array Int Bool))
(assert
 (let (($x86 (or (and (= __fsm_owned ((as const (Array Int Bool)) false))))))
(and $x86 (not $x86))))
(check-sat)
