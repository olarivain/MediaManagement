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
#import "MMPlaylistContentType.h"

@interface MMContentList()
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, retain) NSArray *content;
@property (nonatomic, readwrite, retain) NSArray *children;
@end
@implementation MMContentList

+ (id) contentListWithSubContentType: (MMPlaylistContentType*) contentType andName: (NSString*) name
{
  return [[[MMContentList alloc] initWithSubContentType: contentType andName: name] autorelease];
}

- (id) initWithSubContentType: (MMPlaylistContentType*) type andName: (NSString*) contentName
{
  self = [super init];
  if (self) 
  {
    contentType = [type retain];
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
  [contentType release];
  [super dealloc];
}

@synthesize contentType;
@synthesize name;
@synthesize content;
@synthesize playlist;
@synthesize children;

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
    [playlist removeContentList: self];
  }
  return YES;
}

- (void) addChild: (MMContentList*) child

{
  if([children containsObject: children])
  {
    return;
  }
  
  [children addObject: child];
}

- (void) removeChild: (MMContentList*) child
{
  if(![children containsObject: children])
  {
    return;
  }
  
  [children removeObject: child];
}

- (void) sortContent
{
  [children sortUsingSelector: @selector(compare:)];
  [content sortUsingSelector:@selector(compare:)];
}

- (NSComparisonResult) compare: (MMContentList*) other
{
  return [name caseInsensitiveCompare: other.name];
}

@end
