//
//  ContentAssembler.h
//  MediaManagementCommon
//
//  Created by Kra on 4/3/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContent;
@class MMPlaylist;

@interface MMContentAssembler : NSObject 
{
@private
    
}

+ (id) sharedInstance;

- (NSDictionary*) writePlaylist: (MMPlaylist*) playlist;
- (NSArray*) writePlaylists: (NSArray*) playlists;

- (NSDictionary*) writeContent: (MMContent*) content;
- (NSArray*) writeContentArray: (NSArray*) contentList;

- (MMPlaylist*) createPlaylist: (NSDictionary*) dictionary;

- (MMContent*) createContent: (NSDictionary*) dictionary;
- (NSArray*) createContentArray: (NSArray*) dictionary;

- (MMContent*) createContent: (NSDictionary*) dictionary withPlaylistId: (NSString *) playlistId;
- (NSArray*) createContentArray: (NSArray*) dictionary withPlaylistId: (NSString *) playlistId;

@end