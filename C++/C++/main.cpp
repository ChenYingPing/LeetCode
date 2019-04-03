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
};


int main(int argc, const char * argv[]) {
    
    Solution slution;
    
    int m=3, n=7;
    
    return 0;
}
