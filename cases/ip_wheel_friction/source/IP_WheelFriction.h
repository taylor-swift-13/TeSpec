#ifndef IP_WHEELFRICTION_H
#define IP_WHEELFRICTION_H

typedef unsigned int unint32;

#define FALSE32 0x00000000u
#define TRUE32  0xEB90146Fu

/* 精简结构体：只保留 WheelFriction 实际访问的字段 */
/* float64 全部替换为 unint32，指针解引用展平 */

typedef struct TAG_MW_DATA {
    unint32 F_Valid_MW[4];   /* 动量轮数据有效标志 */
    unint32 vf[4];            /* 摩擦力矩补偿电压（原 float64） */
} MW_DATA;

typedef struct TAG_MW_CTRL {
    unint32 kf[4];            /* 摩擦系数（原 float64） */
    unint32 cut[4];           /* 控制电压力矩系数（原 float64） */
    unint32 vf0[4];           /* 摩擦力矩对应补偿电压（原 float64） */
} MW_CTRL;

/* 全局变量 */
MW_DATA sMWData;
MW_CTRL sMWCtrl;

void WheelFriction(void);

#endif
