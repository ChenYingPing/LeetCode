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
     
        findMedianSortedArrays([1, 2], [3,4])
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
    
    func maxProductAfterCutting_colution1(length :Int) -> Int {
        if length < 2 {
            return 0
        }
        if length == 2 {
            return 1
        }
        if length == 3 {
            return 2
        }
        
        var product = [Int]()
        product[0] = 0
        product[1] = 1
        product[2] = 2
        product[3] = 3
        
        var max = 0
        
        for i in 4...length {
            max = 0
            for j in 0...i/2 {
                let value = product[j]*product[i-j]
                if max < value {
                    max = value
                }
                product[i] = max
            }
        }
        max = product[length]
        
        return max
    }
    
    func NumberOf1(n :Int) -> Int {
        var count = 0
        var n = n
        
        while (n != 0) {
            count += 1
            n = (n - 1) & n
        }
        
        return count
    }
    
    func DeleteNode(pListHead : ListNode?, pToBeDeleted : ListNode?) {
        var pListHead = pListHead
        var pToBeDeleted = pToBeDeleted
        
        if pListHead == nil || pToBeDeleted == nil {
            return
        }
        // 要删除的元素不是尾节点
        if pToBeDeleted?.next != nil {
            var pNext = pToBeDeleted?.next
            pToBeDeleted?.val = pNext!.val
            pToBeDeleted?.next = pNext?.next
            pNext = nil
        }
        else if (pListHead === pToBeDeleted) {  // 链表中只有一个节点
            pListHead = nil
            pToBeDeleted = nil
        }
        else { // 链表中有多个节点，需要被删除的节点是尾节点
            var pNode = pListHead
            while pNode?.next !== pToBeDeleted {
                pNode = pNode?.next
            }
            
            pNode?.next = nil
            pToBeDeleted = nil
        }
    }
    
    func ReverseList(pHead :ListNode?) -> ListNode? {
        var pReversedHead: ListNode?
        var pNode = pHead
        var pPrev :ListNode?
        while pNode != nil {
            let pNext = pNode?.next
            if pNext != nil {
                pReversedHead = pNode
            }
            pNode?.next = pPrev
            
            pPrev = pNode
            pNode = pNext
        }
        
        return pReversedHead
    }
    
    func Merge(pHead1 :ListNode?, pHead2 :ListNode?) -> ListNode? {
        if pHead1 == nil {
            return pHead2
        }
        if pHead2 == nil {
            return pHead1
        }
        var pHead1 = pHead1, pHead2 = pHead2
        var pMergeHead :ListNode?
        var pMergeHeadCurr :ListNode?
        while pHead1 != nil && pHead2 != nil  {
            if pHead1!.val < pHead2!.val {
                if pMergeHead == nil {
                    pMergeHead = pHead1
                    pMergeHeadCurr = pMergeHead
                } else {
                    pMergeHeadCurr?.next = pHead1
                    pMergeHead = pMergeHead?.next
                }
                pHead1 = pHead1?.next
            }
            else {
                if pMergeHead == nil {
                    pMergeHead = pHead2
                    pMergeHeadCurr = pMergeHead
                } else {
                    pMergeHeadCurr?.next = pHead2
                    pMergeHead = pMergeHead?.next
                }
                pHead2 = pHead2?.next
            }
        }
        
        if pHead1 == nil {
            while pHead2 != nil {
                pMergeHeadCurr?.next = pHead2
                pMergeHeadCurr = pMergeHeadCurr?.next
                pHead2 = pHead2?.next
            }
        }
        
        if pHead2 == nil {
            while pHead1 != nil {
                pMergeHeadCurr?.next = pHead1
                pMergeHeadCurr = pMergeHeadCurr?.next
                pHead1 = pHead1?.next
            }
        }
        
        return pMergeHead
    }
    
    func MirrorRecursively(pNode :TreeNode?) {
        if pNode == nil {
            return
        }
        if pNode?.left == nil && pNode?.right == nil {
            return
        }
        
        let pTemp = pNode?.left
        pNode?.left = pNode?.right
        pNode?.right = pTemp
        
        if pNode?.left != nil {
            MirrorRecursively(pNode: pNode?.left)
        }
        if pNode?.right != nil {
            MirrorRecursively(pNode: pNode?.right)
        }
    }
    
    func isSymmetrical(pRoot :TreeNode?) -> Bool {
        return isSymmetrical(pRoot1: pRoot, pRtoot2: pRoot)
    }
    
    func isSymmetrical(pRoot1 :TreeNode?, pRtoot2: TreeNode?) -> Bool {
        if pRoot1 == nil && pRtoot2 == nil {
            return true
        }
        if pRoot1 == nil || pRtoot2 == nil {
            return false
        }
        if pRoot1?.val != pRtoot2?.val {
            return false
        }
        
        return isSymmetrical(pRoot1: pRoot1?.left, pRtoot2: pRtoot2?.right) && isSymmetrical(pRoot1: pRoot1?.right, pRtoot2: pRtoot2?.left)
    }
    
    func PrintFromTopToBottom(pTreeRoot :TreeNode?) {
        if pTreeRoot == nil {
            return
        }
        var dequeTreeNode: [TreeNode?] = []
        dequeTreeNode.append(pTreeRoot)
        
        while dequeTreeNode.count > 0 {
            let pNode =  dequeTreeNode.removeFirst()
            print(pNode!.val)
            
            if pNode?.left != nil {
                dequeTreeNode.append(pNode?.left)
            }
            if pNode?.right != nil {
                dequeTreeNode.append(pNode?.right)
            }
        }
    }
    
    func Print(pRoot :TreeNode?) {
        if pRoot == nil {
            return
        }
        
        var queue: [TreeNode?] = []
        queue.append(pRoot)
        var nextLevel = 0
        var toBePrinted = 1
        while queue.count > 0 {
            let pNode = queue.removeFirst()
            print(pNode!.val)
            
            if pNode?.left != nil {
                queue.append(pNode?.left)
                nextLevel += 1
            }
            if pNode?.right != nil {
                queue.append(pNode?.right)
                nextLevel += 1
            }
            toBePrinted -= 1
            if toBePrinted == 0 {
                print("\n")
                toBePrinted = nextLevel
                nextLevel = 0
            }
        }
    }
    
    func GetLeastNumbers(input :[Int]?, n :Int, output :[Int]?, k :Int) {
        if input == nil || output == nil || k > n || n <= 0 || k <= 0 {
            return
        }
        var start = 0
        var end = n - 1
        var index = Partition(input: input, n: n, start: start, end: end)
        while index != (k - 1) {
            if index > k - 1 {
                end = index - 1
                index = Partition(input: input, n: n, start: start, end: end)
            }
            else {
                start = index + 1
                index = Partition(input: input, n: n, start: start, end: end)
            }
        }
        var output = output
        for i in 0..<k {
            output![i] = input![i]
        }
    }
    
    func Partition(input :[Int]?, n :Int, start :Int, end :Int) -> Int {
        return 1
    }
    
    var g_InvalidInput = false
    func FindGreatestSumOfSubArray(pData :[Int]?, nLength :Int) -> Int {
        if pData == nil || nLength <= 0 {
            g_InvalidInput = true
            return 0
        }
        
        g_InvalidInput = false
        
        var nCurSum = 0
        var nGreatestSum = 0
        for i in 0..<nLength {
            if nCurSum <= 0 {
                nCurSum = pData![i]
            }
            else {
                nCurSum += pData![i]
            }
            
            if nCurSum > nGreatestSum {
                nGreatestSum = nCurSum
            }
        }
        return nGreatestSum
    }
    
    func getMaxValue_solution1(values :[Int]?, rows :Int, cols :Int) -> Int {
        if values == nil || rows <= 0 || cols <= 0 {
            return 0
        }
        
        var maxValues :[[Int]] = []
        for i in 0..<rows {
            maxValues[i] = Array.init(arrayLiteral: cols)
        }
        
        for i in 0..<rows {
            for j in 0..<cols {
                var left = 0
                var up = 0
                if i > 0 {
                    up = maxValues[i-1][j]
                }
                if j > 0 {
                    left = maxValues[i][j-1]
                }
                maxValues[i][j] = max(left, up) + values![i*cols + j]
            }
        }
        let result = maxValues[rows - 1][cols - 1]
        return result
    }
    
//    func InversePairs(data: [Int]?, length :Int) -> Int {
//        if data == nil || length < 0 {
//            return 0
//        }
//
//        var copy: [Int] = []
//        for i in 0..<length {
//            copy[i] = data![i]
//        }
//
//        let count = InversePairsCore(data: data!, copy: copy, start: 0, end: length-1)
//
//        return count
//    }
//
//    func InversePairsCore(data: [Int], copy: [Int], start :Int, end :Int) -> Int {
//        var copy = copy
//        if start == end {
//            copy[start] = data[start]
//            return 0
//        }
//
//        var length = (end - start) / 2
//        var left = InversePairsCore(data: copy, copy: data, start: start, end: start + length)
//        var right = InversePairsCore(data: copy, copy: data, start: start + length + 1, end: end)
//
//        var i = start + length
//        var j = end
//        var indexCopy = end
//        var count = 0
//        while i  {
//            <#code#>
//        }
//    }
    
    func FindFirstCommonNode(pHead1 :ListNode?, pHead2 :ListNode?) -> ListNode? {
        if pHead1 == nil || pHead2 == nil {
            return nil
        }
        let nLength1 = GetListLength(pHead: pHead1)
        let nLength2 = GetListLength(pHead: pHead2)
        var nLengthDif = nLength1 - nLength2
        
        var pListHeadLong = pHead1
        var pListHeadShort = pHead2
        if nLength2 > nLength1 {
            pListHeadLong = pHead2
            pListHeadShort = pHead1
            nLengthDif = nLength2 - nLength1
        }
        
        // 先在长链表上走几步，再同时在两个链表上遍历
        for _ in 0..<nLengthDif {
            pListHeadLong = pListHeadLong?.next
        }
        while pListHeadLong != nil && pListHeadShort != nil && pListHeadLong !== pListHeadShort {
            pListHeadLong = pListHeadLong?.next
            pListHeadShort = pListHeadShort?.next
        }
        let pFirstCommonNode = pListHeadLong
        
        return pFirstCommonNode
    }
    
    func GetListLength(pHead :ListNode?) -> Int {
        var nLength = 0
        var pNode = pHead
        while pNode != nil {
            pNode = pNode?.next
            nLength += 1
        }
        
        return nLength
    }
    
    func GetFirstK(data :[Int], length :Int, k :Int, start :Int, end :Int) -> Int {
        var start = start, end = end
        
        if start > end {
            return -1
        }
        let middleIndex = (start + end) / 2
        let middleData = data[middleIndex]
        if middleData == k {
            if (middleIndex > 0 && data[middleIndex-1] != k) || middleIndex == 0  {
                return middleIndex
            }
            else {
                end = middleIndex - 1
            }
        }
        else if (middleData > k) {
            end = middleIndex - 1
        }
        else {
            start = middleIndex + 1
        }
        return GetFirstK(data: data, length: length, k: k, start: start, end: end)
    }
    
    func GetLastK(data :[Int], length :Int, k :Int, start :Int, end :Int) -> Int {
        var start = start, end = end
        
        if start > end {
            return -1
        }
        let middleIndex = (start + end) / 2
        let middleData = data[middleIndex]
        if middleData == k {
            if (middleIndex < length-1 && data[middleIndex+1] != k) || middleIndex == length-1  {
                return middleIndex
            }
            else {
                start = middleIndex + 1
            }
        }
        else if (middleData < k) {
            start = middleIndex + 1
        }
        else {
            end = middleIndex - 1
        }
        return GetFirstK(data: data, length: length, k: k, start: start, end: end)
    }
    
    func GetNumberOfK(data :[Int]?, length :Int, k :Int) -> Int {
        var number = 0
        if data != nil && length > 0 {
            let first = GetFirstK(data: data!, length: length, k: k, start: 0, end: length - 1)
            let last = GetLastK(data: data!, length: length, k: k, start: 0, end: length - 1)
            if first > -1 && last > -1 {
                number = last - first + 1
            }
        }
        
        return number
    }
    
    func TreeDepth(pRoot :TreeNode?) -> Int {
        if pRoot == nil {
            return 0
        }
        let nLeft = TreeDepth(pRoot: pRoot?.left)
        let nRight = TreeDepth(pRoot: pRoot?.right)
        
        return (nLeft > nRight) ? (nLeft + 1) : (nRight + 1)
    }
    
    func IsBalanced(pRoot :TreeNode?, pDepth :inout Int) -> Bool {
        if pRoot == nil {
            pDepth = 0
            return true
        }
        
        var left = 0, right = 0
        if IsBalanced(pRoot: pRoot?.left, pDepth: &left) && IsBalanced(pRoot: pRoot?.right, pDepth: &right) {
            let diff = left - right
            if diff <= 1 && diff >= -1 {
                pDepth = 1 + (left > right ? left : right)
                return true
            }
        }
        return false
    }
    
    func maxInWindows(num :[Int], size :Int) -> [Int] {
        var maxInWindows :[Int] = []
        if num.count >= size && size >= 1 {
            var index: [Int] = []
            for i in 0..<size {
                while index.count != 0 && num[i] >= num[index.last!] {
                    index.removeLast()
                }
                index.append(i)
            }
            for i in size..<num.count {
                maxInWindows.append(num[index.first!])
                while index.count > 0 && num[i] >= num[index.last!] {
                    index.removeLast()
                }
                if index.count > 0 && index.first! <= (i - size) {
                    index.removeFirst()
                }
                index.append(i)
            }
            maxInWindows.append(num[index.first!])
        }
        return maxInWindows
    }
    
    func MaxDiff(number :[Int], length :Int) -> Int {
        if number.count < length || length < 2 {
            return 0
        }
        
        var min = number[0]
        var maxDiff = number[1] - min
        for i in 2..<length {
            if number[i - 1] < min {
                min = number[ i - 1]
            }
            let currentDiff = number[i] - min
            if currentDiff > maxDiff {
                maxDiff = currentDiff
            }
        }
        return maxDiff
    }
    
    func Add(num1 :Int, num2 :Int) -> Int {
        var num1 = num1, num2 = num2
        var sum = 0, carry = 0
        while (num2 != 0){
            sum = num1 ^ num1
            carry = (num1 & num2) << 1
            num1 = sum
            num2 = carry
        }
        
        return num1
    }
    
    func minWindow(s :String, t :String) -> String {
        var minLen = INT_MAX, left = 0, right = 0
        var start = 0
        var window :[Character : Int] = [:]
        var needs :[Character : Int] = [:]
        for c in t {
            needs[c] = needs[c] ?? 0 + 1
        }
        
        var match = 0
        while right < s.count {
            let c1 = s[s.index(s.startIndex, offsetBy: right)]
            if needs[c1] != nil {
                window[c1] = window[c1] ?? 0 + 1
                if window[c1] == needs[c1] {
                    match += 1
                }
            }
            right += 1
            
            while match == needs.count {
                if right - left < minLen {
                    start = left
                    minLen = Int32(right - left)
                }
                let c2 = s[s.index(s.startIndex, offsetBy: left)]
                if needs[c2] != nil {
                    window[c2] = window[c2]! - 1
                    if window[c2]! < needs[c2]! {
                        match -= 1
                    }
                }
                left += 1
            }
        }
        let startIndex = s.index(s.startIndex, offsetBy: start)
//        let endIndex = s.index(startIndex, offsetBy: minLen)
//        return minLen == INT_MAX ? "" : s.substr(start, minLen);
        return ""
    }
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        if nums1.count > nums2.count {
            return findMedianSortedArrays(nums2, nums1)
        }
        var low = 0, high = nums1.count, k = (nums1.count + nums2.count + 1) >> 1, nums1Mid = 0, nums2Mid = 0
        while low <= high {
            nums1Mid = low + (high-low)>>1
            nums2Mid = k - nums1Mid
            if nums1Mid > 0 && nums1[nums1Mid-1] > nums2[nums2Mid] {
                high = nums1Mid - 1
            }
            else if nums1Mid != nums1.count && nums1[nums1Mid] < nums2[nums2Mid-1] {
                low = nums1Mid + 1
            } else {
                // 找到合适的划分了
                break
            }
        }
        var midLeft = 0, midRight = 0
        if nums1Mid == 0 {
            midLeft = nums2[nums2Mid-1]
        } else if nums2Mid == 0 {
            midLeft = nums1[nums1Mid-1]
        } else {
            midLeft = max(nums1[nums1Mid-1], nums2[nums2Mid-1])
        }
        
        if (nums1.count+nums2.count) & 1 == 1 {
            return Double(midLeft)
        }
        if nums1Mid == nums1.count {
            midRight = nums2[nums2Mid]
        } else if nums2Mid == nums2.count {
            midRight = nums1[nums1Mid]
        } else {
            midRight = min(nums1[nums1Mid], nums2[nums2Mid])
        }
        
        return Double((midLeft + midRight)) / 2.0
    }
    
    
    func longestPalindrome(_ s: String) -> String {
        var res = ""
//        var dp :[[Bool]] = []
//        for i in 0..<s.count {
//            dp[i] = Array.init(repeating: true, count: s.count)
//        }
//        for i in (0...s.count-1).reversed() {
//            for j in i..<s.count {
//                dp[i][j] = (s[i] == s[j]) && ((j-i < 3) || dp[i+1][j-1])
//                if dp[i][j] && (res == "" || j-i+1 > res.count) {
//                    res = s[i : j+1]
//                }
//            }
//        }
        
        return res
    }
    
    func longestPalindrome1(_ s: String) -> String {
        var res = ""
        for i in 0..<s.count {
            res = maxPalindrome(s: s, i: i, j: i, res: res)
            res = maxPalindrome(s: s, i: i, j: i+1, res: res)
        }
        
        return res
    }
    
    func maxPalindrome(s: String, i: Int, j: Int, res: String) -> String {
        var sub = "", i = i, j = j
        while i >= 0 && j < s.count && s[s.index(s.startIndex, offsetBy: i)] == s[s.index(s.startIndex, offsetBy: j)] {
            let start = s.index(s.startIndex, offsetBy: i)
            let end = s.index(s.startIndex, offsetBy: j+1)
            sub = String(s[start..<end])
            i -= 1
            j += 1
        }
        if res.count < sub.count {
            return sub
        }
        return res
    }
    
    func quicksort<T: Comparable>(_ a: [T]) -> [T] {
        guard a.count > 1 else {
            return a
        }
        
        let pivot = a[a.count / 2]
        let less = a.filter{ $0 < pivot}
        let equal = a.filter{ $0 == pivot}
        let greater = a.filter{$0 > pivot}
        
        return quicksort(less) + equal + quicksort(greater)
    }
    
    
    func maxValue ( _ s: String,  _ k: Int) -> Int {
    // write code here
        if k >= s.count || k <= 0 {
            return Int(s) ?? 0
        }
        var maxValue = 0;
        var startIndex = s.startIndex, endIndex = s.startIndex
        for i in 0..<s.count-k {
            startIndex = s.index(s.startIndex, offsetBy: i)
            endIndex = s.index(s.startIndex, offsetBy: i+k-1)
            let currentValue = s[startIndex...endIndex]
            if Int(currentValue)! > Int(exactly: maxValue)! {
                maxValue = Int(currentValue)!;
            }
        }
        
        return maxValue;
    }
}


