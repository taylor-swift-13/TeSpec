
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

(* Helper function to access grid values safely *)
Definition get_grid_val (grid : list (list Z)) (r c : Z) : option Z :=
  match nth_error grid (Z.to_nat r) with
  | Some row => nth_error row (Z.to_nat c)
  | None => None
  end.

(* Predicate for valid grid bounds *)
Definition in_bounds (N : Z) (r c : Z) : Prop :=
  0 <= r < N /\ 0 <= c < N.

(* Predicate for grid adjacency (Manhattan distance of 1) *)
Definition is_adjacent (r1 c1 r2 c2 : Z) : Prop :=
  Z.abs (r1 - r2) + Z.abs (c1 - c2) = 1.

(* Inductive predicate to define a valid path of coordinates in the grid *)
Inductive valid_path_coords (N : Z) : list (Z * Z) -> Prop :=
| vp_start : forall r c, 
    in_bounds N r c -> 
    valid_path_coords N [(r, c)]
| vp_step : forall r1 c1 r2 c2 rest,
    in_bounds N r1 c1 ->
    is_adjacent r1 c1 r2 c2 ->
    valid_path_coords N ((r2, c2) :: rest) ->
    valid_path_coords N ((r1, c1) :: (r2, c2) :: rest).

(* Function to map a list of coordinates to their values in the grid *)
Fixpoint map_coords_to_values (grid : list (list Z)) (coords : list (Z * Z)) : list Z :=
  match coords with
  | [] => []
  | (r, c) :: rest =>
      match get_grid_val grid r c with
      | Some v => v :: map_coords_to_values grid rest
      | None => [] (* Should not happen for valid paths *)
      end
  end.

(* Inductive predicate for lexicographical less-than-or-equal comparison *)
Inductive lex_le : list Z -> list Z -> Prop :=
| lex_nil : forall l, lex_le [] l
| lex_cons_lt : forall x y xs ys, 
    x < y -> 
    lex_le (x :: xs) (y :: ys)
| lex_cons_eq : forall x xs ys, 
    lex_le xs ys -> 
    lex_le (x :: xs) (x :: ys).

(* Main Specification *)
Definition minPath_spec (grid : list (list Z)) (k : Z) (result : list Z) : Prop :=
  let N := Z.of_nat (length grid) in
  (* Preconditions *)
  N >= 2 /\
  k > 0 /\
  (forall row, In row grid -> length row = Z.to_nat N) /\
  (* Every integer in [1, N*N] appears exactly once (implied permutation property) *)
  (forall z, 1 <= z <= N * N -> 
     exists r c, in_bounds N r c /\ get_grid_val grid r c = Some z) /\
  
  (* Postconditions *)
  length result = Z.to_nat k /\
  
  (* 1. The result corresponds to a valid path in the grid *)
  (exists coords, 
     length coords = Z.to_nat k /\
     valid_path_coords N coords /\
     map_coords_to_values grid coords = result) /\
     
  (* 2. The result is lexicographically minimal among all valid paths of length k *)
  (forall other_coords other_vals,
     length other_coords = Z.to_nat k ->
     valid_path_coords N other_coords ->
     map_coords_to_values grid other_coords = other_vals ->
     lex_le result other_vals).
