def get_grid_val(grid, r, c):
    r_nat = max(0, int(r))
    c_nat = max(0, int(c))
    if r_nat < len(grid):
        row = grid[r_nat]
        if c_nat < len(row):
            return row[c_nat]
    return None

def in_bounds(N, r, c):
    return 0 <= r < N and 0 <= c < N

def is_adjacent(r1, c1, r2, c2):
    return abs(r1 - r2) + abs(c1 - c2) == 1

def valid_path_coords(N, coords):
    if not coords:
        return False
    for r, c in coords:
        if not in_bounds(N, r, c):
            return False
    if len(coords) == 1:
        return True
    for i in range(len(coords) - 1):
        r1, c1 = coords[i]
        r2, c2 = coords[i+1]
        if not is_adjacent(r1, c1, r2, c2):
            return False
    return True

def map_coords_to_values(grid, coords):
    res = []
    for r, c in coords:
        val = get_grid_val(grid, r, c)
        if val is None:
            break
        res.append(val)
    return res

def lex_le(l1, l2):
    return l1 <= l2

def _orig_minPath_spec(grid, k, output):
    N = len(grid)
    k = int(k)
    if not N >= 2:
        return False
    if not k > 0:
        return False
    for row in grid:
        if len(row) != N:
            return False
    all_vals = [val for row in grid for val in row]
    if sorted(all_vals) != list(range(1, N * N + 1)):
        return False
    if len(output) != k:
        return False
    active_paths = []
    for r in range(N):
        for c in range(N):
            active_paths.append(([grid[r][c]], r, c))
    min_path_val = min(active_paths, key=lambda x: x[0])[0]
    active_paths = [p for p in active_paths if p[0] == min_path_val]
    for _ in range(k - 1):
        next_paths = []
        for (path, r, c) in active_paths:
            for (dr, dc) in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                (nr, nc) = (r + dr, c + dc)
                if 0 <= nr < N and 0 <= nc < N:
                    next_paths.append((path + [grid[nr][nc]], nr, nc))
        if not next_paths:
            break
        min_path_val = min(next_paths, key=lambda x: x[0])[0]
        active_paths = [p for p in next_paths if p[0] == min_path_val]
        unique_active = {}
        for p in active_paths:
            pos = (p[1], p[2])
            if pos not in unique_active:
                unique_active[pos] = p
        active_paths = list(unique_active.values())
    if not active_paths:
        return False
    best_path = active_paths[0][0]
    return output == best_path

def minPath_spec(grid, k, output):
    return bool(_orig_minPath_spec(grid, k, output))
