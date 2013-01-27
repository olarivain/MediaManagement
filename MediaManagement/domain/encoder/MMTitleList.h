//
//  ITSTitleList.h
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMTitle;

/**
 Root aggregate for titles. So far, holds only a list of titles. I'm sure more will be coming in.
 */
@interface MMTitleList : NSObject
{
}

+ (MMTitleList *) titleListWithId: (NSString *) titleListId;

@property (nonatomic, readonly) NSArray *titles;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *titleListId;
@property (nonatomic, readonly) NSString *encodedTitleListId;
@property (nonatomic, readonly) NSArray *selectedTitles;
@property (nonatomic, readonly) BOOL isCompleted;
@property (nonatomic, readwrite, assign) BOOL active;

@property (nonatomic, readonly) MMTitle *activeTitle;
@property (nonatomic, readonly) NSInteger selectedCount;
@property (nonatomic, readonly) NSInteger completedCount;

- (void) addtitle: (MMTitle *) title;
- (NSInteger) indexOfTitle: (MMTitle *) title;
- (MMTitle *) titleWithIndex: (NSInteger) index;

- (BOOL) isCompleted;
- (MMTitle *) nextTitleToEncode;
@end
