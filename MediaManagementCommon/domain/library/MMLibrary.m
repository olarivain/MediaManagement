//
//  MMLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMLibrary.h"
#import "MMPlaylist.h"

@implementation MMLibrary

#pragma mark - Constructor/destructors/getters
- (id)init
{
  self = [super init];
  if (self) 
  {
    playlists = [[NSMutableArray alloc] initWithCapacity:5];
  }
  
  return self;
}

- (void)dealloc
{
  [uniqueId release];
  self.name = nil;
  [playlists release];
  [super dealloc];
}

@synthesize uniqueId;
@synthesize name;
@synthesize playlists;

#pragma mark - Public business methods

- (void) addPlaylist: (MMPlaylist*) mediaLibrary
{
  if([playlists containsObject: mediaLibrary])
  {
    return;
  }
  
  [playlists addObject: mediaLibrary];
  mediaLibrary.library = self;
}

- (void) clear
{
  for (MMPlaylist *playlist in playlists)
  {
    playlist.library = nil;
  }
  [playlists removeAllObjects];
}

@end
