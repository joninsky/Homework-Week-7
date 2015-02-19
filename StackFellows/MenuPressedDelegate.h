//
//  MenuPressedDelegate.h
//  StackFellows
//
//  Created by Jon Vogel on 2/18/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuPressedDelegate <NSObject>

-(void)menuOptionSelected:(NSInteger)selectedRow;

@end
