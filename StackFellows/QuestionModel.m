//
//  QuestionModel.m
//  StackFellows
//
//  Created by Jon Vogel on 2/17/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "QuestionModel.h"


@implementation QuestionModel

+(NSArray *)questionsFromJSON:(NSData *)jsonData {
  
  NSError *error;
  NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
  if (error) {
    NSLog(@"%@",error.localizedDescription);
    return nil;
  }
  
  NSArray *items = [jsonDictionary objectForKey:@"items"];
  
  NSMutableArray *temp = [[NSMutableArray alloc] init];
  
  for (NSDictionary *item in items) {
    QuestionModel *question = [[QuestionModel alloc] init];
    question.title = item[@"title"];
    NSDictionary *userInfo = item[@"owner"];
    
    NSString *urlString = userInfo[@"profile_image"];
    
    question.avatarURL = [[NSURL alloc] initWithString:urlString];
    
    [temp addObject:question];
  }
  NSArray *final = [[NSArray alloc] initWithArray:temp];
  return final;
}

@end
