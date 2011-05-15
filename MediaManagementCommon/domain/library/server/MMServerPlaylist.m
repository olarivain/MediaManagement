//
//  MMiTunesMediaLibrary.m
//  CLIServer
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMServerPlaylist.h"


@implementation MMServerPlaylist

+ (id) playlist 
{
  return [MMServerPlaylist playlistWithKind: MUSIC andSize:1000];
}

+ (id) playlistWithSize:(NSUInteger)size 
{
  return [MMServerPlaylist playlistWithKind: MUSIC andSize:size];
}

+ (id) playlistWithKind:(MMContentKind)kind andSize:(NSUInteger)size
{
  return [[[MMServerPlaylist alloc] initWithContentKind: kind andSize: size] autorelease];
}

- (id) initWithContentKind: (MMContentKind) kind andSize:(NSUInteger)size
{
  return [[[MMServerPlaylist alloc] initWithContentKind: kind andSize: size] autorelease];
}

- (void)dealloc
{
    [super dealloc];
}

- (void) contentAdded:(MMContent *)content
{
  // Do nothing!
}

- (void) contentRemoved:(MMContent *)content
{
  // Do nothing!
}

@end
