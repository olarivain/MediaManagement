//
//  MMPlaylistContentType.m
//  MediaManagementCommon
//
//  Created by Kra on 5/15/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMPlaylistContentType.h"

@interface MMPlaylistContentType()
- (id) initWithName: (NSString*) name andType: (MMSubContentType) type;
@end
@implementation MMPlaylistContentType

+ (id) playlistContentTypeWithName: (NSString*) name andType: (MMSubContentType) type
{
  return [[[MMPlaylistContentType alloc] initWithName:name andType:type] autorelease];
}

- (id) initWithName: (NSString*) contentName andType: (MMSubContentType) contentType
{
  self = [super init];
  if(self)
  {
    name = [contentName retain];
    type = contentType;
  }
  return self;
}

- (void) dealloc
{
  [name release];
  [super dealloc];
}

@synthesize name;
@synthesize type;

@end
