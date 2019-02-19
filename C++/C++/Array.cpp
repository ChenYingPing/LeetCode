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

};

int main(int argc, const char * argv[]) {
    // insert code here...
//    std::cout << "Hello, World!dfdsfads\n";
    vector<int> nums = {2, 7, 11, 15};
    Solution solu;
    vector<int> result = solu.twoSum(nums, 22);
    
    return 0;
}



 

