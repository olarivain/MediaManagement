//
//  MMLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMLibrary.h"
#import "MMMediaLibrary.h"

@implementation MMLibrary

#pragma mark - Constructor/destructors/getters
- (id)init
{
  self = [super init];
  if (self) 
  {
    mediaLibraries = [[NSMutableArray alloc] initWithCapacity:5];
  }
  
  return self;
}

- (void)dealloc
{
  [uniqueId release];
  self.name = nil;
  [mediaLibraries release];
  [super dealloc];
}

@synthesize uniqueId;
@synthesize name;
@synthesize mediaLibraries;

#pragma mark - Public business methods

- (void) addMedialibrary: (MMMediaLibrary*) mediaLibrary
{
  if([mediaLibraries containsObject: mediaLibrary])
  {
    return;
  }
  
  [mediaLibraries addObject: mediaLibrary];
  mediaLibrary.library = self;
}

@end
