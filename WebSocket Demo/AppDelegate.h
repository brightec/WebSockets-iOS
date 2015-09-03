//
//  AppDelegate.h
//  WebSocket Demo
//
//  Created by Chris Leversuch on 27/03/2015.
//  Copyright (c) 2015 Brightec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDSocket.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) WSDSocket *socket;

- (void)openSocketWithIP:(NSString *)ipAddress port:(NSInteger)port delegate:(id<WSDSocketDelegate>)delegate;
@end

