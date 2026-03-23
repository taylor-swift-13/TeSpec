def sum_list(l):
    """
    Definition sum_list (l : list Z) : Z :=
      fold_right Z.add 0 l.
    """
    return sum(l)

def will_it_fly_spec(q, w, res):
    """
    Definition will_it_fly_spec (q : list Z) (w : Z) (res : bool) : Prop :=
      res = true <-> (q = rev q /\ sum_list q <= w).
    """
    # Check if q is a palindrome (q = rev q)
    # In Python, q[::-1] creates a reversed copy of the list
    is_palindrome = (q == q[::-1])
    
    # Check if the sum of elements in q is less than or equal to w
    is_light_enough = (sum_list(q) <= w)
    
    # The specification requires res to be equivalent (<->) to the conjunction
    # of the palindrome check and the weight check.
    return res == (is_palindrome and is_light_enough)
