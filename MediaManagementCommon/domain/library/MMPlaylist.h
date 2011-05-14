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

typedef enum MMSubContentType
{
  ARTIST = 0,
  ALBUM = 1,
  SERIES = 2,
  SEASON = 3
} MMSubContentType;

@interface MMPlaylist : NSObject 
{
@private
  MMContentKind kind;
  NSString *uniqueId;
  NSString *name;
  MMLibrary *library;
  
  NSMutableArray *content;
  NSMutableArray *contentLists;
  NSMutableDictionary *contentListBySubContentType;
}

@property (readonly) MMContentKind kind;
@property (readonly) NSString *uniqueId;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, assign) MMLibrary *library;
@property (readonly) NSArray *content;
@property (readonly) NSArray *contentLists;

+ (id) playlist;
+ (id) playlistWithSize: (NSUInteger) size;
+ (id) playlistWithKind: (MMContentKind) kind andSize: (NSUInteger) size;

- (void) addContent: (MMContent*) content;
- (void) removeContent: (MMContent*) content;

- (void) addContentList: (MMContentList*) contentList;
- (void) removeContentList: (MMContentList*) contentList;

- (NSArray*) contentListsWithSubContentType: (MMSubContentType) contentType;
- (MMContentList*) contentListsWithSubContentType: (MMSubContentType) contentType andName: (NSString*) name;

@end
