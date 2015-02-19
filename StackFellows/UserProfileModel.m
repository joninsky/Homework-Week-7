//
//  UserProfileModel.m
//  StackFellows
//
//  Created by Jon Vogel on 2/18/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "UserProfileModel.h"

@implementation UserProfileModel



+(UserProfileModel*)createUser:(NSDictionary *)JSONdic{
  
  UserProfileModel *theUser = [[UserProfileModel alloc] init];
  
  NSLog(@"%@", JSONdic);
  
  NSArray *userArray = JSONdic[@"items"];
  NSDictionary *userDictionary = [userArray firstObject];
  
  theUser.about = userDictionary[@"display_name"];
    NSString *urlAsString = [[NSString alloc] initWithFormat:@"%@", userDictionary[@"profile_image"] ];
    
    theUser.avatarURL = [[NSURL alloc] initWithString:urlAsString];
  
  return theUser;
}



@end
