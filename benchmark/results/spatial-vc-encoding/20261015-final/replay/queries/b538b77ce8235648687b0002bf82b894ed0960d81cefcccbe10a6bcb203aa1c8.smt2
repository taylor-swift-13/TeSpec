; benchmark generated from python API
(set-info :status unknown)
(declare-fun __fsm_owned () (Array Int Bool))
(assert
 (let (($x1176 (or (and (= __fsm_owned ((as const (Array Int Bool)) false))))))
(and $x1176 (not $x1176))))
(check-sat)
