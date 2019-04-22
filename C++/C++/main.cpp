//
//  main.cpp
//  C++
//
//  Created by 陈应平 on 2019/2/11.
//  Copyright © 2019 陈应平. All rights reserved.
//  https://github.com/haoel/leetcode

#include <iostream>
#include "DataDefine.hpp"

using namespace std;

// 78-
class Solution {
public:
    vector<vector<int>> subsets(vector<int>& nums) {
        vector<vector<int>> subs;
        vector<int> sub;
        subsets(nums, 0, sub, subs);
        return subs;
    }

    void subsets(vector<int>& nums, int start, vector<int>& sub, vector<vector<int>>& subs) {
        subs.push_back(sub);
        for (int j = start; j < nums.size(); j++) {
            sub.push_back(nums[j]);
            subsets(nums, j + 1, sub, subs);
            sub.pop_back();
        }
    }
    
    bool exist(vector<vector<char> > &board, string word) {
        if (board.size()<=0 || word.size()<=0) return false;
        int row = board.size();
        int col = board[0].size();
        for(int i=0; i<board.size(); i++) {
            for(int j=0; j<board[i].size(); j++){
                if ( board[i][j]==word[0]  ){
                    if( exist(board, word, 0, i, j) ){
                        return true;
                    }
                }
            }
        }
        return false;
    }
    
    bool exist(vector<vector<char> > &board, string& word, int idx, int row, int col) {
        if ( row<0 || row>=board.size() ||
            col<0 || col>=board[0].size() ||
            board[row][col] != word[idx]) {
            return false;
        }
        if (idx+1 == word.size()) return true;
        
        //replace to a special char to avoid duplication.
        board[row][col] = '\0';
        
        if ( exist(board, word, idx+1, row+1, col ) ||
            exist(board, word, idx+1, row-1, col ) ||
            exist(board, word, idx+1, row, col+1 ) ||
            exist(board, word, idx+1, row, col-1 ) ) {
            return true;
        }
        //restore the char
        board[row][col] = word[idx];
        
        return false;
    }
    
    bool search(vector<int> &A, int n, int target) {
        int lo =0, hi = n-1;
        int mid = 0;
        while(lo<hi){
            mid=(lo+hi)/2;
            if(A[mid]==target) return true;
            if(A[mid]>A[hi]){
                // maybe in non-rotated array or rotated array
                if(A[mid]>target && A[lo] <= target) hi = mid;
                else lo = mid + 1;
            }else if(A[mid] < A[hi]){
                if(A[mid]<target && A[hi] >= target) lo = mid + 1;
                else hi = mid;
            }else{
                hi--;
            }
            
        }
        return A[lo] == target ? true : false;
    }
    
    ListNode* deleteDuplicates(ListNode* head) {
        if(head==nullptr) return nullptr;
        ListNode FakeHead=ListNode(0);
        FakeHead.next=head;
        ListNode *pre=&FakeHead;
        ListNode *cur=head;
        while(cur!=nullptr){
            while(cur->next!=nullptr&&cur->val==cur->next->val){
                cur=cur->next;
            }
            if(pre->next==cur){
                pre=pre->next;
            }
            else{
                pre->next=cur->next;
            }
            cur=cur->next;
        }
        return FakeHead.next;
    }
    
    int maximalRectangle(vector<vector<char> > &matrix) {
        if(matrix.empty()) return 0;
        const int m = matrix.size();
        const int n = matrix[0].size();
        int left[n], right[n], height[n];
        fill_n(left,n,0); fill_n(right,n,n); fill_n(height,n,0);
        int maxA = 0;
        for(int i=0; i<m; i++) {
            int cur_left=0, cur_right=n;
            for(int j=0; j<n; j++) { // compute height (can do this from either side)
                if(matrix[i][j]=='1') height[j]++;
                else height[j]=0;
            }
            for(int j=0; j<n; j++) { // compute left (from left to right)
                if(matrix[i][j]=='1') left[j]=max(left[j],cur_left);
                else {left[j]=0; cur_left=j+1;}
            }
            // compute right (from right to left)
            for(int j=n-1; j>=0; j--) {
                if(matrix[i][j]=='1') right[j]=min(right[j],cur_right);
                else {right[j]=n; cur_right=j;}
            }
            // compute the area of rectangle (can do this from either side)
            for(int j=0; j<n; j++)
                maxA = max(maxA,(right[j]-left[j])*height[j]);
        }
        return maxA;
    }
    
    //Count[i] = Count[i-1]              if S[i-1] is a valid char (not '0')
    //         = Count[i-1]+ Count[i-2]  if S[i-1] and S[i-2] together is still a valid char (10 to 26).
    int check(char ch){
        //check 0 or not
        return (!isdigit(ch) || ch=='0') ? 0 : 1;
    }
    int check(char ch1, char ch2){
        //check it's between 10 and 26
        return (ch1=='1' || (ch1=='2' && ch2<='6')) ? 1: 0;
    }
    int numDecodings(string s) {
        if (s.size()<=0) return 0;
        if (s.size()==1) return check(s[0]);
        
        int* dp = new int[s.size()];
        memset(dp, 0, s.size()*sizeof(int));
        
        dp[0] = check(s[0]);
        dp[1] = check(s[0]) *  check(s[1]) + check(s[0], s[1]) ;
        for (int i=2; i<s.size(); i++) {
            if (!isdigit(s[i])) break;
            if (check(s[i])) {
                dp[i] = dp[i-1];
            }
            if (check(s[i-1], s[i])) {
                dp[i] += dp[i-2];
            }
            
        }
        int result = dp[s.size()-1];
        delete[] dp;
        return result;
    }
    
    ListNode *reverseBetween(ListNode *head, int m, int n) {
        if(head == NULL || m >= n) return head;
        ListNode dummy(0); // create a dummy node to mark the head of this list
        dummy.next = head;
        ListNode *pre = &dummy; // make a pointer pre as a marker for the node before reversing
        for(int i = 0; i<m-1; i++) pre = pre->next;
        
        ListNode *start = pre->next; // a pointer to the beginning of a sub-list that will be reversed
        ListNode *then = start->next; // a pointer to a node that will be reversed
        
        // 1 - 2 -3 - 4 - 5 ; m=2; n =4 ---> pre = 1, start = 2, then = 3
        // dummy-> 1 -> 2 -> 3 -> 4 -> 5
        
        for(int i=0; i<n-m; i++)
        {
            start->next = then->next;
            then->next = pre->next;
            pre->next = then;
            then = start->next;
        }
        
        // first reversing : dummy->1 - 3 - 2 - 4 - 5; pre = 1, start = 2, then = 4
        // second reversing: dummy->1 - 4 - 3 - 2 - 5; pre = 1, start = 2, then = 5 (finish)
        
        return dummy.next;
    }
    
    ListNode *reverseBetweenII(ListNode *head, int m, int n) {
        if (head==NULL || m>=n) return head;

        ListNode fake(0);
        fake.next = head;
        ListNode *pBegin=&fake, *pEnd=&fake;
        
        int distance = n - m ;
        while(pEnd && distance>0){
            pEnd = pEnd->next;
            distance--;
        }
        while(pBegin && pEnd && m-1>0) {
            pBegin = pBegin->next;
            pEnd = pEnd->next;
            m--;
        }
        if (pBegin==NULL || pEnd==NULL || pEnd->next == NULL){
            return head;
        }
        
        ListNode *p = pBegin->next;
        ListNode *q = pEnd->next->next;
        
        ListNode *pHead = q;
        while(p != q){
            ListNode* node = p->next;
            p->next = pHead;
            pHead = p;
            p = node;
        }
        pBegin->next = pHead;
        
        return fake.next;
    }
 
    void restoreIpAddressesHelper(string& s, int start, int partNum, string ip, vector<string>& result) {
        
        int len = s.size();
        if ( len - start < 4-partNum  || len - start > (4-partNum)*3 ) {
            return;
        }
        
        if (partNum == 4 && start == len){
            ip.erase(ip.end()-1, ip.end());
            result.push_back(ip);
            return;
        }
        
        int num = 0;
        for (int i=start; i<start+3; i++){
            num = num*10 + s[i]-'0';
            if (num<256){
                ip+=s[i];
                restoreIpAddressesHelper(s, i+1, partNum+1, ip+'.', result);
            }
            //0.0.0.0 valid, but 0.1.010.01 is not
            if (num == 0) {
                break;
            }
        }
    }
    
    vector<string> restoreIpAddresses(string s) {
        vector<string> res;
        int len = s.length();
        for(int i = 1; i<4 && i<len-2; i++){
            for(int j = i+1; j<i+4 && j<len-1; j++){
                for(int k = j+1; k<j+4 && k<len; k++){
                    string s1 = s.substr(0,i), s2 = s.substr(i,j-i), s3 = s.substr(j,k-j), s4 = s.substr(k,len-k);
                    if(isValid(s1) && isValid(s2) && isValid(s3) && isValid(s4)){
                        res.push_back(s1+"."+s2+"."+s3+"."+s4);
                    }
                }
            }
        }
        return res;
    }
    bool isValid(string s){
        if(s.length()>3 || s.length()==0 || (s[0]=='0' && s.length()>1) || atoi(s.c_str())>255)
            return false;
        return true;
    }
    
    vector<string> restoreIpAddressesII(string s) {
        vector<string> ret;
        string ans;
        for (int a=1; a<=3; a++)
            for (int b=1; b<=3; b++)
                for (int c=1; c<=3; c++)
                    for (int d=1; d<=3; d++)
                        if (a+b+c+d == s.length()) {
                            int A = stoi(s.substr(0, a));
                            int B = stoi(s.substr(a, b));
                            int C = stoi(s.substr(a+b, c));
                            int D = stoi(s.substr(a+b+c, d));
                            if (A<=255 && B<=255 && C<=255 && D<=255)
                                if ( (ans=to_string(A)+"."+to_string(B)+"."+to_string(C)+"."+to_string(D)).length() == s.length()+3)
                                    ret.push_back(ans);
                        }
        
        return ret;
    }
    
    vector<int> inorderTraversal(TreeNode *root) {
        vector<TreeNode*> stack;
        vector<int> v;
        
        while(stack.size()>0 || root!=NULL){
            if (root!=NULL){
                stack.push_back(root);
                root = root->left;
            }else{
                if (stack.size()>0) {
                    root = stack.back();
                    stack.pop_back();
                    v.push_back(root->val);
                    root = root->right;
                }
            }
        }
        return v;
    }
    
    vector<TreeNode*> generateTrees(int n) {
        vector<TreeNode*> v;
        v = generateTrees(1, n);
        return v;
    }
    vector<TreeNode*> generateTrees(int low, int high){
        vector<TreeNode*> v;
        if (low > high || low<=0 || high<=0){
            v.push_back(NULL);
            return v;
        }
        if (low==high){
            TreeNode* node = new TreeNode(low);
            v.push_back(node);
            return v;
        }
        for (int i=low; i <= high; i++){
            vector<TreeNode*> vleft = generateTrees(low, i-1);
            vector<TreeNode*> vright = generateTrees(i+1, high);
            for (int l=0; l<vleft.size(); l++){
                for (int r=0; r<vright.size(); r++){
                    TreeNode *root = new TreeNode(i);
                    root->left = vleft[l];
                    root->right = vright[r];
                    v.push_back(root);
                }
            }
        }
        return v;
    }
    
    //Dynamic Programming
    bool isInterleave(string s1, string s2, string s3) {
        if (s1.size() + s2.size() != s3.size()) {
            return false;
        }
        vector< vector<int> > match(s1.size()+1, vector<int>(s2.size()+1, false) );
        match[0][0] = true;
        for(int i=1; i<=s1.size(); i++) {
            if (s1[i-1] == s3[i-1] ) {
                match[i][0] = true;
            }else{
                break;
            }
        }
        for(int i=1; i<=s2.size(); i++) {
            if (s2[i-1] == s3[i-1] ) {
                match[0][i] = true;
            }else{
                break;
            }
        }
        for(int i=1; i<=s1.size(); i++) {
            for(int j=1; j<=s2.size(); j++) {
                if (s1[i-1] == s3[i+j-1]) {
                    match[i][j] = match[i-1][j] || match[i][j];
                }
                if (s2[j-1] == s3[i+j-1]) {
                    match[i][j] = match[i][j-1] || match[i][j];
                }
            }
        }
        return match[s1.size()][s2.size()];
    }

};


int main(int argc, const char * argv[]) {
    
    Solution slution;
    
    vector<string> res = slution.restoreIpAddresses("25525511135");
    
    
    return 0;
}
