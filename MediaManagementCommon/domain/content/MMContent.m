//
//  Content.m
//  MediaManagement
//
//  Created by Kra on 3/9/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMContent.h"

@interface MMContent(private)
- (id) init: (MMContentKind) kind;
- (BOOL) isSet: (NSString*) value;
@end
@implementation MMContent

+ (id) content: (MMContentKind) kind
{
  return [[[MMContent alloc] init: kind] autorelease];
}

- (id) init:(MMContentKind) contentKind
{
  self = [super init];
  if(self)
  {
    kind = contentKind;
  }
  return self;
}

- (void) dealloc
{
  [contentId release];
  [artist release];
  [album release];
  [genre release];
  [name release];
  [description release];
  [show release];
  [super dealloc];
}

@synthesize contentId;
@synthesize name;
@synthesize description;
@synthesize genre;
@synthesize kind;

@synthesize album;
@synthesize artist;
@synthesize trackNumber;

@synthesize show;
@synthesize episodeNumber;
@synthesize season;

#pragma mark - Business Logic
- (BOOL) isSet: (NSString*) value
{
  return [[value stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0;
}

- (BOOL) isArtistSet
{
  return [self isSet: artist];
}
- (BOOL) isAlbumSet
{
  return [self isSet: album];  
}

@end
