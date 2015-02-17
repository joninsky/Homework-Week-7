//
//  ViewController.m
//  StackFellows
//
//  Created by Jon Vogel on 2/17/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "MenuTableViewController.h"
#import "WebOAuthViewController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
 
  
}


-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults stringForKey:@"token"];
  if (!token) {
    //show the user the web view for login
    WebOAuthViewController *webOAuthController = [[WebOAuthViewController alloc] init];
    
    [self presentViewController:webOAuthController animated:true completion:^{
      
      
      
    }];
    
  }
  
  
  
}









@end
