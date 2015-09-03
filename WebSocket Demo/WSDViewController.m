//
//  ViewController.m
//  WebSocket Demo
//
//  Created by Chris Leversuch on 27/03/2015.
//  Copyright (c) 2015 Brightec. All rights reserved.
//

#import "WSDViewController.h"
#import "AppDelegate.h"


static NSString *const kIpAddress = @"";
static NSInteger const kPort = 12345;


@interface WSDViewController () <WSDSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;
@end


@implementation WSDViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate openSocketWithIP:kIpAddress port:kPort delegate:self];

    self.responseLabel.text = nil;
}


- (IBAction)sendMessageButtonWasTouched:(UIButton *)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.socket sendString:self.textField.text];
}


#pragma mark -
#pragma mark WSDSocketDelegate

- (void)socketDidOpen:(WSDSocket *)socket
{
    NSLog(@"socketDidOpen");
}


- (void)socket:(WSDSocket *)socket didReceiveMessage:(NSString *)message
{
    NSLog(@"didReceiveMessage: %@", message);
    self.responseLabel.text = message;
}


- (void)socket:(WSDSocket *)socket didFailWithError:(NSError *)error
{
}


- (void)socket:(WSDSocket *)socket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
}


@end
