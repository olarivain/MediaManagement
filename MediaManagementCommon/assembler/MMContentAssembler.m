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
#import "MMGenericPlaylist.h"

#import "MMContentList.h"

static MMContentAssembler *sharedInstance;

@interface MMContentAssembler()
- (void) setInDictionary: (NSMutableDictionary*) dictionary object: (id) object forKey: (id) key;
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

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - Convenience methods
- (void) setInDictionary: (NSMutableDictionary*) dictionary object: (id) object forKey: (id) key
{
  if(object == nil)
  {
    return;
  }
  
  [dictionary setObject:object forKey: key];
}

#pragma mark - Domain -> DTO methods
- (NSDictionary*) writeContent: (MMContent*) content
{
  NSMutableDictionary *dto = [NSMutableDictionary dictionary];
  
  
  NSNumber *kind = [NSNumber numberWithInt:content.kind];
  [self setInDictionary: dto object:kind forKey:@"kind"];
  
  [self setInDictionary: dto object:content.contentId forKey:@"contentId"];

  [self setInDictionary: dto object:content.name forKey:@"name"];
  [self setInDictionary: dto object:content.genre forKey:@"genre"];
  [self setInDictionary: dto object:content.artist forKey:@"artist"];
  [self setInDictionary: dto object:content.album forKey:@"album"];
  [self setInDictionary: dto object:content.trackNumber forKey:@"trackNumber"];
  [self setInDictionary: dto object:content.description forKey:@"description"];
  [self setInDictionary: dto object:content.show forKey:@"show"];
  [self setInDictionary: dto object:content.season forKey:@"season"];
  [self setInDictionary: dto object:content.episodeNumber forKey:@"episodeNumber"];
  
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
  [self setInDictionary: dto object:library.name forKey:@"name"];  
  
  NSNumber *kind = [NSNumber numberWithInt:library.kind];
  [self setInDictionary: dto object:kind forKey:@"kind"];  
  
  NSString *uniqueID = library.uniqueId;
  [self setInDictionary: dto object:uniqueID forKey:@"uniqueId"];  

  MMContentList *defaultContentList = [library defaultContentList];
  NSArray *content = [self writeContentArray: defaultContentList.content];
  [self setInDictionary: dto object:content forKey:@"content"];

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
  NSNumber *kindNumber = [dictionary objectForKey:@"kind"];
  if(kindNumber == nil)
  {
    return nil;
  }
  
  MMContentKind kind = [kindNumber intValue];
  NSArray *contents = [dictionary objectForKey: @"content"];
  
  MMPlaylist *playlist = [self mediaLibraryForKind: kind andSize: [contents count]];
  playlist.uniqueId = [dictionary objectForKey:@"uniqueId"];
  playlist.name = [dictionary objectForKey:@"name"];
  
  for(NSDictionary *contentDictionary in contents)
  {
    MMContent *content = [self createContent: contentDictionary];
    [playlist addContent: content];
  }
  
  return playlist;
}

- (MMContent*) createContent: (NSDictionary*) dictionary
{
  NSNumber *kindNumber = [dictionary objectForKey:@"kind"];
  if(kindNumber == nil)
  {
    return nil;
  }
  
  MMContentKind kind = [kindNumber intValue];
  MMContent *content = [MMContent content:kind];
  content.contentId = [dictionary objectForKey: @"contentId"];
  content.name = [dictionary objectForKey: @"name"];
  content.description = [dictionary objectForKey: @"description"];
  content.genre = [dictionary objectForKey: @"genre"];
  content.album = [dictionary objectForKey: @"album"];
  content.artist = [dictionary objectForKey: @"artist"];
  content.trackNumber = [dictionary objectForKey: @"trackNumber"];
  content.show = [dictionary objectForKey: @"show"];
  content.episodeNumber = [dictionary objectForKey: @""];
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

@end
