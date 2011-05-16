//
//  MMContentList.h
//  MediaManagementCommon
//
//  Created by Kra on 5/13/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMContentGroup.h"

@class MMContent;

@interface MMContentList : NSObject {
@private
  NSString *name;
  MMContentGroupType type;
  
  NSMutableArray *content;
  NSMutableArray *children;
  
  MMContentGroup *group;
}

+ (id) contentListWithType: (MMContentGroupType) contentType andName: (NSString*) name;
- (id) initWithType: (MMContentGroupType) type andName: (NSString*) contentName;

@property (nonatomic, readonly) MMContentGroupType type;
@property (nonatomic, readonly, retain) NSString *name;
@property (nonatomic, readonly, retain) NSArray *content;
@property (nonatomic, readonly, retain) NSArray *children;
@property (nonatomic, readwrite, assign) MMContentGroup *group;

- (BOOL) addContent: (MMContent*)  content;
- (BOOL) removeContent: (MMContent*)  content;
- (NSInteger) contentCount;

- (void) addChild: (MMContentList*) child;
- (void) removeChild: (MMContentList*) child;
- (NSInteger) childrenCount;
- (BOOL) hasChildren;

- (void) sortContent;

- (NSComparisonResult) compare: (MMContentList*) other;
@end
