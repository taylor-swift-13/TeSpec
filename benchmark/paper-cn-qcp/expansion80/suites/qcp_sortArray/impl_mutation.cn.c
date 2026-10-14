/*@
function [rec] (integer) Count(map<integer,integer> a, integer n, integer v) { if(n <= 0) {0} else { if(a[n-1] == v) {1 + Count(a,n-1,v)} else {Count(a,n-1,v)} } }
@*/









int* sortArray(int* nums, int numsSize, int* returnSize) 
/*@ requires 1 <= numsSize; numsSize <= 50000; take A = each(integer i; 0 <= i && i < numsSize) {RW<int>(array_shift<int>(nums,i))}; take R = W<int>(returnSize); ensures take B = each(integer i; 0 <= i && i < numsSize) {RW<int>(array_shift<int>(return,i))}; take R2 = RW<int>(returnSize); R2 == numsSize; each(integer i; 0 <= i && i < numsSize-1) {B[i] <= B[i+1]}; each(integer i; 0 <= i && i < numsSize) {Count(A,numsSize,A[i]) == Count(B,numsSize,A[i])}; each(integer i; 0 <= i && i < numsSize) {Count(A,numsSize,B[i]) == Count(B,numsSize,B[i])}; @*/
{
    *returnSize = numsSize;
    {
    int i;
    
    for (i = 1; i < numsSize; ++i) {
        int key = nums[i];
        int j = i - 1;
        
        while (j >= 0 && nums[j] < key) {
            
            nums[j + 1] = nums[j];
                    
            j--;
        }
        nums[j + 1] = key;
    }
    }
    return nums;
}
