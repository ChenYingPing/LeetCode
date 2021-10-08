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
        internal var parent: TreeNode?
        internal init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
            self.parent = nil
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
    
    func GetNext(pNode :TreeNode?) -> TreeNode? {
        if (pNode == nil) {
            return nil;
        }
        
        var pNext:TreeNode? = nil;
        if ((pNode?.right) != nil) {
            var pRight = pNode?.right
            while pRight?.left != nil {
                pRight = pRight?.left
            }
            pNext = pRight
        }
        else if (pNode?.parent != nil) {
            var pCurrent = pNode
            var pParent = pNode?.parent
            while (parent != nil && pCurrent?.val == pParent?.right?.val) {
                pCurrent = pParent
                pParent = pParent?.parent
            }
            
            pNext = pParent
        }
        
        return pNext;
    }
    
    func Fibonacci(n :Int) -> Int {
        var fibN = 0
        let result = [0,1]
        if n < 2 {
            return result[n]
        }
        var fibNMinusOne = 1
        var fibNMinusTwo = 0
        for _ in 2...n {
            fibN = fibNMinusOne + fibNMinusTwo
            fibNMinusTwo = fibNMinusOne
            fibNMinusOne = fibN
        }
        
        return fibN
    }
    
    func SortAges( ages :inout [Int], length :Int) {
        if ages.count <= 0 || length <= 0 {
            return
        }
        let oldestAge = 99
        var timesOfAge = [Int]()
        
        for i in 0...oldestAge {
            timesOfAge[i] = 0
        }
        
        for i in 0..<length {
            let age = ages[i]
            if age < 0 || age > oldestAge {
                return
            }
            timesOfAge[age] += 1
        }
        
        var index = 0
        for i in 0...oldestAge {
            for _ in 0..<timesOfAge[i] {
                ages[index] = i
                index += 1
            }
        }
    }
    
    func Minxxx(numbers :[Int], length :Int) -> Int {
        if numbers.count <= 0 || length <= 0  {
            return -1
        }
        
        var index1 = 0
        var index2 = length - 1
        var indexMid = index1
        while numbers[index1] >= numbers[index2] {
            if index2 - index1 == 1 {
                indexMid = index2
                break
            }
            indexMid = (index1 + index2) / 2
            // 如果下标为 index1、index2 和 indexMid 指向的三个数字相等
            // 则只能顺序查找
            if numbers[index1] == numbers[index2] && numbers[indexMid] == numbers[index1] {
                return -111 // 顺序查找的结果
            }
            
            if numbers[indexMid] >= numbers[index1] {
                index1 = indexMid
            } else if numbers[indexMid] <= numbers[index2] {
                index2 = indexMid
            }
        }
        
        return numbers[indexMid]
    }
    
    func movingCount(threshold :Int, rows :Int, cols :Int) -> Int {
        if threshold < 0 || rows <= 0 || cols <= 0 {
            return 0
        }
        var visited = [Bool]()
        for i in 0..<(rows*cols) {
            visited[i] = false
        }
        
        let count = movingCountCore(threshold: threshold, rows: rows, cols: cols, row: 0, col: 0, visited: &visited)
        
        return count
        
    }
    
    func movingCountCore(threshold :Int, rows :Int, cols :Int, row :Int, col :Int,  visited: inout [Bool]) -> Int {
        var count = 0
        if check(threshold: threshold, rows: rows, cols: cols, row: row, col: col, visited: visited) {
            visited[row*cols + col] = true
            count = 1 + movingCountCore(threshold: threshold, rows: rows, cols: cols, row: row, col: col, visited: &visited) + movingCountCore(threshold: threshold, rows: rows, cols: cols, row: row, col: col, visited: &visited) + movingCountCore(threshold: threshold, rows: rows, cols: cols, row: row, col: col, visited: &visited) + movingCountCore(threshold: threshold, rows: rows, cols: cols, row: row , col: col+1, visited: &visited)
        }
        return count
    }
    
    func check(threshold: Int, rows: Int, cols: Int, row :Int, col :Int, visited :[Bool]) -> Bool {
        var row = row
        var col = col
        if row >= 0 && row < rows && col >= 0 && col < cols && getDigitSum(number: &row) + getDigitSum(number: &col) <= threshold && !visited[row*cols+col] {
            return true
        }
        return false
    }
    
    func getDigitSum(number: inout Int) -> Int {
        var sum = 0
        while number > 0 {
            sum += number % 10
            number /= 10
        }
        
        return sum
    }
}
