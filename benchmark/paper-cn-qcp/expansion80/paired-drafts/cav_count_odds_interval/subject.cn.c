int count_odds_interval(int low, int high)
/*@ requires 0 <= low; low <= high; ensures ((rem(low, 2) != 0 || rem(high, 2) != 0) || return == (high - low) / 2) && ((rem(low, 2) == 0 && rem(high, 2) == 0) || return == (high - low) / 2 + 1); @*/
{
    if (low % 2 == 0 && high % 2 == 0) {
        return (high - low) / 2;
    }

    return (high - low) / 2 + 1;
}
