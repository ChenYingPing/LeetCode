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
            if m[another] != nil {
                return [m[another]!, i]
            }
            m[nums[i]] = i
        }
        return []
    }

    // https://leetcode-cn.com/problems/add-two-numbers/
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var head1 = l1
        var head2 = l2
        let result = ListNode(0)
        var n1 = 0
        var n2 = 0
        var carry = 0
        var current = result
        while head1 != nil || head2 != nil || carry != 0 {
            if head1 == nil {
                n1 = 0
            } else {
                n1 = head1!.val
                head1 = head1?.next
            }
            if head2 == nil {
                n2 = 0
            } else {
                n2 = head2!.val
                head2 = head2?.next
            }
            current.next = ListNode((n1 + n2 + carry) % 10)
            current = current.next!
            carry = (n1 + n2 + carry) / 10
        }
        
        return result.next
    }
    
    func duplicate(numbers : inout [Int], length :Int, duplication :inout Int)  -> Bool {
        if numbers.count <= 0 || length <= 0 {
            return false
        }
        
        for i in 0..<numbers.count {
            if numbers[i] < 0 || numbers[i] > length - 1 {
                return false
            }
        }
        
        for i in 0..<numbers.count {
            while numbers[i] != i {
                if numbers[i] == numbers[numbers[i]] {
                    duplication = numbers[i];
                    return true
                }
                
                // swap numbers[i] and numbers[numbers[i]]
                let temp = numbers[i]
                numbers[i] = numbers[temp]
                numbers[temp] = temp
            }
        }
        
        return false
    }
    
    func Find(matrix: [Int], rows :Int, columns :Int, number :Int) -> Bool {
        var found = false
        
        if matrix.count > 0 && rows > 0 && columns > 0 {
            var row = 0
            var column = columns - 1
            while row < rows && column >= 0 {
                if matrix[row * columns + column] == number {
                    found = true
                    break
                }
                else if (matrix[row * column + column] > number) {
                    column -= 1
                }
                else {
                    row += 1
                }
            }
        }
        
        return found;
    }
    
    
}
