//
//  UserProfileModel.h
//  StackFellows
//
//  Created by Jon Vogel on 2/18/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileModel : NSObject

+(UserProfileModel*)createUser:(NSDictionary *)JSONDic;
@property (strong,nonatomic) NSString *about;
@property (strong,nonatomic) NSURL *avatarURL;
@property (strong, nonatomic) UIImage *theImage;

@end
