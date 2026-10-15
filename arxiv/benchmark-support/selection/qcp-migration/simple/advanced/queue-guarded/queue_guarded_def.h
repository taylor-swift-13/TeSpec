struct int_queueCell { int first; struct int_queueCell *next; };
struct int_queue { struct int_queueCell *front; struct int_queueCell *back; };
/*@ Import Coq Require Import CNQueueGuarded */
/*@ Extern Coq (CNQueueAux : Z -> Z -> list Z -> Assertion) */
