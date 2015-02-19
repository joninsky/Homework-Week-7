//
//  NetworkController.h
//  StackFellows
//
//  Created by Jon Vogel on 2/17/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkController : NSObject

+(id)sharedService;
-(void)fetchQuestionsForSearchTerm:(NSString *)searchTerm completionHandle:(void (^) (NSArray *results, NSString *error))complete;

-(void)fetchUserProfile: (void (^)(NSDictionary *jsonDictionary, NSString *error))completion;
-(void)fetchUserImage:(NSURL*)theURL completionHandler:(void (^)(UIImage *image))completion;

@end
