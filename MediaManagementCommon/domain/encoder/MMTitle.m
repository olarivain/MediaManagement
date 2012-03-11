//
//  ITSEncodableContent.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <KraCommons/NSArray+BoundSafe.h>
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
    duration = aDuration;
  }
  return self;
}

@synthesize name;
@synthesize index;
@synthesize duration;
@synthesize progress;
@synthesize eta;
@synthesize subtitleTracks;
@synthesize audioTracks;
@synthesize selected;
@synthesize encoding;
@synthesize completed;
@synthesize targetPath;

#pragma mark - track management
#pragma mark Audio
- (void) addAudioTrack: (MMAudioTrack *) soundtrack
{
  if(soundtrack == nil || [audioTracks containsObject: soundtrack])
  {
    return;
  }
  
  [audioTracks addObject: soundtrack];
}

- (NSInteger) indexOfAudioTrack:(MMAudioTrack *)audioTrack
{
  return [audioTracks indexOfObject: audioTrack];
}

- (MMAudioTrack *) audioTrackWithIndex: (NSInteger) anIndex
{
  for(MMAudioTrack *track in audioTracks)
  {
    if(track.index == anIndex)
    {
      return track;
    }
  }
  return nil;
}

#pragma mark Subtitle
- (void) addSubtitleTrack: (MMSubtitleTrack *) subtitleTrack
{
  if(subtitleTrack == nil || [subtitleTracks containsObject: subtitleTrack])
  {
    return;
  }
  
  [subtitleTracks addObject: subtitleTrack];
}

- (NSInteger) indexOfSubtitleTrack:(MMSubtitleTrack *)subtitleTrack
{
  return [subtitleTracks indexOfObject: subtitleTrack];
}

- (MMSubtitleTrack *) subtitleTrackWithIndex: (NSInteger) anIndex
{
  for(MMSubtitleTrack *track in subtitleTracks)
  {
    if(track.index == anIndex)
    {
      return track;
    }
  }
  return nil;
}

#pragma mark - selecting tracks
#pragma mark Audio
- (void) selectAudioTrack: (MMAudioTrack *) audioTrack
{
  // flip the switch on selected track
  BOOL isSelected = !audioTrack.selected;
  audioTrack.selected = isSelected;
  
  if(isSelected)
  {
    self.selected = YES;
  }
  else
  {
    self.selected = [[self selectedAudioTracks] count] > 0;
  }
}

- (NSArray *) selectedAudioTracks
{
  NSMutableArray *selectedAudioTracks = [NSMutableArray arrayWithCapacity: [audioTracks count]];
  for(MMAudioTrack *track in audioTracks)
  {
    if(track.selected)
    {
      [selectedAudioTracks addObject: track];
    }
  }
  return selectedAudioTracks;
}

#pragma mark Subtitles
- (void) selectSubtitleTrack: (MMSubtitleTrack *) subtitleTrack
{
  BOOL isSelected = !subtitleTrack.selected;
  subtitleTrack.selected = isSelected;
    
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

- (NSArray *) selectedSubtitleTracks
{
  NSMutableArray *selectedSubtitleTracks = [NSMutableArray arrayWithCapacity: [subtitleTracks count]];
  for(MMSubtitleTrack *track in subtitleTracks)
  {
    if(track.selected)
    {
      [selectedSubtitleTracks addObject: track];
    }
  }
  return selectedSubtitleTracks;
}

@end
