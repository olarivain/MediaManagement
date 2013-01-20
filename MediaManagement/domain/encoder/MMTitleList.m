//
//  ITSTitleList.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <KraCommons/NSArray+BoundSafe.h>
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
@synthesize active;

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

- (NSInteger) indexOfTitle: (MMTitle *) title
{
  return [titles indexOfObject: title];
}

- (MMTitle *) titleWithIndex: (NSInteger) index
{
  for(MMTitle *title in titles)
  {
    if(title.index == index)
    {
      return title;
    }
  }
  return nil;
}

- (BOOL) isCompleted
{
  for(MMTitle *title in self.selectedTitles)
  {
    if (!title.completed) 
    {
      return NO;
    }
  }
  return YES;
}

- (MMTitle *) nextTitleToEncode
{
  for(MMTitle *title in self.selectedTitles)
  {
    if(!title.completed)
    {
      return title;
    }
  }
  return nil;
}

#pragma mark - Selected titles
- (NSArray *) selectedTitles
{
  NSMutableArray *selectedTitles = [NSMutableArray arrayWithCapacity: [titles count]];
  for(MMTitle *title in titles)
  {
    if(title.selected)
    {
      [selectedTitles addObject: title];
    }
  }
  return selectedTitles;
}

#pragma mark - ID equality
- (NSUInteger) hash
{
  return [titleListId hash];
}

- (BOOL) isEqual:(id)object
{
  if(![object isKindOfClass: [MMTitleList class]])
  {
    return NO;
  }
  
  MMTitleList *other = (MMTitleList *) object;
  return [titleListId isEqualToString: other.titleListId];
}

@end