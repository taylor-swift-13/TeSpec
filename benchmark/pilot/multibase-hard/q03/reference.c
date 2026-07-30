typedef long long scalar64;

typedef struct {
    scalar64 A11, H1, D1;
    scalar64 A32, A33, H2, H3, D2;
    scalar64 A54, A55, H4, H5, D3;
    scalar64 A76, A77, H6, H7, D4;
} Filter;

scalar64 global_prd;

scalar64 run_filter(
    scalar64 *X, Filter *f, scalar64 *pid, scalar64 Ang, scalar64 dAng)
{
    scalar64 old1 = X[1], old3 = X[3], old5 = X[5];
    scalar64 Kp = pid[0], Ki = pid[1], Kd = pid[2];

    X[0] = f->A11 * X[0] + f->H1 * Kp * Ang;
    scalar64 Y1 = X[0] + f->D1 * Kp * Ang;
    scalar64 U2 = Y1 + Kd * dAng;
    scalar64 Y2 = X[1] + f->D2 * U2;

    X[1] = X[2] + f->H2 * U2;
    X[2] = f->A32 * old1 + f->A33 * X[2] + f->H3 * U2;

    scalar64 Y3 = X[3] + f->D3 * Y2;
    X[3] = X[4] + f->H4 * Y2;
    X[4] = f->A54 * old3 + f->A55 * X[4] + f->H5 * Y2;

    scalar64 Y4 = X[5] + f->D4 * Y3;
    X[5] = X[6] + f->H6 * Y3;
    X[6] = f->A76 * old5 + f->A77 * X[6] + f->H7 * Y3;
    X[7] = X[7] + global_prd * Ki * Ang;
    return Y4;
}
