//
//  Hundred.swift
//  LeetCode
//
//  Created by Chen on 16/5/23.
//  Copyright © 2016年 ChenYingPing. All rights reserved.
//

import UIKit

class Hundred: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        let tree = ListNode(3)
        tree.next = ListNode(2)
        tree.next?.next = ListNode(4)
    }
    // MARK: - leetCode NO.129
    func sumNumbers(root: TreeNode?) -> Int {
        var arr: [Int] = []
        sumNumbersting(&arr,root: root ,sum:"")
        var res = 0
        for num in arr {
            res += num
        }
        return res
    }
    func sumNumbersting(inout arr: [Int], root: TreeNode?, sum: String) {
        if root == nil { return }
        var sum = sum
        sum += String(root!.val)
        if root?.left != nil {
             sumNumbersting(&arr, root: root?.left, sum: sum)
        }
        if root?.right != nil {
            sumNumbersting(&arr, root:root?.right, sum: sum)
        }
        if root?.left == nil && root?.right == nil {  // 叶子节点
            arr.append(Int(sum)!)
        }
    }
    // MARK: - leetCode NO.130
    func solve(inout board: [[Character]]) {
        let row = board.count
        if(row == 0) { return }
        let col = board[0].count   // 从数组四周字符为O的节点开始衍生，寻找周围也为O的节点，更改字符为1
        for i in 0 ..< row {  // 遍历数组第一行的数据
            check(&board,i: i,j: 0,row: row,col: col)
            if(col>1) {  // 遍历数组最后一列的数据
                check(&board,i: i,j: col-1,row: row,col: col)
            }
        }
        for j in 0 ..< col {  // 遍历数组第一列的数组
            check(&board,i: 0,j: j,row: row,col: col)
            if(row > 1) { // 遍历数组最后一行的数据
                check(&board,i: row-1,j: j,row: row,col: col)
            }
        }
        for i in 0 ..< row {
            for j in 0 ..< col {
                if(board[i][j] == Character.init("O")) { // 遍历数组，把为“O”的字符改为"X"
                    board[i][j] = Character.init("X")
                }
            }
        }
        for i in 0 ..< row {  // 遍历数组，把为“1”的字符改为O
            for j in 0 ..< col {
                if(board[i][j] == Character.init("1")) {
                    board[i][j] = Character.init("O")
                }
            }
        }
    }
    func check(inout vec: [[Character]], i: Int, j: Int, row: Int, col: Int){
        if(vec[i][j] == Character.init("O")){  // 如果当前字符为O，则把它改为1，并且寻找它边上为O的字符也改为1，一直递归到找不到字符为O的位置。
            // 因为原来的字符已经改为1了，所以该函数并不会无限循环
            vec[i][j] = Character.init("1")
            if(i > 1) {
                check(&vec,i: i-1,j: j,row: row,col: col)
            }
            if(j > 1) {
                check(&vec,i: i,j: j-1,row: row,col: col)
            }
            if(i+1 < row) {
                check(&vec,i: i+1,j: j,row: row,col: col)
            }
            if(j+1 < col) {
                check(&vec,i: i,j: j+1,row: row,col: col)
            }
        }
    }
    // MARK: - leetCode NO.131
    func partition(s: String) -> [[String]] {  // 用回溯法实现
        //https://leetcode.com/discuss/18984/java-backtracking-solution
        var res: [[String]] = []
        return res
    }
    // MARK: - leetCode NO.135
    func candy(ratings: [Int]) -> Int {
        if ratings.count <= 1 {
            return ratings.count
        }
        var arr = Array.init(count: ratings.count, repeatedValue: 1)
        for i in 1 ..< ratings.count {
            if ratings[i] > ratings[i-1] {  // 后面的比之前的大
                arr[i] = arr[i-1] + 1
            }
        }
        for (var i = ratings.count-1; i > 0; i -= 1) {
            if(ratings[i-1] > ratings[i]) {  // 前面的比后面的大
                arr[i-1] = max(arr[i]+1,arr[i-1])
            }
        }
        return arr.reduce(0, combine: {
            $0 + $1
        })
    }
    // MARK: - leetCode NO.136
    func singleNumber(nums: [Int]) -> Int {
        // swift也能用 异或 真是太屌了  相同为0 不同为1
        var result = 0
        for i in 0 ..< nums.count
        {
            result ^= nums[i]
        }
        return result
    }
    // MARK: - leetCode NO.137
    func singleNumberII(nums: [Int]) -> Int {
//        let nums = nums.sort()
//        for (var i = 0 i < nums.count - 1 i+=3) {
//            if nums[i] != nums[i+1] || nums[i] != nums[i+2] {
//                return nums[i]
//            }
//        }
//        return nums.last ?? 0
        var ones = 0
        var twos = 0
        for i in 0 ..< nums.count {
            ones = (ones ^ nums[i]) & ~twos
            twos = (twos ^ nums[i]) & ~ones
        }
        return ones
    }
    // MARK: - leetCode NO.144
//    var resArr: [Int] = []
    func preorderTraversal(root: TreeNode?) -> [Int] {
//        if root == nil {  // 递归的做法
//            return []
//        }
//        resArr.append(root!.val)
//        preorderTraversal(root?.left)
//        preorderTraversal(root?.right)
//        return resArr
        var root = root  // 非递归
        var resArr: [Int] = []
        var tempArr: [TreeNode] = []
        while root != nil {
            resArr.append(root!.val)
            if root?.right != nil {
                tempArr.append(root!.right!)
            }
            root = root?.left
            if root == nil && !tempArr.isEmpty {
                root = tempArr.popLast()
            }
        }
        return resArr
    }
    // MARK: - leetCode NO.145   后续遍历
//    var resArr: [Int] = []
    func postorderTraversal(root: TreeNode?) -> [Int] {
//        if root == nil {  // 递归的做法
//            return []
//        }
//        postorderTraversal(root?.left)
//        postorderTraversal(root?.right)
//        resArr.append(root!.val)
//        return resArr
        if root == nil { return [] }
        var stack: [TreeNode] = []
        var resArr: [Int] = []
        stack.append(root!)
        while !stack.isEmpty {
            let node = stack.popLast()
            resArr.append(node!.val)
            if node?.left != nil {
                stack.append(node!.left!)
            }
            if node?.right != nil {
                stack.append(node!.right!)
            }
        }
        return resArr.reverse()
    }
    // MARK: - leetCode NO.147  插入排序
    func insertionSortListII(head: ListNode?) -> ListNode? {
        var head = head
        var arr: [Int] = []
        while head != nil {
            arr.append(head!.val)
            head = head?.next
        }
        arr.sortInPlace()
        var result = ListNode(0)
        let pre = result
        for val in arr {
            let node = ListNode(val)
            result.next = node
            result = result.next!
        }
        return pre.next
    }

    func insertionSortList(head: ListNode?) -> ListNode? {
        if( head == nil ){
            return head
        }
        let helper = ListNode(0) //new starter of the sorted list
        var cur = head   //the node will be inserted
        var pre = helper //insert node between pre and pre.next
        var next: ListNode? //the next node will be inserted
        //not the end of input list
        while( cur != nil ){
            next = cur!.next
            //find the right place to insert
            while( pre.next != nil && pre.next!.val < cur!.val ){
                pre = pre.next!
            }
            //insert between pre and pre.next
            cur!.next = pre.next
            pre.next = cur
            pre = helper
            cur = next
        }
        
        return helper.next
    }
    // MARK: - leetCode NO.148
    func sortList(head: ListNode?) -> ListNode? {  // 快速排序是最好的吧
        var head = head
        var arr: [Int] = []
        while head != nil {
            arr.append(head!.val)
            head = head?.next
        }
        arr.sortInPlace()
        var result = ListNode(0)
        let pre = result
        for val in arr {
            let node = ListNode(val)
            result.next = node
            result = result.next!
        }
        return pre.next
    }
    // MARK: - leetCode NO.150
    func evalRPN(tokens: [String]) -> Int {
        var numArr: [Int] = []
        for char in tokens {
            switch char {
            case "+":
                if numArr.count < 2 { break }
                let num1 = numArr.popLast()
                let num2 = numArr.popLast()
                let sum = num2! + num1!
                numArr.append(sum)
            case "-":
                if numArr.count < 2 { break }
                let num1 = numArr.popLast()
                let num2 = numArr.popLast()
                let sum = num2! - num1!
                numArr.append(sum)
            case "*":
                if numArr.count < 2 { break }
                let num1 = numArr.popLast()
                let num2 = numArr.popLast()
                let sum = num2! * num1!
                numArr.append(sum)
            case "/":
                if numArr.count < 2 { break }
                let num1 = numArr.popLast()
                let num2 = numArr.popLast()
                let sum = num2! / num1!
                numArr.append(sum)
            default:
                numArr.append(Int(char)!)
            }
        }
        return numArr.popLast() ?? 0
    }
     // MARK: - leetCode NO.152  DP
    func maxProduct(nums: [Int]) -> Int {
        if (nums.count == 0) {
            return 0
        }
        var maxherepre = nums[0]
        var minherepre = nums[0]
        var maxsofar = nums[0]
        var maxhere = 0
        var minhere = 0
        for i in 1 ..< nums.count {
            maxhere = max(max(maxherepre * nums[i], minherepre * nums[i]), nums[i])
            minhere = min(min(maxherepre * nums[i], minherepre * nums[i]), nums[i])
            maxsofar = max(maxhere, maxsofar)
            maxherepre = maxhere
            minherepre = minhere
        }
        return maxsofar
    }
    // MARK: - leetCode NO.164  桶排序
    /*
     http://www.cnblogs.com/Vae1990Silence/p/4280693.html
     假设桶的个数和元素的数目相同，若是平均分布，则每个桶里有一个数，而若某个桶里有两个以上的数时，这时必有至少一个是空桶，那么最大间隔可能就落在空桶的相邻两个桶存储的数之间，最大间隔不会落在同一个桶的数里，因此我们不需要对每个桶再排一次序，只需要记录同一个桶的最大值和最小值，算出前一个有最大值的桶和后一个有最小值的桶之差，则可能是最大间隔
     */
    func maximumGap(nums: [Int]) -> Int {
//        if (nums.count < 2) { return 0 }   
//        var nums = nums.sort()
//        var ret = 0
//        for i in 1 ..< nums.count {
//            ret = max(ret, nums[i]-nums[i-1]);
//        }
//        return ret
        if nums.count < 2 { return 0 }
        var minNum = nums[0]
        var maxNum = nums[0]
        for i in nums {
            minNum = min(minNum, i)
            maxNum = max(maxNum, i)
        }
        let gap = Double(maxNum - minNum) / Double(nums.count - 1)  // 数组里的数平均的间距
        var bucketsMIN = Array.init(count: nums.count - 1, repeatedValue: Int.max)
        var bucketsMAX = Array.init(count: nums.count - 1, repeatedValue: Int.min)
        for i in nums {
            if i == minNum || i == maxNum { continue }
            let idx = Int(Double(i - minNum) / gap)  // 求出i在排序后的数组中的位置
            bucketsMIN[idx] = min(i, bucketsMIN[idx])
            bucketsMAX[idx] = max(i, bucketsMAX[idx])
        }
        var maxGap = Int.min
        var previous = minNum
        for i in 0 ..< nums.count - 1 {
            if bucketsMIN[i] == Int.max && bucketsMAX[i] == Int.min {  // 空桶，没有一个值
                continue
            }
            maxGap = max(maxGap, bucketsMIN[i] - previous)
            previous = bucketsMAX[i]
        }
        return max(maxGap, maxNum - previous)
    }
    // MARK: - leetCode NO.165
    func compareVersion(version1: String, _ version2: String) -> Int {
        if version1 == version2 { return 0 }
        let nums1 = version1.componentsSeparatedByString(".")
        let nums2 = version2.componentsSeparatedByString(".")
        for i in 0 ..< min(nums1.count, nums2.count) {
            if Int(nums1[i]) > Int(nums2[i]) {
                return 1
            } else if Int(nums1[i]) < Int(nums2[i]) {
                return -1
            }
        }
        let differ = abs(nums2.count-nums1.count)
        var nums = nums1.count > nums2.count ? nums1 : nums2
        for i in nums.count-differ ..< nums.count {
            if Int(nums[i]) > 0 {
                return nums1.count > nums2.count ? 1 : -1
            }
        }
        return 0
    }
    // MARK: - leetCode NO.166
    func fractionToDecimal(numerator: Int, _ denominator: Int) -> String {
//        if numerator == 0 {
//            return "0"
//        }
//        var res = ""
//        res.stringByAppendingString(((numerator > 0 ? 1 : 0)^(denominator > 0 ? 1: 0)) == 0 ? "-":"")
        return ""
    }
    // MARK: - leetCode NO.168
    var strs = ["A","B","C","D","E","F","G","H","I","j","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    func convertToTitle(n: Int) -> String {
        var n = n
        return n == 0 ? "" : convertToTitle(--n / 26) + strs[n % 26]
    }
    // MARK: - leetCode NO.169
    func majorityElement(nums: [Int]) -> Int {
        var map: [Int : Int] = [:]
        for num in nums {
            if map[num] != nil {
                map[num]! += 1
                if map[num] > nums.count / 2 {
                    return num
                }
            } else {
                map[num] = 1
            }
        }
        return nums[0]
    }
    // MARK: - leetCode NO.171
    func titleToNumber(s: String) -> Int {
        var result = 0
        for char in s.characters {  // 操作swift的字符真是太麻烦了
//            result = result * 26 + (char - Character("A") + 1)
        }
        return result
    }
    // MARK: - leetCode NO.174
    func calculateMinimumHP(dungeon: [[Int]]) -> Int {
        if dungeon.count == 0 || dungeon.first == nil {
            return 0
        }
        let rows = dungeon.count
        let cols = dungeon.first!.count
        let colsArr = Array.init(count: cols, repeatedValue: 0)
        var dp = Array.init(count: rows, repeatedValue: colsArr)
        for (var i = rows - 1; i >= 0; i -= 1) {
            for (var j = cols - 1; j >= 0; j -= 1) {
                if i == rows - 1 && j == cols - 1 {
                    dp[i][j] = max(1, 1-dungeon[i][j])
                } else if j == cols - 1 {
                    dp[i][j] = max(1, dp[i+1][j]-dungeon[i][j])
                } else if i == rows - 1 {
                    dp[i][j] = max(1, dp[i][j+1]-dungeon[i][j])
                } else {
                    dp[i][j] = max(1, min(dp[i+1][j]-dungeon[i][j], dp[i][j+1]-dungeon[i][j]))
                }
            }
        }
        return dp[0][0]
    }
}

