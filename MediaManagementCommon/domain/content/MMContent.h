//
//  Content.h
//  MediaManagement
//
//  Created by Kra on 3/9/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MMContentKind
{
  MUSIC = 0,
  MOVIE = 1,
  TV_SHOW = 2,
  PODCAST = 3,
  ITUNES_U = 4,
  USER = 5,
  UNKNOWN = 6
} MMContentKind;

@interface MMContent : NSObject 
{
  @private
  NSString *contentId;
  
  // common to all content
  NSString *name;
  NSString *description;
  NSString *genre;
  MMContentKind kind;

  // music related
  NSString *album;
  NSString *artist;
  NSInteger trackNumber;
  
  // tv show related
  NSString *show;
  NSInteger episodeNumber;
  NSInteger season;

}

+ (id) content: (MMContentKind) kind;

@property (nonatomic, readwrite, retain) NSString *contentId;

@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, retain) NSString *description;
@property (nonatomic, readwrite, retain) NSString *genre;
@property (nonatomic, readwrite, assign) MMContentKind kind;

@property (nonatomic, readwrite, retain) NSString *album;
@property (nonatomic, readwrite, retain) NSString *artist;
@property (nonatomic, readwrite, assign) NSInteger trackNumber;

@property (nonatomic, readwrite, retain) NSString *show;
@property (nonatomic, readwrite, assign) NSInteger episodeNumber;
@property (nonatomic, readwrite, assign) NSInteger season;

- (BOOL) isArtistSet;
- (BOOL) isAlbumSet;
@end
