/* BSD flsl ABI required by the frozen C input; the Linux libc lacks it.
   This matches the portability helper used by native-adapter.c. */
long flsl(long x)
{
    unsigned long bits = (unsigned long)x;
    long position = 0;
    while (bits) { ++position; bits >>= 1; }
    return position;
}
