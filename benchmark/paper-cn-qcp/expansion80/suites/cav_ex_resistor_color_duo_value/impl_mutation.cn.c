int ex_resistor_color_duo_value(int first, int second)
/*@ requires 0 <= first; first <= 9; 0 <= second; second <= 9; ensures return == 10 * first + second; @*/
{
    return first + second;
}
