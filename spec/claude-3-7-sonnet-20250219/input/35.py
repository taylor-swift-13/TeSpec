def max_element_spec(l, m):
    """
    Implementation of the Coq specification:
    Definition max_element_spec (l : list nat) (m : nat) : Prop :=
      l <> [] /\
      In m l /\
      forall x, In x l -> x <= m.
    """
    # l <> []
    condition1 = len(l) > 0
    
    # In m l
    condition2 = m in l
    
    # forall x, In x l -> x <= m
    condition3 = all(x <= m for x in l)
    
    return condition1 and condition2 and condition3
