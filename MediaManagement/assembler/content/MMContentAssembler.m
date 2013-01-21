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

#import "MMMoviesPlaylist.h"
#import "MMTVShowPlaylist.h"
#import "MMGenericPlaylist.h"

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
    [dto setObjectNilSafe: content.description forKey:@"description"];
    [dto setObjectNilSafe: content.show forKey:@"show"];
    [dto setObjectNilSafe: content.season forKey:@"season"];
    [dto setObjectNilSafe: content.episodeNumber forKey:@"episodeNumber"];
    //  [dto setObjectNilSafe: content.parent.pla forKey:@"playlistId"];
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


- (NSDictionary*) writePlaylist: (MMPlaylist*) playlist
{
    NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithCapacity:5];
    [dto setObjectNilSafe:playlist.name forKey:@"name"];
    [dto setInteger: playlist.kind forKey:@"kind"];
    [dto setObjectNilSafe: playlist.uniqueId forKey:@"uniqueId"];
    
    NSArray *content = [self writeContentArray: playlist.content];
    [dto setObjectNilSafe:content forKey:@"content"];
    
    return dto;
}

#pragma mark - DTO -> Domain methods
- (MMPlaylist*) mediaLibraryForKind: (MMContentKind) kind andSize: (NSUInteger) count
{
    MMPlaylist *library = [MMGenericPlaylist playlistWithKind: kind andSize:count];
    switch (kind) {
        case MOVIE:
            library = [MMMoviesPlaylist playlistWithKind: MOVIE andSize: count];
            break;
        case TV_SHOW:
            library = [MMTVShowPlaylist playlistWithKind: TV_SHOW andSize: count];
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
    content.show = [dictionary nullSafeForKey: @"show"];
    content.episodeNumber = [dictionary nullSafeForKey: @"episodeNumber"];
    content.season = [dictionary nullSafeForKey:@"season"];
    content.duration = [dictionary nullSafeForKey: @"duration"];
    return content;
}

- (MMContent*) createContent: (NSDictionary*) dictionary withPlaylistId: (NSString *) playlistId
{
    MMContent *content = [self createContent: dictionary];
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
