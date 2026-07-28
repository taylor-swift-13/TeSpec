typedef struct FloatRecord {
    float value;
} FloatRecord;

/*@ Extern Coq (store_float : Z -> fp32 -> Assertion) */

void write_struct_float(FloatRecord *record, float x)
/*@ Require undef_data_at(&(record->value))
    Ensure  store_float(&(record->value), x)
*/
{
    record->value = x;
}
