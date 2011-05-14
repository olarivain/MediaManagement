//
//  MMContentList.m
//  MediaManagementCommon
//
//  Created by Kra on 5/13/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMContentList.h"
#import "MMContent.h"

@interface MMContentList()
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, retain) NSArray *content;
@end
@implementation MMContentList

+ (id) contentListWithSubContentType: (MMSubContentType) contentType andName: (NSString*) name
{
  return [[[MMContentList alloc] initWithSubContentType: contentType andName: name] autorelease];
}

- (id) initWithSubContentType: (MMSubContentType) contentType andName: (NSString*) contentName
{
  self = [super init];
  if (self) 
  {
    subContentType = contentType;
    self.name = contentName;
    self.content = [NSMutableArray arrayWithCapacity: 20];
  }
  
  return self;
}

- (void)dealloc
{
  self.name = nil;
  self.content = nil;
  [super dealloc];
}

@synthesize subContentType;
@synthesize name;
@synthesize content;
@synthesize playlist;

- (void) addContent: (MMContent*)  newContent
{
  if([content containsObject: newContent])
  {
    return;
  }
  
  [content addObject: newContent];
}

- (void) removeContent: (MMContent*)  newContent
{
  if(![content containsObject: newContent])
  {
    return;
  }
  
  [content removeObject: newContent];
  if([content count] == 0)
  {
    [playlist removeContentList: self];
  }
}

@end
