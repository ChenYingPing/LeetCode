//
//  lifeCycle.swift
//  LeetCode
//
//  Created by Chen on 16/5/12.
//  Copyright © 2016年 ChenYingPing. All rights reserved.
//

import UIKit

class lifeCycle: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let layer = CALayer()   // swift的array的拷贝是深拷贝。array里的元素都是值类型的
        var arr = [layer,2,3];
        let arrcopy = arr
        arr[0] = 0
        print(arr)
        print(arrcopy)
        print(unsafeAddressOf(arr[0]))
        print(unsafeAddressOf(arrcopy[0]))
        */
    }
    // MARK: - leetCode NO.89
    func grayCode(n: Int) -> [Int] {
        var arr: [Int] = []
        arr.append(0)
        for i in 0 ..< n{
            let inc = 1<<i
            for(var j=arr.count-1;j>=0;j -= 1){
                arr.append(arr[j]+inc)
            }
        }
        return arr
        
    }
    // MARK: - leetCode NO.90
    func subsetsWithDup(nums: [Int]) -> [[Int]] { // 并没有去除重复
        var res: [[Int]] = []
        res.append([])
        subSet(&res, nums: nums.sort(),i: 0)
        return res
    }
    var tempArr: [Int] = []
    func subSet(inout res:[[Int]], nums: [Int], i: Int) {
        if i == nums.count { return }
        for i in i ..< nums.count {
            tempArr.append(nums[i])
            res.append(tempArr)
            subSet(&res, nums: nums, i: i+1)
            tempArr.removeLast()
        }
    }
    // MARK: - leetCode NO.94  树的中序遍历 左->根->右
    var count: [Int] = []
    func inorderTraversal(root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        if root?.left != nil {
            inorderTraversal(root?.left)
        }
        count.append(root!.val)
        if root?.right != nil {
            inorderTraversal(root?.right)
        }
        return count
    }
    // MARK: - leetCode NO.98
    func isValidBST(root: TreeNode?) -> Bool {
        let resArr = inorderTraversal(root)
        var minNum = Int.min
        for res in resArr {
            if res > minNum {
                minNum = res
            } else {
                return false
            }
        }
        return true
    }
    // MARK: - leetCode NO.95
    func generateTrees(n: Int) -> [TreeNode?] {
        if n == 0 { return [] }
        return generateTrees(1, end: n)
    }
    func generateTrees(start: Int, end: Int) -> [TreeNode?] {
        var list: [TreeNode?] = []
        if start > end {
            list.append(nil)
            return list
        }
        if start == end {
            list.append(TreeNode(start))
            return list
        }
        var left: [TreeNode?]
        var right: [TreeNode?]
        for i in start ... end {
            left = generateTrees(start, end: i-1)
            right = generateTrees(i+1, end: end)
            for lnode in left {
                for rnode in right {
                    let root = TreeNode(i)
                    root.left = lnode
                    root.right = rnode
                    list.append(root)
                }
            }
        }
        
        return list
    }
    // MARK: - leetCode NO.99
    var firstElement: TreeNode?
    var secondElement: TreeNode?
    var preElement: TreeNode? = TreeNode(Int.min)
    func recoverTree(root: TreeNode?) {  // 根本就是中序遍历
        traverse(root)
        let temp = firstElement?.val
        if secondElement != nil { firstElement?.val = secondElement!.val }
        if firstElement != nil { secondElement?.val = temp! }
    }
    func traverse(root: TreeNode?) {
        if root == nil { return }
        traverse(root?.left)
        if firstElement == nil &&  preElement!.val >= root?.val {
            firstElement = preElement
        }
        if firstElement != nil && preElement!.val >= root?.val {
            secondElement = root
        }
        preElement = root
        traverse(root?.right)
    }
    // MARK: - leetCode NO.103  层序遍历
    func zigzagLevelOrder(root: TreeNode?) -> [[Int]] {
        var sol: [[Int]] = []
        travel(root, sol: &sol, level: 0)
        return sol
    }
    func travel(curr: TreeNode?, inout sol: [[Int]], level: Int) {
        if curr == nil { return }
        if sol.count <= level {
            let newLevel: [Int] = []
            sol.append(newLevel)
        }
        var collection = sol[level]  // 取出大数组中的数组
        if level % 2 == 0 {
            collection.append(curr!.val)
        } else {
            collection.insert(curr!.val, atIndex: 0)
        }
        sol[level] = collection  // 比java的实现要多出这一步，因为java取出的应该是地址
        travel(curr?.left, sol: &sol, level: level + 1)
        travel(curr?.right, sol: &sol, level: level + 1)
    }
    // MARK: - leetCode NO.105  
    func buildTree(preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        // 根据前序遍历和中序遍历的结果画出这棵树
        return helper(0, inStart: 0, inEnd: inorder.count-1, preorder: preorder, inorder: inorder)
    }
    func helper(preStart: Int, inStart: Int, inEnd: Int, preorder: [Int], inorder: [Int]) -> TreeNode? {
        if preStart > preorder.count - 1 || inStart > inEnd {
            return nil
        }
        let root = TreeNode(preorder[preStart])
        var inIndex = 0
        for i in inStart ... inEnd {
            if inorder[i] == root.val {
                inIndex = i
            }
        }
        root.left = helper(preStart + 1, inStart: inStart, inEnd: inIndex - 1, preorder: preorder, inorder: inorder)
        root.right = helper(preStart + inIndex - inStart + 1, inStart: inIndex + 1, inEnd: inEnd, preorder: preorder, inorder: inorder)
        return root
    }
    
    // MARK: - leetCode NO.108  高度平衡二叉树
    func sortedArrayToBST(nums: [Int]) -> TreeNode? {
        if nums.count == 0 { return nil }
        let mid = nums.count / 2
        let root = TreeNode(nums[mid])
        var leftArr: [Int] = []
        for i in 0 ..< mid {
            leftArr.append(nums[i])
        }
        root.left = sortedArrayToBST(leftArr)
        var rightArr: [Int] = []
        for i in mid+1 ..< nums.count {
            rightArr.append(nums[i])
        }
        root.right = sortedArrayToBST(rightArr)
        return root
    }
    
    // MARK: - leetCode NO.109
    func sortedListToBST(head: ListNode?) -> TreeNode? {
        var myhead = head
        var nums: [Int] = []
        while myhead != nil {
            nums.append(myhead!.val)
            myhead = myhead?.next
        }
        return sortedArrayToBST(nums)
    }
    
    // MARK: - leetCode NO.112
    func hasPathSum(root: TreeNode?, _ sum: Int) -> Bool {
        if root == nil {
            return false
        }
        if sum == root!.val && root?.left == nil && root?.right == nil {  // 一定是叶子节点
            return true
        }
        // 分治算法，分解成小的问题去解决
        return hasPathSum(root?.left, sum - root!.val) || hasPathSum(root?.right, sum - root!.val)
    }
    
    // MARK: - leetCode NO.113
    func pathSum(root: TreeNode?, _ sum: Int) -> [[Int]] {
        var res: [[Int]] = []
        hasPathSum(&res, tempArr: [] , root: root, sum)
        return res
    }
    func hasPathSum(inout res: [[Int]],tempArr: [Int], root: TreeNode?, _ sum: Int) {
        if root == nil { return }
        var temp = tempArr
        temp.append(root!.val)
        if sum == root!.val && root?.left == nil && root?.right == nil {  // 一定是叶子节点
            res.append(temp)
        }
        // 分治算法，分解成小的问题去解决
        hasPathSum(&res, tempArr: temp, root: root?.left, sum-root!.val)
        hasPathSum(&res, tempArr: temp, root: root?.right, sum-root!.val)
    }
    
    // MARK: - leetCode NO.114
    private var prev: TreeNode?
    func flatten(root: TreeNode?) {  // 非常完美，牛逼
        if root == nil {
            return
        }
        flatten(root?.right)
        flatten(root?.left)
        root?.right = prev
        root?.left = nil
        prev = root
    }
    
    // MARK: - leetCode NO.115
    // DP 动态规划 http://blog.csdn.net/feliciafay/article/details/42959119
    func numDistinct(s: String, _ t: String) -> Int {
        return 0
    }
    
    // MARK: - leetCode NO.118
    func generate(numRows: Int) -> [[Int]] {
        var res: [[Int]] = []
        if numRows > 0  {
            res.append([1])
        }
        var tempArr = [0,1,0]
        for (var i = 0; i < numRows-1; i += 1) {
            let convertArr = convertArrToNextArr(tempArr)
            res.append(convertArr)
            tempArr = convertArr
            tempArr.append(0)
            tempArr.insert(0, atIndex: 0)
        }
        return res
    }
    func convertArrToNextArr(arr: [Int]) -> [Int] {
        var res: [Int] = []
        for i in 0 ..< arr.count - 1 {
            res.append(arr[i]+arr[i+1])
        }
        return res
    }
    // MARK: - leetCode NO.119
    func getRow(rowIndex: Int) -> [Int] {
        var res: [Int] = [1]
        for _ in 0 ..< rowIndex {
            res.append(0)
            res.insert(0, atIndex: 0)
            res = convertArrToNextArr(res)
        }
        return res
    }
    // MARK: - leetCode NO.120
    func minimumTotal(triangle: [[Int]]) -> Int {  // DP
        var triangle = triangle
        for (var i = triangle.count - 2; i >= 0; i -= 1) {
            for (var j = 0; j <= i; j += 1){
                // 状态转移方程,自底向上
                triangle[i][j] += min(triangle[i+1][j+1],triangle[i+1][j]);
            }
        }
        return triangle[0][0];
    }
    // MARK: - leetCode NO.121
    func maxProfit(prices: [Int]) -> Int {
        let count = prices.count
        if count == 0 { return 0 }
        var maxProfit = 0
        var curMin = prices[0]
        for i in 1 ..< count {
            curMin = min(prices[i], curMin)
            maxProfit = max(maxProfit, prices[i] - curMin)
        }
        return maxProfit
    }
    // MARK: - leetCode NO.122
    func maxProfitII(prices: [Int]) -> Int {
        let count = prices.count
        if count == 0 { return 0 }
        var maxProfit = 0
        var curMin = prices[0]
        for i in 1 ..< count {
            if prices[i] > curMin {
                maxProfit += prices[i] - curMin
            }
            curMin = prices[i]
        }
        return maxProfit
    }
    // MARK: - leetCode NO.123
    func maxProfitIII(prices: [Int]) -> Int {
        var hold1 = Int.min
        var hold2 = Int.min
        var release1 = 0
        var release2 = 0
        for i in prices {  // Assume we only have 0 money at first
            release2 = max(release2, hold2+i)  // The maximum if we've just sold 2nd stock so far.
            hold2 = max(hold2, release1-i)  // The maximum if we've just buy  2nd stock so far.
            release1 = max(release1, hold1+i)  // The maximum if we've just sold 1nd stock so far.
            hold1 = max(hold1, -i)  // The maximum if we've just buy  1st stock so far.
        }
        return release2
    }
    // MARK: - leetCode NO.125
    func isPalindrome(s: String) -> Bool {
        if s == "" {
            return true
        }
        var arr: [Character] = []
        let s = s.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        for char in s.characters {
            if (char >= "a" && char <= "z") || (char >= "0" && char <= "9") {
                arr.append(char)
            }
        }
        var count = arr.count - 1
        var i = 0
        while count > i {
            if arr[count] != arr[i] {
                return false
            }
            count -= 1
            i += 1
        }
        return true
    }
    // MARK: - leetCode NO.128
    func longestConsecutive(nums: [Int]) -> Int {
        var res = 0
        var map: [Int : Int] = [:]
        for n in nums {
            if map[n] == nil {
                let left = map[n-1] ?? 0
                let right = map[n+1] ?? 0
                let sum = left + right + 1
                map[n] = sum
                res = max(res, sum)
                // map[n-left]为和n相连续而且最小的那个
                // map[n+right]为和n相连续而且最大的那个
                // 如果存在则会赋值，如果不存在则不会做任何事 left == right == 0
                map[n-left] = sum
                map[n+right] = sum
            } else { // 已经存在的，直接跳过就好
                continue
            }
        }
        return res
    }
    /*
    func longestConsecutive(nums: [Int]) -> Int { // 自己写的要差劲一些O(3n)
        let nums = nums.sort()
        var length = 1
        if nums.count <= 1 { return 1 }
        var number = nums[0]
        var allLength: [Int] = []
        for i in 1 ..< nums.count {
            if nums[i] == number + 1 {
                length += 1
            } else if number != nums[i] {
                allLength.append(length)
                length = 1
            }
            if i == nums.count - 1 { allLength.append(length) }
            number = nums[i]
        }
        length = 0
        for num in allLength {
            if num > length {
                length = num
            }
        }
        return length
    }
 */
}

















