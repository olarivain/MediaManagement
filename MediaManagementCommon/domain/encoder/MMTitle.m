//
//  ITSEncodableContent.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
//

#import "MMTitle.h"

#import "MMAudioTrack.h"
#import "MMSubtitleTrack.h"

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
@synthesize selected;

#pragma mark - adding tracks
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

#pragma mark - selecting tracks
- (void) selectAudioTrack: (MMAudioTrack *) audioTrack
{
  // flip the switch on selected track
  BOOL selected = !audioTrack.selected;
  audioTrack.selected = selected;
}

- (void) selectSubtitleTrack: (MMSubtitleTrack *) subtitleTrack
{
  BOOL selected = !subtitleTrack.selected;
  subtitleTrack.selected = selected;
  
  BOOL isClosedCaption = subtitleTrack.type == SUBTITLE_CLOSED_CAPTION;
  
  // CC was selected, unselect ALL vobsubs, but let other CCs selected
  if(subtitleTrack.type == SUBTITLE_CLOSED_CAPTION)
  {
    for(MMSubtitleTrack *track in subtitleTracks)
    {
      if(track != subtitleTrack && track.type == SUBTITLE_VOBSUB)
      {
        track.selected = NO;
      }
    }
  }
  // otherwise, we have a vobsub, unselect all other subtitles - VOBSUB is mutually exclusive
  else
  {
    for(MMSubtitleTrack *track in subtitleTracks)
    {
      if(track != subtitleTrack)
      {
        track.selected = NO;
      }
    }
  }
  
  
}

@end
