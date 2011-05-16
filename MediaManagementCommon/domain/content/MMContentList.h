//
//  MMContentList.h
//  MediaManagementCommon
//
//  Created by Kra on 5/13/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMPlaylist;
@class MMPlaylistContentType;
@class MMContent;

@interface MMContentList : NSObject {
@private
  NSString *name;
  MMPlaylistContentType *contentType;
  
  NSMutableArray *content;
  NSMutableArray *children;
  
  MMPlaylist *playlist;
}

+ (id) contentListWithSubContentType: (MMPlaylistContentType*) contentType andName: (NSString*) name;
- (id) initWithSubContentType: (MMPlaylistContentType*) contentType andName: (NSString*) contentName;

@property (nonatomic, readonly) MMPlaylistContentType *contentType;
@property (nonatomic, readonly, retain) NSString *name;
@property (nonatomic, readonly, retain) NSArray *content;
@property (nonatomic, readonly, retain) NSArray *children;
@property (nonatomic, readwrite, assign) MMPlaylist *playlist;

- (BOOL) addContent: (MMContent*)  content;
- (BOOL) removeContent: (MMContent*)  content;
- (NSInteger) contentCount;

- (void) addChild: (MMContentList*) child;
- (void) removeChild: (MMContentList*) child;
- (BOOL) hasChildren;

- (void) sortContent;

- (NSComparisonResult) compare: (MMContentList*) other;
@end
