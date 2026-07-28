#include "IP_StructFilter.h"

float64 StructFilter(float64 *X, STRUCT_FILTER *filter, float64 *PIDPara,
                     float64 Ang, float64 dAng)
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
