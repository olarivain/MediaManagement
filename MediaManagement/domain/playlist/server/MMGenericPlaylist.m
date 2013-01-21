//
//  MMiTunesMediaLibrary.m
//  CLIServer
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMGenericPlaylist.h"
#import "MMPlaylistProtected.h"

@implementation MMGenericPlaylist


+ (id) playlistWithKind:(MMContentKind)kind andSize:(NSUInteger)size
{
    return [[self alloc] initWithContentKind: kind andSize: size];
}

- (void) privateSortContent: (NSMutableArray *) groups {
    
}

@end
