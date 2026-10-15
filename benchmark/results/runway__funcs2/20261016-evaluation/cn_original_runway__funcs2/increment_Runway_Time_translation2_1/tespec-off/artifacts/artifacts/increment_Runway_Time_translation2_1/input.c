#include "verification_stdlib.h"


#define ACTIVE 1
#define INACTIVE 0
struct State { int ModeA; int ModeD; int W_A; int W_D; int Runway_Time; int Plane_Counter; };
struct State increment_Plane_Counter(struct State s)
/*@ With a0 d0 wa0 wd0 t0 c0 Require 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && s.Plane_Counter <= 2 && s.ModeA+s.ModeD == 1 && s.W_D >= s.ModeA && s.W_A >= s.ModeD && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && __return.Plane_Counter == c0+1 && __return.ModeA == a0 && __return.ModeD == d0 && __return.W_A == wa0 && __return.W_D == wd0 && __return.Runway_Time == t0 && emp */
{
  struct State temp = s;
  temp.Plane_Counter = s.Plane_Counter + 1;
  return temp;
}
struct State reset_Plane_Counter(struct State s)
/*@ With a0 d0 wa0 wd0 t0 c0 Require 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && __return.Plane_Counter == 0 && __return.ModeA == a0 && __return.ModeD == d0 && __return.W_A == wa0 && __return.W_D == wd0 && __return.Runway_Time == t0 && emp */
{
  struct State temp = s;
  temp.Plane_Counter = 0;
  return temp;
}
struct State increment_Runway_Time(struct State s)

/*@ __tespec_entry With a0 d0 wa0 wd0 t0 c0 Require
      (a0 == (0)) && (c0 == (2)) && (d0 == (1)) && (t0 == (4)) && (wa0 == (2)) && (wd0 == (1)) && s.ModeA == 0 && s.ModeD == 1 && s.W_A == 2 && s.W_D == 1 && s.Runway_Time == 4 && s.Plane_Counter == 2 && 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && s.Runway_Time <= 4 && s.ModeA+s.ModeD == 1 && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && __return.ModeA == a0 && __return.ModeD == d0 && __return.Plane_Counter == c0 && emp */
/*@ With a0 d0 wa0 wd0 t0 c0 Require s.ModeA == 0 && s.ModeD == 1 && s.W_A == 2 && s.W_D == 1 && s.Runway_Time == 4 && s.Plane_Counter == 2 && 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && s.Runway_Time <= 4 && s.ModeA+s.ModeD == 1 && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && __return.ModeA == a0 && __return.ModeD == d0 && __return.Plane_Counter == c0 && emp */
{
  struct State temp = s;
  temp.Runway_Time = s.Runway_Time + 1;
  return temp;
}
struct State reset_Runway_Time(struct State s)
/*@ With a0 d0 wa0 wd0 t0 c0 Require 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && __return.Runway_Time == 0 && __return.ModeA == a0 && __return.ModeD == d0 && __return.W_A == wa0 && __return.W_D == wd0 && __return.Plane_Counter == c0 && emp */
{
  struct State temp = s;
  temp.Runway_Time = 0;
  return temp;
}
struct State arrive(struct State s)
/*@ With a0 d0 wa0 wd0 t0 c0 Require 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && s.ModeA == 1 && s.W_A >= 1 && s.Plane_Counter <= 2 && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && __return.ModeA == a0 && __return.ModeD == d0 && __return.W_D == wd0 && __return.Runway_Time == t0 && (wd0 != 0 || __return.Plane_Counter == c0) && (wd0 <= 0 || __return.Plane_Counter == c0+1) && emp */
{
  struct State temp = s;
  temp.W_A = s.W_A - 1;
  if (s.W_D > 0) {
    temp.Plane_Counter = temp.Plane_Counter + 1;
  }
  return temp;
}
struct State depart(struct State s)
/*@ With a0 d0 wa0 wd0 t0 c0 Require 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && s.ModeD == 1 && s.W_D >= 1 && s.Plane_Counter <= 2 && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && __return.ModeA == a0 && __return.ModeD == d0 && __return.W_A == wa0 && __return.Runway_Time == t0 && emp */
{
  struct State temp = s;
  temp.W_D = s.W_D - 1;
  if (s.W_A > 0) {
    temp.Plane_Counter = temp.Plane_Counter + 1;
  }
  return temp;
}
struct State switch_modes(struct State s)
/*@ With a0 d0 wa0 wd0 t0 c0 Require 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && s.ModeA+s.ModeD == 1 && s.Plane_Counter == 0 && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && __return.ModeA+__return.ModeD == 1 && __return.ModeA == d0 && __return.ModeD == a0 && __return.W_A == wa0 && __return.W_D == wd0 && __return.Runway_Time == t0 && __return.Plane_Counter == c0 && emp */
{
  struct State temp = s;
  if (s.ModeA == INACTIVE) {
    temp.ModeA = ACTIVE;
  } else {
    temp.ModeA = INACTIVE;
  }
  if (s.ModeD == INACTIVE) {
    temp.ModeD = ACTIVE;
  } else {
    temp.ModeD = INACTIVE;
  }
  return temp;
}
struct State tick(struct State s)
/*@ With a0 d0 wa0 wd0 t0 c0 Require 0 <= s.ModeA && s.ModeA <= 1 && 0 <= s.ModeD && s.ModeD <= 1 && s.ModeA+s.ModeD <= 1 && s.W_A >= 0 && s.W_D >= 0 && 0 <= s.Runway_Time && s.Runway_Time <= 5 && 0 <= s.Plane_Counter && s.Plane_Counter <= 3 && s.Plane_Counter <= 3*(s.ModeA+s.ModeD) && s.Runway_Time <= 5*(s.ModeA+s.ModeD) && s.Plane_Counter <= 3*(1-s.ModeA+s.W_D) && s.Plane_Counter <= 3*(1-s.ModeD+s.W_A) && s.Plane_Counter < 2147483647 && s.W_A < 2147483647 && s.W_D < 2147483647 && emp && s.ModeA == a0 && s.ModeD == d0 && s.W_A == wa0 && s.W_D == wd0 && s.Runway_Time == t0 && s.Plane_Counter == c0 Ensure 0 <= __return.ModeA && __return.ModeA <= 1 && 0 <= __return.ModeD && __return.ModeD <= 1 && __return.ModeA+__return.ModeD <= 1 && __return.W_A >= 0 && __return.W_D >= 0 && 0 <= __return.Runway_Time && __return.Runway_Time <= 5 && 0 <= __return.Plane_Counter && __return.Plane_Counter <= 3 && __return.Plane_Counter <= 3*(__return.ModeA+__return.ModeD) && __return.Runway_Time <= 5*(__return.ModeA+__return.ModeD) && __return.Plane_Counter <= 3*(1-__return.ModeA+__return.W_D) && __return.Plane_Counter <= 3*(1-__return.ModeD+__return.W_A) && (wa0 <= 0 || wd0 != 0 || t0 != 0 || __return.ModeA == 1) && (wd0 <= 0 || wa0 != 0 || t0 != 0 || __return.ModeD == 1) && emp */
{
    if (s.Runway_Time > 0)
    {
      if (s.Runway_Time == 5)
      {
        s.Runway_Time = 0;
      } else {
        s.Runway_Time = s.Runway_Time + 1;
      }
      return s;
    }
    else if (s.ModeA == ACTIVE && s.W_A > 0 && s.Plane_Counter < 3) {
      s.W_A = s.W_A - 1;
if (s.W_D > 0) s.Plane_Counter = s.Plane_Counter + 1;
      s.Runway_Time = s.Runway_Time + 1;
      return s;
    }
    else if (s.ModeD == ACTIVE && s.W_D > 0 && s.Plane_Counter < 3) {
      s.W_D = s.W_D - 1;
if (s.W_A > 0) s.Plane_Counter = s.Plane_Counter + 1;
      s.Runway_Time = s.Runway_Time + 1;
      return s;
    }
    else {
      if (s.ModeA == ACTIVE) {
        s.Plane_Counter = 0;
        if (s.ModeA == 0) s.ModeA = 1; else s.ModeA = 0;
if (s.ModeD == 0) s.ModeD = 1; else s.ModeD = 0;
        if (s.W_D > 0) {
          s.W_D = s.W_D - 1;
if (s.W_A > 0) s.Plane_Counter = s.Plane_Counter + 1;
          s.Runway_Time = s.Runway_Time + 1;
        }
        return s;
      }
      else if (s.ModeD == ACTIVE) {
        s.Plane_Counter = 0;
        if (s.ModeA == 0) s.ModeA = 1; else s.ModeA = 0;
if (s.ModeD == 0) s.ModeD = 1; else s.ModeD = 0;
        if (s.W_A > 0) {
          s.W_A = s.W_A - 1;
if (s.W_D > 0) s.Plane_Counter = s.Plane_Counter + 1;
          s.Runway_Time = s.Runway_Time + 1;
        }
        return s;
      }
      else {
        if (s.W_A > 0) {
          s.ModeA = ACTIVE;
          s.W_A = s.W_A - 1;
if (s.W_D > 0) s.Plane_Counter = s.Plane_Counter + 1;
          s.Runway_Time = s.Runway_Time + 1;
          return s;
        } else if (s.W_D > 0) {
          s.ModeD = ACTIVE;
          s.W_D = s.W_D - 1;
if (s.W_A > 0) s.Plane_Counter = s.Plane_Counter + 1;
          s.Runway_Time = s.Runway_Time + 1;
          return s;
        } else {
          s.ModeA = ACTIVE;
          return s;
        }
      }
    }
}
