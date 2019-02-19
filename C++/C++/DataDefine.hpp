//
//  DataDefine.h
//  C++
//
//  Created by 陈应平 on 2019/2/17.
//  Copyright © 2019 陈应平. All rights reserved.
//

#ifndef DataDefine_h
#define DataDefine_h

#include <stdio.h>
#include <vector>
#include <unordered_map>
#include <map>

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

#endif /* DataDefine_h */
