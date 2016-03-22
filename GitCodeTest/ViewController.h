//
//  ViewController.h
//  GitCodeTest
//
//  Created by Dhruv Shah on 3/22/16.
//  Copyright © 2016 Match. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssuesViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *repoTableView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) NSMutableArray *tableData;


@end

