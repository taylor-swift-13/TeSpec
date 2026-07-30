int classify_switch(int n)
{
    if (n < 0) {
        return -30;
    }
    if (n == 0) {
        return 10;
    }
    if (n == 1) {
        return 20;
    }
    if (n < 10) {
        return 40;
    }
    return 30;
}
