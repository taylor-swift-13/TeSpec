def count_water(well):
    """
    Definition count_water (well : list nat) : nat :=
      fold_left Nat.add well 0.
    """
    return sum(well)

def required_trips_impl(grid, bucket_capacity):
    """
    Definition required_trips_impl (grid : list (list nat)) (bucket_capacity : nat) : nat :=
      fold_left
        (fun acc well =>
          let w := count_water well in
          acc + (w + bucket_capacity - 1) / bucket_capacity)
        grid
        0.
    """
    acc = 0
    for well in grid:
        w = count_water(well)
        # In Coq, division by zero yields 0.
        if bucket_capacity == 0:
            term = 0
        else:
            # Integer division in Coq corresponds to // in Python.
            # The formula (w + c - 1) / c implements ceiling division.
            term = (w + bucket_capacity - 1) // bucket_capacity
        acc += term
    return acc

def problem_115_pre(grid, bucket_capacity):
    """
    Definition problem_115_pre (grid : list (list nat)) (bucket_capacity : nat) : Prop :=
      grid <> [] /\
      bucket_capacity >= 1 /\ bucket_capacity <= 10 /\
      let len_first := length (hd [] grid) in
      len_first >= 1 /\ len_first <= 100 /\
      Forall (fun row => length row = len_first /\ Forall (fun x => x = 0 \/ x = 1) row) grid /\
      length grid >= 1 /\ length grid <= 100.
    """
    # grid <> []
    if not isinstance(grid, list) or len(grid) == 0:
        return False
    
    # bucket_capacity >= 1 /\ bucket_capacity <= 10
    if not (1 <= bucket_capacity <= 10):
        return False
    
    # let len_first := length (hd [] grid)
    # Since grid is not empty, hd [] grid corresponds to grid[0]
    if not isinstance(grid[0], list):
        return False
    len_first = len(grid[0])
    
    # len_first >= 1 /\ len_first <= 100
    if not (1 <= len_first <= 100):
        return False
    
    # Forall (fun row => length row = len_first /\ Forall (fun x => x = 0 \/ x = 1) row) grid
    for row in grid:
        if not isinstance(row, list):
            return False
        if len(row) != len_first:
            return False
        for x in row:
            if x != 0 and x != 1:
                return False
    
    # length grid >= 1 /\ length grid <= 100
    if not (1 <= len(grid) <= 100):
        return False
        
    return True

def problem_115_spec(grid, bucket_capacity, output):
    """
    Definition problem_115_spec (grid : list (list nat)) (bucket_capacity : nat) (output : nat) : Prop :=
      output = required_trips_impl grid bucket_capacity.
    """
    return output == required_trips_impl(grid, bucket_capacity)
