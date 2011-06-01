//
//  MMContentGroup.h
//  MediaManagementCommon
//
//  Created by Kra on 5/15/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContentList;
@class MMContent;
typedef enum MMContentGroupType
{
  NONE = 0,
  ARTIST = 1,
  ALBUM = 2,
  SERIES = 3,
  SEASON = 4
} MMContentGroupType;


// An MMContentGroup groups MMContentList by "kind" (artist, album, series etc.).
// It is held by playlists, typically a playlist will have multiple content groups, one per
// natural grouping criteria for that type of playlist (artist+album for music, tv show + seasons
// for series), but it can also have one and only one, for example movies or books.
// An MMContentGroup provides a default content list, which is meant as a catch all for content
// that don't have enough meta data to be added to a specific content list (typically, UnknownArtist etc.)
@interface MMContentGroup : NSObject {
  MMContentGroupType type;
  NSString *name;
  NSMutableArray *contentLists;
}

+ (id) contentGroupWithName: (NSString*) name andType: (MMContentGroupType) type;

@property (readonly) MMContentGroupType type;
@property (nonatomic, readonly, retain) NSString *name;
//@property (nonatomic, readonly, retain) NSArray *contentLists;

- (MMContentList*) defaultContentList;
- (BOOL) addContentList: (MMContentList*) list;
- (BOOL) removeContentList: (MMContentList*) list;
- (MMContentList *) contentListWithName: (NSString *) listName;

- (NSInteger) contentListCount;
- (MMContentList*) contentListForFlatIndex: (NSInteger) index;
- (MMContent*) contentForSection: (NSInteger) section andRow: (NSInteger) row;

- (void) sortContentLists;

- (void) clear;


@end
