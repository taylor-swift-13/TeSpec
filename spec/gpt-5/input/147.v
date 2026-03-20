Require Import Coq.ZArith.ZArith.

Open Scope Z_scope.

Definition get_max_triples_spec (n ans : Z) : Prop :=
  ans =
    (if Z.leb n 2 then 0
     else
       let one_cnt := 1 + 2 * Z.div (n - 2) 3 + Z.modulo (n - 2) 3 in
       let zero_cnt := n - one_cnt in
       Z.div (one_cnt * (one_cnt - 1) * (one_cnt - 2)) 6 +
       Z.div (zero_cnt * (zero_cnt - 1) * (zero_cnt - 2)) 6).