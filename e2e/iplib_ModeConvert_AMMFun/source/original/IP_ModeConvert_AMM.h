#if !defined(__MODECONVERT_AMM_H__)
#define __MODECONVERT_AMM_H__

#include "IP.h"

void ModeConvert_AMMFun(void *p);

/* 模式切换指令处理 */
typedef struct __ModeConvert_AMM
{
    /* 接口函数*/
    Fun     fun;

    /* 输入端口*/
    float64 m_starTime;                          /* 当前星时 t */
    float64 tm3;                   /* 轨迹规划结束点时刻（绝对星时） */

    unint32 csMnvData_F_MnvNextMode;            /* 姿态机动调姿标志 */
    /* 输出端口 */
    unint32 m_WorkMode;                          /* 当前模式 */

    /* 输入输出端口 */

    /* 状态变量 */

    /* 参数变量 */
    float64 csOrb19_Para_I_t0;                   /* 使用的轨道参数的参考时刻 */
    float64 csModePara_dt_OrbitInject;           /* 星箭分离到入轨段计时开始的相对时间 */
    float64 LmtT_ModeSwitch_AMM;                    /* 姿态机动规划结束模式切换延时阈值 */

} ModeConvert_AMM;

#endif // __MODECONVERT_AMM_H__