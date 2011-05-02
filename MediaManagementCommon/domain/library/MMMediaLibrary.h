//
//  MMPlaylist.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMLibrary;
@class MMContent;

typedef enum MMPlaylistKind
{
  MusicPlaylist = 0,
  MoviesPlaylist = 1,
  TvShowsPlaylist = 2,
  itunesUPlaylist = 3,
  PodcastPlaylist = 4,
  UserPlaylist = 5
} MMPlaylistKind;

@interface MMMediaLibrary : NSObject 
{
@private
  MMPlaylistKind kind;
  NSString *uniqueId;
  NSString *name;
  MMLibrary *library;
  
  NSMutableArray *content;
}

@property (readonly) MMPlaylistKind kind;
@property (readonly) NSString *uniqueId;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, assign) MMLibrary *library;
@property (readonly) NSArray *content;

- (void) addContent: (MMContent*) content;
- (void) removeContent: (MMContent*) content;

@end
