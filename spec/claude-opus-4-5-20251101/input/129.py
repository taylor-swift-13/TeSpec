def is_valid_grid(grid, N):
    if N < 2:
        return False
    if len(grid) != N:
        return False
    for row in grid:
        if not isinstance(row, list) or len(row) != N:
            return False

    elements = set()
    for i in range(N):
        for j in range(N):
            elements.add(get_cell(grid, i, j))

    for v in range(1, int(N * N) + 1):
        if v not in elements:
            return False
    return True

def get_cell(grid, i, j):
    i_nat = max(0, int(i))
    j_nat = max(0, int(j))
    if i_nat < len(grid):
        row = grid[i_nat]
    else:
        row = []
    if j_nat < len(row):
        return row[j_nat]
    else:
        return 0

def is_neighbor(N, i1, j1, i2, j2):
    if not (0 <= i1 < N and 0 <= j1 < N and 0 <= i2 < N and 0 <= j2 < N):
        return False
    if i1 == i2 and (j2 == j1 + 1 or j2 == j1 - 1):
        return True
    if j1 == j2 and (i2 == i1 + 1 or i2 == i1 - 1):
        return True
    return False

def find_one_pos(grid, N, x, y):
    return 0 <= x < N and 0 <= y < N and get_cell(grid, x, y) == 1

def min_neighbor_value(grid, N, x, y, mn):
    neighbors = []
    for i, j in [(x-1, y), (x+1, y), (x, y-1), (x, y+1)]:
        if is_neighbor(N, x, y, i, j):
            neighbors.append(get_cell(grid, i, j))
    if not neighbors:
        return False
    return min(neighbors) == mn

def minPath_spec(grid, k, result):
    N = len(grid)
    if not is_valid_grid(grid, N):
        return True
    if k < 1:
        return True

    if len(result) != k:
        return False

    for x in range(N):
        for y in range(N):
            if find_one_pos(grid, N, x, y):
                neighbors = []
                for i, j in [(x-1, y), (x+1, y), (x, y-1), (x, y+1)]:
                    if is_neighbor(N, x, y, i, j):
                        neighbors.append(get_cell(grid, i, j))

                if not neighbors:
                    continue

                mn = min(neighbors)

                match = True
                for idx in range(int(k)):
                    expected = 1 if idx % 2 == 0 else mn
                    if result[idx] != expected:
                        match = False
                        break

                if match:
                    return True

    return False
