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
@private
  MMContentKind kind;
  NSString *uniqueId;
  NSString *name;
  
  MMLibrary *library;
  
  NSMutableArray *contentGroups;
}

@property (readonly) MMContentKind kind;
@property (nonatomic, readwrite, retain) NSString *uniqueId;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, assign) MMLibrary *library;
@property (readonly) NSArray *contentGroups;

+ (id) playlist;
+ (id) playlistWithSize: (NSUInteger) size;
+ (id) playlistWithKind: (MMContentKind) kind andSize: (NSUInteger) size;

- (void) addContent: (MMContent*) content;
- (void) removeContent: (MMContent*) content;

- (void) addContentList: (MMContentList*) contentList;
- (void) removeContentList: (MMContentList*) contentList;

- (MMContentGroup*) defaultContentGroup;
- (MMContentList*) defaultContentList;
- (void) clear;

- (MMContentGroup*) contentGroupForType: (MMContentGroupType) type;
- (MMContentList*) contentListsWithType: (MMContentGroupType) contentType andName: (NSString*) name;

- (void) sortContent;

- (BOOL) isSystem;

@end