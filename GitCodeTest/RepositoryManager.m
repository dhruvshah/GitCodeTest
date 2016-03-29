//
//  RepositoryManager.m
//  GitCodeTest
//
//  Created by Dhruv Shah on 3/22/16.
//  Copyright © 2016 Match. All rights reserved.
//

#import "RepositoryManager.h"

@implementation RepositoryManager

@synthesize userRepoData,issueData;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static RepositoryManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        userRepoData = [[NSMutableArray alloc] init];
        issueData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getRepositoryData:(NSArray*)userRepos{
    
    if (userRepoData!=nil)
    {
        [userRepoData removeAllObjects];
    }
    for (int i=0; i<userRepos.count; i++)
    {
        NSDictionary *dict = [userRepos objectAtIndex:i];
        NSString *name = [dict objectForKey:@"name"];
        [userRepoData addObject:name];
    }
}

- (void)getIssuesData:(NSArray*)userRepos{
    
    if (issueData!=nil)
    {
        [issueData removeAllObjects];
    }
    for (int i=0; i<userRepos.count; i++)
    {
        NSDictionary *dict = [userRepos objectAtIndex:i];
        NSString *name = [dict objectForKey:@"title"];
        [issueData addObject:name];
    }
}

@end
