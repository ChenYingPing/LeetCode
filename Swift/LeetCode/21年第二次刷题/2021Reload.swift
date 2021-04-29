//
//  2021Reload.swift
//  LeetCode
//
//  Created by apiao on 2021/4/17.
//  Copyright © 2021 ChenYingPing. All rights reserved.
//

import UIKit

class ReloadLeetcode: UIViewController
{
    
    internal class Interval {
        internal var start: Int
        internal var end: Int
        internal init(_ start: Int, _ end: Int) {
            self.start = start
            self.end = end
        }
    }
    
    internal class ListNode {
        internal var val: Int
        internal var next: ListNode?
        internal init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    internal class TreeNode {
        internal var val: Int
        internal var left: TreeNode?
        internal var right: TreeNode?
        internal init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    // MARK: - Array
    // No.1 Two Sum https://leetcode.com/problems/two-sum/
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var m = [Int: Int]()
        for i in 0..<nums.count {
            let another = target - nums[i]
            if (m[another] != nil) {
                return [m[another]!, i]
            }
            m[nums[i]] = i
        }
        return []
    }

}
