#include <stdio.h>
struct int_queueCell { int first; struct int_queueCell *next; };
void push_induction(struct int_queueCell* front, struct int_queueCell* p)
{
    if (front == p) {
        return;
    } else {
        push_induction(front->next, p);
        return;
    }
}
static int extract(struct int_queueCell *f, struct int_queueCell *b, int *vals) {
 int n=0; while(f!=b) { if(!f || !f->next || n>=8) return -1; vals[n++]=f->first; f=f->next; } return n;
}
int main(void) {
 struct int_queueCell f={1,0}, z={2,0}, p={3,0}; f.next=&z; z.next=&p; p.next=&z;
 int before[8],after[8]; int a=extract(&f,&p,before);
 int pre=(a==2 && before[0]==1 && before[1]==2 && &f!=p.next && p.next!=0);
 push_induction(&f,&p);
 int b=extract(&f,p.next,after); int post=(b==3 && after[0]==1 && after[1]==2 && after[2]==3);
 printf("{\"precondition_holds\":%s,\"before_length\":%d,\"post_length\":%d,\"expected_post_length\":3,\"postcondition_holds\":%s}\n",pre?"true":"false",a,b,post?"true":"false");
 return !(pre && !post);
}
