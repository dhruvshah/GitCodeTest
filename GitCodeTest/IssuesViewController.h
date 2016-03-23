//
//  IssuesViewController.h
//  GitCodeTest
//
//  Created by Dhruv Shah on 3/22/16.
//  Copyright © 2016 Match. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoryManager.h"

@interface IssuesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) NSString* userName;
@property(strong, nonatomic) NSString* repoName;
@property (strong, nonatomic) IBOutlet UITableView *issueTableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@end
