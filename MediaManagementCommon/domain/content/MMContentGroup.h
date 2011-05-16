//
//  MMContentGroup.h
//  MediaManagementCommon
//
//  Created by Kra on 5/15/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContentList;

typedef enum MMContentGroupType
{
  NONE = 0,
  ARTIST = 1,
  ALBUM = 2,
  SERIES = 3,
  SEASON = 4
} MMContentGroupType;

@interface MMContentGroup : NSObject {
  MMContentGroupType type;
  NSString *name;
  NSMutableArray *contentLists;
}

+ (id) contentGroupWithName: (NSString*) name andType: (MMContentGroupType) type;

@property (readonly) MMContentGroupType type;
@property (nonatomic, readonly, retain) NSString *name;
@property (nonatomic, readonly, retain) NSArray *contentLists;

- (MMContentList*) defaultContentList;
- (BOOL) addContentList: (MMContentList*) list;
- (BOOL) removeContentList: (MMContentList*) list;
- (MMContentList *) contentListWithName: (NSString *) listName;

- (void) sortContentLists;

- (void) clear;


@end
