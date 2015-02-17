//
//  QuestionTableViewCell.h
//  StackFellows
//
//  Created by Jon Vogel on 2/17/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myImage;


@property (weak, nonatomic) IBOutlet UITextView *txtQuestion;


@end
