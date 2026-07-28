/* ============================================================
 * CheckCal08 的 QCP 验证用 C 源码
 *
 * 功能：计算长度为 len 的无符号 8 位数组 pkv 的 8 位累加和，
 *       结果写回 pIp->chksum。
 *
 * 为避开 QCP parser 对头文件宏、函数指针等无关特性的限制，
 * 这里使用自包含的最小等价形态：保留原始类型名和字段名，
 * 但把结构体定义内联，并把入口改为直接接收 CheckCal08*。
 * ============================================================ */

typedef unsigned int  unint32;
typedef unsigned char unint08;

typedef struct __CheckCal08
{
    unint08 *pkv;       /* 数组首地址指针 */
    unint32 len;        /* 计算长度 */
    unint08 chksum;     /* 计算结果 */
} CheckCal08;

/*@ Extern Coq (CheckCal08Post : list Z -> Z -> Z -> Prop) */
/*@ Extern Coq (CheckCal08Inv  : list Z -> Z -> Z -> Z -> Prop) */
/*@ Import Coq Require Import QCIPLib.SAMCodeSynthesis.CheckCal08.IP_CheckCal08_lib */

void CheckCal08Fun(CheckCal08 *pIp)
/*@ With (pkv_list: list Z) (len: Z) (old_chksum: Z) (pkv_addr: Z)
    Require
      0 <= len &&
      Zlength(pkv_list) == len &&
      store(&(pIp->pkv), pkv_addr) *
      store(&(pIp->len), len) *
      store(&(pIp->chksum), old_chksum) *
      UCharArray::full(pkv_addr, len, pkv_list)
    Ensure
      exists new_chksum,
        CheckCal08Post(pkv_list, len, new_chksum) &&
        store(&(pIp->pkv), pkv_addr) *
        store(&(pIp->len), len) *
        store(&(pIp->chksum), new_chksum) *
        UCharArray::full(pkv_addr, len, pkv_list)
*/
{
    unint08 *pkv_local = pIp->pkv;
    unint32 len_local = pIp->len;
    unint32 i;

    pIp->chksum = 0;

    /*@ Inv Assert
        exists chksum,
          0 <= i && i <= len &&
          len_local == len &&
          pkv_local == pkv_addr &&
          CheckCal08Inv(pkv_list, len, i, chksum) &&
          store(&(pIp->pkv), pkv_addr) *
          store(&(pIp->len), len) *
          store(&(pIp->chksum), chksum) *
          UCharArray::full(pkv_addr, len, pkv_list)
    */
    for (i = 0; i < len_local; i++)
    {
        pIp->chksum = pIp->chksum + pkv_local[i];
    }

    return;
}
