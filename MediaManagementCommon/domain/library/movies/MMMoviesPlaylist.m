//
//  MMMoviesMediaLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMMoviesPlaylist.h"


@implementation MMMoviesPlaylist

+ (id) playlist 
{
  return [MMMoviesPlaylist playlistWithKind:MOVIE andSize:500];
}

+ (id) playlistWithSize:(NSUInteger)size
{
  return [[[MMMoviesPlaylist alloc] initWithContentKind: MOVIE andSize: size] autorelease];

}

- (id)initWithContentKind:(MMContentKind)kind andSize:(NSUInteger)size
{
  self = [super initWithContentKind:kind andSize: size];
  if (self) 
  {
    if(kind != MOVIE)
    {
      NSLog(@"FATAL: Movie Library Must have a type of MOVIE");
    }
  }
  
  return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) contentAdded: (MMContent *) content
{
  // do nothing;
}

- (void) contentRemoved: (MMContent *) content
{
  // do nothing;
}

@end
