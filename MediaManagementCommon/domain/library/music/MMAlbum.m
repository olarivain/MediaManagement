//
//  MMAlbum.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMAlbum.h"
#import "MMArtist.h"

@interface MMAlbum()
- (id) initWithName: (NSString *) albumName;
@end

@implementation MMAlbum

+ (id) albumWithName: (NSString *) name
{
  return  [[[MMAlbum alloc] initWithName: name] autorelease];
}

- (id) initWithName: (NSString *) albumName
{
  self = [super init];
  if (self) 
  {
    tracks = [[NSMutableArray alloc] initWithCapacity: 10];
    name = [albumName retain];
    albumId = [[name lowercaseString] retain];
  }
  
  return self;
}

- (void)dealloc
{
  [tracks release];
  [name release];
  [super dealloc];
}

@synthesize albumId;
@synthesize name;
@synthesize tracks;
@synthesize artist;

#pragma mark - Track management
- (void) addTrack: (MMContent *) content
{
  if([tracks containsObject: content])
  {
    return;
  }
  
  [tracks addObject: content];
}

- (void) removeTrack: (MMContent *) content
{
  if(![tracks containsObject: content])
  {
    return;
  }
  
  [tracks removeObject: content];

  // album is now empty, delete ourself
  [[self retain] autorelease];
  if([tracks count] == 0)
  {
    [artist removeAlbum: self];
  }
}

@end
