/* QCP-front-end preprocessed source: typedefs, structs and globals inlined
   so that the QCP parser does not have to process header guards/macros.
   float64 is adapted to long long for the QCP store layer (64-bit opaque
   cells interpreted as mathematical integers in the spec). */

typedef unsigned int        unint32;
typedef long long           float64;
typedef long long           llong64;
typedef unsigned long long  ulong64;

typedef struct TAG_GNC_TIME
{
    llong64 tLong;
    llong64 tLongMs;
    float64 tDbl;
    ulong64 newCycle;
    ulong64 oldCycle;
    unint32 ErrCnt;
    float64 prd;
    unint32 cycle;
    unint32 reset;
} GNC_TIME;

typedef struct TAG_STRUCT_FILTER
{
    float64 A11;
    float64 H1;
    float64 D1;
    float64 A32;
    float64 A33;
    float64 H2;
    float64 H3;
    float64 D2;
    float64 A54;
    float64 A55;
    float64 H4;
    float64 H5;
    float64 D3;
    float64 A76;
    float64 A77;
    float64 H6;
    float64 H7;
    float64 D4;
} STRUCT_FILTER;

GNC_TIME sTime;

float64 StructFilter( float64 * X, STRUCT_FILTER * filter, float64 * PIDPara, float64 Ang, float64 dAng );

// =======================================================
// 函数实现
// =======================================================

/*@ Import Coq Require Import QCIPLib.IP.StructFilter.IP_StructFilter_lib */
/*@ Extern Coq (StructFilterInputsBounded : list Z -> list Z -> list Z -> Z -> Z -> Z -> Prop)
*/
/*@ Extern Coq (StructFilterPost : list Z -> list Z -> list Z -> Z -> Z -> Z -> list Z -> Z -> Prop)
*/

float64 StructFilter( float64 * X, STRUCT_FILTER * filter, float64 * PIDPara, float64 Ang, float64 dAng )
/*@ With (old_X: list Z)
         (filter_coeffs: list Z)
         (old_PIDPara: list Z)
         (prd: Z)
    Require
      Zlength(old_X) == 8 &&
      Zlength(filter_coeffs) == 18 &&
      Zlength(old_PIDPara) == 3 &&
      StructFilterInputsBounded(old_X, filter_coeffs, old_PIDPara, Ang, dAng, prd) &&
      store(&(X[0]), Znth(0, old_X, 0)) *
      store(&(X[1]), Znth(1, old_X, 0)) *
      store(&(X[2]), Znth(2, old_X, 0)) *
      store(&(X[3]), Znth(3, old_X, 0)) *
      store(&(X[4]), Znth(4, old_X, 0)) *
      store(&(X[5]), Znth(5, old_X, 0)) *
      store(&(X[6]), Znth(6, old_X, 0)) *
      store(&(X[7]), Znth(7, old_X, 0)) *
      store(&(filter->A11), Znth(0, filter_coeffs, 0)) *
      store(&(filter->H1), Znth(1, filter_coeffs, 0)) *
      store(&(filter->D1), Znth(2, filter_coeffs, 0)) *
      store(&(filter->A32), Znth(3, filter_coeffs, 0)) *
      store(&(filter->A33), Znth(4, filter_coeffs, 0)) *
      store(&(filter->H2), Znth(5, filter_coeffs, 0)) *
      store(&(filter->H3), Znth(6, filter_coeffs, 0)) *
      store(&(filter->D2), Znth(7, filter_coeffs, 0)) *
      store(&(filter->A54), Znth(8, filter_coeffs, 0)) *
      store(&(filter->A55), Znth(9, filter_coeffs, 0)) *
      store(&(filter->H4), Znth(10, filter_coeffs, 0)) *
      store(&(filter->H5), Znth(11, filter_coeffs, 0)) *
      store(&(filter->D3), Znth(12, filter_coeffs, 0)) *
      store(&(filter->A76), Znth(13, filter_coeffs, 0)) *
      store(&(filter->A77), Znth(14, filter_coeffs, 0)) *
      store(&(filter->H6), Znth(15, filter_coeffs, 0)) *
      store(&(filter->H7), Znth(16, filter_coeffs, 0)) *
      store(&(filter->D4), Znth(17, filter_coeffs, 0)) *
      store(&(PIDPara[0]), Znth(0, old_PIDPara, 0)) *
      store(&(PIDPara[1]), Znth(1, old_PIDPara, 0)) *
      store(&(PIDPara[2]), Znth(2, old_PIDPara, 0)) *
      store(&(sTime.prd), prd)
    Ensure
      exists (new_X: list Z) (ret: Z),
        Zlength(new_X) == 8 &&
        __return == ret &&
        store(&(X[0]), Znth(0, new_X, 0)) *
        store(&(X[1]), Znth(1, new_X, 0)) *
        store(&(X[2]), Znth(2, new_X, 0)) *
        store(&(X[3]), Znth(3, new_X, 0)) *
        store(&(X[4]), Znth(4, new_X, 0)) *
        store(&(X[5]), Znth(5, new_X, 0)) *
        store(&(X[6]), Znth(6, new_X, 0)) *
        store(&(X[7]), Znth(7, new_X, 0)) *
        store(&(filter->A11), Znth(0, filter_coeffs, 0)) *
        store(&(filter->H1), Znth(1, filter_coeffs, 0)) *
        store(&(filter->D1), Znth(2, filter_coeffs, 0)) *
        store(&(filter->A32), Znth(3, filter_coeffs, 0)) *
        store(&(filter->A33), Znth(4, filter_coeffs, 0)) *
        store(&(filter->H2), Znth(5, filter_coeffs, 0)) *
        store(&(filter->H3), Znth(6, filter_coeffs, 0)) *
        store(&(filter->D2), Znth(7, filter_coeffs, 0)) *
        store(&(filter->A54), Znth(8, filter_coeffs, 0)) *
        store(&(filter->A55), Znth(9, filter_coeffs, 0)) *
        store(&(filter->H4), Znth(10, filter_coeffs, 0)) *
        store(&(filter->H5), Znth(11, filter_coeffs, 0)) *
        store(&(filter->D3), Znth(12, filter_coeffs, 0)) *
        store(&(filter->A76), Znth(13, filter_coeffs, 0)) *
        store(&(filter->A77), Znth(14, filter_coeffs, 0)) *
        store(&(filter->H6), Znth(15, filter_coeffs, 0)) *
        store(&(filter->H7), Znth(16, filter_coeffs, 0)) *
        store(&(filter->D4), Znth(17, filter_coeffs, 0)) *
        store(&(PIDPara[0]), Znth(0, old_PIDPara, 0)) *
        store(&(PIDPara[1]), Znth(1, old_PIDPara, 0)) *
        store(&(PIDPara[2]), Znth(2, old_PIDPara, 0)) *
        store(&(sTime.prd), prd) &&
        StructFilterPost(old_X, filter_coeffs, old_PIDPara, Ang, dAng, prd, new_X, ret)
*/
{
    float64 tmpX2;
    float64 tmpX4;
    float64 tmpX6;
    float64 Kp, Ki, Kd; 
    float64 Y1, Y2, Y3, Y4, U2;

    tmpX2 = X[1];
    tmpX4 = X[3];
    tmpX6 = X[5];

    Kp = PIDPara[0];
    Ki = PIDPara[1];
    Kd = PIDPara[2];

    /* (1) 控制器 */
    X[0] = filter->A11 * X[0] + filter->H1 * Kp * Ang;

    Y1 = X[0] + filter->D1 * Kp * Ang;
    U2 = Y1 + Kd * dAng;
    Y2 = X[1] + filter->D2 * U2;

    X[1] = X[2] + filter->H2 * U2;
    X[2] = filter->A32 * tmpX2 + filter->A33 * X[2] + filter->H3 * U2;

    Y3 = X[3] + filter->D3 * Y2;
    X[3] = X[4] + filter->H4 * Y2;
    X[4] = filter->A54 * tmpX4 + filter->A55 * X[4] + filter->H5 * Y2;

    Y4 = X[5] + filter->D4 * Y3;

    X[5] = X[6] + filter->H6 * Y3;
    X[6] = filter->A76 * tmpX6 + filter->A77 * X[6] + filter->H7 * Y3;

    X[7] = X[7] + sTime.prd * Ki * Ang;

    return Y4;

}
