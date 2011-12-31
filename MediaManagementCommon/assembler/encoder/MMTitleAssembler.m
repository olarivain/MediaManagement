//
//  MMTitleAssembler.m
//  MediaManagementCommon
//
//  Created by Larivain, Olivier on 12/29/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <KraCommons/NSArray+BoundSafe.h>
#import <KraCommons/NSDictionary+NilSafe.h>

#import "MMTitleAssembler.h"

#import "MMTitleList.h"
#import "MMTitle.h"
#import "MMSubtitleTrack.h"
#import "MMAudioTrack.h"

static MMTitleAssembler *sharedInstance;

@interface MMTitleAssembler()
// write top level title objects
- (NSArray *) writeTitles: (NSArray *) titles;
- (NSDictionary *) writeTitle: (MMTitle *) title;

// audio tracks
- (NSArray *) writeAudioTracks: (NSArray *) audioTracks;
- (NSDictionary *) writeAudioTrack: (MMAudioTrack *) audioTrack;

// subtitle tracks
- (NSArray *) writeSubtitleTracks: (NSArray *) subtitleTracks;
- (NSDictionary *) writeSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;
@end

@implementation MMTitleAssembler

+ (MMTitleAssembler *) sharedInstance
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[MMTitleAssembler alloc] init];
  });
  return sharedInstance;
}

#pragma mark - Writing title list (domain -> DTO)
- (NSArray *) writeTitleLists: (NSArray *) titleLists 
{
  if(titleLists == nil)
  {
    return nil;
  }
  
  NSMutableArray *dtos = [NSMutableArray arrayWithCapacity: [titleLists count]];
  for(MMTitleList *titleList in titleLists)
  {
    NSDictionary *dto = [self writeTitleList: titleList];
    if(dto == nil)
    {
      continue;
    }
    
    [dtos addObject: dto];
  }
  return dtos;
}

- (NSDictionary *) writeTitleList: (MMTitleList *) titleList
{
  if(titleList == nil)
  {
    return nil;
  }
  
  NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithCapacity: 2];

  // write title list, add to dto
  NSArray *titles = [self writeTitles: titleList.titles];
  [dto setObjectNilSafe: titles forKey: @"titles"];
  [dto setObjectNilSafe: titleList.titleListId forKey: @"id"];
  [dto setObjectNilSafe: titleList.name forKey: @"name"];
  
  return dto;
}

- (NSArray *) writeTitles: (NSArray *) titles
{
  // abort early
  if([titles count] == 0)
  {
    return nil;
  }
  
  // write all titles
  NSMutableArray *dtos = [NSMutableArray arrayWithCapacity: [titles count]];
  for(MMTitle *title in titles)
  {
    NSDictionary *titleDto = [self writeTitle: title];
    if(titleDto == nil)
    {
      continue;
    }
    [dtos addObject: titleDto];
  }
  return dtos;
}

- (NSDictionary *) writeTitle: (MMTitle *) title
{
  if(title == nil)
  {
    return nil;
  }
  
  // for now, just dump direct fields in there
  NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithCapacity: 5];
  [dto setInteger: title.index forKey: @"index"];
  [dto setInteger: title.duration forKey: @"duration"];
  [dto setObjectNilSafe: title.name forKey: @"name"];
  
  NSArray *audioTrackDtos = [self writeAudioTracks: title.audioTracks];
  [dto setObjectNilSafe: audioTrackDtos forKey: @"audioTracks"];
  
  NSArray *subtitleTrackDtos = [self writeSubtitleTracks: title.subtitleTracks];
  [dto setObjectNilSafe: subtitleTrackDtos forKey: @"subtitleTracks"];
  
  return dto;
}

#pragma mark write audio tracks
- (NSArray *) writeAudioTracks: (NSArray *) audioTracks
{
  if(audioTracks == nil)
  {
    return nil;
  }
  
  NSMutableArray *dtos = [NSMutableArray arrayWithCapacity: [audioTracks count]];
  for(MMAudioTrack *track in audioTracks)
  {
    NSDictionary *dto = [self writeAudioTrack: track];
    if(dto == nil)
    {
      continue;
    }
    [dtos addObject: dto];
  }
  return dtos;
}

- (NSDictionary *) writeAudioTrack: (MMAudioTrack *) audioTrack
{
  if(audioTrack == nil)
  {
    return nil;
  }
  
  NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithCapacity: 5];
  [dto setObjectNilSafe: audioTrack.language forKey: @"language"];
  [dto setInteger: audioTrack.codec forKey: @"codec"];
  [dto setInteger: audioTrack.channelCount forKey: @"channelCount"];
  [dto setInteger: audioTrack.hasLFE forKey: @"lfe"];
  [dto setInteger: audioTrack.index forKey: @"index"];
  return dto;
}

#pragma mark write subtitle tracks
- (NSArray *) writeSubtitleTracks: (NSArray *) subtitleTracks
{
  if(subtitleTracks == nil)
  {
    return nil;
  }
  
  NSMutableArray *dtos = [NSMutableArray arrayWithCapacity: [subtitleTracks count]];
  for(MMSubtitleTrack *subtitleTrack in subtitleTracks)
  {
    NSDictionary *dto = [self writeSubtitleTrack: subtitleTrack];
    if(dto == nil)
    {
      continue;
    }
    [dtos addObject: dto];
  }
  return dtos;
}

- (NSDictionary *) writeSubtitleTrack: (MMSubtitleTrack *) subtitleTrack
{
  if(subtitleTrack == nil)
  {
    return nil;
  }
  
  NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithCapacity: 4];
  [dto setObjectNilSafe: subtitleTrack.language forKey: @"language"];
  [dto setInteger: subtitleTrack.index forKey: @"index"];
  [dto setInteger: subtitleTrack.type forKey: @"type"];
  return dto;
}

#pragma mark - Creating title list (DTO -> domain)
- (MMTitleList *) createTitleList: (NSDictionary *) titleList
{
#warning implement.
  return nil;
}

@end
