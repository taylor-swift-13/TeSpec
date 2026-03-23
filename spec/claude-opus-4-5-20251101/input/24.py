def largest_divisor_spec(n, result):
    # The Coq spec is a conjunction of two implications:
    # (n <= 1 -> result = 1) /\ (n > 1 -> ...)
    
    def check_n_le_1():
        if n <= 1:
            return result == 1
        return True

    def check_n_gt_1():
        if n > 1:
            # result >= 1 /\ result < n /\ (n mod result = 0)
            if not (result >= 1):
                return False
            if not (result < n):
                return False
            if n % result != 0:
                return False
            
            # (forall d : Z, d > result -> d < n -> n mod d <> 0 \/ d * (n / d) <> n / (n / d))
            # We check all integers d such that result < d < n.
            for d in range(result + 1, n):
                disjunct1 = (n % d != 0)
                
                # Coq's Z division corresponds to integer division (//) for positive numbers.
                # Since d >= 2 and n > d, n // d >= 1, so division by zero is impossible.
                disjunct2 = (d * (n // d) != n // (n // d))
                
                if not (disjunct1 or disjunct2):
                    return False
            return True
        return True

    # Both implications must hold simultaneously
    return check_n_le_1() and check_n_gt_1()
