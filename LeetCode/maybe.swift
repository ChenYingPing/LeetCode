//
//  maybe.swift
//  LeetCode
//
//  Created by Chen on 16/4/29.
//  Copyright © 2016年 ChenYingPing. All rights reserved.
//

import UIKit

class maybe: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = [1]
        print(merge(&arr, 1, [], 0))
    }

    func minPathSum(grid: [[Int]]) -> Int {
        myobstacleGrid = grid
        let m = grid.count - 1
        let n = (grid.first?.count)! - 1
        huisu(m, n: n, minpath: 0)
        return result
    }
    var myobstacleGrid: [[Int]] = []
    var result = Int.max
    func huisu(m: Int, n: Int, minpath: Int) { // 虽然递归次数不算很多，但是毕竟是调用方法。而且方法里面创建了局部变量。所以速度还是比较慢。
        let  minsumPath = minpath + myobstacleGrid[m][n]
        if minsumPath > result {
            return
        }
        if m == 0 && n == 0 {
            if minsumPath < result {
                result = minsumPath
            }
            return
        } else if m > 0 && n > 0 {
            huisu(m-1, n: n,minpath: minsumPath)
            huisu(m, n: n-1, minpath: minsumPath)
        } else if m > 0 && n == 0 {
            huisu(m-1, n: n,minpath: minsumPath)
        } else if n > 0 && m == 0 {
            huisu(m, n: n-1,minpath: minsumPath)
        }
    }
    func mySqrt(x: Int) -> Int {
        for i in 0...x {
            if i * i > x {
                return i - 1
            } else if i * i == x {
                return i
            }
        }
        return 0
    }
    
    func setZeroes(inout matrix: [[Int]]) {
        let row = matrix.count
        let col = matrix.count > 0 ? matrix.first!.count : 0
        var mapi: [Int : Int] = [:]
        var mapj: [Int : Int] = [:]
        for i in 0..<row {
            for j in 0..<col {
                if mapj[j] != nil {
                    continue
                }
                if matrix[i][j] == 0 { // 标记一下这一行这一列都应该被置为0
                    mapi[i] = i
                    mapj[j] = j
                }
            }
        }
        for i in 0..<row {
            if mapi[i] != nil {
                for j in 0..<col {
                    matrix[i][j] = 0
                }
            }
        }
        for j in 0..<col {
            if mapj[j] != nil {
                for i in 0..<row {
                    matrix[i][j] = 0
                }
            }
        }
    }
    
    func searchMatrix(matrix: [[Int]], _ target: Int) -> Bool {
        var lo = 0
        var hi = matrix.count - 1
        while lo <= hi {
            let mid = (lo + hi) / 2
            if target == matrix[mid].last {
                return true
            } else if target > matrix[mid].last {
                lo = mid + 1
            } else {
                hi = mid - 1
            }
        }
        if lo > matrix.count - 1 { return false }
        let point = lo
        lo = 0
        hi = matrix[point].count
        while lo <= hi {
            let mid = (lo + hi) / 2
            if target == matrix[point][mid] {
                return true
            } else if target > matrix[point][mid] {
                lo = mid + 1
            } else {
                hi = mid - 1
            }
        }
        return false
    }
    func sortColors(inout nums: [Int]) {  // 快速排序
        let count = nums.count
        quickSort(&nums, low: 0, high: count-1)
    }
    func quickSort(inout nums: [Int], low: Int, high: Int) {
        if low < high {
            let pivot = partition(&nums, low: low, high: high)
            quickSort(&nums, low: low, high: pivot - 1)
            quickSort(&nums, low: pivot + 1, high: high)
        }
    }
    func partition(inout nums: [Int], low: Int, high: Int) -> Int {
        var mylow = low
        var myhigh = high
        let pivot = nums[low]
        while mylow < myhigh {
            while mylow < myhigh && pivot <= nums[high] {
                myhigh -= 1
            }
            nums[mylow] = nums[myhigh]
            while mylow < myhigh && pivot >= nums[mylow] {
                mylow += 1
            }
            nums[myhigh] = nums[mylow]
        }
        nums[mylow] = pivot
        return mylow
    }
    // MARK: - leetCode No.78
    func subsets(nums: [Int]) -> [[Int]] {  // 回溯法解决 NO.77 ~ 78
        var mynums = nums
        var combs: [[Int]] = []
        var comb: [Int] = []
        let count = nums.count
        for k in 0...count {
            combine(&mynums, combs: &combs, comb: &comb, start: 0, n: count, k: k)
        }
        return combs
    }
    func combine(inout nums: [Int], inout combs: [[Int]], inout comb: [Int], start: Int, n: Int, k: Int) {
        if k == 0 {
            combs.append(comb.sort())
            return
        }
        for(var i = start; i < n; i += 1) {
            comb.append(nums[i])
            combine(&nums, combs: &combs, comb: &comb, start: i+1, n: n, k: k-1)
            comb.removeLast()
        }
    }
    // MARK: - leetCode NO.79
    func exist(board: [[Character]], _ word: String) -> Bool {
        var wordArr: [Character] = []
        for char in word.characters {
            wordArr.append(char)
        }
        let rows = board.count
        let cols = board.first!.count
        for i in 0 ..< rows {
            for j in 0 ..< cols {
                if word.characters.first == board[i][j] {
                    if exist(board, y: i, x: j, word: wordArr, i: 0) {
                        return true
                    }
                }
            }
        }
        return false
    }
    func exist(board: [[Character]], y: Int, x: Int, word: [Character], i: Int) -> Bool {
        if i == word.count {
            return true
        }
        if y < 0 || y == board.count || x < 0 || x == board[y].count { return false }
        if (board[y][x] != word[i])  { return false }
        var myboard = board
        myboard[y][x] = Character.init("~") // 只能希望board[y][x]不等于 ~ 字符了
        let result = exist(myboard, y: y, x: x-1, word: word, i: i+1) || exist(myboard, y: y-1, x: x, word: word, i: i+1) || exist(myboard, y: y, x: x+1, word: word, i: i+1) || exist(myboard, y: y+1, x: x, word: word, i: i+1)
        return result
    }
    // MARK: - leetCode NO.80
    func removeDuplicates(inout nums: [Int]) -> Int {
        nums.sortInPlace()
        var i = 0
        while i < nums.count - 3 {
            if nums[i] == nums[i+1] && nums[i] == nums[i+2] {
                nums.removeAtIndex(i)
            } else {
                i += 1
            }
        }
        return nums.count
    }
    // MARK: - leetCode NO.81
    func search(nums: [Int], _ target: Int) -> Bool {
        let mynus = nums.sort()
        var lo = 0
        var hi = mynus.count - 1
        while lo <= hi {
            let mid = (lo + hi) / 2
            if nums[mid] == target {
                return true
            } else if nums[mid] > target {
                hi = mid - 1
            } else {
                lo = mid + 1
            }
        }
        return false
    }
    // MARK: - leetCode NO.82
    func deleteDuplicates(head: ListNode?) -> ListNode? {
        var myhead = head
        var pre = ListNode(0)
        let result = pre
        let same = ListNode(-1001)
        while myhead != nil {
            if myhead?.val == same.val || myhead?.val == myhead?.next?.val {
                same.val = myhead!.val
                myhead = myhead?.next
            } else {
                let node = ListNode(myhead!.val)
                pre.next = node
                pre = pre.next!
            }
        }
        return result.next
    }
    // MARK: - leetCode NO.84
    func largestRectangleArea(heights: [Int]) -> Int { //http://www.cnblogs.com/felixfang/p/3676193.html 解释在这里，看完解释再看代码就容易理解了. 下面的解法比文章还做了改进。时间复杂度为O(n)
        let len = heights.count
        var s: [Int] = []
        var maxArea = 0;
        for(var i = 0; i <= len; i += 1){
            let h = (i == len ? 0 : heights[i]);
            if(s.isEmpty || h >= heights[s.last!]){
                s.append(i)
            }else{
                let tp = s.last
                s.removeLast()
                maxArea = max(maxArea, heights[tp!] * (s.isEmpty ? i : i - 1 - s.last!));
                i -= 1;
            }
        }
        return maxArea;
    }
    // MARK: - leetCode NO.86
    func partition(head: ListNode?, _ x: Int) -> ListNode? {
        var myhead = head
        var less = ListNode(0)
        let preLess = less
        var bigger = ListNode(0)
        let preBigger = bigger
        while myhead != nil {
            let val = myhead!.val
            if val >= x {
                bigger.next = ListNode(val)
                bigger = bigger.next!
            } else {
                less.next = ListNode(val)
                less = less.next!
            }
            myhead = myhead?.next
        }
        less.next = preBigger.next
        return preLess.next
    }
    // MARK: - leetCode NO.88
    func merge(inout nums1: [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var lowNum1 = 0
        var lowNum2 = 0
        var tempArr:[Int] = []
        while lowNum1 < m && lowNum2 < n {
            let temp = nums1[lowNum1] < nums2[lowNum2] ? nums1[lowNum1++] : nums2[lowNum2++]
            tempArr.append(temp)
        }
        while lowNum1 < m {
            tempArr.append(nums1[lowNum1++])
        }
        while lowNum2 < n {
            tempArr.append(nums2[lowNum2++])
        }
        nums1 = tempArr
    }
    // MARK: - leetCode NO.87
//    public class Solution {
//        public boolean isScramble(String s1, String s2) {
//        if(s1==null || s2==null || s1.length()!=s2.length()) return false;
//        if(s1.equals(s2)) return true;
//        char[] c1 = s1.toCharArray();
//        char[] c2 = s2.toCharArray();
//        Arrays.sort(c1);
//        Arrays.sort(c2);
//        if(!Arrays.equals(c1, c2)) return false;
//        for(int i=1; i<s1.length(); i++)
//        {
//        if(isScramble(s1.substring(0,i), s2.substring(0,i)) && isScramble(s1.substring(i), s2.substring(i))) return true;
//        if(isScramble(s1.substring(0,i), s2.substring(s2.length()-i)) && isScramble(s1.substring(i), s2.substring(0, s2.length()-i))) return true;
//        }
//        return false;
//        }
//    }
}
//    int uniquePaths(int m, int n) {  使用这种解法比回溯法更棒，核心思想为排列组合。遍历次数少。
//        int N = n + m - 2;// how much steps we need to do
//        int k = m - 1; // number of steps that need to go down
//        double res = 1;
//        // here we calculate the total possible path number
//        // Combination(N, k) = n! / (k!(n - k)!)
//        // reduce the numerator and denominator and get
//        // C = ( (n - k + 1) * (n - k + 2) * ... * n ) / k!
//        for (int i = 1; i <= k; i++)
//            res = res * (N - k + i) / i;
//            return (int)res;
//        }
//    }
//    public int uniquePathsWithObstacles(int[][] obstacleGrid) {
//        int width = obstacleGrid[0].length;
//        int[] dp = new int[width];
//        dp[0] = 1;
//        for (int[] row : obstacleGrid) {
//        for (int j = 0; j < width; j++) {
//            if (row[j] == 1)
//                dp[j] = 0;
//            else if (j > 0)
//                dp[j] += dp[j - 1];
//            }
//        }
//        return dp[width - 1]; // dp[x] is the paths number to column x in the current row.
//    }