//
//  MMArtist.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMArtist.h"
#import "MMAlbum.h"
#import "MMContent.h"
#import "MMMusicPlaylist.h"

@interface MMArtist()
- (MMAlbum*) albumForContent: (MMContent *) content create: (BOOL) create;
- (id) initWithName: (NSString*) name;
- (void) addAlbum: (MMAlbum*) album;
@end

@implementation MMArtist

+ (id) artistWithName: (NSString*) name
{
  return [[[MMArtist alloc] initWithName: name] autorelease];
}

- (id) initWithName: (NSString*) artistName;
{
  self = [super init];
  if (self) 
  {
    name = [artistName retain];
    artistId = [name lowercaseString];
    albums = [[NSMutableArray alloc] initWithCapacity: 5];
    unknownAlbum = [[MMAlbum albumWithName: @"Unknown Album"] retain];
  }
  
  return self;
}

- (void)dealloc
{
  [albums release];
  self.name = nil;
  [unknownAlbum release];
  [super dealloc];
}

@synthesize library;
@synthesize name;
@synthesize albums;
@synthesize artistId;

#pragma mark - Album management
- (void) addAlbum: (MMAlbum*) album
{
  if([albums containsObject: albums])
  {
    return;
  }
  
  [albums addObject: album];
}

- (void) removeAlbum: (MMAlbum*) album
{
  if(![albums containsObject: albums])
  {
    return;
  }
  
  [albums removeObject: album];
  // if the album list is now empty, remove ourselves from library
  [[self retain] autorelease];
  if([albums count] == 0)
  {
    [library removeArtist: self];
  }
}

#pragma mark - Album track management
- (void) addTrack: (MMContent*) content
{
  // double check content kind
  if(content.kind != MUSIC)
  {
    NSLog(@"Warning, trying to add non music to an artist");
    return;
  }
  
  // get album for that 
  MMAlbum *contentAlbum = [self albumForContent: content create: TRUE];  
  // now we can safely add a track to the current album
  [contentAlbum addTrack: content];
}

- (void) removeTrack:(MMContent *)content
{
  MMAlbum *album = [self albumForContent: content create: FALSE];
  // TODO: this might blow up somehow...
  [album removeTrack: content];
}

- (MMAlbum*) albumForContent: (MMContent *) content create: (BOOL) create
{
  
  // album is not set, default to unknown album
  if(![content isAlbumSet])
  {
    return unknownAlbum;
  }
  
  MMAlbum *contentAlbum = nil;
  // TODO: this is not good, extract this logic to another place
  NSString *albumId = [content.album lowercaseString];
  
  BOOL foundAlbum = NO;  
  // start looking for an existing album with the right id
  for(MMAlbum *album in albums)
  {
    if([album.albumId compare: albumId options: NSLiteralSearch] == NSOrderedSame)
    {
      foundAlbum = YES;
      contentAlbum = album;
      break;
    }
  }
  
  // album hasn't been found, create it and add it to our list
  if(create && !foundAlbum)
  {
    contentAlbum = [MMAlbum albumWithName: content.album];
    [self addAlbum: contentAlbum];
  }
  
  return contentAlbum;
 
}

@end
