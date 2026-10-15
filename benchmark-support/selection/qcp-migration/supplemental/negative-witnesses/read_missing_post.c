#include <stdio.h>
#include <stdlib.h>
int read (int *p)
{
  return *p;
}
int main(void){int*p=malloc(sizeof(int));if(!p)return 90;*p=5;int x=read(p);if(x!=5||*p!=5)return 1;printf("return=%d live caller allocation remains; value=%d\n",x,*p);free(p);return 0;}
