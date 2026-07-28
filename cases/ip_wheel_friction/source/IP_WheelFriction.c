typedef unsigned int unint32;

typedef struct TAG_MW_DATA {
    unint32 F_Valid_MW[4];
    unint32 vf[4];
} MW_DATA;

typedef struct TAG_MW_CTRL {
    unint32 kf[4];
    unint32 cut[4];
    unint32 vf0[4];
} MW_CTRL;

MW_DATA sMWData;
MW_CTRL sMWCtrl;

unint32 WheelFricComp(unint32 kf, unint32 cut, unint32 vf0)
  /*@ Require emp
      Ensure __return == 0 && emp
   */
{
    return 0;
}

/*@ Import Coq Require Import SimpleC.EE.LLM_bench.Engineering.WheelFriction.IP_WheelFriction_lib */
/*@ Extern Coq (WheelFricPost1: Z -> Z -> Z -> Z -> Z -> Prop) */

void WheelFriction(void)
/*@ With (fv0 fv1 fv2 fv3 kf0 kf1 kf2 kf3 cut0 cut1 cut2 cut3 vf00 vf01 vf02 vf03 vf_old0 vf_old1 vf_old2 vf_old3 : Z)
    Require store(&(sMWData.F_Valid_MW[0]), fv0) *
            store(&(sMWData.F_Valid_MW[1]), fv1) *
            store(&(sMWData.F_Valid_MW[2]), fv2) *
            store(&(sMWData.F_Valid_MW[3]), fv3) *
            store(&(sMWData.vf[0]), vf_old0) *
            store(&(sMWData.vf[1]), vf_old1) *
            store(&(sMWData.vf[2]), vf_old2) *
            store(&(sMWData.vf[3]), vf_old3) *
            store(&(sMWCtrl.kf[0]), kf0) *
            store(&(sMWCtrl.kf[1]), kf1) *
            store(&(sMWCtrl.kf[2]), kf2) *
            store(&(sMWCtrl.kf[3]), kf3) *
            store(&(sMWCtrl.cut[0]), cut0) *
            store(&(sMWCtrl.cut[1]), cut1) *
            store(&(sMWCtrl.cut[2]), cut2) *
            store(&(sMWCtrl.cut[3]), cut3) *
            store(&(sMWCtrl.vf0[0]), vf00) *
            store(&(sMWCtrl.vf0[1]), vf01) *
            store(&(sMWCtrl.vf0[2]), vf02) *
            store(&(sMWCtrl.vf0[3]), vf03)
    Ensure exists (vf0' vf1' vf2' vf3' : Z),
      WheelFricPost1(fv0, kf0, cut0, vf00, vf0') &&
      WheelFricPost1(fv1, kf1, cut1, vf01, vf1') &&
      WheelFricPost1(fv2, kf2, cut2, vf02, vf2') &&
      WheelFricPost1(fv3, kf3, cut3, vf03, vf3') &&
      store(&(sMWData.F_Valid_MW[0]), fv0) *
      store(&(sMWData.F_Valid_MW[1]), fv1) *
      store(&(sMWData.F_Valid_MW[2]), fv2) *
      store(&(sMWData.F_Valid_MW[3]), fv3) *
      store(&(sMWData.vf[0]), vf0') *
      store(&(sMWData.vf[1]), vf1') *
      store(&(sMWData.vf[2]), vf2') *
      store(&(sMWData.vf[3]), vf3') *
      store(&(sMWCtrl.kf[0]), kf0) *
      store(&(sMWCtrl.kf[1]), kf1) *
      store(&(sMWCtrl.kf[2]), kf2) *
      store(&(sMWCtrl.kf[3]), kf3) *
      store(&(sMWCtrl.cut[0]), cut0) *
      store(&(sMWCtrl.cut[1]), cut1) *
      store(&(sMWCtrl.cut[2]), cut2) *
      store(&(sMWCtrl.cut[3]), cut3) *
      store(&(sMWCtrl.vf0[0]), vf00) *
      store(&(sMWCtrl.vf0[1]), vf01) *
      store(&(sMWCtrl.vf0[2]), vf02) *
      store(&(sMWCtrl.vf0[3]), vf03)
*/
{
    /* 循环展开：4 个动量轮逐个处理 */

    /* 动量轮 0 */
    if (sMWData.F_Valid_MW[0] == 3952088175)
    {
        sMWData.vf[0] = WheelFricComp(sMWCtrl.kf[0], sMWCtrl.cut[0], sMWCtrl.vf0[0]);
    }
    else
    {
        sMWData.vf[0] = 0;
    }

    /* 动量轮 1 */
    if (sMWData.F_Valid_MW[1] == 3952088175)
    {
        sMWData.vf[1] = WheelFricComp(sMWCtrl.kf[1], sMWCtrl.cut[1], sMWCtrl.vf0[1]);
    }
    else
    {
        sMWData.vf[1] = 0;
    }

    /* 动量轮 2 */
    if (sMWData.F_Valid_MW[2] == 3952088175)
    {
        sMWData.vf[2] = WheelFricComp(sMWCtrl.kf[2], sMWCtrl.cut[2], sMWCtrl.vf0[2]);
    }
    else
    {
        sMWData.vf[2] = 0;
    }

    /* 动量轮 3 */
    if (sMWData.F_Valid_MW[3] == 3952088175)
    {
        sMWData.vf[3] = WheelFricComp(sMWCtrl.kf[3], sMWCtrl.cut[3], sMWCtrl.vf0[3]);
    }
    else
    {
        sMWData.vf[3] = 0;
    }

    return;
}
