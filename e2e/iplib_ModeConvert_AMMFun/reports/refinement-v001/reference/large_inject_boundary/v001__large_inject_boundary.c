/*
 * QCP-front-end copy of QCIP/INPUT/iplib/ModeConvert_AMM.
 * The source program's float64 cells are represented as signed 64-bit
 * mathematical integers, matching the existing StructFilter adapter.
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
/*@ With (star_time: Z)
         (tm3: Z)
         (next_mode: Z)
         (old_mode: Z)
         (orbit_t0: Z)
         (orbit_inject_delay: Z)
         (switch_delay: Z)
    Require
      (p == (86016)) && (next_mode == (0)) && (old_mode == (18)) && (orbit_inject_delay == (100000)) && (orbit_t0 == (900000)) && (star_time == (1000000)) && (switch_delay == (0)) && (tm3 == (2000000)) &&
      p != 0 &&
      store(&(((ModeConvert_AMM *)p)->m_starTime), star_time) *
      store(&(((ModeConvert_AMM *)p)->tm3), tm3) *
      store(&(((ModeConvert_AMM *)p)->csMnvData_F_MnvNextMode), next_mode) *
      store(&(((ModeConvert_AMM *)p)->m_WorkMode), old_mode) *
      store(&(((ModeConvert_AMM *)p)->csOrb19_Para_I_t0), orbit_t0) *
      store(&(((ModeConvert_AMM *)p)->csModePara_dt_OrbitInject), orbit_inject_delay) *
      store(&(((ModeConvert_AMM *)p)->LmtT_ModeSwitch_AMM), switch_delay)
    Ensure
      exists (new_mode: Z),
        store(&(((ModeConvert_AMM *)p@pre)->m_starTime), star_time) *
        store(&(((ModeConvert_AMM *)p@pre)->tm3), tm3) *
        store(&(((ModeConvert_AMM *)p@pre)->csMnvData_F_MnvNextMode), next_mode) *
        store(&(((ModeConvert_AMM *)p@pre)->m_WorkMode), new_mode) *
        store(&(((ModeConvert_AMM *)p@pre)->csOrb19_Para_I_t0), orbit_t0) *
        store(&(((ModeConvert_AMM *)p@pre)->csModePara_dt_OrbitInject), orbit_inject_delay) *
        store(&(((ModeConvert_AMM *)p@pre)->LmtT_ModeSwitch_AMM), switch_delay) &&
        (star_time > tm3 + switch_delay && next_mode == 1 => new_mode == 2) &&
        (star_time > tm3 + switch_delay && next_mode == 2 => new_mode == 5) &&
        (!(star_time > tm3 + switch_delay && next_mode == 1) &&
         !(star_time > tm3 + switch_delay && next_mode == 2) &&
         star_time - orbit_t0 >= orbit_inject_delay => new_mode == 1) &&
        (!(star_time > tm3 + switch_delay && next_mode == 1) &&
         !(star_time > tm3 + switch_delay && next_mode == 2) &&
         !(star_time - orbit_t0 >= orbit_inject_delay) => new_mode == old_mode)
*/
{
    ModeConvert_AMM *pIp = (ModeConvert_AMM*)p;

    if((pIp->m_starTime - pIp->csOrb19_Para_I_t0) >= pIp->csModePara_dt_OrbitInject)
    /* if (m_starTime >= csModePara.dt_OrbitInject) */
    {
        pIp->m_WorkMode = 0x01u;
    }

    // /* ������ƫ�÷��� */
    if ((pIp->m_starTime > pIp->tm3 + pIp->LmtT_ModeSwitch_AMM) &&
        ( (pIp->csMnvData_F_MnvNextMode == 2)))
    {
        pIp->m_WorkMode = 0x05u;
    }
    // /* �����������Ե� */
    if ((pIp->m_starTime > pIp->tm3 + pIp->LmtT_ModeSwitch_AMM) &&
        ( (pIp->csMnvData_F_MnvNextMode == 1)))
    {
        pIp->m_WorkMode = 0x02u;
    }

    return;
}
