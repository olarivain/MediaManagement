//
//  MMTVShowPlaylist.m
//  MediaManagementCommon
//
//  Created by Kra on 5/31/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMTVShowPlaylist.h"
#import "MMTVShow.h"

@interface MMTVShowPlaylist()
- (MMContentList*) tvShowForContent: (MMContent*) content create: (BOOL) create;

@property (nonatomic, readwrite, retain) MMContentList *unknownShow;
@end

@implementation MMTVShowPlaylist

+(id) playlist 
{
  return [MMTVShowPlaylist playlistWithKind:TV_SHOW andSize:75];
}

+(id) playlistWithSize:(NSUInteger)size 
{
  return [[[MMTVShowPlaylist alloc] initWithContentKind:TV_SHOW andSize:size] autorelease];
}

- (id)initWithContentKind:(MMContentKind)kind andSize:(NSUInteger)size
{
  self = [super initWithContentKind:kind andSize: size];
  if (self) 
  {
    if(kind != MUSIC)
    {
      NSLog(@"FATAL: Music Playlist must have a kind of MUSIC");
    }
  }
  return self;
}

- (void)dealloc
{
  self.unknownShow = nil;
  [super dealloc];
}

@synthesize unknownShow;

- (MMContentGroup*) defaultContentGroup
{
  return [self contentGroupForType: SERIES];
}

- (NSArray*) initializeContentGroups
{
  MMContentGroup *series = [MMContentGroup contentGroupWithName:@"Series" andType: SERIES];
  return [NSArray arrayWithObject: series];
}

#pragma mark - MMMediaLibrary callbacks
- (void) contentAdded:(MMContent *)content
{
  // create artist if needed and add it to list
  MMContentList *tvShow = [self tvShowForContent: content create: YES];
  [tvShow addContent: content];
}

- (void) contentRemoved:(MMContent *)content
{
  // notify artist and album that the track is getting removed
  MMContentList *tvShow = [self tvShowForContent: content create: NO];
  [tvShow removeContent: content];
}

#pragma mark - TV Show management
- (MMContentList*) tvShowForContent: (MMContent*) content create: (BOOL) create
{
  // is artist isn't set, return default unknown artist
  if(![content isShowSet])
  {
    return  unknownShow;
  }
  
  MMContentGroup *contentGroup = [self contentGroupForType: SERIES];
  MMContentList *contentList = [contentGroup contentListWithName: content.show];
  
  if(contentList == nil && create)
  {
    contentList = [[[MMTVShow alloc] initWithType: SERIES andName: content.show] autorelease];
    [contentGroup addContentList: contentList];
  } 
  
  return contentList;
}

@end
