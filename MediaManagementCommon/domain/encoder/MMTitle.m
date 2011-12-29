//
//  ITSEncodableContent.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
//

#import "MMTitle.h"

@interface MMTitle()
- (id) initWithIndex: (NSInteger) anIndex chapterCount: (NSInteger) aChapterCount andDuration: (NSInteger) aDuration;
@end

@implementation MMTitle

+ (MMTitle *) titleWithIndex: (NSInteger) index chapterCount: (NSInteger) chapterCount andDuration: (NSInteger) duration
{
  return [[MMTitle alloc] initWithIndex: index chapterCount:chapterCount andDuration:duration];
}

- (id) initWithIndex: (NSInteger) anIndex chapterCount: (NSInteger) aChapterCount andDuration: (NSInteger) aDuration
{
  self = [super init];
  if(self)
  {
    index = anIndex;
    chapterCount = aChapterCount;
#warning this will at 90000KHz, don't forget to convert!!!
    duration = aDuration;
  }
  return self;
}

@synthesize name;
@synthesize index;
@synthesize duration;
@synthesize chapterCount;

@end
