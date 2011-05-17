//
//  MMMusicLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMMusicPlaylist.h"
#import "MMContent.h"
#import "MMArtist.h"
#import "MMContentList.h"
#import "MMContentGroup.h"

@interface MMMusicPlaylist()
- (MMContentList*) artistForContent: (MMContent*) content create: (BOOL) create;
- (MMContentList*) albumForContent: (MMContent*) content create: (BOOL) create;

@property (nonatomic, readwrite, retain) MMContentList *unknownArtist;
@property (nonatomic, readwrite, retain) MMContentList *unknownAlbum;
@end
@implementation MMMusicPlaylist

+(id) playlist 
{
  return [MMMusicPlaylist playlistWithKind:MUSIC andSize:2000];
}

+(id) playlistWithSize:(NSUInteger)size 
{
  return [[[MMMusicPlaylist alloc] initWithContentKind:MUSIC andSize:size] autorelease];
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
  self.unknownArtist = nil;
  self.unknownAlbum = nil;
  [super dealloc];
}

@synthesize unknownAlbum;
@synthesize unknownArtist;

- (NSArray*) initializeContentGroups
{
  MMContentGroup *songs = [MMContentGroup contentGroupWithName:@"Songs" andType: NONE];
  MMContentGroup *artists = [MMContentGroup contentGroupWithName:@"Artists" andType: ARTIST];
  MMContentGroup *albums = [MMContentGroup contentGroupWithName:@"Albums" andType: ALBUM];
  return [NSArray arrayWithObjects: artists, albums, songs, nil];
}

- (void) initializeContentLists
{
  unknownArtist = [MMArtist contentListWithType:ARTIST andName:@"Unknown Artist"];
  [self addContentList: unknownArtist];
  
  unknownAlbum = [MMContentList contentListWithType:ALBUM andName:@"Unknown Album"];
  [self addContentList: unknownAlbum];
  [super initializeContentLists];
}

#pragma mark - MMMediaLibrary callbacks
- (void) contentAdded:(MMContent *)content
{
  // create artist if needed and add it to list
  MMContentList *artist = [self artistForContent: content create: YES];
  [artist addContent: content];
  
  // same for album
  MMContentList *album = [self albumForContent: content create:YES];
  [album addContent: content];
}

- (void) contentRemoved:(MMContent *)content
{
  // notify artist and album that the track is getting removed
  MMContentList *artist = [self artistForContent: content create: NO];
  [artist removeContent: content];
  
  MMContentList *album = [self albumForContent: content create:NO];
  [album removeContent: content];
}

#pragma mark - Artist management
- (MMContentList*) artistForContent: (MMContent*) content create: (BOOL) create
{
  // is artist isn't set, return default unknown artist
  if(![content isArtistSet])
  {
    return  unknownArtist;
  }

  MMContentGroup *contentGroup = [self contentGroupForType: ARTIST];
  MMContentList *contentList = [contentGroup contentListWithName: content.artist];
  
  if(contentList == nil && create)
  {
    contentList = [[[MMArtist alloc  ]initWithType: ARTIST andName: content.artist] autorelease];
    [contentGroup addContentList: contentList];
  } 
  
  return contentList;
  // otherwise go with artist that has the same name, creating it if needed
//  return [self contentListWithType: ARTIST name: content.artist create:YES];
}

#pragma mark - Artist management
- (MMContentList*) albumForContent: (MMContent*) content create: (BOOL) create
{
  // if album isn't set, return default unknown album
  if(![content isAlbumSet])
  {
    return  unknownAlbum;
  }
  
  // otherwise go with album that has the same name, creating it if needed
  return [self contentListWithType: ALBUM name: content.album create:YES];
}

@end
