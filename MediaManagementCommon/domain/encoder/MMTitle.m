//
//  ITSEncodableContent.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
//

#import "MMTitle.h"

@interface MMTitle()
- (id) initWithIndex: (NSInteger) anIndex andDuration: (NSTimeInterval) aDuration;
@end

@implementation MMTitle

+ (MMTitle *) titleWithIndex: (NSInteger) index andDuration: (NSTimeInterval) duration
{
  return [[MMTitle alloc] initWithIndex: index andDuration:duration];
}

- (id) initWithIndex: (NSInteger) anIndex andDuration: (NSTimeInterval) aDuration
{
  self = [super init];
  if(self)
  {
    audioTracks = [NSMutableArray arrayWithCapacity: 5];
    subtitleTracks = [NSMutableArray arrayWithCapacity: 5];
    
    index = anIndex;
    // this duration is coming from libHB, which provides duration at 90KHz rather than 1 or 1000 Hz
    duration = aDuration;
  }
  return self;
}

@synthesize name;
@synthesize index;
@synthesize duration;
@synthesize subtitleTracks;
@synthesize audioTracks;

- (NSString *) audioTracksCount
{
  NSInteger count = [audioTracks count];
  if(count == 0)
  {
    return @"no";
  }
  
  return [NSString stringWithFormat:@"%i", count];
}

- (NSString *) subtitleTracksCount
{
  NSInteger count = [subtitleTracks count];
  if(count == 0)
  {
    return @"no";
  }
  
  return [NSString stringWithFormat:@"%i", count];
}

- (void) addAudioTrack: (MMAudioTrack *) soundtrack
{
  if(soundtrack == nil || [audioTracks containsObject: soundtrack])
  {
    return;
  }
  
  [audioTracks addObject: soundtrack];
}

- (void) addSubtitleTrack: (MMSubtitleTrack *) subtitleTrack
{
  if(subtitleTrack == nil || [subtitleTracks containsObject: subtitleTrack])
  {
    return;
  }
  
  [subtitleTracks addObject: subtitleTrack];
}

@end
