#ifndef IP_STRUCTFILTER_H
#define IP_STRUCTFILTER_H

typedef unsigned int unint32;
typedef double float64;
typedef long long llong64;
typedef unsigned long long ulong64;

typedef struct TAG_GNC_TIME {
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

typedef struct TAG_STRUCT_FILTER {
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

float64 StructFilter(float64 *X, STRUCT_FILTER *filter, float64 *PIDPara,
                     float64 Ang, float64 dAng);

#endif
