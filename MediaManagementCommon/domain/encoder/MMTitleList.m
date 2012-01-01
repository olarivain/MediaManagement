//
//  ITSTitleList.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
//

#import "MMTitleList.h"

#import "MMTitle.h"

@interface MMTitleList()
- (id) initWithId: (NSString *) aTitleListId;
@end

@implementation MMTitleList

+ (MMTitleList *) titleListWithId: (NSString *) titleListId
{
  return [[MMTitleList alloc] initWithId: titleListId];
}

- (id) initWithId: (NSString *) aTitleListId
{
  self = [super init];
  if(self)
  {
    titles = [NSMutableArray arrayWithCapacity: 10];
    titleListId = aTitleListId;
    name = [[titleListId pathComponents] lastObject];
  }
  return self;
}

@synthesize titleListId;
@synthesize name;
@synthesize titles;

- (NSString *) encodedTitleListId
{
  return [[titleListId stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] stringByReplacingOccurrencesOfString: @"/" withString: @"%2F"];
}

#pragma mark - Title management
- (void) addtitle:(MMTitle *)title
{
  if(title == nil || [titles containsObject: title])
  {
    return;
  }
  
  [titles addObject: title];
}

@end
