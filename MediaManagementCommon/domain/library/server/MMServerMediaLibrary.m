//
//  MMiTunesMediaLibrary.m
//  CLIServer
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMServerMediaLibrary.h"


@implementation MMServerMediaLibrary

+ (id) mediaLibraryWithContentKind: (MMContentKind) kind
{
  return [MMServerMediaLibrary mediaLibraryWithContentKind: kind andSize: 2000];
}

+ (id) mediaLibraryWithContentKind: (MMContentKind) kind andSize:(NSUInteger)size
{
  return [[[MMServerMediaLibrary alloc] initWithContentKind: kind andSize: size] autorelease];
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
