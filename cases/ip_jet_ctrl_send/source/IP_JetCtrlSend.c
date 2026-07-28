/* ============================================================
 * JetCtrlSend 的 QCP 验证用 C 源码
 *
 * 功能：根据 12 路推力器脉冲输入 pulse[0..11]，把 6 对脉冲信号
 *       打包成软件喷气字节 wPulse（第 k 对任意一路为 1 则置位
 *       0x04 << k），再组帧 [0xEB, 0x93, wPulse] 通过 UartSend 发出。
 *
 * 为避开当前 symexec 的限制，本文件采用自包含最小等价形态：
 *   1. 结构体定义内联，入口直接接收 JetCtrlSend*（原为 void* 强转）。
 *   2. 当前 symexec 不支持局部 C 数组（裸声明即报
 *      "Unsupported array predicate"），因此原始代码中的局部数组
 *      sendBuf[10] 建模为结构体指针字段 sendBuf（指向 3 字节缓冲区，
 *      原始代码只使用前 3 字节）。
 *   3. 每个 if 块内联形式会产生 3 条可行路径，6 个 if 共 3^6=729 条
 *      返回路径（实测 3642 个 witness，无法承受）。因此把每个 if 块
 *      原样抽取为 helper 函数 JetCtrlSendPairStep，调用点使用其 spec，
 *      主函数只有 1 条返回路径。helper 的条件分支与原始代码完全一致
 *      （包括 || 短路语义）。
 * ============================================================ */

typedef unsigned int  unint32;
typedef unsigned char unint08;

/*@ Extern Coq (UartSendRecord : Z -> list Z -> Prop) */
/*@ Extern Coq (jet_step : Z -> Z -> Z -> Z -> Z) */
/*@ Extern Coq (JetCtrlSendPost : list Z -> list Z -> Prop) */
/*@ Import Coq Require Import QCIPLib.SAMCodeSynthesis.JetCtrlSend.IP_JetCtrlSend_lib */

typedef struct __JetCtrlSend
{
    unint32 uartno;         /* 串口号 */
    unint32 *pulse;         /* 输入的推力器分配[12] */
    unint08 *sendBuf;       /* 验证模型：发送缓冲区指针（>=3 字节） */
} JetCtrlSend;

void UartSend(unint32 uartno, unint08 *buf, unint32 sendsize)
/*@ With (l: list Z)
    Require Zlength(l) == sendsize && UCharArray::full(buf, sendsize, l)
    Ensure UartSendRecord(uartno, l) && UCharArray::full(buf, sendsize, l)
*/
;

/* 单对脉冲信号的置位：与原始 if 块逐字一致 */
unint08 JetCtrlSendPairStep(unint32 p0, unint32 p1, unint08 w, unint08 mask)
/*@ Require 0 <= w && w < 256 && 0 <= mask && mask < 256 && emp
    Ensure __return == jet_step(p0, p1, w, mask) && emp
*/
{
    if ( (p0 == 1) || (p1 == 1) )
    {
        w = w | mask ;
    }
    return w;
}

void JetCtrlSendFun(JetCtrlSend *pIp)
/*@ With (uartno: Z) (pulse_addr: Z) (pulse_list: list Z) (sb_addr: Z) (sb_list: list Z)
    Require
      Zlength(pulse_list) == 12 &&
      Zlength(sb_list) == 3 &&
      store(&(pIp->uartno), uartno) *
      store(&(pIp->pulse), pulse_addr) *
      store(&(pIp->sendBuf), sb_addr) *
      UIntArray::full(pulse_addr, 12, pulse_list) *
      UCharArray::full(sb_addr, 3, sb_list)
    Ensure
      exists sent,
        UartSendRecord(uartno, sent) &&
        JetCtrlSendPost(pulse_list, sent) &&
        store(&(pIp->uartno), uartno) *
        store(&(pIp->pulse), pulse_addr) *
        store(&(pIp->sendBuf), sb_addr) *
        UIntArray::full(pulse_addr, 12, pulse_list) *
        UCharArray::full(sb_addr, 3, sent)
*/
{
    unint08 wPulse = 0;

    wPulse = JetCtrlSendPairStep(pIp->pulse[0], pIp->pulse[1], wPulse, 0x04);
    wPulse = JetCtrlSendPairStep(pIp->pulse[2], pIp->pulse[3], wPulse, 0x08);
    wPulse = JetCtrlSendPairStep(pIp->pulse[4], pIp->pulse[5], wPulse, 0x10);
    wPulse = JetCtrlSendPairStep(pIp->pulse[6], pIp->pulse[7], wPulse, 0x20);
    wPulse = JetCtrlSendPairStep(pIp->pulse[8], pIp->pulse[9], wPulse, 0x40);
    wPulse = JetCtrlSendPairStep(pIp->pulse[10], pIp->pulse[11], wPulse, 0x80);

    pIp->sendBuf[0] = 0xEB;
    pIp->sendBuf[1] = 0x93;
    pIp->sendBuf[2] = wPulse;

    UartSend(pIp->uartno, pIp->sendBuf, 3);

    return;
}
