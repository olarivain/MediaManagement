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
  if([content containsObject: newContent])
  {
    return NO;
  }
  
  [content addObject: newContent];
  return YES;
}

- (BOOL) removeContent: (MMContent*)  newContent
{
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
  if(![self hasChildren])
  {
    return [content count];
  }
  
  // TODO: this assumes that a ContentList has children XOR content
  // make a decision whether this is true or not and fix the class
  // accordingly
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
  if(![children containsObject: child])
  {
    return;
  }
  
  [children removeObject: child];
}

- (BOOL) hasChildren
{
  return [children count] > 0;
}

- (NSInteger) childrenCount
{
  return [children count];
}

#pragma mark - Sortings
- (NSComparisonResult) compare: (MMContentList*) other
{
  return [name caseInsensitiveCompare: other.name];
}

- (void) sortContent
{
  [children sortUsingSelector: @selector(compare:)];
  [content sortUsingSelector:@selector(compare:)];
}

@end
