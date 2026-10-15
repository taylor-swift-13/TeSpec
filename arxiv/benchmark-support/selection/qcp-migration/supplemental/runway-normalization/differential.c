#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#define ACTIVE 1
#define INACTIVE 0
struct State { int ModeA,ModeD,W_A,W_D,Runway_Time,Plane_Counter; };
struct State increment_Plane_Counter(struct State s)
{
  struct State temp = s;
  temp.Plane_Counter = s.Plane_Counter + 1;
  return temp;
}
struct State reset_Plane_Counter(struct State s)
{
  struct State temp = s;
  temp.Plane_Counter = 0;
  return temp;
}
struct State increment_Runway_Time(struct State s)
{
  struct State temp = s;
  temp.Runway_Time = s.Runway_Time + 1;
  return temp;
}
struct State reset_Runway_Time(struct State s)
{
  struct State temp = s;
  temp.Runway_Time = 0;
  return temp;
}
struct State arrive(struct State s)
{
  struct State temp = s;
  temp.W_A = s.W_A - 1;
  if (s.W_D > 0) {
    temp = increment_Plane_Counter(temp);
  }
  return temp;
}
struct State depart(struct State s)
{
  struct State temp = s;
  temp.W_D = s.W_D - 1;
  if (s.W_A > 0) {
    temp = increment_Plane_Counter(temp);
  }
  return temp;
}
struct State switch_modes(struct State s)
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
{
    if (s.Runway_Time > 0)
    {
      if (s.Runway_Time == 5)
      {
        s = reset_Runway_Time(s);
      } else {
        s = increment_Runway_Time(s);
      }
      return s;
    }
    else if (s.ModeA == ACTIVE && s.W_A > 0 && s.Plane_Counter < 3) {
      s = arrive(s);
      s = increment_Runway_Time(s);
      return s;
    }
    else if (s.ModeD == ACTIVE && s.W_D > 0 && s.Plane_Counter < 3) {
      s = depart(s);
      s = increment_Runway_Time(s);
      return s;
    }
    else {
      if (s.ModeA == ACTIVE) {
        s = reset_Plane_Counter(s);
        s = switch_modes(s);
        if (s.W_D > 0) {
          s = depart(s);
          s = increment_Runway_Time(s);
        }
        return s;
      }
      else if (s.ModeD == ACTIVE) {
        s = reset_Plane_Counter(s);
        s = switch_modes(s);
        if (s.W_A > 0) {
          s = arrive(s);
          s = increment_Runway_Time(s);
        }
        return s;
      }
      else {
        if (s.W_A > 0) {
          s.ModeA = ACTIVE;
          s = arrive(s);
          s = increment_Runway_Time(s);
          return s;
        } else if (s.W_D > 0) {
          s.ModeD = ACTIVE;
          s = depart(s);
          s = increment_Runway_Time(s);
          return s;
        } else {
          s.ModeA = ACTIVE;
          return s;
        }
      }
    }
}


#define ACTIVE 1
#define INACTIVE 0

struct State normalized_increment_Plane_Counter(struct State s)

{
  struct State temp = s;
  temp.Plane_Counter = s.Plane_Counter + 1;
  return temp;
}
struct State normalized_reset_Plane_Counter(struct State s)

{
  struct State temp = s;
  temp.Plane_Counter = 0;
  return temp;
}
struct State normalized_increment_Runway_Time(struct State s)

{
  struct State temp = s;
  temp.Runway_Time = s.Runway_Time + 1;
  return temp;
}
struct State normalized_reset_Runway_Time(struct State s)

{
  struct State temp = s;
  temp.Runway_Time = 0;
  return temp;
}
struct State normalized_arrive(struct State s)

{
  struct State temp = s;
  temp.W_A = s.W_A - 1;
  if (s.W_D > 0) {
    temp.Plane_Counter = temp.Plane_Counter + 1;
  }
  return temp;
}
struct State normalized_depart(struct State s)

{
  struct State temp = s;
  temp.W_D = s.W_D - 1;
  if (s.W_A > 0) {
    temp.Plane_Counter = temp.Plane_Counter + 1;
  }
  return temp;
}
struct State normalized_switch_modes(struct State s)

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
struct State normalized_tick(struct State s)

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

int valid(struct State s) { return (s.ModeA==0||s.ModeA==1)&&(s.ModeD==0||s.ModeD==1)&&(s.ModeA==0||s.ModeD==0)&&s.W_A>=0&&s.W_D>=0&&s.Runway_Time>=0&&s.Runway_Time<=5&&s.Plane_Counter>=0&&s.Plane_Counter<=3&&(!(s.ModeA==0&&s.ModeD==0)||s.Plane_Counter==0)&&(!(s.Runway_Time>0)||s.ModeA==1||s.ModeD==1)&&(!(s.Plane_Counter>0&&s.ModeA==1)||s.W_D>0)&&(!(s.Plane_Counter>0&&s.ModeD==1)||s.W_A>0); }
int equal(struct State a,struct State b) {return a.ModeA==b.ModeA&&a.ModeD==b.ModeD&&a.W_A==b.W_A&&a.W_D==b.W_D&&a.Runway_Time==b.Runway_Time&&a.Plane_Counter==b.Plane_Counter;}
int main(void) {int values[]={0,1,2,3,INT_MAX-1};int count=0;
 for(int a=0;a<=1;a++) for(int d=0;d<=1;d++) for(int i=0;i<5;i++) for(int j=0;j<5;j++) for(int t=0;t<=5;t++) for(int c=0;c<=3;c++) {
 struct State s={a,d,values[i],values[j],t,c};if(!valid(s))continue;struct State x=tick(s),y=normalized_tick(s);if(!equal(x,y)||!valid(y))return 1;
 if(s.W_A>0&&s.W_D==0&&s.Runway_Time==0&&y.ModeA!=1)return 2;
 if(s.W_D>0&&s.W_A==0&&s.Runway_Time==0&&y.ModeD!=1)return 3;
 count++;
 } printf("%d valid boundary states matched\n",count);return 0;}
