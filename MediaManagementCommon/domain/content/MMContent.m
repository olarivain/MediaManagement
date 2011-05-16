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
  self.contentId = nil;
  self.artist = nil;
  self.album = nil;
  self.genre = nil;
  self.name = nil;
  self.description = nil;
  self.show = nil;
  self.season = nil;
  self.episodeNumber = nil;
  self.trackNumber = nil;
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

- (NSComparisonResult) compare: (MMContent*) other
{
  if(kind == MUSIC)
  {
    return [trackNumber compare: other.trackNumber];
  }
  
  if(kind == TV_SHOW)
  {
    return [episodeNumber compare: other.episodeNumber];
  }
  
  return [name caseInsensitiveCompare: other.name];
}

@end
