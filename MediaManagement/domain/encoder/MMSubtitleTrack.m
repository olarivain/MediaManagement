//
//  ITSSubtitleTrack.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import "MMSubtitleTrack.h"

@interface MMSubtitleTrack()
- (id) initWithIndex: (NSInteger) index 
            language: (NSString *) language 
             andType: (MMSubtitleType) type;
@end

@implementation MMSubtitleTrack

+ (MMSubtitleTrack *) subtitleTrackWithIndex: (NSInteger) index 
                                    language: (NSString *) language 
                                     andType: (MMSubtitleType) type
{
  return [[MMSubtitleTrack alloc] initWithIndex: index 
                                       language: language 
                                        andType: type];
}

- (id) initWithIndex: (NSInteger) anIndex 
            language: (NSString *) aLanguage 
             andType: (MMSubtitleType) aType
{
  self = [super init];
  if(self)
  {
    language = aLanguage;
    index = anIndex;
    type = aType;
  }
  return self;
}

@synthesize index;
@synthesize language;
@synthesize type;
@synthesize selected;

@end
