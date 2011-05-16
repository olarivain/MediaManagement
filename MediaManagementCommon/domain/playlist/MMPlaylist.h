//
//  MMPlaylist.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMContent.h"

@class MMLibrary;
@class MMContentList;
@class MMPlaylistContentType;

@interface MMPlaylist : NSObject 
{
@private
  MMContentKind kind;
  NSString *uniqueId;
  NSString *name;
  
  MMLibrary *library;
  
  NSMutableArray *contentLists;
  NSArray *contentTypes;
  NSMutableDictionary *contentListBySubContentType;
}

@property (readonly) MMContentKind kind;
@property (nonatomic, readwrite, retain) NSString *uniqueId;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, assign) MMLibrary *library;
@property (readonly) NSArray *contentLists;
@property (readonly) NSArray *contentTypes;

+ (id) playlist;
+ (id) playlistWithSize: (NSUInteger) size;
+ (id) playlistWithKind: (MMContentKind) kind andSize: (NSUInteger) size;

- (void) addContent: (MMContent*) content;
- (void) removeContent: (MMContent*) content;

- (void) addContentList: (MMContentList*) contentList;
- (void) removeContentList: (MMContentList*) contentList;

- (MMContentList*) defaultContentList;
- (void) clearPlaylist;

- (NSArray*) contentListsWithSubContentType: (MMPlaylistContentType*) contentType;
- (MMContentList*) contentListsWithSubContentType: (MMPlaylistContentType*) contentType andName: (NSString*) name;

- (void) sortContent;

- (BOOL) isSystem;

@end
