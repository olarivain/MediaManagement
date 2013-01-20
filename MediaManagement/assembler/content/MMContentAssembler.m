//
//  ContentAssembler.m
//  MediaManagementCommon
//
//  Created by Kra on 4/3/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMContentAssembler.h"
#import "MMContent.h"
#import "MMPlaylist.h"

#import "MMMusicPlaylist.h"
#import "MMMoviesPlaylist.h"
#import "MMTVShowPlaylist.h"
#import "MMGenericPlaylist.h"

#import "MMContentList.h"

static MMContentAssembler *sharedInstance;

@interface MMContentAssembler()
- (MMPlaylist*) mediaLibraryForKind: (MMContentKind) kind andSize: (NSUInteger) count;
@end


@implementation MMContentAssembler

+ (id) sharedInstance
{
  @synchronized(self){
    if(sharedInstance == nil) 
    {
      sharedInstance = [[MMContentAssembler alloc] init];
    }
  }
  return sharedInstance;
}

- (id)init
{
  self = [super init];
  return self;
}

#pragma mark - Domain -> DTO methods
- (NSDictionary*) writeContent: (MMContent*) content
{
  NSMutableDictionary *dto = [NSMutableDictionary dictionary];
  
  
  NSNumber *kind = [NSNumber numberWithInt:content.kind];
  [dto setObjectNilSafe: kind forKey:@"kind"];
  
  [dto setObjectNilSafe: content.contentId forKey:@"contentId"];

  [dto setObjectNilSafe: content.name forKey:@"name"];
  [dto setObjectNilSafe: content.genre forKey:@"genre"];
  [dto setObjectNilSafe: content.artist forKey:@"artist"];
  [dto setObjectNilSafe: content.album forKey:@"album"];
  [dto setObjectNilSafe: content.trackNumber forKey:@"trackNumber"];
  [dto setObjectNilSafe: content.description forKey:@"description"];
  [dto setObjectNilSafe: content.show forKey:@"show"];
  [dto setObjectNilSafe: content.season forKey:@"season"];
  [dto setObjectNilSafe: content.episodeNumber forKey:@"episodeNumber"];
  [dto setObjectNilSafe: content.playlistId forKey:@"playlistId"];
  [dto setObjectNilSafe: content.duration forKey: @"duration"];
  
  return dto;
}

- (NSArray*) writeContentArray: (NSArray*) contentList
{
  NSMutableArray *dtos = [NSMutableArray arrayWithCapacity:[contentList count]];
  for(MMContent *content in contentList)
  {
    NSDictionary *dto = [self writeContent: content];
    if(dto != nil)
    {
      [dtos addObject: dto];
    }
  }
  
  return dtos;
}

- (NSArray*) writePlaylists: (NSArray*) playlists
{
  NSMutableArray *dtos = [NSMutableArray arrayWithCapacity: [playlists count]];
  for(MMPlaylist *playlist in playlists)
  {
    NSDictionary *dto = [self writePlaylist: playlist];
    [dtos addObject: dto];
  }
  
  return dtos;
}


- (NSDictionary*) writePlaylist: (MMPlaylist*) library
{
  NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithCapacity:5];
  [dto setObjectNilSafe:library.name forKey:@"name"];  
  
  NSNumber *kind = [NSNumber numberWithInt:library.kind];
  [dto setObjectNilSafe:kind forKey:@"kind"];  
  
  NSString *uniqueID = library.uniqueId;
  [dto setObjectNilSafe:uniqueID forKey:@"uniqueId"];  

  MMContentList *defaultContentList = [library defaultContentList];
  NSArray *content = [self writeContentArray: defaultContentList.content];
  [dto setObjectNilSafe:content forKey:@"content"];

  return dto;
}

#pragma mark - DTO -> Domain methods
- (MMPlaylist*) mediaLibraryForKind: (MMContentKind) kind andSize: (NSUInteger) count
{
  MMPlaylist *library = [MMGenericPlaylist playlistWithKind: kind andSize:count];
  switch (kind) {
    case MUSIC:
      library = [MMMusicPlaylist playlistWithSize: count];
      break;
    case MOVIE:
      library = [MMMoviesPlaylist playlistWithSize: count];
      break;
    case TV_SHOW:
      library = [MMTVShowPlaylist playlistWithSize: count];
      break;
    case PODCAST:
      break;
    case ITUNES_U:
      break;
    case USER:
      break;
    default:
      break;
  }
  return library;
}

- (MMPlaylist*) createPlaylist:(NSDictionary *)dictionary
{
  NSNumber *kindNumber = [dictionary nullSafeForKey:@"kind"];
  if(kindNumber == nil)
  {
    return nil;
  }
  
  MMContentKind kind = [kindNumber intValue];
  NSArray *contents = [dictionary nullSafeForKey: @"content"];
  
  MMPlaylist *playlist = [self mediaLibraryForKind: kind andSize: [contents count]];
  playlist.uniqueId = [dictionary nullSafeForKey:@"uniqueId"];
  playlist.name = [dictionary nullSafeForKey:@"name"];
  
  for(NSDictionary *contentDictionary in contents)
  {
    MMContent *content = [self createContent: contentDictionary];
    [playlist addContent: content];
  }
  
  return playlist;
}

- (MMContent*) createContent: (NSDictionary*) dictionary
{
  NSNumber *kindNumber = [dictionary nullSafeForKey:@"kind"];
  if(kindNumber == nil)
  {
    return nil;
  }
  
  MMContentKind kind = [kindNumber intValue];
  MMContent *content = [MMContent content:kind];
  content.contentId = [dictionary nullSafeForKey: @"contentId"];
  content.name = [dictionary nullSafeForKey: @"name"];
  content.description = [dictionary nullSafeForKey: @"description"];
  content.genre = [dictionary nullSafeForKey: @"genre"];
  content.album = [dictionary nullSafeForKey: @"album"];
  content.artist = [dictionary nullSafeForKey: @"artist"];
  content.trackNumber = [dictionary nullSafeForKey: @"trackNumber"];
  content.show = [dictionary nullSafeForKey: @"show"];
  content.episodeNumber = [dictionary nullSafeForKey: @"episodeNumber"];
  content.season = [dictionary nullSafeForKey:@"season"];
  content.playlistId = [dictionary nullSafeForKey: @"playlistId"];
  content.duration = [dictionary nullSafeForKey: @"duration"];
  return content;
}

- (MMContent*) createContent: (NSDictionary*) dictionary withPlaylistId: (NSString *) playlistId 
{
  MMContent *content = [self createContent: dictionary];
  content.playlistId = playlistId;
  return content;
}

- (NSArray*) createContentArray: (NSArray*) dtoList
{
  NSMutableArray *domains = [NSMutableArray arrayWithCapacity: [dtoList count]];
  for(NSDictionary *dto in dtoList)
  {
    MMContent *content = [self createContent: dto];
    if(content != nil)
    {
      [domains addObject: content];
    }
  }
  return domains;
}

- (NSArray*) createContentArray: (NSArray*) dtoList withPlaylistId: (NSString *) playlistId
{
  NSMutableArray *domains = [NSMutableArray arrayWithCapacity: [dtoList count]];
  for(NSDictionary *dto in dtoList)
  {
    MMContent *content = [self createContent: dto withPlaylistId: playlistId];
    if(content != nil)
    {
      [domains addObject: content];
    }
  }
  return domains;
}


@end
