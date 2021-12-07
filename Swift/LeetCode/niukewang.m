//
//  niukewang.m
//  LeetCode
//
//  Created by apiao on 2021/10/20.
//  Copyright © 2021 ChenYingPing. All rights reserved.
//

#import "niukewang.h"
#import <Foundation/Foundation.h>
#import <pthread.h>

@interface _YYLinkedMapNode : NSObject {
    @package
    __unsafe_unretained _YYLinkedMapNode *_prev; // retained by dic
    __unsafe_unretained _YYLinkedMapNode *_next; // retained by dic
    id _key;
    id _value;
    NSUInteger _cost;
    NSTimeInterval _time;
}
@end

@implementation _YYLinkedMapNode
@end

@interface _YYLinkedMap : NSObject {
    @package
    CFMutableDictionaryRef _dic; // do not set object directly
    NSUInteger _totalCost;
    NSUInteger _totalCount;
    _YYLinkedMapNode *_head;
    _YYLinkedMapNode *_tail;
    BOOL _releaseOnMainThread;
    BOOL _releaseAsynchronously;
}

- (void)insertNodeAtHead:(_YYLinkedMapNode *)node;

- (void)bringNodeToHead:(_YYLinkedMapNode *)node;

- (void)removeNode:(_YYLinkedMapNode *)node;

- (_YYLinkedMapNode *)removeTailNode;

- (void)removeAll;

@end

@implementation _YYLinkedMap

- (instancetype)init
{
    if (self = [super init]) {
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        _releaseOnMainThread = NO;
        _releaseAsynchronously = YES;
    }
    return self;
}


- (void)dealloc
{
    CFRelease(_dic);
}

- (void)insertNodeAtHead:(_YYLinkedMapNode *)node
{
    CFDictionarySetValue(_dic, (__bridge const void *)(node->_key), (__bridge const void *)(node));
    _totalCost += node->_cost;
    _totalCount++;
    if (_head) {
        node->_next = _head;
        _head->_prev = node;
        _head = node;
    } else {
        _head = _tail = node;
    }
}

- (void)bringNodeToHead:(_YYLinkedMapNode *)node
{
    if (_head == node) {
        return;
    }
    
    if (_tail == node) {
        _tail = node->_prev;
        _tail->_next = nil;
    } else {
        node->_next->_prev = node->_prev;
        node->_prev->_next = node->_next;
    }
    node->_next = _head;
    node->_prev = nil;
    _head->_prev = node;
    _head = node;
}

- (void)removeNode:(_YYLinkedMapNode *)node
{
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(node->_key));
    _totalCost -= node->_cost;
    _totalCount--;
    if (node->_next) node->_next->_prev = node->_prev;
    if (node->_prev) node->_prev->_next = node->_next;
    if (_head == node) _head = node->_next;
    if (_tail == node) _tail = node->_prev;
}

- (_YYLinkedMapNode *)removeTailNode
{
    if (!_tail) return  nil;
    _YYLinkedMapNode *tail = _tail;
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(_tail->_key));
    _totalCost -= _tail->_cost;
    _totalCount--;
    if (_head == _tail) {
        _head = _tail = nil;
    } else {
        _tail = _tail->_prev;
        _tail->_next = nil;
    }
    return tail;
}

- (void)removeAll
{
    _totalCost = 0;
    _totalCount = 0;
    _head = _tail = nil;
    if (CFDictionaryGetCount(_dic) > 0) {
        CFMutableDictionaryRef holder = _dic;
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        if (_releaseAsynchronously) {
            dispatch_queue_t queue = _releaseOnMainThread ? dispatch_get_main_queue() : dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
            dispatch_async(queue, ^{
                CFRelease(holder);
            });
        } else if (_releaseOnMainThread && !pthread_main_np()) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CFRelease(holder); // hold and release in specified queue
            });
        } else {
            CFRelease(holder);
        }
    }
}

@end

@interface ListNode : NSObject
@property (nonatomic, assign) int val;
@property (nonatomic, strong) ListNode *next;
@end

@implementation ListNode

- (instancetype)init:(int)val next:(ListNode *)next {
    self = [super init];
    if (self) {
        self.val = val;
        self.next = next;
    }
    return self;
}

@end

@interface TreeNode : NSObject
@property (nonatomic, assign) int val;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;
@end

@implementation TreeNode

- (instancetype)init:(int)val left:(TreeNode *)left right:(TreeNode *)right {
    self = [super init];
    if (self) {
        self.val = val;
        self.left = left;
        self.right = right;
    }
    return self;
}

- (NSMutableArray *)levelOrder:(TreeNode *)root
{
    if (root == nil) {
        return nil;
    }
    
    NSMutableArray *leves = [NSMutableArray new];
    
    NSMutableArray *queue = [NSMutableArray new];
    [queue addObject:root];
    while (queue.count) {
        NSUInteger count = queue.count;
        NSMutableArray *tempArr = [NSMutableArray new];
        for (NSUInteger i = 0; i < count; i++) {
            TreeNode *node = [queue firstObject];
            [queue removeObjectAtIndex:0];
            [tempArr addObject:@(node.val)];
            if (node.left) {
                [queue addObject:node.left];
            }
            if (node.right) {
                [queue addObject:node.right];
            }
        }
        [leves addObject:tempArr];
    }
    
    return leves;
}

@end

@implementation niukewang

- (ListNode *)removeNthFromEnd:(ListNode *)head n:(int)n
{
    ListNode *dumyHead = [[ListNode alloc] init:0 next:head];
    ListNode *preSlow = dumyHead;
    ListNode *slow = head;
    ListNode *fast = head;
    while (fast != nil) {
        fast = fast.next;
        if (n <= 0) {
            preSlow = slow;
            slow = slow.next;
        }
        n--;
    }
    preSlow.next = slow.next;
    return dumyHead.next;
}

int maxSum = 0;
- (int)maxPathSum:(TreeNode *)root
{
    if (root == nil) {
        return 0;
    }
    int val = root.val;
    int sumLeft = 0;
    int sumRight = 0;
    if (root.left) {
        sumLeft = [self maxPathSum:root.left];
    }
    if (root.right) {
        sumRight = [self maxPathSum:root.right];
    }
    if (val > maxSum) {
        maxSum = val;
    }
    if (sumLeft > maxSum) {
        maxSum = sumLeft;
    }
    if (sumRight > maxSum) {
        maxSum = sumRight;
    }
    if (val + sumLeft + sumRight > maxSum) {
        maxSum = val + sumLeft + sumRight;
    }
    
    return maxSum;
}

- (int)trap:(NSArray *)height
{
    if (height.count < 3) {
        return 0;
    }
    NSUInteger left = 0;
    NSUInteger right = height.count - 1;
    int maxLeft = [height[left] intValue];
    int maxRight = [height[right] intValue];
    int result = 0;
    while (left < right) {
        if (maxLeft < maxRight) {
            left += 1;
            int leftNextValue = [height[left] intValue];
            if (leftNextValue < maxLeft) {
                result += maxLeft - leftNextValue;
            } else {
                maxLeft = leftNextValue;
            }
        } else {
            right -= 1;
            int rightPreValue = [height[right] intValue];
            if (rightPreValue < maxRight) {
                result += maxRight - rightPreValue;
            } else {
                maxRight = rightPreValue;
            }
        }
    }
    
    return result;
}

@end
