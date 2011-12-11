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
  return [[MMContent alloc] init: kind];
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


@synthesize parent;
@synthesize contentId;
@synthesize playlistId;
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

#pragma mark - Convenience accessors to determine if an attribute is set.
- (BOOL) isSet: (NSString*) value
{
  return [[value stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0;
}

- (BOOL) isArtistSet
{
  return artist != nil && [self isSet: artist];
}
- (BOOL) isAlbumSet
{
  return album != nil && [self isSet: album];  
}

- (BOOL) isShowSet 
{
  return show != nil && [self isSet: show];
}

- (BOOL) isSeasonSet 
{
  return season != nil && [season intValue] > 0;
}

- (BOOL) isMusic
{
  return kind == MUSIC;
}

- (BOOL) isMovie
{
  return kind == MOVIE;  
}

- (BOOL) isTvShow
{
  return kind == TV_SHOW;
}

#pragma mark - Comparison method
- (NSComparisonResult) compare: (MMContent*) other
{
  // TODO: this is pretty brutal.
  // Should sort by artist, then album, then track.
  // Same concept for TV Shows.
  // failback to name based sort if we don't have anything else.
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
