//
//  ITSTitleList.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
//

#import "MMTitleList.h"

#import "MMTitle.h"

@implementation MMTitleList

+ (MMTitleList *) titleList
{
  return [[MMTitleList alloc] init];
}

- (id) init
{
  self = [super init];
  if(self)
  {
    titles = [NSMutableArray arrayWithCapacity: 10];
  }
  return self;
}

@synthesize titles;

#pragma mark - Title management
- (void) addtitle:(MMTitle *)title
{
  if([titles containsObject: title])
  {
    return;
  }
  
  [titles addObject: title];
}

@end
