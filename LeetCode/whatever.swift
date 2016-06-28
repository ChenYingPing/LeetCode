//
//  whatever.swift
//  LeetCode
//
//  Created by Chen on 16/4/18.
//  Copyright © 2016年 ChenYingPing. All rights reserved.
//

import UIKit

class whatever: UIViewController
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
        
        let array: Array = [1,2,3,4,5,6,7]
        let arr = array.map { // 对数组元素进行遍历，并进行某些转换，返回的是一个数组
             return $0
        }
        let arr1 = array.flatMap { // 与map方法类似，与之不同的是flatmap可以会把optional.None过滤出去，并且对于数组嵌套数组的情况，会打破嵌套，合并为一个新的数组。而map会保留optional.None和原先的嵌套结构
            return $0 > 3
        }
        let arr2 = array.filter { // 对数组里的元素进行过滤操作，保留满足条件的元素并组合一个新的数组返回
            return $0 > 3
        }
        let arr3 = array.reduce(1) { // 对数组里的元素进行一个整合，例如求和，或者求积
            return $0 * $1
        }
        let res = array.sort { (num1, num2) -> Bool in
            return num1 > num2
        }
        array.forEach { (num) in // 高级函数遍历
            print(num)
        }
        let arr4 = array.reduce([]) { (a: [Int], element: Int) -> [Int] in
            var t = a   // 使用数组的reduce方法实现map的效果
            t.append(element * 2)
            return t
        }
        let res1: (Int, Int) = arr.reduce((0, 1)) {  // 使用reduce方法实现偶数得积，奇数得和
            (a :(Int, Int), element: Int) -> (Int, Int) in
            if element % 2 == 0 {
                return (a.0, a.1 * element)
            } else {
                return (a.0 + element, a.1)
            }
        }
        let res2 = arr.filter { // 链式调用，求数组里所有偶数的平方和
            $0 % 2 == 0
        }.map {
            $0 * $0
        }.reduce(0) {
            $0 + $1
        }
        
        print(arr)
        print(arr1)
        print(arr2)
        print(arr3)
        print(arr4)
        print(res)
        print(res1)
        print(res2)
    }
    
    func threeSumClosest(nums: [Int], _ target: Int) -> Int {
        if nums.count <= 3 {  // 小于等于三个的时候，直接相加返回就好
            var result = 0
            for num in nums {
                result += num
            }
            return result
        }
        let mynums = nums.sort()  // mynums : -1 -1 0 1
        var result = nums[0]+nums[1]+nums[2]
        for index in 0..<mynums.count - 2 {
            var lo = index + 1
            var hi = mynums.count - 1
            while lo < hi {
                let tempnum = mynums[index] + mynums[lo] + mynums[hi]
                let differ = target - tempnum
                if abs(target - tempnum) < abs(result - target) {
                    result = tempnum
                    if differ == 0 {
                        return tempnum
                    }
                } else if differ > 0 {
                    lo += 1
                } else {
                    hi -= 1
                }
            }
        }
        return result
    }
    
    
    func maxArea(height: [Int]) -> Int {
        if (height.count < 2) { return 0 }
        var ans = 0
        var l = 0
        var r = height.count - 1
        while (l < r) {
            let v = (r - l) * min(height[l], height[r])
            if (v > ans) { ans = v }
            if (height[l] < height[r]) { l += 1 }
            else { r -= 1 }
        }
        return ans
    }

    
    func isPalindromicString(s: String) -> Bool {
        let num = s.characters.count / 2
        var myS = s.substringFromIndex(s.startIndex.advancedBy(num))
        let string = myS
        var compareStr = ""
        while myS.characters.count > 0 {
            compareStr += myS.substringFromIndex(myS.endIndex.advancedBy(-1))
            myS.removeAtIndex(myS.endIndex.advancedBy(-1))
        }
        if string == compareStr {
            return true
        }
        return true
    }
    
    func fourSum(nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count < 4 { return [] }  // mynums -3 -1 0 2 4 5
        var mynums = nums.sort()
        var result:[[Int]] = []
        for index in 0..<mynums.count-1 {
            if index != 0 && mynums[index] == mynums[index - 1]  {continue}
            for (var j = mynums.count-1; j > index; j -= 1) {
                if j != mynums.count-1 && mynums[j] == mynums[j + 1] {continue}
                var lo = index + 1
                let sum = target - mynums[index] - mynums[j]
                var hi = j-1
                while lo < hi {
                    if sum == mynums[lo] + mynums[hi] {
                        let tempArr: [Int] = [mynums[index], mynums[lo], mynums[hi], mynums[j]]
                        result.append(tempArr)
                        while lo < hi && mynums[lo] == mynums[lo+1] {
                            lo += 1
                        }
                        while lo < hi && mynums[hi] == mynums[hi-1] {
                            hi -= 1
                        }
                        lo += 1
                        hi -= 1
                    } else if (mynums[lo] + mynums[hi] < sum) {
                        lo += 1
                    } else {
                        hi -= 1
                    }
                }
            }
        }
        return result
    }
    
    func removeNthFromEnd(head: ListNode?, _ n: Int) -> ListNode? {
        var myHead = head
        var prev: ListNode? = ListNode(0)
        let result = prev
        var i = 0
        while (myHead != nil) {
            i += 1
            myHead = myHead?.next
        }
        myHead = head
        var index = 0
        while myHead != nil {
            if i - index != n {
                let node = ListNode(myHead!.val)
                prev?.next = node
                prev = prev?.next
            }
            index += 1
            myHead = myHead?.next
        }
        
        return result?.next
    }
    
    func mergeKLists(lists: [ListNode?]) -> ListNode? {
        if (lists.count==0) {return nil}
        if (lists.count==1) {return lists[0]}
        if (lists.count==2) {return merge(lists[0], second: lists[1])}
        var first:[ListNode?] = []
        var second:[ListNode?] = []
        for index in 0..<lists.count {
            if index < lists.count / 2 {
                first.append(lists[index])
            } else {
                second.append(lists[index])
            }
        }
        return merge(mergeKLists(first),
                             second: mergeKLists(second))
    }
    
    func merge( first: ListNode?, second: ListNode?) -> ListNode? {
        if first == nil {
            return second
        }
        if second == nil {
            return first
        }
        if first?.val < second?.val {  // 这么简单的递归我竟然没想到
            first?.next = merge(first?.next, second: second)
            return first
        } else {
            second?.next = merge(first, second: second?.next)
            return second
        }
    }
    
    func reverseKGroup(head: ListNode?, _ k: Int) -> ListNode? {
        if k <= 1 {
            return head
        }
        var myhead = head
        var array: [ListNode?] = []
        var prev = ListNode(0)
        let result = prev
        while myhead != nil {
            let node: ListNode = ListNode(myhead!.val)
            array.append(node)
            if array.count == k {
                while array.count > 0 {
                    prev.next = array.last!
                    prev = prev.next!
                    array.removeLast()
                }
            }
            myhead = myhead?.next
        }
        for node in array {
            prev.next = node
            prev = prev.next!
        }
        return result.next
    }
    
    func divide(dividend: Int, _ divisor: Int) -> Int {
        return dividend / divisor > Int.max ? Int.max : dividend / divisor
    }
    
//    func findSubstring(s: String, _ words: [String]) -> [Int] {
//        // 1.先把所有的words存放到一个字典中
//        // 2.对s进行遍历，并且取出word长度的子字符串。把取出来的子字符串与words中的
//    }
    func nextPermutation(inout nums: [Int]) {
        var pos = -1
        for i in 0..<nums.count {
            if nums[i] < nums[i+1] {
                pos = i
                break
            }
        }
        if pos < 0 {
            nums.sortInPlace()
            return
        }
        for i in nums.count-1...0 {
            if nums[i] > nums[pos] {
                let temp = nums[i]
                nums[i] = nums[pos]
                nums[pos] = temp
                break
            }
        }
        reverseArray(&nums, begin: pos + 1, end: nums.count - 1)
    }
    
    func reverseArray(inout num: [Int], begin: Int, end : Int) {
        var l = begin, r = end;
        while (l < r) {
            let tmp = num[l];
            num[l] = num[r];
            num[r] = tmp;
            l += 1;
            r -= 1;
        }
    }
    func longestValidParentheses(s: String) -> Int {
        let n = s.characters.count
        var longest = 0
        var arr:[Int] = []
        for i in 0..<n {
            if (s as NSString).substringWithRange(NSMakeRange(i, 1)) == "(" {
                arr.append(i)
            } else {
                if !arr.isEmpty {
                    if NSString(string: s as String).substringWithRange(NSMakeRange(arr.last!, 1)) == "(" {
                        arr.removeLast()
                    } else {
                        arr.append(i)
                    }
                } else {
                    arr.append(i)
                }
            }
        }
        if arr.isEmpty {
            longest = n
        } else {
            var a = n
            var b = 0
            while !arr.isEmpty {
                b = arr.last!
                arr.removeLast()
                longest = max(longest, a-b-1)
                a = b
            }
            longest = max(longest, a)
        }
        return longest
    }
    
    func searchRange(nums: [Int], _ target: Int) -> [Int] {
        var lo = 0
        var hi = nums.count - 1
        while lo < hi {
            let mid = (lo + hi) / 2
            if nums[mid] < target {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        if nums[lo] != target {
            return [-1,-1]
        }
        let start = lo
        hi = nums.count - 1
        while lo < hi {
            let mid = (lo + hi) / 2 + 1
            if nums[mid] > target {
                hi = mid - 1
            } else {
                lo = mid
            }
        }
        return [start, hi]
    }
}
/*
 public List<String> letterCombinations(String digits) {
    LinkedList<String> ans = new LinkedList<String>();
    String[] mapping = new String[] {"0", "1", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
    ans.add("");
    for(int i =0; i<digits.length();i++){
        int x = Character.getNumericValue(digits.charAt(i));
        while(ans.peek().length()==i){
            String t = ans.remove();
            for(char s : mapping[x].toCharArray())
            ans.add(t+s);
        }
    }
    return ans;
}

vector<string> letterCombinations(string digits) {
    vector<string> res;
    string charmap[10] = {"0", "1", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
    res.push_back("");
    for (int i = 0; i < digits.size(); i++)
    {
        vector<string> tempres;
        string chars = charmap[digits[i] - '0'];
        for (int c = 0; c < chars.size();c++)
            for (int j = 0; j < res.size();j++)
                tempres.push_back(res[j]+chars[c]);
        res = tempres;
    }
    return res;
}
 */