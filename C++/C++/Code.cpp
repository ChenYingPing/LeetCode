//
//  Array.cpp
//  C++
//
//  Created by 陈应平 on 2019/2/12.
//  Copyright © 2019 陈应平. All rights reserved.
//  https://github.com/haoel/leetcode

#include <iostream>
#include "DataDefine.hpp"

using namespace std;

// 0-77
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        // 为了解决冲突，所以unordered_map内部其实是由很多哈希桶组成的，每个哈希桶中可能没有元素，也可能有多个元素
        unordered_map<int, int> m;
        vector<int> result;
        for(int i=0; i<nums.size(); i++){
            // not found the second one
            if (m.find(nums[i])==m.end() ) {
                // store the first one poisition into the second one's key
                m[target - nums[i]] = i;
            }else {
                // found the second one
                result.push_back(m[nums[i]]);
                result.push_back(i);
                break;
            }
        }
        return result;
    }
    
    vector<int> twoSumII(vector<int>& numbers, int target) {
        vector<int> result;
        int low=0, high=numbers.size()-1;
        while (low < high) {
            if (numbers[low]+numbers[high] == target) {
                result.push_back(low);
                result.push_back(high);
                break;
            }
            else {
                numbers[low]+numbers[high] > target ? high-- : low++;
            }
        }
        return result;
    }
    
    ListNode *addTwoNumbers(ListNode *l1, ListNode *l2) {
        int x=0, y=0, carry=0, sum=0;
        ListNode *h=NULL, **t=&h;
        
        while (l1!=NULL || l2!=NULL) {
            x = (l1 == NULL) ? 0 : l1->val;
            y = (l2 == NULL) ? 0 : l2->val;
            
            sum = carry + x + y;
            
            ListNode *node = new ListNode(sum%10);
            *t = node;
            t = (&node->next);
            
            carry = sum/10;
            
            l1 = (l1 == NULL) ? l1 : l1->next;
            l2 = (l2 == NULL) ? l2 : l2->next;
        }
        
        if (carry > 0) {
            ListNode *node = new ListNode(carry%10);
            *t = node;
        }
        
        return h;
    }
    
    int lengthOfLongestSubstring(string s) {
        map<char, int> m;
        int maxLen = 0;
        int lastRepeatPos = -1;
        for (int i = 0; i < s.size(); i++) {
            if (m.find(s[i]) != m.end() && lastRepeatPos < m[s[i]]) {
                lastRepeatPos = m[s[i]];
            }
            if ((i - lastRepeatPos) > maxLen) {
                maxLen = i - lastRepeatPos;
            }
            m[s[i]] = i;
        }
        
        return maxLen;
    }
    
    void findPalindrome(string s, int left, int right, int& start, int& len)
    {
        int n = s.size();
        int l = left;
        int r = right;
        while (left>=0 && right <= n-1 && s[left] == s[right]) {
            left--;
            right++;
        }
        if (right-left-1 > len) {
            len = right - left - 1;
            start = left + 1;
        }
    }
    
    //The following solution is better than previous solution.
    //Because it remove the sub-string return in findPalindrome().
    string longestPalindrome(string s) {
        int n = s.size();
        if (n <= 1) return s;
        
        int start = 0, len = 0;
        string longest;
        
        string str;
        for (int i = 0; i < n-1; i++) {
            findPalindrome(s, i, i, start, len);
            findPalindrome(s, i, i+1, start, len);
        }
        
        return s.substr(start, len);
    }
    
    // Optimized DP soltuion can be accepted by LeetCode.
    string longestPalindrome_dp_opt_way(string s) {
        int n = s.size();
        if (n<=1) { return s; }
        bool **matrix = (bool**)malloc(n*sizeof(bool*));
        int start = 0, len = 0;
        for (int i = 0; i < n; i++) {
            matrix[i] = (bool*)malloc((i+1)*sizeof(bool));
            memset(matrix[i], false, (i+1)*sizeof(bool));
            matrix[i][i] = true;
            for (int j = 0; j <= i; j++) {
                if (i == j || (s[j]==s[i] && (i-j<2 || matrix[i-1][j+1]))) {
                    matrix[i][j] = true;
                    if (len < i-j+1) {
                        start = j;
                        len = i - j + 1;
                    }
                }
            }
        }
        for (int i = 0; i < n; i++) {
            free(matrix[i]);
        }
        free(matrix);
        
        return s.substr(start, len);
    }
    
    string convert(string s, int numRows) {
        if (numRows <= 1)
            return s;
        
        const int len = (int)s.length();
        string *str = new string[numRows];
        
        int row = 0, step = 1;
        for (int i = 0; i < len; ++i)
        {
            str[row].push_back(s[i]);
            
            if (row == 0)
                step = 1;
            else if (row == numRows - 1)
                step = -1;
            
            row += step;
        }
        
        s.clear();
        for (int j = 0; j < numRows; ++j)
        {
            s.append(str[j]);
        }
        
        delete[] str;
        return s;
    }
    bool isPalindrome(int x) {
        if (x<0 || (x!=0 && x%10==0)) return false;
        int rev = 0;
        while (x>rev){
            rev = rev*10 + x%10;
            x = x/10;
        }
        return (x==rev || x==rev/10);
    }
//    第10题思路
//    1, If p.charAt(j) == s.charAt(i) :  dp[i][j] = dp[i-1][j-1];
//    2, If p.charAt(j) == '.' : dp[i][j] = dp[i-1][j-1];
//    3, If p.charAt(j) == '*':
//    here are two sub conditions:
//    1   if p.charAt(j-1) != s.charAt(i) : dp[i][j] = dp[i][j-2]  //in this case, a* only counts as empty
//    2   if p.charAt(i-1) == s.charAt(i) or p.charAt(i-1) == '.':
//    dp[i][j] = dp[i-1][j]    //in this case, a* counts as multiple a
//    or dp[i][j] = dp[i][j-1]   // in this case, a* counts as single a
//    or dp[i][j] = dp[i][j-2]   // in this case, a* counts as empty
   
    int maxArea(vector<int> &height) {
        int maxArea = 0;
        int left = 0;
        int right = height.size()-1;
        
        int area;
        while (left < right) {
            area = (right - left) * (height[left] < height[right] ? height[left] : height[right]);
            maxArea = area > maxArea ? area : maxArea;
            if (height[left] < height[right]) {
                do {
                    left++;
                } while (left < right && height[left-1] >= height[left]);
            } else {
                do {
                    right--;
                } while (right > left && height[right+1] >= height[right]);
            }
        }
        
        return maxArea;
    }
    
    string intToRoman(int num) {
        string symbol[] =   {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};
        int value[]     =   {1000,900,500,400, 100, 90,  50, 40,  10, 9,   5,  4,   1};
        string result;
        for(int i=0; num!=0; i++){
            while(num >= value[i]){
                num -= value[i];
                result+=symbol[i];
            }
        }
        return result;
    }
    
    string longestCommonPrefix(vector<string>& strs) {
        if(strs.size() == 0) return "";
        int i = -1;
        while(strs[0][++i])
            for(int j = 0;j < strs.size();j++)
                if(strs[j][i] != strs[0][i]) return strs[0].substr(0,i);
        return strs[0].substr(0,i);
    }
    
    ListNode *removeNthFromEnd(ListNode *head, int n) {

        if (head==NULL || n <= 0) {
            return NULL;
        }
        ListNode fakeHead(0);
        fakeHead.next=head;
        head=&fakeHead;
        ListNode *p1, *p2;
        p1=p2=head;
        for (int i = 0; i < n; i++) {
            if (p2==NULL) return NULL;
            p2=p2->next;
        }
        while (p2->next!=NULL) {
            p2=p2->next;
            p1=p1->next;
        }
        p1->next = p1->next->next;
        return head->next;
    }

    /*just swap the node's value instead of node*/
    ListNode *swapPairs1(ListNode *head) {
        for (ListNode *p = head; p && p->next; p = p->next->next) {
            int n = p->val;
            p->val = p->next->val;
            p->next->val = n;
        }
        return head;
    }
    /*swap the list nodes physically*/
    ListNode *swapPairs2(ListNode *head) {
        ListNode *h = NULL;
        //using `*p` to traverse the linked list
        for (ListNode *p = head; p && p->next; p = p->next) {
            //`n` is `p`'s next node, and swap `p` and `n` physcially
            ListNode *n = p->next;
            p->next = n->next;
            n->next = p;
            //using `h` as `p`'s previous node
            if (h){
                h->next = n;
            }
            h=p;

            //determin the really 'head' pointer
            if (head == p){
                head = n;
            }
        }

        return head;
    }
    
    ListNode* reverseKGroup(ListNode* head, int k) {
        ListNode *curr = head;
        int count = 0;
        while (curr != NULL && count != k) { // find the k+1 node
            curr = curr->next;
            count++;
        }
        if (count == k) { // if k+1 node is found
            curr = reverseKGroup(curr, k); // reverse list with k+1 node as head
            // head - head-pointer to direct part,
            // curr - head-pointer to reversed part;
            while (count-- > 0) { // reverse current k-group:
                ListNode *tmp = head->next; // tmp - next head in direct part
                head->next = curr; // preappending "direct" head to the reversed list
                curr = head; // move head of reversed part to a new node
                head = tmp; // move "direct" head to the next node in direct part
            }
            head = curr;
        }
        return head;
    }
    
    int removeDuplicates(vector<int>& nums) {
        int n = nums.size();
        if (n<=1) return n;
        
        int pos=0;
        for(int i=0; i<n-1; i++){
            if (nums[i]!=nums[i+1]){
                nums[++pos] = nums[i+1];
            }
        }
        return pos+1;
    }
    
    int strStr(string haystack, string needle) {
        for (int i = 0; ; i++) {
            for (int j = 0; ; j++) {
                if (j == needle.length()) return i;
                if (i + j == haystack.length()) return -1;
                if (needle[j] != haystack[i + j]) break;
            }
        }
        
    }
    
    int longestValidParentheses(string s) {
        int maxLen = 0;
        int lastError = -1;
        vector<int> stack;
        for(int i=0; i<s.size(); i++){
            if (s[i] == '('){
                stack.push_back(i);
            }else if (s[i] == ')') {
                if (stack.size()>0 ){
                    stack.pop_back();
                    int len;
                    if (stack.size()==0){
                        len = i - lastError;
                    } else {
                        len = i - stack.back();
                    }
                    if (len > maxLen) {
                        maxLen = len;
                    }
                }else{
                    lastError = i;
                }
            }
        }
        return maxLen;
    }
   
    int search(vector<int>& nums, int target) {
        int n = nums.size();
        if (n <= 0) return -1;
        if (n == 1) {
            return (nums[0] == target) ? 0 : -1;
        }
        int low = 0, high = n - 1;
        while (low <= high) {
            if (nums[low] <= nums[high] && (target < nums[low] || target > nums[high])) {
                return -1;
            }
            
            int mid = low + (high - low) / 2;
            if (nums[mid] == target) {
                return mid;
            }
            //the target in non-rotated array
            if (nums[low] < nums[mid] && target >= nums[low] && target < nums[mid]) {
                high = mid - 1;
                continue;
            }
            //the target in non-rotated array
            if (nums[mid] < nums[high] && target > nums[mid] && target <= nums[high]) {
                low = mid + 1;
                continue;
            }
            //the target in rotated array
            if (nums[low] > nums[mid]) {
                high = mid - 1;
                continue;
            }
            //the target in rotated array
            if (nums[mid] > nums[high]) {
                low = mid + 1;
                continue;
            }
        }
        return -1;
    }
    
    bool isValidSudoku(vector<vector<char>>& board) {
        const int cnt = 9;
        bool row_mask[cnt][cnt] = {false};
        bool col_mask[cnt][cnt] = {false};
        bool area_mask[cnt][cnt] = {false};
        //check each rows and cols
        for(int r=0; r<board.size(); r++){
            for (int c=0; c<board[r].size(); c++){
                if (!isdigit(board[r][c])) continue;
                int idx =  board[r][c] - '0' - 1;
         
                //check the rows
                if (row_mask[r][idx] == true){
                    return false;
                }
                row_mask[r][idx] = true;
         
                //check the cols
                if (col_mask[c][idx] == true) {
                    return false;
                }
                col_mask[c][idx] = true;
         
                //check the areas
                int area = (r/3) * 3 + (c/3);
                if (area_mask[area][idx] == true) {
                    return false;
                }
                area_mask[area][idx] = true;
            }
        }
        
        return true;
    }

    int firstMissingPositive(vector<int>& nums) {
        int n = nums.size();
        if (n<=0) return 1;
        int num;
        for(int i=0; i<n; i++) {
            num = nums[i];
            while (num>0 && num<n && nums[num-1]!=num) {
                swap(nums[i], nums[num-1]);
                num = nums[i];
            }
        }
        for (int i=0; i<n; i++){
            if (i+1 != nums[i]){
                return i+1;
            }
        }
        return n+1;
    }
    
    int trap(vector<int>& height) {
        int left = 0;
        int right = height.size()-1;
        int res = 0;
        int maxleft = 0;
        int maxright = 0;
        while(left <= right){
            if(height[left] <= height[right]){
                if(height[left]>=maxleft) { maxleft = height[left]; }
                else  { res += maxleft - height[left]; }
                left += 1;
            }
            else{
                if(height[right] >= maxright) { maxright = height[right]; }
                else { res += maxright - height[right]; }
                right -= 1;
            }
        }
        return res;
    }
    
    bool isMatchAAA(const char *s, const char *p) {
        
        const char *last_s = NULL;
        const char *last_p = NULL;
        while( *s != '\0' ){
            if (*p=='*'){
                //skip the "*", and mark a flag
                p++;
                //edge case
                if (*p=='\0') return true;
                //use last_s and last_p to store where the "*" match starts.
                last_s = s;
                last_p = p;
            }else if (*p=='?' || *s == *p){
                s++; p++;
            }else if (last_s != NULL){ // check "last_s" to know whether meet "*" before
                // if meet "*" previously, and the *s != *p
                // reset the p, using '*' to match this situation
                p = last_p;
                s = ++last_s;
            }else{
                // *p is not wildcard char,
                // doesn't match *s,
                // there are no '*' wildcard matched before
                return false;
            }
        }
        //edge case: "s" is done, but "p" still have chars.
        while (*p == '*') p++;
        return *p == '\0';
    }

    int jump(vector<int>& nums) {
        int n = nums.size();
        if(n<2)return 0;
        int level=0,currentMax=0,i=0,nextMax=0;
        
        while(currentMax-i+1>0){        //nodes count of current level>0
            level++;
            for(;i<=currentMax;i++){    //traverse current level , and update the max reach of next level
                nextMax=max(nextMax,nums[i]+i);
                if(nextMax>=n-1)return level;   // if last element is in level+1,  then the min jump=level
            }
            currentMax=nextMax;
        }
        return 0;
    }
    
    vector<vector<int> > permute(vector<int> &num) {
        vector<vector<int> > result;
        permuteRecursive(num, 0, result);
        return result;
    }
    
    // permute num[begin..end]
    // invariant: num[0..begin-1] have been fixed/permuted
    void permuteRecursive(vector<int> &num, int begin, vector<vector<int> > &result)    {
        if (begin >= num.size()) {
            // one permutation instance
            result.push_back(num);
            return;
        }
        
        for (int i = begin; i < num.size(); i++) {
            swap(num[begin], num[i]);
            permuteRecursive(num, begin + 1, result);
            // reset
            swap(num[begin], num[i]);
        }
    }
    
    /*
     * clockwise rotate
     * first reverse up to down, then swap the symmetry
     * 1 2 3     7 8 9     7 4 1
     * 4 5 6  => 4 5 6  => 8 5 2
     * 7 8 9     1 2 3     9 6 3
     */
    void rotate(vector<vector<int>>& matrix) {
        reverse(matrix.begin(), matrix.end());
        for (int i = 0; i < matrix.size(); ++i) {
            for (int j = i + 1; j < matrix[i].size(); ++j)
                swap(matrix[i][j], matrix[j][i]);
        }
    }
    double myPow(double x, int n) {
        bool sign = false;
        unsigned int exp = n;
        if(n<0){
            exp = -n;
            sign = true;
        }
        double result = 1.0;
        while (exp) {
            if (exp & 1){
                result *= x;
            }
            exp >>= 1;
            x *= x;
        }
        
        return sign ? 1/result : result;
    }
    
    vector<vector<string> > solveNQueens(int n) {
        vector<vector<string> > res;
        vector<string> nQueens(n, string(n, '.'));
        solveNQueens(res, nQueens, 0, n);
        return res;
    }
    void solveNQueens(vector<vector<string> > &res, vector<string> &nQueens, int row, int &n) {
        if (row == n) {
            res.push_back(nQueens);
            return;
        }
        for (int col = 0; col != n; ++col)
            if (isValid(nQueens, row, col, n)) {
                nQueens[row][col] = 'Q';
                solveNQueens(res, nQueens, row + 1, n);
                nQueens[row][col] = '.';
            }
    }
    bool isValid(vector<string> &nQueens, int row, int col, int &n) {
        //check if the column had a queen before.
        for (int i = 0; i != row; ++i)
            if (nQueens[i][col] == 'Q')
                return false;
        //check if the 45° diagonal had a queen before.
        for (int i = row - 1, j = col - 1; i >= 0 && j >= 0; --i, --j)
            if (nQueens[i][j] == 'Q')
                return false;
        //check if the 135° diagonal had a queen before.
        for (int i = row - 1, j = col + 1; i >= 0 && j < n; --i, ++j)
            if (nQueens[i][j] == 'Q')
                return false;
        return true;
    }
    
    vector<int> spiralOrder(vector<vector<int>>& matrix) {
        vector<int> res;
        if (matrix.size() == 0) {
            return res;
        }
        int rowBegin = 0;
        int rowEnd = matrix.size()-1;
        int colBegin = 0;
        int colEnd = matrix[0].size() - 1;
        
        while (rowBegin <= rowEnd && colBegin <= colEnd) {
            // Traverse Right
            for (int j = colBegin; j <= colEnd; j ++) {
                res.push_back(matrix[rowBegin][j]);
            }
            rowBegin++;
            
            // Traverse Down
            for (int j = rowBegin; j <= rowEnd; j ++) {
                res.push_back(matrix[j][colEnd]);
            }
            colEnd--;
            
            if (rowBegin <= rowEnd) {
                // Traverse Left
                for (int j = colEnd; j >= colBegin; j --) {
                    res.push_back(matrix[rowEnd][j]);
                }
            }
            rowEnd--;
            
            if (colBegin <= colEnd) {
                // Traver Up
                for (int j = rowEnd; j >= rowBegin; j --) {
                    res.push_back(matrix[j][colBegin]);
                }
            }
            colBegin ++;
        }
        return res;
    }
    
    ListNode *rotateRight(ListNode *head, int k) {
        if (!head || k<=0){
            return head;
        }

        //find the length of List
        int len=1;
        ListNode *p=head;
        while( p->next != NULL ){
            p = p->next;
            len++;
        }
        //connect the tail to head
        p->next = head;
        //find the left place (take care the case - k > len)
        k = len - k % len;
        
        //find the place
        for(int i=0; i<k; i++){
            p = p->next;
        }
        
        //break the list
        head = p->next;
        p->next = NULL;
        
        return head;
    }
    
    // using C++ STL vector , the code is much easy to read
    int uniquePaths(int m, int n) {
        vector< vector <int> >  dp (n, vector<int>(m, 1));
        for (int row=1; row<n; row++) {
            for (int col=1; col<m; col++) {
                dp[row][col] = dp[row-1][col] + dp[row][col-1];
            }
        }
        return dp[n-1][m-1];
    }
    
    int uniquePathsWithObstacles(vector<vector<int>>& obstacleGrid) {
        size_t row = obstacleGrid.size();
        size_t col = obstacleGrid[0].size();
        vector<vector<unsigned int>>  v (row, vector<unsigned int>(col, 0));
        unsigned int max=0;
        for (int i=0; i<obstacleGrid.size(); i++){
            for (int j=0; j<obstacleGrid[0].size(); j++){
                if(obstacleGrid[i][j] == 1){
                    max = v[i][j] = 0;
                } else {
                    if (i>0 && j>0) {
                        max= v[i][j] = v[i-1][j] + v[i][j-1];
                    }else if(i>0){
                        max = v[i][j] = v[i-1][j];
                    }else if(j>0){
                        max = v[i][j] = v[i][j-1];
                    }else{
                        max = v[i][j] = 1 ;
                    }
                }
            }
        }
        return max;
    }
    
    string addBinary(string a, string b) {
        string s = "";
        
        int c = 0, i = a.size() - 1, j = b.size() - 1;
        while(i >= 0 || j >= 0 || c == 1)
        {
            c += i >= 0 ? a[i --] - '0' : 0;
            c += j >= 0 ? b[j --] - '0' : 0;
            s = char(c % 2 + '0') + s;
            c /= 2;  // c remain the carry
        }
        
        return s;
    }
    
    void setZeroes(vector<vector<int> > &matrix) {
        int bRow = false, bCol=false;
        for (int r=0; r<matrix.size(); r++){
            for(int c=0; c<matrix[r].size(); c++){
                if (matrix[r][c]==0){
                    if (r==0) bRow = true;
                    if (c==0) bCol = true;
                    matrix[0][c] = matrix[r][0] = 0;
                }
            }
        }
        for (int r=1; r<matrix.size(); r++){
            for(int c=1; c<matrix[r].size(); c++){
                if (matrix[0][c]==0 || matrix[r][0]==0) {
                    matrix[r][c]=0;
                }
            }
        }
        if (bRow){
            for(int c=0; c<matrix[0].size(); c++) matrix[0][c] = 0;
        }
        if (bCol){
            for(int r=0; r<matrix.size(); r++) matrix[r][0] = 0;
        }
    }
    
    void sortColors(vector<int>& nums) {
        int second=nums.size()-1, zero=0;
        for (int i=0; i<=second; i++) {
            // use while can make sure if after swap nums[i] == 2,can also swap to second--
            while (nums[i]==2 && i<second) swap(nums[i], nums[second--]);
            while (nums[i]==0 && i>zero) swap(nums[i], nums[zero++]);
        }
    }
    
    vector<vector<int> > combine(int n, int k) {
        vector<vector<int> > result;
        vector<int> solution;
        getCombination(n, k, solution, result);
        return result;
    }
    
    void getCombination(int n, int k, vector<int>& solution, vector< vector<int> >& result ){
        if (k==0){
            //sort to meet LeetCode requirement
            vector<int> v = solution;
            sort(v.begin(), v.end());
            result.push_back(v);
            return;
        }
        for(int i=n; i>0; i--){
            solution.push_back(i);
            getCombination(i-1, k-1, solution, result);
            solution.pop_back();
        }
    }
    /*
    vector<vector<int> > combine(int n, int k) {
        vector<vector<int> > result;
        vector<int> solution;
        getCombination(1, n, k, solution, result);
        return result;
    }

    void getCombination(int start, int n, int k, vector<int> &solution, vector< vector<int> >& result ){
        if (k==0){
            vector<int> v = solution;
            result.push_back(v);
            return;
        }
        for(int i=start; i<=n; i++){
            solution.push_back(i);
            getCombination(i+1,n, k-1, solution, result);
            solution.pop_back();
        }
    }
    */
};

//int main(int argc, const char * argv[]) {
//    
//    Solution slution;
//    
//    int m=3, n=7;
//    
//    printf("uniquePaths=%d\n", slution.uniquePaths(m,n));
//    
//    return 0;
//}



 

