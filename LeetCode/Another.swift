//
//  Another.swift
//  LeetCode
//
//  Created by Chen on 16/4/22.
//  Copyright © 2016年 ChenYingPing. All rights reserved.
//

import UIKit

class Another: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    func firstMissingPositive(nums: [Int]) -> Int {
        var newnum = nums.filter {
            return $0 > 0
        }
        newnum.sortInPlace()
        for (var i = 1; i < newnum.count; i += 1) {
            if i > newnum.count - 1 {
                break
            }
            if i > 0 && newnum[i] == newnum[i - 1] {
                newnum.removeAtIndex(i)
                i -= 1
            }
        }
        if newnum.count == 0{
            return 1
        }
        for i in 1...newnum.count {
            if i != newnum[i - 1] {
                return i
            }
        }
        return newnum.last! + 1
    }
    
    // http://www.leetcode.com/wp-content/uploads/2012/08/rainwatertrap.png
    func trap(height: [Int]) -> Int {  // [0,1,0,2,1,0,1,3,2,1,2,1], return 6.   能装多少水
        var left=0
        var right=height.count-1
        var res=0
        var maxleft=0
        var maxright=0
        while(left<=right){
            if(height[left]<=height[right]){
                if(height[left]>=maxleft) { maxleft=height[left] }
                else  { res+=maxleft-height[left] }
                left += 1
            }
            else{
                if(height[right]>=maxright) { maxright = height[right] }
                else { res+=maxright-height[right] }
                right -= 1
            }
        }
        return res
    }
    
    func containsNearbyAlmostDuplicate(nums: [Int], _ k: Int, _ t: Int) -> Bool {
        var map: [Int : Int] = [:]
        for i in 0..<nums.count {
            if let value = map[nums[i]] {
                if i - value <= k {
                    return true
                } else {
                    map[nums[i]] = i
                }
            } else {
                map[nums[i]] = i
            }
        }
        return false
    }
    
    func reverseString(s: String) -> String {
        if s.characters.count == 1 {
            return s
        }
        
        let count = s.characters.count / 2
        var mys = ""
        
        mys += reverseString(s.substringFromIndex(s.startIndex.advancedBy(count)))
        mys += reverseString(s.substringToIndex(s.startIndex.advancedBy(count)))
        return mys
    }
    
    func groupAnagrams(strs: [String]) -> [[String]] {
        if strs.count < 2 {
            return [strs]
        }
        var arr: [[String]] = []
        var containDict: [String : [String]] = [:] // 判断是不是已经包含了这个数字
        for str in strs {
            let key: String = str.characters.sort().description
            if var tempArr = containDict[key] {
                tempArr.append(str)
                tempArr.sortInPlace()
                containDict[key] = tempArr
            } else {
                var temp: [String] = []
                temp.append(str)
                containDict[key] = temp
            }
        }
        for value in containDict.values {
            arr.append(value)
        }
        return arr
    }
    
    func combineWithSameChar(str1: String, str2: String) -> Bool {
        return str1.characters.sort() == str2.characters.sort()
    }
    
    func myPow(x: Double, _ n: Int) -> Double {
        if n == 1 {
            return x
        }
        if pow(x, Double(n)) > pow(123, 123456) {
            return pow(123, 123456)
        }
        if n < 0 {
            return 1/x * myPow(1/x, -n-1)
        } else {
            return x * myPow(x, n-1)
        }
    }
    // MARK: - leetcode NO.51
    var rows: [Int] = []
    var resultArr: [[String]] = []
    func solveNQueens(n: Int) -> [[String]] { // N皇后算法，求得所有的解
        rows = Array.init(count: n, repeatedValue: 0)  // 每一行中皇后的位置
        getArrangement(0, maxqueen: n)
        return resultArr
    }
    func getArrangement(n: Int, maxqueen: Int) {
        // 第n行中所有列的值初始化都为false
        var cols:[Bool] = Array(count: maxqueen, repeatedValue: false)
        for i in 0 ..< n { // 比n小的前面几行，找出皇后所在位置，并标记在对角线方法或者直线方向的位置无效
            cols[rows[i]]=true
            let d = n-i
            if(rows[i]-d >= 0) { cols[rows[i]-d]=true }  // 左对角线
            if(rows[i]+d <= maxqueen-1) { cols[rows[i]+d]=true }  // 右对角线
        }
        for i in 0 ..< maxqueen {
            // 判断第n行中第i列是否合法
            if(cols[i]) { continue }
            //设置第n行的合法位置为i
            rows[n] = i
            if(n<maxqueen-1){
                getArrangement(n+1,maxqueen: maxqueen)
            }else{  // 找到了一种新的摆放方式
                var tempArr: [String] = []
                for i in 0 ..< maxqueen {
                    var tempStr = ""
                    for j in 0 ..< maxqueen {
                        if(j == rows[i]){
                            tempStr += "Q"
                        }else {
                            tempStr += "."
                        }
                    }
                    tempArr.append(tempStr)
                }
                resultArr.append(tempArr)
            }
        }
    }
    
    func generateMatrix(n: Int) -> [[Int]] {  // 螺旋矩阵的问题
        let arr = Array.init(count: n, repeatedValue: 0)
        var result: [[Int]] = Array.init(count: n, repeatedValue: arr)
        var cur = 0
        var x = 0
        var y = -1
        while cur < n * n {
            while y + 1 < n && result[x][y+1] == 0 {
                y += 1
                cur += 1
                result[x][y] = cur
            }
            while x + 1 < n && result[x+1][y] == 0 {
                x += 1
                cur += 1
                result[x][y] = cur
            }
            while y - 1 >= 0 && result[x][y-1] == 0 {
                y -= 1
                cur += 1
                result[x][y] = cur
            }
            while x - 1 >= 0 && result[x-1][y] == 0 {
                x -= 1
                cur += 1
                result[x][y] = cur
            }
        }
        return result
    }
    func spiralOrder(matrix: [[Int]]) -> [Int] { // 螺旋矩阵
        let col = matrix.first?.count // 每行有多少个
        let row = matrix.count // 一共有多少行
        if col == nil || row == 0 {
            return []
        }
        var result: [Int] = []
        let max = col! * row
        var cur = 0
        var x = 0
        var y = -1
        var containDict: [Int : Int] = [:]
        while cur < max {
            while y + 1 < col && containDict[matrix[x][y+1]] == nil {
                y += 1
                cur += 1
                result.append(matrix[x][y])
                containDict[matrix[x][y]] = matrix[x][y]
            }
            while x + 1 < row && containDict[matrix[x+1][y]] == nil {
                x += 1
                cur += 1
                result.append(matrix[x][y])
                containDict[matrix[x][y]] = matrix[x][y]
            }
            while y - 1 >= 0 && containDict[matrix[x][y-1]] == nil {
                y -= 1
                cur += 1
                result.append(matrix[x][y])
                containDict[matrix[x][y]] = matrix[x][y]
            }
            while x - 1 >= 0 && containDict[matrix[x-1][y]] == nil {
                x -= 1
                cur += 1
                result.append(matrix[x][y])
                containDict[matrix[x][y]] = matrix[x][y]
            }
        }
        return result
    }
    
    func canJump(nums: [Int]) -> Bool {
        var maxNum = 0
        // 判断能不能到 第 i 个位置, 判断条件为前 i-1 个元素中有没有 x + nums[x] >= i (0 <= x <= i-1)， 第0个元素不用判断，肯定能到
        for i in 0 ..< nums.count {
            if(i>maxNum) { return false }
            maxNum = max(nums[i]+i, maxNum)
        }
        return true
    }
    
    func insert(intervals: [Interval], _ newInterval: Interval) -> [Interval] {
        var res: [Interval] = []
        var i = 0
        while i < intervals.count && intervals[i].end < newInterval.start {
            res.append(intervals[i++])
        }
        while i < intervals.count && intervals[i].start <= newInterval.end  { // 这一句话要多理解一下，特别是判断条件，当我的start已经大于你的end，说明我已经不在你的范围内了，不用合并我，我是新的需要加入的结点
            newInterval.start = min(intervals[i].start, newInterval.start)
            newInterval.end = max(intervals[i++].end, newInterval.end)
        }
        res.append(newInterval)
        while i < intervals.count {
            res.append(intervals[i++])
        }
        return res
    }
    
    
    
    // 找到 interval.start < newInterval.start && interval.end < newInterval.start
//    func findLowInterval(intervals: [Interval], _ newInterval: Interval) -> Interval {
//        
//    }
}
// MARK: - Find the contiguous subarray within an array (containing at least one number) which has the largest sum.
//public static int maxSubArray(int[] A) {
//    int maxSoFar=A[0], maxEndingHere=A[0];
//    for (int i=1;i<A.length;++i){
//        maxEndingHere= Math.max(maxEndingHere+A[i],A[i]);
//        maxSoFar=Math.max(maxSoFar, maxEndingHere);
//    }
//    return maxSoFar;
//}

//public class Solution {
//    public List<List<String>> groupAnagrams(String[] strs) {
//    if (strs == null || strs.length == 0) return new ArrayList<List<String>>()
//    Map<String, List<String>> map = new HashMap<String, List<String>>()
//    Arrays.sort(strs)
//    for (String s : strs) {
//    char[] ca = s.toCharArray()
//    Arrays.sort(ca)
//    String keyStr = String.valueOf(ca)
//    if (!map.containsKey(keyStr)) map.put(keyStr, new ArrayList<String>())
//    map.get(keyStr).add(s)
//    }
//    return new ArrayList<List<String>>(map.values())
//    }
//}

//    func isMatch(s: String, _ p: String) -> Bool {
//        let m = s.characters.count
//        let n = p.characters.count
//        var i = 0
//        var j = 0
//        var asterisk = -1
//        var match = 0
//        while (i < m) {
//            if (j < n && p[j] == "*") {
//                match = i
//                asterisk = j++
//            }
//            else if (j < n && (s[i] == p[j] || p[j] == '?')) {
//                i++
//                j++
//            }
//            else if (asterisk >= 0) {
//                i = ++match
//                j = asterisk + 1
//            }
//            else { return false }
//        }
//        while (j < n && p[j] == '*') j++
//        return j == n
//    }
