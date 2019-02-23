//
//  Array.cpp
//  C++
//
//  Created by 陈应平 on 2019/2/12.
//  Copyright © 2019 陈应平. All rights reserved.
//

#include <iostream>
#include "DataDefine.hpp"

using namespace std;


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

};

int main(int argc, const char * argv[]) {
    
    Solution slution;
    string str = "Hello, Worldd";
    string result = slution.convert(str, 3);
    
    
    return 0;
}



 

