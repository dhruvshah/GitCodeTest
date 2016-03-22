//
//  ViewController.m
//  GitCodeTest
//
//  Created by Dhruv Shah on 3/22/16.
//  Copyright © 2016 Match. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tableData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"repositoryTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *issueId = @[self.searchTextField.text,[tableData objectAtIndex:indexPath.item]];
    [self performSegueWithIdentifier:@"IssueView" sender:issueId];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSArray *)sender
{
    IssuesViewController *issueViewController = (IssuesViewController *)[segue destinationViewController];
    issueViewController.userName = [sender objectAtIndex:0]; //get user Name
    issueViewController.repoName = [sender objectAtIndex:1]; //get Repository Name
}

- (IBAction)searchButtonTapped:(id)sender {  // API call to get Repos
    
    NSString *userName = self.searchTextField.text;
    
    if (self.searchTextField.text!=nil || ![userName isEqualToString:@""]) {
        
        tableData = [[NSMutableArray alloc] init];
        
        NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.github.com/users/%@/repos?",userName]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                             {
                                                 NSArray *userRepos = JSON;
                                                 for (int i=0; i<userRepos.count; i++)
                                                 {
                                                     NSDictionary *dict = [userRepos objectAtIndex:i];
                                                     NSString *name = [dict objectForKey:@"name"];
                                                     [tableData addObject:name];
                                                 }
                                                 
                                                 [self.repoTableView reloadData];
                                                 
                                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"User Not Found"
                                                                                                                          message:@"Please Enter a Valid Username"
                                                                                                                   preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                  handler:nil];
                                                 
                                                 [alertController addAction:actionOk];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                             }];
        
        [operation start];
    
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
