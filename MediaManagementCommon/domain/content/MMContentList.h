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

// MMContentList is a root aggregate for MMContent objects.
// An MMContentList can either group content directly in it's content attribute (for example, Albums or Movies, who are 
// implemented as plain MMContentList)
// or it can have an extra layer of children MMContentList (for example, MMArtist or MMTVSHow, that has a list
// of Albums or Seaons, which in turn have the actual MMContent objects.
// The purpose of this class is to provide a decently simple abstraction of the multiple grouping criteria
// iTunes System library provide.
// Since objective-c's sorting api sorts big time, and also because this code will mostly be running on iphone
// with somewhat limited computing resources, the sorting of the subcontent has to be explicitly called, otherwise
// elements will be sorted in the order the content has been added to it which is pretty random.
// Note that sorting will NOT recursively sort children MMContentList if there are any. ie, sending MMArtist the sortContent message
// will sort the album list, but will NOT sort the albums' content.
// It is not technically enforced by the class, but it is somehow implicit that an MMContentList has content XOR children.
// A decision will be made later, make this 100% and enforce it in code if needed.
@interface MMContentList : NSObject {
    NSMutableArray *children;
@private
  NSString *name;
  MMContentGroupType type;
  
  NSMutableArray *content;
  
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

- (NSArray *) allContent;

- (void) sortContent;

- (NSComparisonResult) compare: (MMContentList*) other;
@end
