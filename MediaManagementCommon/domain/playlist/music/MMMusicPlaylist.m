//
//  MMMusicLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMMusicPlaylist.h"
#import "MMContent.h"
#import "MMContentList.h"

@interface MMMusicPlaylist()
- (MMContentList*) artistForContent: (MMContent*) content create: (BOOL) create;
- (MMContentList*) albumForContent: (MMContent*) content create: (BOOL) create;
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
      MMPlaylistContentType *artist = [self contentType: ARTIST];
      unknownArtist = [MMContentList contentListWithSubContentType:artist andName:@"Unknown Artist"];
      [self addContentList: unknownArtist];

      MMPlaylistContentType *album = [self contentType: ARTIST];
      unknownAlbum = [MMContentList contentListWithSubContentType:album andName:@"Unknown Album"];
      [self addContentList: unknownAlbum];
    }
  }
  
  return self;
}

- (void)dealloc
{
  [super dealloc];
}

- (NSArray*) initializeContentTypes
{
  MMPlaylistContentType *songs = [MMPlaylistContentType playlistContentTypeWithName:@"Songs" andType: NONE];
  MMPlaylistContentType *artists = [MMPlaylistContentType playlistContentTypeWithName:@"Artists" andType: ARTIST];
  MMPlaylistContentType *albums = [MMPlaylistContentType playlistContentTypeWithName:@"Albums" andType: ALBUM];
  return [NSArray arrayWithObjects: songs, artists, albums, nil];
}

#pragma mark - MMMediaLibrary callbacks
- (void) contentAdded:(MMContent *)content
{
  // create artist if needed and add it to list
  MMContentList *artist = [self artistForContent: content create: YES];
  // TODO artist don't need references to their tracks, it'll go through the album
//  [artist addContent: content];
  
  MMContentList *album = [self albumForContent: content create:YES];
  [album addContent: content];
  
  // don't forget the artist has albums
  [artist addChild: album];
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

  // otherwise go with artist that has the same name, creating it if needed
  MMPlaylistContentType *artist = [self contentType: ARTIST];
  return [self contentListWithSubContentType: artist name: content.artist create:YES];
}

#pragma mark - Artist management
- (MMContentList*) albumForContent: (MMContent*) content create: (BOOL) create
{
  // if album isn't set, return default unknown album
  if(![content isArtistSet])
  {
    return  unknownArtist;
  }
  
  MMPlaylistContentType *album = [self contentType: ALBUM];
  // otherwise go with album that has the same name, creating it if needed
  return [self contentListWithSubContentType: album name: content.album create:YES];
}

@end
