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

static MMContentAssembler *sharedInstance;

@interface MMContentAssembler()
@end


@implementation MMContentAssembler

+ (id) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MMContentAssembler alloc] init];
    });
    return sharedInstance;
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
    [dto setObjectNilSafe: content.playlistId forKey:@"playlistId"];
    [dto setObjectNilSafe: content.duration forKey: @"duration"];
	[dto setBool: content.unplayed forKey: @"unplayed"];
    
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
    content.playlistId = [dictionary nullSafeForKey: @"playlistId"];
	content.unplayed = [dictionary boolForKey: @"unplayed"];
	
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
