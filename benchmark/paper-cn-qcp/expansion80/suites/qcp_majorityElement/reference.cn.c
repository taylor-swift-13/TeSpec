/*@
function [rec] (integer) Count(map<integer,integer> a, integer n, integer v) { if(n <= 0) {0} else { if(a[n-1] == v) {1 + Count(a,n-1,v)} else {Count(a,n-1,v)} } }
function [rec] (integer) MaxCount(map<integer,integer> a, integer n) { if(n <= 0) {0} else { if(Count(a,n,a[n-1]) > MaxCount(a,n-1)) {Count(a,n,a[n-1])} else {MaxCount(a,n-1)} } }
@*/









int majorityElement(int* nums, int numsSize)
/*@ requires 1 <= numsSize; numsSize <= 50000; take A = each(integer i; 0 <= i && i < numsSize) {RW<int>(array_shift<int>(nums,i))}; 2 * MaxCount(A,numsSize) > numsSize; ensures take B = each(integer i; 0 <= i && i < numsSize) {RW<int>(array_shift<int>(nums,i))}; B == A; 2 * Count(A,numsSize,return) > numsSize; @*/
{
    int vote = 0;
    int candidate = 0;
    {
    int i;
    
    for (i = 0; i < numsSize; i++) {
        if (vote == 0) {
            candidate = nums[i];
        }
        vote += (nums[i] == candidate) ? 1 : -1;
    }
    }
    return candidate;
}