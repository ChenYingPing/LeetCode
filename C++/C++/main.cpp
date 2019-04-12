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
};


int main(int argc, const char * argv[]) {
    
    Solution slution;
    
    int m=3, n=7;
    
    return 0;
}
