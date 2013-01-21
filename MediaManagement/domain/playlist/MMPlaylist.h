//
//  MMPlaylist.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMContent.h"
#import "MMContentGroup.h"

@class MMLibrary;
@class MMContentList;

@interface MMPlaylist : NSObject
{
    
}

@property (nonatomic, readonly) MMContentKind kind;
@property (nonatomic, readwrite, strong) NSString *uniqueId;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, weak) MMLibrary *library;
@property (nonatomic, readonly, strong) NSArray *contentGroups;
@property (nonatomic, readonly, strong) NSArray *content;

+ (id) playlistWithKind: (MMContentKind) kind andSize: (NSUInteger) size;

- (void) addContent: (MMContent*) content;
- (void) removeContent: (MMContent*) content;
- (void) updateContent: (MMContent *) content;

- (void) clear;

- (void) sortContent;

- (BOOL) belongsToPlaylist: (MMContent *) content;

@end
