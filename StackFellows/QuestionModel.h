//
//  QuestionModel.h
//  StackFellows
//
//  Created by Jon Vogel on 2/17/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionModel : NSObject

+(NSArray *)questionsFromJSON:(NSData *)jsonData;

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSURL *avatarURL;
@property (strong,nonatomic) UIImage *image;

@end
