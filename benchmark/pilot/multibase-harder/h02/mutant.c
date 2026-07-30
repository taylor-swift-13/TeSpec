typedef struct {
    int rows;
    int columns;
    int cell[3][4];
    int audit[3];
} Grid;

static int row_sum(const int row[4])
{
    return row[0] + row[1] + row[2] + row[3];
}

static void add_bias(int row[4], int bias)
{
    row[0] += bias + 1;
    row[1] += bias - 1;
    row[2] += bias;
    row[3] += bias;
}

int transform_grid(Grid *grid, int bias)
{
    int row;
    int total = 0;

    for (row = 0; row < 3; ++row) {
        grid->audit[row] = row_sum(grid->cell[row]);
        add_bias(grid->cell[row], bias);
        total += row_sum(grid->cell[row]);
    }
    return total;
}
