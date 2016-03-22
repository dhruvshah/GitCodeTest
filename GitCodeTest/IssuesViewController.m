//
//  IssuesViewController.m
//  GitCodeTest
//
//  Created by Dhruv Shah on 3/22/16.
//  Copyright © 2016 Match. All rights reserved.
//

#import "IssuesViewController.h"
#import "AFNetworking.h"

@interface IssuesViewController ()

@end

@implementation IssuesViewController

@synthesize tableData;
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getIssueList];  //API call to get Issues
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getIssueList
{
    tableData = [[NSMutableArray alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/issues?",self.userName,self.repoName]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             NSArray *userRepos = JSON;
                                             for (int i=0; i<userRepos.count; i++)
                                             {
                                                 NSDictionary *dict = [userRepos objectAtIndex:i];
                                                 NSString *name = [dict objectForKey:@"title"];
                                                 [tableData addObject:name];
                                             }
                                             
                                             if (tableData.count>0)
                                             {
                                                  [self.issueTableView reloadData];
                                             }
                                             
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                         }];
    

    
    [operation start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"issuesTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
        
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)backButtonPressed:(id)sender   //dismiss the Modal View
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
