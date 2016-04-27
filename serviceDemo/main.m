//
//  main.m
//  serviceDemo
//
//  Created by yangjie on 16-3-20.
//  Copyright (c) 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SocketService.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        SocketService *service = [[SocketService alloc] init];
        [service start];
        
        [[NSRunLoop mainRunLoop] run];
        
    }
    return 0;
}
