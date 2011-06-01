//
//  MMContentGroup.m
//  MediaManagementCommon
//
//  Created by Kra on 5/15/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMContentGroup.h"
#import "MMContentList.h"
#import "MMContent.h"

@interface MMContentGroup()
- (id) initWithName: (NSString*) name andType: (MMContentGroupType) type;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, retain) NSMutableArray *contentLists;
@end

@implementation MMContentGroup

+ (id) contentGroupWithName: (NSString*) name andType: (MMContentGroupType) type
{
  return [[[MMContentGroup alloc] initWithName: name andType:type] autorelease];
}

- (id) initWithName: (NSString*) groupName andType: (MMContentGroupType) groupType
{
  self = [super init];
  if(self)
  {
    self.name = groupName;
    type = groupType;
    self.contentLists = [NSMutableArray arrayWithCapacity: 20];
  }
  return self;
}

- (void) dealloc
{
  self.contentLists = nil;
  self.name = nil;
  [super dealloc];
}

@synthesize contentLists;
@synthesize name;
@synthesize type;

#pragma mark - Content List management
- (BOOL) addContentList:(MMContentList *)list
{
  if([contentLists containsObject: list])
  {
    return NO;
  }
  
  [contentLists addObject: list];
  return YES;
}

- (BOOL) removeContentList: (MMContentList*) list
{
  if(![contentLists containsObject: list])
  {
    return NO;
  }
  
  [contentLists removeObject: list];
  return YES;
}

- (MMContentList*) defaultContentList
{
  if([contentLists count] == 1)
  {
    return [contentLists objectAtIndex:0];
  }
  
  for(MMContentList *contentList in contentLists)
  {
    if(contentList.type == NONE)
    {
      return contentList;
    }
  }
  
  return nil;
}

- (MMContentList*) contentListWithName:(NSString *)listName
{
  for(MMContentList *contentList in contentLists)
  {
    if([contentList.name caseInsensitiveCompare: listName] == NSOrderedSame)
    {
      return contentList;
    }
  }
  return nil;
}

- (void) clear
{
  [contentLists removeAllObjects];
}

#pragma mark - Content List Count and accessors
- (NSInteger) contentListCount
{
  NSInteger count = 0;
  for(MMContentList *contentList in contentLists)
  {
    count += [contentList childrenCount] + 1;
  }
  return  count;
}

// flattens the list of content (ie, goes through children's content if any
// and return the content list at a given index.
- (MMContentList*) contentListForFlatIndex: (NSInteger) index
{
  NSInteger counter = 0;
  for(MMContentList *contentList in contentLists)
  {
    if(counter == index)
    {
      return contentList;
    }
    counter++;
    NSArray *childrenContentLists = [contentList children];
    for(MMContentList *childContentList in childrenContentLists)
    {
      if(counter == index)
      {
        return childContentList;
      }
      counter++;
    }
  }
  return nil;
}

// returns a content at index "row" in content list at index "seciton"
- (MMContent*) contentForSection: (NSInteger) section andRow: (NSInteger) row
{
  MMContentList *contentList = [self contentListForFlatIndex: section];
  return [[contentList content] objectAtIndex: row];
}

#pragma mark - Sort
- (void) sortContentLists
{
  [contentLists sortUsingSelector:@selector(compare:)];
  for(MMContentList *contentList in contentLists)
  {
    [contentList sortContent];
  }
}

@end
