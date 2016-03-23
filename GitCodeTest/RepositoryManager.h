//
//  RepositoryManager.h
//  GitCodeTest
//
//  Created by Dhruv Shah on 3/22/16.
//  Copyright © 2016 Match. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryManager : NSObject

@property (nonatomic, strong) NSMutableArray *userRepoData;
@property (nonatomic, strong) NSMutableArray *issueData;

+ (id)sharedManager;
- (void)getRepositoryData:(NSArray*)userRepos;
- (void)getIssuesData:(NSArray*)userRepos;

@end
