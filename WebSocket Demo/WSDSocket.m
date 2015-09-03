//
//  WSDSocket.m
//  WebSocket Demo
//
//  Created by Chris Leversuch on 27/03/2015.
//  Copyright (c) 2015 Brightec. All rights reserved.
//

#import "WSDSocket.h"
#import <SocketRocket/SRWebSocket.h>


@interface WSDSocket () <SRWebSocketDelegate>
@property (strong, nonatomic) SRWebSocket *socket;
@end


@implementation WSDSocket


- (instancetype)initWithHost:(NSString *)host port:(NSInteger)port
{
    self = [super init];
    if (self) {
        NSString *urlString = [NSString stringWithFormat:@"ws://%@:%ld", host, port];
        NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        _socket = [[SRWebSocket alloc] initWithURLRequest:request];
        _socket.delegate = self;
    }
    return self;
}


- (void)open
{
    if (self.socket.readyState == SR_OPEN) {
        return;
    }

    [self.socket open];
}


- (void)close
{
    if (self.socket.readyState != SR_OPEN) {
        return;
    }

    [self.socket close];
}


- (BOOL)sendString:(NSString *)string
{
    if (self.socket.readyState != SR_OPEN) {
        return NO;
    }

    [self.socket send:string];
    return YES;
}


- (BOOL)isConnectionOpen
{
    return self.socket.readyState == SR_OPEN;
}


# pragma mark -
# pragma mark SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    if ([self.delegate respondsToSelector:@selector(socketDidOpen:)]) {
        [self.delegate socketDidOpen:self];
    }
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    if ([self.delegate respondsToSelector:@selector(socket:didReceiveMessage:)]) {
        [self.delegate socket:self didReceiveMessage:message];
    }
}


- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(socket:didFailWithError:)]) {
        [self.delegate socket:self didFailWithError:error];
    }
}


- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    if ([self.delegate respondsToSelector:@selector(socket:didCloseWithCode:reason:wasClean:)]) {
        [self.delegate socket:self didCloseWithCode:code reason:reason wasClean:wasClean];
    }
}


@end
