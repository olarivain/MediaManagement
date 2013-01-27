//
//  MMLibrary.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMLibrary.h"

#import "MMPlaylist.h"
#import "MMContent.h"

@interface MMLibrary () {
    __strong NSMutableArray *_playlists;
}
@property (nonatomic, readwrite, strong) NSString *uniqueId;
@end

@implementation MMLibrary

#pragma mark - Constructor/destructors/getters
- (id)init
{
    self = [super init];
    if (self)
    {
        _playlists = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return self;
}

#pragma mark - Public business methods

- (void) addPlaylist: (MMPlaylist*) playlist
{
    if([self.playlists containsObject: playlist])
    {
        return;
    }

    [_playlists addObjectNilSafe: playlist];
    playlist.library = self;
}

- (void) addContent: (MMContent *) content {
	for(MMPlaylist *playlist in self.playlists) {
		if([playlist belongsToPlaylist: content]) {
			[playlist addContent: content];
		}
	}
}

- (void) clear
{
    [_playlists removeAllObjects];
}

- (void) updateContent:(MMContent *)content {
	// remove the element and add it again. it's somewhat brutal, but it works
	for(MMPlaylist *playlist in self.playlists) {
		[playlist removeContent: content];
	}
    // now, find the playlist to which it belongs, and add it.
    // add it to the first one that claims the content belongs to it,
    // the object design should make this a valid assumption.
    for(MMPlaylist *playlist in self.playlists) {
        if([playlist belongsToPlaylist: content]) {
            [playlist addContent: content];
        }
    }
    
}

@end
