//
//  SocketService.m
//  serviceDemo
//
//  Created by yangjie on 16-3-20.
//  Copyright (c) 2016年 YJ. All rights reserved.
//

#import "SocketService.h"
#import "GCDAsyncSocket.h"

@interface SocketService ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;

@property (nonatomic, strong) NSMutableArray *socketsArr;

@end

@implementation SocketService

-(NSMutableArray *)socketsArr
{
    if (!_socketsArr) {
        _socketsArr = [NSMutableArray array];
    }
    
    return _socketsArr;
    
    
}

- (void)start
{
    
    GCDAsyncSocket *socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    NSError *error = nil;
    [socket acceptOnPort:5288 error:&error];
    
    if (!error) {
        NSLog(@"服务开启成功");
    }else{
        NSLog(@"失败: %@", error);
    }
    
    self.socket = socket;
    
}

-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    NSLog(@"sock = %@", sock);
    
    NSLog(@"newSocket = %@", newSocket);
    [newSocket readDataWithTimeout:-1 tag:0];
    
    [self.socketsArr addObject:newSocket];
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    
    NSInteger num = [str integerValue];
    
    NSString *writeStr = nil;
    switch (num) {
        case 1:
        {
            writeStr = @"充值服务\n";
        }
            
            break;
        case 2:
        {
            writeStr = @"瞎扯淡\n";
        }
            
            break;
        case 3:
        {
            writeStr = @"随便聊\n";
        }
            
            break;
        case 4:
        {
            writeStr = @"特殊服务\n";
        }
            
            break;
            
        default:
            break;
    }
    
    NSData *writeData = [writeStr dataUsingEncoding:NSUTF8StringEncoding];
    [sock writeData:writeData withTimeout:-1 tag:0];
    
    [sock readDataWithTimeout:-1 tag:0];
    
}

@end
