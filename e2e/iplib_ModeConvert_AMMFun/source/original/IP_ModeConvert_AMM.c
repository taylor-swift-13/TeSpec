#include "IP_ModeConvert_AMM.h"

void ModeConvert_AMMFun(void *p)
{
    ModeConvert_AMM *pIp = (ModeConvert_AMM*)p;

    if((pIp->m_starTime - pIp->csOrb19_Para_I_t0) >= pIp->csModePara_dt_OrbitInject)
    /* if (m_starTime >= csModePara.dt_OrbitInject) */
    {
        pIp->m_WorkMode = 0x01u;
    }

    // /* 机动进偏置飞行 */
    if ((pIp->m_starTime > pIp->tm3 + pIp->LmtT_ModeSwitch_AMM) &&
        ( (pIp->csMnvData_F_MnvNextMode == 2)))
    {
        pIp->m_WorkMode = 0x05u;
    }
    // /* 机动回正常对地 */
    if ((pIp->m_starTime > pIp->tm3 + pIp->LmtT_ModeSwitch_AMM) &&
        ( (pIp->csMnvData_F_MnvNextMode == 1)))
    {
        pIp->m_WorkMode = 0x02u;
    }

    return;
}