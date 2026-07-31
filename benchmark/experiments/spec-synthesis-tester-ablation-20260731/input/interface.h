typedef unsigned int unint32;
typedef long long float64;
typedef long long Fun;

typedef struct __ModeConvert_AMM
{
    Fun fun;
    float64 m_starTime;
    float64 tm3;
    unint32 csMnvData_F_MnvNextMode;
    unint32 m_WorkMode;
    float64 csOrb19_Para_I_t0;
    float64 csModePara_dt_OrbitInject;
    float64 LmtT_ModeSwitch_AMM;
} ModeConvert_AMM;

void ModeConvert_AMMFun(void *p);
