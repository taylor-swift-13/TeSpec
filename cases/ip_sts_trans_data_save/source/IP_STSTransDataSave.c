#include "IP_STSTransDataSave.h"

/*@ Import Coq Require Import SimpleC.EE.LLM_bench.Engineering.STSTransDataSave.IP_STSTransDataSave_lib */
/*@ Extern Coq (STSTransDataSaveBytePost: Z -> Z -> list Z -> list Z -> list Z -> Prop) */

void STSTransDataSave()
/*@ With ptr data_head data_tail prefix old_dst suffix
    Require 0 <= ptr && ptr <= 776 &&
            Zlength(data_head) == 248 && Zlength(data_tail) == 8 &&
            Zlength(prefix) == ptr && Zlength(old_dst) == 248 &&
            Zlength(suffix) == 1024 - ptr - 248 &&
            store(&(sSTSTran.ptr), ptr) *
            CharArray::full(&(sSTSTran.dataBuf[0]), 248, data_head) *
            CharArray::full(&(sSTSTran.dataBuf[0]) + 248, 8, data_tail) *
            CharArray::full(1074343936, ptr, prefix) *
            CharArray::full(1074343936 + ptr, 248, old_dst) *
            CharArray::full(1074343936 + ptr + 248, 1024 - ptr - 248, suffix)
    Ensure exists ptr1 new_sram,
            STSTransDataSaveBytePost(ptr, ptr1, app(data_head, data_tail), app(prefix, app(old_dst, suffix)), new_sram) &&
            store(&(sSTSTran.ptr), ptr1) *
            CharArray::full(&(sSTSTran.dataBuf[0]), 248, data_head) *
            CharArray::full(&(sSTSTran.dataBuf[0]) + 248, 8, data_tail) *
            CharArray::full(1074343936, 1024, new_sram)
*/
{
    unint32 pDst;

    if (sSTSTran.ptr < 776) {
        pDst = 1074343936u + sSTSTran.ptr;
        /*@ Assert ptr < 776 && pDst == 1074343936 + ptr &&
            0 <= ptr && ptr <= 776 &&
            Zlength(data_head) == 248 && Zlength(data_tail) == 8 &&
            Zlength(prefix) == ptr && Zlength(old_dst) == 248 &&
            Zlength(suffix) == 1024 - ptr - 248 &&
            store(&(sSTSTran.ptr), ptr) *
            CharArray::full(&(sSTSTran.dataBuf[0]), 248, data_head) *
            CharArray::full(&(sSTSTran.dataBuf[0]) + 248, 8, data_tail) *
            CharArray::full(1074343936, ptr, prefix) *
            CharArray::full(pDst, 248, old_dst) *
            CharArray::full(pDst + 248, 1024 - ptr - 248, suffix)
        */
        Memcpyx((unint08*)pDst, &(sSTSTran.dataBuf[0]), 248) /*@ where bytes = data_head, old_dst = old_dst */;
        /*@ Assert ptr < 776 && pDst == 1074343936 + ptr &&
            0 <= ptr && ptr <= 776 &&
            Zlength(data_head) == 248 && Zlength(data_tail) == 8 &&
            Zlength(prefix) == ptr && Zlength(old_dst) == 248 &&
            Zlength(suffix) == 1024 - ptr - 248 &&
            store(&(sSTSTran.ptr), ptr) *
            CharArray::full(&(sSTSTran.dataBuf[0]), 248, data_head) *
            CharArray::full(&(sSTSTran.dataBuf[0]) + 248, 8, data_tail) *
            CharArray::full(1074343936, ptr, prefix) *
            CharArray::full(pDst, 248, data_head) *
            CharArray::full(pDst + 248, 1024 - ptr - 248, suffix)
        */
        sSTSTran.ptr = sSTSTran.ptr + 248;
    }

    return;
}
