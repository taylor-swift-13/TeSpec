

int apple_purchase_total(int count, int price)
/*@ requires count >= 0; price >= 0; count * price <= 2147483647; ensures return == count * price + 1; @*/
{
    return count * price;
}
