//
//  MMLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMLibrary.h"

@implementation MMLibrary

#pragma mark - Constructor/destructors/getters
- (id)init
{
  self = [super init];
  if (self) 
  {
  }
  
  return self;
}

- (void)dealloc
{
  [uniqueId release];
  self.name = nil;
  [collections release];
  [super dealloc];
}

@synthesize uniqueId;
@synthesize name;
@synthesize collections;

#pragma mark - Public business methods
- (void) updateContent: (MMContent*) content 
{
#warning implement
}


@end
