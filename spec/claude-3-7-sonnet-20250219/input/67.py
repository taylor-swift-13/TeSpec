def fruit_distribution_spec(s, n, mangoes):
    # The Coq specification defines the property as the existence of 
    # non-negative integers c1 and c2 such that mangoes = n - c1 - c2 
    # and n - c1 - c2 >= 0.
    # 1. mangoes = n - c1 - c2 and n - c1 - c2 >= 0 implies mangoes >= 0.
    # 2. c1 >= 0 and c2 >= 0 implies c1 + c2 >= 0.
    # 3. Since c1 + c2 = n - mangoes, then n - mangoes >= 0, so n >= mangoes.
    # Thus, the existence of such c1 and c2 is equivalent to 0 <= mangoes <= n.
    # The string s is not formally constrained in the provided Coq Prop.
    return 0 <= mangoes <= n
