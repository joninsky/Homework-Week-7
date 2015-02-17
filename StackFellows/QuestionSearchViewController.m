//
//  QuestionSearchViewController.m
//  StackFellows
//
//  Created by Jon Vogel on 2/17/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "QuestionTableViewCell.h"
#import "NetworkController.h"
#import "QuestionModel.h"

@interface QuestionSearchViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (strong, nonatomic) NSArray *arrayOfQuestions;
@end

@implementation QuestionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.myTableView.delegate = self;
  self.myTableView.dataSource = self;
  self.mySearchBar.delegate = self;
  self.myTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
  
  [[NetworkController sharedService] fetchQuestionsForSearchTerm:searchBar.text completionHandle:^(NSArray *results, NSString *error) {
    
    self.arrayOfQuestions = results;
    
    [self.myTableView reloadData];
  }];
  
  
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  
  return self.arrayOfQuestions.count;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  QuestionTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
  
  Cell.myImage.image = nil;
  
  QuestionModel *theQuestion = self.arrayOfQuestions[indexPath.row];
  Cell.txtQuestion.text = theQuestion.title;
  if (!theQuestion.image) {
    [[NetworkController sharedService] fetchUserImage:theQuestion.avatarURL completionHandler:^(UIImage *image) {
      theQuestion.image = image;
      Cell.imageView.image = image;
      
    }];
    
  }else{
    Cell.imageView.image = theQuestion.image;
  }
  
  
  return Cell;
}




@end
