

int leap_year(int year)
/*@ requires 1 <= year; ensures (rem(year, 400) != 0 || return == 1) && ((rem(year, 100) != 0 || rem(year, 400) == 0) || return == 0) && ((rem(year, 4) != 0 || rem(year, 100) == 0) || return == 1) && (rem(year, 4) == 0 || return == 0); @*/
{
    if (year % 400 == 0) {
        return 1;
    }
    if (year % 100 == 0) {
        return 0;
    }
    return year % 4 == 0;
}
