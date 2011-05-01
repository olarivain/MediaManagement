//
//  Content.m
//  MediaManagement
//
//  Created by Kra on 3/9/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "Content.h"

@interface Content(private)
- (id) init: (ContentKind) kind;
@end
@implementation Content

+ (id) content: (ContentKind) kind
{
  return [[[Content alloc] init: kind] autorelease];
}

- (id) init:(ContentKind) contentKind
{
  self = [super init];
  if(self)
  {
    kind = contentKind;
  }
  return self;
}

- (void) dealloc
{
  [contentId release];
  [artist release];
  [album release];
  [genre release];
  [name release];
  [description release];
  [show release];
  [super dealloc];
}

@synthesize contentId;
@synthesize name;
@synthesize description;
@synthesize genre;
@synthesize kind;

@synthesize album;
@synthesize artist;
@synthesize trackNumber;

@synthesize show;
@synthesize episodeNumber;
@synthesize season;


@end
