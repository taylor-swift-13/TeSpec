; benchmark generated from python API
(set-info :status unknown)
(declare-fun __fsm_owned () (Array Int Bool))
(assert
 (let (($x79 (or (and (= __fsm_owned ((as const (Array Int Bool)) false))))))
(and $x79 (not $x79))))
(check-sat)
