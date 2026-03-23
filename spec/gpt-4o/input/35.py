def max_element_spec(l, max_elem):
    """
    Checks if max_elem is the maximum element in the list l.
    Coq definition:
    Definition max_element_spec (l : list nat) (max_elem : nat) : Prop :=
      In max_elem l /\ (forall x, In x l -> x <= max_elem).
    """
    # In max_elem l
    is_in_list = max_elem in l
    
    # forall x, In x l -> x <= max_elem
    is_maximal = all(x <= max_elem for x in l)
    
    return is_in_list and is_maximal
