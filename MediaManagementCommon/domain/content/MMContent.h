//
//  Content.h
//  MediaManagement
//
//  Created by Kra on 3/9/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMPlaylist;

typedef enum MMContentKind
{
  MUSIC = 0,
  MOVIE = 1,
  TV_SHOW = 2,
  PODCAST = 3,
  ITUNES_U = 4,
  BOOKS = 5,
  USER = 6,
  UNKNOWN = 7
} MMContentKind;

// Represents an individual content (song, movie. tv show episode etc.).
// So far, MMContent only holds its direct attributes (name, artist name, track number etc.)
// and does not hold a backpointer to its parent MMContentList
@interface MMContent : NSObject 
{
  @private
  
  __weak MMPlaylist *parent;
  
  NSString *contentId;
  
  // common to all content
  NSString *name;
  NSString *description;
  NSString *genre;
  MMContentKind kind;

  // music related
  NSString *album;
  NSString *artist;
  NSNumber *trackNumber;
  
  // tv show related
  NSString *show;
  NSNumber *episodeNumber;
  NSNumber *season;
  
  NSString *playlistId;

}

+ (id) content: (MMContentKind) kind;

@property (nonatomic, readwrite, weak) MMPlaylist *parent;

@property (nonatomic, readwrite, assign) MMContentKind kind;

@property (nonatomic, readwrite, strong) NSString *contentId;
@property (nonatomic, readwrite, strong) NSString *playlistId;

@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *description;
@property (nonatomic, readwrite, strong) NSString *genre;

@property (nonatomic, readwrite, strong) NSString *album;
@property (nonatomic, readwrite, strong) NSString *artist;
@property (nonatomic, readwrite, strong) NSNumber *trackNumber;

@property (nonatomic, readwrite, strong) NSString *show;
@property (nonatomic, readwrite, strong) NSNumber *episodeNumber;
@property (nonatomic, readwrite, strong) NSNumber *season;

- (BOOL) isArtistSet;
- (BOOL) isAlbumSet;
- (BOOL) isShowSet;
- (BOOL) isSeasonSet;

- (BOOL) isMusic;
- (BOOL) isMovie;
- (BOOL) isTvShow;
@end