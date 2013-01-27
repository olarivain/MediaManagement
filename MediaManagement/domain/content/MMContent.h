//
//  Content.h
//  MediaManagement
//
//  Created by Kra on 3/9/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMPlaylist;
@protocol MMContentGroup;

typedef enum MMContentKind
{
    MOVIE = 0,
    TV_SHOW = 1,
    UNKNOWN = -1
} MMContentKind;

// Represents an individual content (movie or tv show episode etc.).
// So far, MMContent only holds its direct attributes (name, artist name, track number etc.)
// and does not hold a backpointer to its parent MMContentList
@interface MMContent : NSObject
{
    
}

+ (id) content: (MMContentKind) kind;

//@property (nonatomic, readwrite, weak) MMPlaylist *parent;
//@property (nonatomic, readwrite, weak) id<MMContentGroup> group;
@property (nonatomic, readwrite, strong) NSString *playlistId;

@property (nonatomic, readwrite, assign) MMContentKind kind;
@property (nonatomic, readonly) NSString *kindHumanReadable;

@property (nonatomic, readwrite, strong) NSString *contentId;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *description;
@property (nonatomic, readwrite, strong) NSString *genre;
@property (nonatomic, readwrite, strong) NSNumber *duration;
@property (nonatomic, readonly) NSString *durationHumanReadable;
@property (nonatomic, readwrite, assign) BOOL unplayed;

@property (nonatomic, readwrite, strong) NSString *show;
@property (nonatomic, readwrite, strong) NSNumber *episodeNumber;
@property (nonatomic, readwrite, strong) NSNumber *season;

- (BOOL) isShowSet;
- (BOOL) isSeasonSet;

- (BOOL) isMovie;
- (BOOL) isTvShow;

- (MMContent *) deepCopy;

@end