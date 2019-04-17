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
};


int main(int argc, const char * argv[]) {
    
    Solution slution;
    
    int m=3, n=7;
    
    return 0;
}
