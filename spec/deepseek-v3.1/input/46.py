def fib4_spec(n: int, result: int) -> bool:
    if n == 0:
        return result == 0
    if n == 1:
        return result == 0
    if n == 2:
        return result == 2
    if n == 3:
        return result == 0

    # In the Coq specification, the variables a, b, c, d are bound by an 
    # existential quantifier OUTSIDE the forall loop. 
    # They are strictly fixed to a=0, b=0, c=2, d=0.
    # Inside the forall loop, the inner variables a', b', c', d' are defined 
    # in terms of the fixed outer variables. 
    # Specifically, d' = a + b + c + d = 0 + 0 + 2 + 0 = 2.
    # Because a, b, c, d are bound outside the loop, they cannot be updated 
    # across iterations. Thus, d' is always 2 for every i.
    # Finally, the condition (i = n -> result = d') forces result to be 2.
    # Therefore, for all n >= 4, the Coq spec evaluates to True iff result == 2.
    
    return result == 2
