//
//  ProfileViewController.m
//  StackFellows
//
//  Created by Jon Vogel on 2/18/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserProfileModel.h"
#import "NetworkController.h"

@interface ProfileViewController ()
@property (retain, nonatomic) IBOutlet UIImageView *profileImage;
@property (retain, nonatomic) IBOutlet UITextView *profileText;
@property (retain, nonatomic) UserProfileModel *theUser;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [[NetworkController sharedService] fetchUserProfile:^(NSDictionary *jsonDictionary, NSString *error) {
    
    self.theUser = [[UserProfileModel createUser:jsonDictionary] retain];
    self.profileText.text = self.theUser.about;
    //[self loadInterface];
    [[NetworkController sharedService] fetchUserImage:self.theUser.avatarURL completionHandler:^(UIImage *image) {
      self.theUser.theImage = image;
      self.profileImage.image = self.theUser.theImage;
      //[self loadInterface];
    }];
  }];
  
  
}


-(void)loadInterface{
  
  self.profileText.text = self.theUser.about;
  self.profileImage.image = self.theUser.theImage;
  
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
  [self.theUser release];
  
  [super dealloc];
}

@end
