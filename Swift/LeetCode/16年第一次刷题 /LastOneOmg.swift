//
//  LastOneOmg.swift
//  LeetCode
//
//  Created by Chen on 16/6/1.
//  Copyright © 2016年 ChenYingPing. All rights reserved.
//

import UIKit

class LastOneOmg: UIViewController
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
        print(rob(nums: [2,1,1,2]))
    }
    
    // MARK: - leetcode NO.188
    //    func maxProfit(k: Int, _ prices: [Int]) -> Int {
    //
    //    }
    
    // MARK: - leetcode NO.189
    
    func rotate( nums: inout [Int], _ k: Int) {
        //        let m = nums.count
        //        let k = k % m
        //        for _ in 0 ..< k {
        //            nums.insert(0, atIndex: 0)
        //        }
        //        for i in 0 ..< k {
        //            nums[i] = nums[m+i]
        //        }
        //        for _ in 0 ..< k {
        //           nums.removeLast()
        //        }
        if nums.count == 0 { return }
        let m = nums.count
        var k = k % m
        while k > 0 {
            let num = nums.popLast()
            nums.insert(num!, at: 0)
            k -= 1
        }
    }
    
    // MARK: - leetcode NO.198
    /*
     func rob(nums: [Int]) -> Int {  // 使用回溯法会超时，虽然是正确的
     var res = 0
     for i in 0 ..< nums.count {
     reverse(nums, start: i, res: &res, sum: 0)
     }
     return res
     }
     func reverse(nums: [Int], start: Int, inout res: Int, sum: Int) {
     var sum = sum
     let rober = start + 2
     sum += nums[start]
     if rober >= nums.count {
     if sum > res {
     res = sum
     }
     return
     }
     for i in rober ..< nums.count {
     reverse(nums, start: i, res: &res, sum: sum)
     }
     } */
    func rob(nums: [Int]) -> Int {
        var a = 0
        var b = 0
        for i in 0 ..< nums.count
        {
            if (i%2==0) {
                a = max(a+nums[i], b)
            } else {
                b = max(a, b+nums[i])
            }
        }
        return max(a, b)
    }
    
    // MARK: - leetcode NO.199
    
    func rightSideView(root: TreeNode?) -> [Int] {
        var res: [Int] = []
        rightView(root: root, res: &res, level: 0)
        return res
    }
    
    func rightView(root: TreeNode?, res: inout [Int], level: Int) {
        if root == nil {
            return
        }
        if level == res.count {  // 说明这一层是新的一层，否则则是已经有数字被看到了
            res.append(root!.val)
        }
        rightView(root: root?.right, res: &res, level: level+1)
        rightView(root: root?.left, res: &res, level: level+1)
    }
    
    // MARK: - leetcode NO.200
    
    func numIslands(grid: [[Character]]) -> Int {
        if grid.count == 0 || grid.first == nil { return 0 }
        let m = grid.count
        let n = grid.first!.count
        var res = 0
        var grid = grid
        for i in 0 ..< m {
            for j in 0 ..< n {
                if grid[i][j] == Character.init("1") {
                    checkGrid(grid: &grid, i: i, j: j)
                    res += 1
                }
            }
        }
        return res
    }
    
    func  checkGrid( grid: inout [[Character]], i: Int, j: Int) {
        let m = grid.count
        let n = grid.first!.count
        if i < 0 || i >= m || j < 0 || j >= n { return }
        if grid[i][j] != Character.init("1") { return }
        grid[i][j] = Character("0")
        checkGrid(grid: &grid, i: i+1, j: j)
        checkGrid(grid: &grid, i: i, j: j+1)
        checkGrid(grid: &grid, i: i-1, j: j)
        checkGrid(grid: &grid, i: i, j: j-1)
    }
    
    // MARK: - leetcode NO.202
    
    func isHappy(n: Int) -> Bool {  // 这题在leetcode上discuss里有更好的解法
        var sum = Helper(n: n)
        var map: [Int: Bool] = [:]
        while sum != 1 {
            if map[sum] != nil {
                return false
            }
            map[sum] = true
            sum = Helper(n: sum)
        }
        return true
    }
    
    func Helper(n: Int) -> Int
    {   // sum of the squares of its digits
        var n = n
        var ret = 0;
        while n != 0 {
            let digit = n % 10
            n /= 10;
            ret += digit*digit
        }
        return ret;
    }
    
    // MARK: - leetcode NO.203
    
    func removeElements(head: ListNode?, _ val: Int) -> ListNode? {
        var head = head
        var res = ListNode(0)
        let pre = res
        while head != nil {
            if head?.val != val {
                let node = ListNode(head!.val)
                res.next = node
                res = res.next!
            }
            head = head?.next
        }
        return pre.next
    }
    
    func reverseList(head: ListNode?) -> ListNode? {
        var head = head
        var res = ListNode(0)
        while head != nil {
            let node = ListNode(head!.val)
            node.next = res.next
            res = node
            head = head?.next
        }
        return res.next
    }
    
    // MARK: - leetcode NO.207 拓扑排序 判断图中图中是否含有环
    
    func canFinish(numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        //        https://leetcode.com/discuss/35578/easy-bfs-topological-sort-java
        return false
    }
    
    // MARK: - leetcode NO.209
    
    func minSubArrayLen(s: Int, _ nums: [Int]) -> Int {
        if (nums.count == 0) { return 0 }
        var i = 0, j = 0, sum = 0, minValue = Int.max
        while (j < nums.count) {
//            sum += nums[j++]
//            while (sum >= s) { // perfect
//                minValue = min(minValue, j - i)
//                sum -= nums[i++]
//            }
        }
        return minValue == Int.max ? 0 : minValue
    }
    // MARK: - leetcode NO.212
//    func findWords(board: [[Character]], _ words: [String]) -> [String] {
//        
//    }
}
