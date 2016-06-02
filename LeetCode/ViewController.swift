//
//  ViewController.swift
//  LeetCode
//
//  Created by Chen on 16/4/13.
//  Copyright © 2016年 ChenYingPing. All rights reserved.
//

import UIKit

public class Interval {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

public class ListNode {
         public var val: Int
         public var next: ListNode?
         public init(_ val: Int) {
                 self.val = val
                    self.next = nil
             }
     }

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        [[2,3],[4,5],[6,7],[8,9],[1,10]
//        print(missingNumber(<#T##nums: [Int]##[Int]#>))
        
        findMedianSortedArrays([1,2], [1,1])
    }
    
    func findMin(nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        var min = Int.max
        for num in nums {
            if num < min {
                min = num
            }
        }
        return min
    }
    
    func increasingTriplet(nums: [Int]) -> Bool {
        var small = Int.max
        var big = Int.max
        for num in nums {
            if num < small {
                small = num
            } else if num < big {
                big = num
            } else {
                return true
            }
        }
        return false
    }
    
    func merge(intervals: [Interval]) -> [Interval] {
        if intervals.count <= 1 {
            return intervals
        }
        var myintervals = intervals
        var index = 0
        var j = 1
        while index < myintervals.count - 1 {
            j = index + 1
            while j < myintervals.count {
                if !(myintervals[index].end < myintervals[j].start || myintervals[index].start > myintervals[j].end) {
                    let start = min(myintervals[index].start, myintervals[j].start)
                    let end = max(myintervals[index].end, myintervals[j].end)
                    let node = Interval(start, end)
                    myintervals.removeAtIndex(index)
                    myintervals.removeAtIndex(j-1)
                    myintervals.insert(node, atIndex: 0)
                    index = 0
                    j = index + 1  // 有点回溯法的感觉，添加完之后，应该回头重新开始比较
                } else {
                    j += 1
                }
            }
            index += 1
        }
        return myintervals
    }

    func reorderList(head: ListNode?) {
        if head == nil || head?.next == nil {
            return
        }
        // 1.首先找到链表的中点Node 1->2>-3->4->5->6
        var p1 = head
        var p2 = head
        while p1 != nil && p2?.next?.next != nil {
            p1 = p1?.next
            p2 = p2?.next?.next
        }
        // 2.把链表中间之后的Node逆序 1->2>-3->4->5->6 to 1->2>-3->6->5->4
        let middle = p1
        let preCurrent = p1?.next
        while preCurrent?.next != nil {  // 把preCurrent.next 一直移到middle.next
            let current = preCurrent?.next
            preCurrent?.next = current?.next
            current?.next = middle?.next
            middle?.next = current
        }
        // 3. 1->2>-3->6->5->4 to 1->6>-2->5->3->4
        p1 = head
        p2 = middle?.next
        while(p1 !== middle!){
            middle?.next = p2!.next
            p2?.next = p1!.next
            p1?.next = p2
            p1 = p2?.next
            p2 = middle?.next
        }
    }
    
    var array: [String] = []
    func generateParenthesis(n: Int) -> [String] {
        addingpar("", n: n, m: 0)
        return array
    }
     // 这个简直绝了，把每一个之路都通过递归使之都有一个addingpar方法对应。等于数组有多少个，就有调用了多少次addingpar方法
    func addingpar(str: String, n: Int, m: Int) {
        if(n==0 && m==0) {
            array.append(str)
            return;
        }
        if(m > 0){ addingpar(str+")", n: n, m: m-1) }
        if(n > 0){ addingpar(str+"(", n: n-1, m: m+1) }
    }
    
    func maxCoins(nums: [Int]) -> Int {
        var result = 0
        var mynums = nums
        while mynums.count > 0 {
            let index = findMinnum(mynums);
            mynums.insert(1, atIndex: 0)
            mynums.append(1)
            result += mynums[index] * mynums[index + 1] * mynums[index + 2]
            mynums.removeAtIndex(index + 1)
            mynums.removeAtIndex(0)
            mynums.removeLast()
        }
        return result
    }
    
    func findMinnum(nums: [Int]) -> Int {
        var min = nums[0]
        var result = 0
        for index in 0..<nums.count {
            if nums[index] < min {
                min = nums[index]
                result = index
            }
        }
        return result
    }
    
    func getAllSum(nums: [Int]) {
        var sum = 0
        var array: [Int] = []
        for index in 0..<nums.count {
            array.append(nums[index])
            
        }
    }

    
    func missingNumber(nums: [Int]) -> Int {
        let count = nums.count
        var sum = count
        for index in 0..<count {
            sum += index - nums[index]
        }
        return sum
    }
    
    func findMedianSortedArrays(nums1: [Int], _ nums2: [Int]) -> Double {
        // 归并排序，算法为时间复杂度logn
        var tmpArr: [Int] = []
        for _ in 0..<nums1.count+nums2.count {
            tmpArr.append(1)
        }
        var lowPos = 0
        var highPos = 0
        let highEnd = nums2.count - 1
        let lowEnd = nums1.count - 1
        var tmpPos = lowPos;
        // 将arr中的记录由小到大归并入tmpArr
        while (lowPos <= lowEnd && highPos <= highEnd){
            if (nums1[lowPos] <= nums2[highPos]){
                tmpArr[tmpPos++] = nums1[lowPos++];
            }else{
                tmpArr[tmpPos++] = nums2[highPos++];
            }
        }
        // 将剩余的arr[low..mid]复制到tmpArr
        while (lowPos <= lowEnd){
            tmpArr[tmpPos++] = nums1[lowPos++];
        }
        
        // 将剩余的arr[mid+1..high]复制到tmpArr
        while (highPos <= highEnd){
            tmpArr[tmpPos++] = nums2[highPos++];
        }
        if tmpArr.count % 2 == 0 {
            let median = tmpArr.count / 2
            let sum = tmpArr[median] + tmpArr[median - 1]
            return Double(sum) / 2
        } else {
            let median = tmpArr.count / 2
            return Double(tmpArr[median])
        }
    }
    
    func hasPathSum(root: TreeNode?, _ sum: Int) -> Bool {
        if root == nil {
            return false
        }
        if sum == root!.val && root?.left == nil && root?.right == nil {
            return true
        }
        return hasPathSum(root?.left, sum - root!.val) || hasPathSum(root?.right, sum - root!.val)
    }
    
    // 是否是平衡二叉树
    func isBalanced(root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        if -1 <= (maxDepth(root?.left) - maxDepth(root?.right)) && (maxDepth(root?.left) - maxDepth(root?.right)) <= 1 {
            return isBalanced(root?.left) && isBalanced(root?.right)
        }
        return false
    }
    func minDepth(root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let left = minDepth(root?.left)
        let right = minDepth(root?.right)
        return (left == 0 || right == 0) ? left + right + 1 : 1 + min(left, right)
    }
    // 二叉树的深度
    func maxDepth(root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return 1 + max(maxDepth(root?.left), maxDepth(root?.right))
    }
    
    // 遍历二叉树
    func levelOrder(root: TreeNode?) -> [[Int]] {
        var result: [[Int]] = []
        var level: [TreeNode] = []
        if root != nil {
            level.append(root!)
        }
        while true {
            if level.isEmpty || level.first == nil {
                break
            }
            var nextLevel: [TreeNode] = []
            var currentLevel: [Int] = []
            for node in level {
                currentLevel.append(node.val)
                if node.left != nil {
                    nextLevel.append(node.left!)
                }
                if node.right != nil {
                    nextLevel.append(node.right!)
                }
            }
            result.append(currentLevel)
            level = nextLevel
        }
        return result.reverse()
    }
    
    // 二叉树是否对称
    func isSymmetric(root: TreeNode?) -> Bool {
        return isSymmetric(root?.left, right: root?.right)
    }
    
    func isSymmetric(left: TreeNode?, right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        if left?.val == right?.val {
            return isSymmetric(left?.left, right: right?.right) && isSymmetric(left?.right, right: right?.left)
        } else {
            return false
        }
    }
    
    // 翻转二叉树
    func invertTree(root: TreeNode?) -> TreeNode? {
        if root == nil {
            return root
        }
        let temp: TreeNode? = root?.left
        root?.left = root?.right
        root?.right = temp
        invertTree(root?.left)
        invertTree(root?.right)
        return root
    }
    
    // 判断二叉树是否相同
    func isSameTree(p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p?.val == q?.val {
            return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
        }
        return false
    }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}
/*
class Solution {
    public:
    vector<string> generateParenthesis(int n) {
    vector<string> res;
    addingpar(res, "", n, 0);
    return res;
    }
    void addingpar(vector<string> &v, string str, int n, int m){
    if(n==0 && m==0) {
    v.push_back(str);
    return;
    }
    if(m > 0){ addingpar(v, str+")", n, m-1); }
    if(n > 0){ addingpar(v, str+"(", n-1, m+1); }
    }
};


public class Solution {
    public boolean isValidSerialization(String preorder) {
    // using a stack, scan left to right
    // case 1: we see a number, just push it to the stack
    // case 2: we see #, check if the top of stack is also #
    // if so, pop #, pop the number in a while loop, until top of stack is not #
    // if not, push it to stack
    // in the end, check if stack size is 1, and stack top is #
    if (preorder == null) {
        return false;
    }
    Stack<String> st = new Stack<>();
    String[] strs = preorder.split(",");
    for (int pos = 0; pos < strs.length; pos++) {
        String curr = strs[pos];
        while (curr.equals("#") && !st.isEmpty() && st.peek().equals(curr)) {
            st.pop();
            if (st.isEmpty()) {
                return false;
            }
            st.pop();
        }
        st.push(curr);
    }
    return st.size() == 1 && st.peek().equals("#");
    }
}
*/
















    