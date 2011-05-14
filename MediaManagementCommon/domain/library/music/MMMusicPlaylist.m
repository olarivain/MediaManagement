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

@interface MMMusicPlaylist()
- (MMArtist*) artistForContent: (MMContent*) content create: (BOOL) create;
- (void) addArtist: (MMArtist*) artist;
@end
@implementation MMMusicPlaylist

+(id) playlist 
{
  return [MMMusicPlaylist playlistWithKind:MUSIC andSize:2000];
}

+(id) playlistWithSize:(NSUInteger)size 
{
  return [MMMusicPlaylist playlistWithKind:MUSIC andSize: size];
}

+ (id) playlistWithKind:(MMContentKind)kind size:(NSUInteger)size {
  return [[[MMMusicPlaylist alloc] initWithContentKind:kind andSize:size] autorelease];
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
    artists = [[NSMutableArray alloc] initWithCapacity: 100];
    unknownArtist = [[MMArtist artistWithName: @"Unknown Artist"] retain];
  }
  
  return self;
}

- (void)dealloc
{
  [artists release];
  [unknownArtist release];
  [super dealloc];
}

@synthesize artists;

#pragma mark - MMMediaLibrary callbacks
- (void) contentAdded:(MMContent *)content
{
  // create artist if needed and add it to list
  MMArtist *artist = [self artistForContent: content create: TRUE];
  [artist addTrack: content];
  [self addArtist: artist];
}

- (void) contentRemoved:(MMContent *)content
{
  // ask artist to remove track (artist will remove itself from library if it becomes empty
  MMArtist *artist = [self artistForContent: content create: FALSE];
  [artist removeTrack: content];
}

#pragma mark - Sections count
- (NSInteger) sectionsCount
{
  return  [artists count];
}

#pragma mark - Sections count
- (NSString*) titleForSection: (NSInteger) index
{
  MMArtist *artist = [artists objectAtIndex: index];
  return artist.name;
}

#pragma mark - Artist management
- (void) addArtist: (MMArtist*) artist
{
  if([artists containsObject: artist])
  {
    return;
  }
  
  [artists addObject: artist];
}

- (void) removeArtist: (MMArtist*) artist
{
  if(![artists containsObject: artist])
  {
    return;
  }
  
  [artists removeObject: artist];
}

- (MMArtist*) artistForContent: (MMContent*) content create: (BOOL) create
{
  if(![content isArtistSet])
  {
    return  unknownArtist;
  }
  
  MMArtist *contentArtist = nil;
  // TODO: this is not good, extract this logic to another place
  NSString *artistId = [content.artist lowercaseString];
  
  BOOL foundArtist = NO;  
  // start looking for an existing album with the right id
  for(MMArtist *artist in artists)
  {
    if([artist.artistId compare: artistId options: NSLiteralSearch] == NSOrderedSame)
    {
      foundArtist = YES;
      contentArtist = artist;
      break;
    }
  }
  
  // album hasn't been found, create it and add it to our list
  if(create && !foundArtist)
  {
    contentArtist = [MMArtist artistWithName: content.artist];
    [self addArtist: contentArtist];
  }
  return contentArtist;
}


@end
