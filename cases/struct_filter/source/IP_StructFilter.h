#ifndef IP_STRUCTFILTER_H
#define IP_STRUCTFILTER_H

#include <stdio.h> // 示例: 添加通用头文件

#include "common.h"

/* --- 类型定义 --- */
typedef unsigned int        unint32;
typedef double              float64;
typedef long long           llong64;
typedef unsigned long long  ulong64;
typedef struct TAG_GNC_TIME
{
	llong64 tLong;                      /* 有符号长整型星时 us */
	llong64 tLongMs;                    /* 有符号长整型星时 ms */
	float64 tDbl;                       /* 双精度浮点星时   s */
//	unint32 tU32;                       /* 校时广播整秒 */

	ulong64 newCycle;                   /* 当前读到(或系统软件)的控制周期时钟计数器 无符号  */
	ulong64 oldCycle;                   /* 上周期保存的时钟计数器数 无符号  */

	unint32 ErrCnt;                     /* 星时计数器错误计数 */

	float64 prd;                        /* 控制周期 */

	unint32 cycle;                      /* 控制周期节拍 */

	unint32 reset;                      /* 上电第一拍 */

}GNC_TIME;
typedef struct TAG_STRUCT_FILTER
{
    float64 A11;                                  /* 01 A11 */
    float64 H1;                                   /* 02 H1  */
    float64 D1;                                   /* 03 D1  */
    float64 A32;                                  /* 04 A32 */
    float64 A33;                                  /* 05 A33 */
    float64 H2;                                   /* 06 H2  */
    float64 H3;                                   /* 07 H3  */
    float64 D2;                                   /* 08 D2  */
    float64 A54;                                  /* 09 A54 */
    float64 A55;                                  /* 10 A55 */
    float64 H4;                                   /* 11 H4  */
    float64 H5;                                   /* 12 H5  */
    float64 D3;                                   /* 13 D3  */
    float64 A76;                                  /* 14 A76 */
    float64 A77;                                  /* 15 A77 */
    float64 H6;                                   /* 16 H6  */
    float64 H7;                                   /* 17 H7  */
    float64 D4;                                   /* 18 D4  */
}STRUCT_FILTER;

/* --- 全局变量定义 --- */
GNC_TIME sTime;

/* --- 函数原型 --- */
float64 StructFilter( float64 * X, STRUCT_FILTER * filter, float64 * PIDPara, float64 Ang, float64 dAng );

#endif // IP_STRUCTFILTER_H