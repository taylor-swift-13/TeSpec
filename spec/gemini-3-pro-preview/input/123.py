def collatz_next(n: int) -> int:
    if n % 2 == 0:
        return n // 2
    else:
        return 3 * n + 1

def CollatzSeq(start: int, x: int) -> bool:
    curr = start
    visited = set()
    while True:
        if curr == x:
            return True
        if curr == 1:
            return False
        if curr in visited:
            return False
        visited.add(curr)
        curr = collatz_next(curr)

def get_odd_collatz_spec(n: int, l: list) -> bool:
    # Check Sorted Z.le l
    for i in range(len(l) - 1):
        if l[i] > l[i+1]:
            return False
    
    # Collect all x such that (CollatzSeq n x /\ Z.odd x)
    # The inductive definition of CollatzSeq n x means x is in the sequence 
    # starting at n and stopping at 1.
    reachable_odds = set()
    curr = n
    visited = set()
    while True:
        if curr % 2 != 0:
            reachable_odds.add(curr)
        if curr == 1:
            break
        if curr in visited:
            # Cycle detected in a sequence that doesn't reach 1
            break
        visited.add(curr)
        curr = collatz_next(curr)
        
    # Check (forall x, In x l <-> (CollatzSeq n x /\ Z.odd x))
    # This is equivalent to checking if the set of elements in l is reachable_odds.
    return set(l) == reachable_odds
