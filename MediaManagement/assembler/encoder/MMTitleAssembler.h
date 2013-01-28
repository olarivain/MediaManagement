//
//  MMTitleAssembler.h
//  MediaManagementCommon
//
//  Created by Larivain, Olivier on 12/29/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMTitleList;

@interface MMTitleAssembler : NSObject

+ (MMTitleAssembler *) sharedInstance;

- (NSArray *) createTitleListIDs: (NSDictionary *) dtos;
- (NSDictionary *) writeTitleListIDs: (NSArray *) titleLists;

- (NSArray *) writeTitleLists: (NSArray *) titleLists;
- (NSDictionary *) writeTitleList: (MMTitleList *) titleList;


@end
