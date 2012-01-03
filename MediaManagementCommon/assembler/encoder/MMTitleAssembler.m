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
// write methods
// top level title objects
- (NSArray *) writeTitles: (NSArray *) titles;
- (NSDictionary *) writeTitle: (MMTitle *) title;

// audio tracks
- (NSArray *) writeAudioTracks: (NSArray *) audioTracks;
- (NSDictionary *) writeAudioTrack: (MMAudioTrack *) audioTrack;

// subtitle tracks
- (NSArray *) writeSubtitleTracks: (NSArray *) subtitleTracks;
- (NSDictionary *) writeSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;

// create methods
// top level title objects
- (MMTitle *) createTitle: (NSDictionary *) dto;

// audio tracks
- (MMAudioTrack *) createAudioTrack: (NSDictionary *) dto;

//subtitle tracks
- (MMSubtitleTrack *) createSubtitleTrack: (NSDictionary *) dto;
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
  [dto setDouble: title.duration forKey: @"duration"];
  [dto setObjectNilSafe: title.name forKey: @"name"];
  [dto setInteger: title.selected forKey: @"selected"];
  
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
  [dto setInteger: audioTrack.selected forKey: @"selected"];
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
  [dto setInteger: subtitleTrack.selected forKey: @"selected"];
  return dto;
}

#pragma mark - Creating title list (DTO -> domain)
- (NSArray *) createTitleLists: (NSArray *) dtos
{
  if(dtos == nil)
  {
    return nil;
  }
  
  NSMutableArray *titleLists = [NSMutableArray arrayWithCapacity: [dtos count]];
  for(NSDictionary *dto in dtos)
  {
    MMTitleList *titleList = [self createTitleList: dto];
    if(titleList == nil)
    {
      continue;
    }
    [titleLists addObject: titleList];
  }
  return titleLists;
}

- (void) updateTitleList: (MMTitleList *) titleList withDto: (NSDictionary *) dto
{
  NSArray *titleDtos = [dto nullSafeForKey: @"titles"];
  for(NSDictionary *titleDto in titleDtos)
  {
    MMTitle *title = [self createTitle: titleDto];
    [titleList addtitle: title];
  }
}

- (MMTitleList *) createTitleList: (NSDictionary *) dto
{
  if(dto == nil)
  {
    return nil;
  }

  NSString *titleListId = [dto nullSafeForKey: @"id"];
  MMTitleList *titleList = [MMTitleList titleListWithId: titleListId];
  [self updateTitleList: titleList withDto: dto];
  
  return titleList;
}

- (MMTitle *) createTitle: (NSDictionary *) dto
{
  if(dto == nil)
  {
    return nil;
  }
  
  // build MMTitle
  NSInteger index = [dto integerForKey: @"index"];
  NSTimeInterval duration = [dto doubleForKey: @"duration"];
  MMTitle *title = [MMTitle titleWithIndex: index andDuration:duration];
  title.selected = [dto booleanForKey: @"selected"];

  // create all audio tracks and add them to hte title object
  NSArray *audioTrackDtos = [dto nullSafeForKey: @"audioTracks"];
  for(NSDictionary *audioTrackDto in audioTrackDtos)
  {
    MMAudioTrack *audioTrack = [self createAudioTrack: audioTrackDto];
    [title addAudioTrack: audioTrack];
  }
  
  // create all subtitle track objects and add them to the title object
  NSArray *subtitleTrackDtos = [dto nullSafeForKey: @"subtitleTracks"];
  for(NSDictionary *subtitleTrackDto in subtitleTrackDtos)
  {
    MMSubtitleTrack *subtitleTrack = [self createSubtitleTrack: subtitleTrackDto];
    [title addSubtitleTrack: subtitleTrack];
  }
  
  return title;
}

- (MMAudioTrack *) createAudioTrack: (NSDictionary *) dto
{
  if(dto == nil)
  {
    return nil;
  }
  
  NSInteger index = [dto integerForKey: @"index"];
  MMAudioCodec codec = (MMAudioCodec) [dto integerForKey: @"codec"];
  NSInteger channelCount = [dto integerForKey: @"channelCount"];
  BOOL lfe = [dto booleanForKey: @"lfe"];
  NSString *language = [dto nullSafeForKey: @"language"];
  MMAudioTrack *audioTrack = [MMAudioTrack audioTrackWithIndex: index codec: codec channelCount: channelCount lfe: lfe andLanguage: language];
  audioTrack.selected = [dto booleanForKey: @"selected"];
  return audioTrack;
}

- (MMSubtitleTrack *) createSubtitleTrack: (NSDictionary *) dto
{
  if(dto == nil)
  {
    return nil;
  }
  
  NSInteger index = [dto integerForKey: @"index"];
  NSString *language = [dto nullSafeForKey: @"language"];
  MMSubtitleType type = (MMSubtitleType) [dto integerForKey: @"type"];
  MMSubtitleTrack *track = [MMSubtitleTrack subtitleTrackWithIndex: index language: language andType: type];
  track.selected = [dto booleanForKey: @"selected"];
  return track;
}

@end
