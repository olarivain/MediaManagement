//
//  MMMusicLibrary.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMPlaylistProtected.h"

@class MMContentList;
@interface MMMusicPlaylist : MMPlaylist 
{
@private
  MMContentList *unknownArtist;
  MMContentList *unknownAlbum;
}

@end
