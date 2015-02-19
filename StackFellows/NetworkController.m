//
//  NetworkController.m
//  StackFellows
//
//  Created by Jon Vogel on 2/17/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "NetworkController.h"
#import "QuestionModel.h"

@implementation NetworkController


+(id)sharedService{
  static NetworkController *myNetworkController;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    myNetworkController = [[NetworkController alloc] init];
  });
  return myNetworkController;
}

-(void)fetchQuestionsForSearchTerm:(NSString *)searchTerm completionHandle:(void (^) (NSArray *results, NSString *error))complete{
  //Get the token fromt he user defaults
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults objectForKey:@"token"];
  //Create the string version and insert the token key
  NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle=%@&access_token=%@&key=Cqcpk6vU6otlh86XaBrErA((", searchTerm,token];
  NSLog(@"%@", urlString);
  //Init an NSURL with the url string
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  //Create a request and set the type to post
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  //Create the data task and give it a shared instance of NSURLSession, the request, and then the completion handlerer logic.
  NSURLSessionTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //Check the error
    if (error) {
      complete(nil, @"Error getting on the internet");
    }else{
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSLog(@"%ld", (long)httpResponse.statusCode);
      switch (httpResponse.statusCode) {
        case 200 ... 299:
        {
          NSArray *theResults = [QuestionModel questionsFromJSON:data];
         dispatch_async(dispatch_get_main_queue(), ^{
           
           complete(theResults, nil);
         });
        }
          break;
          
        default:
        {
          NSLog(@"%ld", (long)httpResponse.statusCode);
        }
          break;
      }
    }
  }];
  [dataTask resume];
}


-(void)fetchUserProfile: (void (^)(NSDictionary *jsonDictionary, NSString *error))completion {
  //Get the token fromt he user defaults
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults objectForKey:@"token"];
  //Create the string version and insert the token key
  NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.stackexchange.com/2.2/me?order=desc&sort=reputation&site=stackoverflow&access_token=%@&key=Cqcpk6vU6otlh86XaBrErA((", token];//;?order=desc&sort=reputation&site=stackoverflow"];//&access_token=%@", token]; ?access_token=%@", token
  NSLog(@"%@", urlString);
  //Init an NSURL with the url string
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  //Create a request and set the type to post
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  //[request setValue:token forHTTPHeaderField:@"Authorization"];
  //Create the data task and give it a shared instance of NSURLSession, the request, and then the completion handlerer logic.
  NSURLSessionTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //Check the error
    if (error) {
      completion(nil, @"Error getting on the internet");
    }else{
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSLog(@"%ld", (long)httpResponse.statusCode);
      switch (httpResponse.statusCode) {
        case 200 ... 299:
        {
          NSDictionary *theDictionarywithUserInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
          
          dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(theDictionarywithUserInfo, nil);
          });
        }
          break;
          
        default:
        {
          NSLog(@"%ld", (long)httpResponse.statusCode);
        }
          break;
      }
    }
  }];
  [dataTask resume];
}


-(void)fetchUserImage:(NSURL *)theURL completionHandler:(void (^)(UIImage *image))completion{
  
  dispatch_queue_t imageQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
  
  dispatch_async(imageQueue, ^{
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:theURL];
    UIImage *theImage = [[UIImage alloc] initWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      completion(theImage);
    });
    
  });
  
  
}




@end
