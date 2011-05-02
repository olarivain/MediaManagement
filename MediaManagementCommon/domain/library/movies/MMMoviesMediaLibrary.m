//
//  MMMoviesMediaLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMMoviesMediaLibrary.h"


@implementation MMMoviesMediaLibrary

+ (id) mediaLibraryWithContentKind:(MMContentKind)kind
{
  return [MMMoviesMediaLibrary mediaLibraryWithContentKind: kind andSize: 2000];
}

+ (id) mediaLibraryWithContentKind:(MMContentKind)kind andSize:(NSUInteger)size
{
  return [[[MMMoviesMediaLibrary alloc] initWithContentKind: kind andSize:size] autorelease];
}

- (id)initWithContentKind:(MMContentKind)kind andSize:(NSUInteger)size
{
  self = [super initWithContentKind:kind andSize: size];
  if (self) 
  {
  }
  
  return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
