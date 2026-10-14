#include <stdio.h>







int rob(int *nums, int n)

{
  int prev2 = 0;
  int prev1 = 0;
  
  for (int i = 0; i < n; ++i) {
    int take = prev2 + nums[i];
    int skip = prev1;
    int cur;
    if (take > skip) {
      cur = take;
    } else {
      cur = skip;
    }
    
    prev2 = prev1;
    prev1 = cur;
  }
  return prev1;
}

int main(void) { int a[5]={2,7,9,3,1}; int copy[5]={2,7,9,3,1}; int result=rob(a,5); printf("%d\n",result); if(result!=12) return 1; for(int i=0;i<5;i++) if(a[i]!=copy[i]) return 2; return 0;}
