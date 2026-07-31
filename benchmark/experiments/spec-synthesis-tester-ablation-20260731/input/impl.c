/*
 * Public QCP-front-end implementation adapted from QCIP
 * INPUT/iplib/ModeConvert_AMM. The task model receives this implementation
 * without the reference specification.
 */

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

void ModeConvert_AMMFun(void *p)
{
    ModeConvert_AMM *pIp = (ModeConvert_AMM*)p;

    if((pIp->m_starTime - pIp->csOrb19_Para_I_t0) >= pIp->csModePara_dt_OrbitInject)
    {
        pIp->m_WorkMode = 0x01u;
    }

    if ((pIp->m_starTime > pIp->tm3 + pIp->LmtT_ModeSwitch_AMM) &&
        ( (pIp->csMnvData_F_MnvNextMode == 2)))
    {
        pIp->m_WorkMode = 0x05u;
    }

    if ((pIp->m_starTime > pIp->tm3 + pIp->LmtT_ModeSwitch_AMM) &&
        ( (pIp->csMnvData_F_MnvNextMode == 1)))
    {
        pIp->m_WorkMode = 0x02u;
    }

    return;
}
