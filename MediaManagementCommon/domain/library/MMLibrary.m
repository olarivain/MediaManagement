//
//  MMLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMLibrary.h"

#import "MMPlaylist.h"

@interface MMLibrary ()
@property (nonatomic, readwrite, strong) NSMutableArray *playlists;
@property (nonatomic, readwrite, strong) NSString *uniqueId;
@end

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

- (void) updateContent:(MMContent *)content {
  // content didn't move to another playlist, just tell the parent
  // that the content has been updated, should do the trick
  if([content.parent belongsToPlaylist: content]) {
    [content.parent updateContent: content];
    return;
  }
  
  // content did move to another playlist, so start by remove content
  // from here first.
  [content.parent removeContent: content];
  
  // now, find the playlist to which it belongs, and add it.
  // add it to the first one that claims the content belongs to it,
  // the object design should make this a valid assumption.
  for(MMPlaylist *playlist in playlists) {
    if([playlist belongsToPlaylist: content]) {
      [playlist addContent: content];
    }
  }
  
}

@end
