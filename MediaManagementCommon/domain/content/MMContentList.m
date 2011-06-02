//
//  MMContentList.m
//  MediaManagementCommon
//
//  Created by Kra on 5/13/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMContentList.h"
#import "MMContent.h"
#import "MMPlaylist.h"


@interface MMContentList()
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, retain) NSArray *content;
@property (nonatomic, readwrite, retain) NSArray *children;
@end
@implementation MMContentList

+ (id) contentListWithType: (MMContentGroupType) type andName: (NSString*) name
{
  return [[[MMContentList alloc] initWithType: (MMContentGroupType) type andName: name] autorelease];
}

- (id) initWithType: (MMContentGroupType) groupType andName: (NSString*) contentName
{
  self = [super init];
  if (self) 
  {
    type = groupType;
    self.name = contentName;
    // Default to 20 content and 5 subcontent
    self.content = [NSMutableArray arrayWithCapacity: 20];
    self.children = [NSMutableArray arrayWithCapacity: 5];
  }
  
  return self;
}

- (void)dealloc
{
  self.name = nil;
  self.content = nil;
  self.children = nil;
  [super dealloc];
}

@synthesize type;
@synthesize name;
@synthesize content;
@synthesize group;
@synthesize children;


#pragma mark - Content Management
- (BOOL) addContent: (MMContent*)  newContent
{
  // add content to list only if we don't have it already
  if([content containsObject: newContent])
  {
    return NO;
  }
  
  [content addObject: newContent];
  return YES;
}

- (BOOL) removeContent: (MMContent*)  newContent
{
  // remove content only if we actually have it
  if(![content containsObject: newContent])
  {
    return NO;
  }
  
  [content removeObject: newContent];
  if([content count] == 0)
  {
    [group removeContentList: self];
  }
  return YES;
}

- (NSInteger) contentCount
{
  // we don't have any children, return the count of content
  // directly under us
  if(![self hasChildren])
  {
    return [content count];
  }
  
  // otherwise, recursively call contentCount on our children 
  // and return the sum.
  NSInteger count = 0;
  for(MMContentList *contentList in children)
  {
    count += [contentList contentCount];
  }
  return count;
}


#pragma  mark - Children Management
- (void) addChild: (MMContentList*) child
{
  // add child only if it's non nil and we don't have it yet
  if(child == nil)
  {
    NSLog(@"child is nil");
  }
  if([children containsObject: child])
  {
    return;
  }
  
  [children addObject: child];
}

- (void) removeChild: (MMContentList*) child
{
  // attempt to remove child only if we're sure we have it
  if(![children containsObject: child])
  {
    return;
  }
  
  [children removeObject: child];
}

// wether this content list has sub content lists
- (BOOL) hasChildren
{
  return [children count] > 0;
}

// complete number of content DIRECTLY under this content list
- (NSInteger) childrenCount
{
  return [children count];
}

- (NSArray *) allContent
{
  if(![self hasChildren])
  {
    return content;
  }
  
  NSMutableArray *array = [NSMutableArray arrayWithCapacity: [self contentCount]];
  for(MMContentList *list in children)
  {
    [array addObjectsFromArray: [list allContent]];
  }
  return array;
}

#pragma mark - Sortings
// sub content lists are sorted alphabetically
- (NSComparisonResult) compare: (MMContentList*) other
{
  return [name caseInsensitiveCompare: other.name];
}

// sort children and direct children.
- (void) sortContent
{
  [children sortUsingSelector: @selector(compare:)];
  [content sortUsingSelector:@selector(compare:)];
}

@end
