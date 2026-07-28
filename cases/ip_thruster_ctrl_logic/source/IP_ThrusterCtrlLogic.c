/* ============================================================
 * ThrusterCtrlLogic 的 QCP 验证用 C 源码
 *
 * 功能：根据 Yp[0..2]、Yn[0..2] 六个标志计算 12 路推力器脉冲。
 *       先把 wPulse[0..11] 清零，再按位成对置 1。
 *
 * 为避开 QCP parser 对头文件宏、函数指针等无关特性的限制，
 * 这里使用自包含的最小等价形态：保留原始类型名和字段名，
 * 但把结构体定义内联，并把入口改为直接接收 ThrusterCtrlLogic*。
 *
 * 注意：wPulse 是结构体内部数组。QCP 的 uint_array 策略要求
 * 数组地址呈现为基地址 + i * sizeof 的形式，因此这里把
 * wPulse[12] 拆成 12 个独立 store 描述，循环也手动展开。
 * ============================================================ */

typedef unsigned int  unint32;
typedef unsigned char unint08;

/*@ Extern Coq (ThrusterCtrlLogicPost : list Z -> list Z -> list Z -> Prop) */
/*@ Import Coq Require Import QCIPLib.SAMCodeSynthesis.ThrusterCtrlLogic.IP_ThrusterCtrlLogic_lib */

typedef struct __ThrusterCtrlLogic
{
    unint08 *Yp;            /* 脉冲方向输出数组指针（正方向），长度 3 */
    unint08 *Yn;            /* 脉冲方向输出数组指针（负方向），长度 3 */
    unint32 wPulse[12];     /* 推力器组合输出 */
} ThrusterCtrlLogic;

void ThrusterCtrlLogicFun(ThrusterCtrlLogic *pIp)
/*@ With (yp_list: list Z) (yn_list: list Z) (old_wPulse: list Z) (yp_addr: Z) (yn_addr: Z)
    Require
      Zlength(yp_list) == 3 &&
      Zlength(yn_list) == 3 &&
      Zlength(old_wPulse) == 12 &&
      store(&(pIp->Yp), yp_addr) *
      store(&(pIp->Yn), yn_addr) *
      UCharArray::full(yp_addr, 3, yp_list) *
      UCharArray::full(yn_addr, 3, yn_list) *
      store(&(pIp->wPulse[0]), Znth(0, old_wPulse, 0)) *
      store(&(pIp->wPulse[1]), Znth(1, old_wPulse, 0)) *
      store(&(pIp->wPulse[2]), Znth(2, old_wPulse, 0)) *
      store(&(pIp->wPulse[3]), Znth(3, old_wPulse, 0)) *
      store(&(pIp->wPulse[4]), Znth(4, old_wPulse, 0)) *
      store(&(pIp->wPulse[5]), Znth(5, old_wPulse, 0)) *
      store(&(pIp->wPulse[6]), Znth(6, old_wPulse, 0)) *
      store(&(pIp->wPulse[7]), Znth(7, old_wPulse, 0)) *
      store(&(pIp->wPulse[8]), Znth(8, old_wPulse, 0)) *
      store(&(pIp->wPulse[9]), Znth(9, old_wPulse, 0)) *
      store(&(pIp->wPulse[10]), Znth(10, old_wPulse, 0)) *
      store(&(pIp->wPulse[11]), Znth(11, old_wPulse, 0))
    Ensure
      exists new_wPulse,
        Zlength(new_wPulse) == 12 &&
        ThrusterCtrlLogicPost(yp_list, yn_list, new_wPulse) &&
        store(&(pIp->Yp), yp_addr) *
        store(&(pIp->Yn), yn_addr) *
        UCharArray::full(yp_addr, 3, yp_list) *
        UCharArray::full(yn_addr, 3, yn_list) *
        store(&(pIp->wPulse[0]), Znth(0, new_wPulse, 0)) *
        store(&(pIp->wPulse[1]), Znth(1, new_wPulse, 0)) *
        store(&(pIp->wPulse[2]), Znth(2, new_wPulse, 0)) *
        store(&(pIp->wPulse[3]), Znth(3, new_wPulse, 0)) *
        store(&(pIp->wPulse[4]), Znth(4, new_wPulse, 0)) *
        store(&(pIp->wPulse[5]), Znth(5, new_wPulse, 0)) *
        store(&(pIp->wPulse[6]), Znth(6, new_wPulse, 0)) *
        store(&(pIp->wPulse[7]), Znth(7, new_wPulse, 0)) *
        store(&(pIp->wPulse[8]), Znth(8, new_wPulse, 0)) *
        store(&(pIp->wPulse[9]), Znth(9, new_wPulse, 0)) *
        store(&(pIp->wPulse[10]), Znth(10, new_wPulse, 0)) *
        store(&(pIp->wPulse[11]), Znth(11, new_wPulse, 0))
*/
{
    pIp->wPulse[0] = 0;
    pIp->wPulse[1] = 0;
    pIp->wPulse[2] = 0;
    pIp->wPulse[3] = 0;
    pIp->wPulse[4] = 0;
    pIp->wPulse[5] = 0;
    pIp->wPulse[6] = 0;
    pIp->wPulse[7] = 0;
    pIp->wPulse[8] = 0;
    pIp->wPulse[9] = 0;
    pIp->wPulse[10] = 0;
    pIp->wPulse[11] = 0;

    if (pIp->Yp[0] != 0)
    {
        pIp->wPulse[0] = 1;
        pIp->wPulse[1] = 1;
    }

    if (pIp->Yn[0] != 0)
    {
        pIp->wPulse[2] = 1;
        pIp->wPulse[3] = 1;
    }

    if (pIp->Yp[1] != 0)
    {
        pIp->wPulse[4] = 1;
        pIp->wPulse[5] = 1;
    }

    if (pIp->Yn[1] != 0)
    {
        pIp->wPulse[6] = 1;
        pIp->wPulse[7] = 1;
    }

    if (pIp->Yp[2] != 0)
    {
        pIp->wPulse[8] = 1;
        pIp->wPulse[9] = 1;
    }

    if (pIp->Yn[2] != 0)
    {
        pIp->wPulse[10] = 1;
        pIp->wPulse[11] = 1;
    }

    return;
}
