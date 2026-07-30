typedef struct {
    int *data;
    int size;
} IntArray;

IntArray *malloc_int_array_struct(void);
int *malloc_int_array(int size);
void free_int_array(int *array, int size);

int abs_int(int x)
{
    if (x < 0) {
        return -x;
    }
    return x;
}

IntArray *p116_sort_array(int *arr, int arr_size)
{
    IntArray *out = malloc_int_array_struct();
    int *bin = 0;
    int m = 0;

    out->size = arr_size;
    out->data = malloc_int_array(arr_size);
    int *data = out->data;
    if (data == 0) {
        out->size = 0;
        return out;
    }

    int i;
    for (i = 0; i < arr_size; i++) {
        data[i] = arr[i];
    }

    bin = malloc_int_array(arr_size);
    if (bin == 0) {
        free_int_array(data, arr_size);
        out->data = 0;
        out->size = 0;
        return out;
    }

    for (i = 0; i < arr_size; i++) {
        int b = 0;
        int n = out->data[i];
        n = abs_int(n);
        while (n > 0) {
            b += n % 2;
            n = n / 2;
        }
        bin[i] = b;
    }

    for (i = 0; i < arr_size; i++) {
        int j;
        for (j = 1; j < arr_size; j++) {
            if (bin[j] < bin[j - 1] ||
                (bin[j] == bin[j - 1] && data[j] < data[j - 1])) {
                m = out->data[j];
                out->data[j] = out->data[j - 1];
                out->data[j - 1] = m;
                m = bin[j];
                bin[j] = bin[j - 1];
                bin[j - 1] = m;
            }
        }
    }

    free_int_array(bin, arr_size);
    return out;
}
