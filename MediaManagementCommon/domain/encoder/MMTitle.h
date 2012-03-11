//
//  ITSEncodableContent.h
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMAudioTrack;
@class MMSubtitleTrack;

@interface MMTitle : NSObject
{
  NSInteger index;
  __strong NSString *name;
  __strong NSMutableArray *audioTracks;
  __strong NSMutableArray *subtitleTracks;
  __strong NSString *targetPath;
  
  BOOL selected;
  BOOL encoding;
  BOOL completed;
  NSInteger progress;
  NSInteger eta;
  NSTimeInterval duration;
}

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readwrite, assign) NSInteger progress;
@property (nonatomic, readwrite, assign) NSInteger eta;
@property (nonatomic, readonly) NSString *formattedProgress;
@property (nonatomic, readonly) NSString *formattedStatus;
@property (nonatomic, readonly) NSArray *audioTracks;
@property (nonatomic, readonly) NSArray *subtitleTracks;
@property (nonatomic, readwrite, strong) NSString *targetPath;
@property (nonatomic, readwrite, assign) BOOL selected;
@property (nonatomic, readwrite, assign) BOOL encoding;
@property (nonatomic, readwrite, assign) BOOL completed;

@property (nonatomic, readonly) NSArray *selectedAudioTracks;
@property (nonatomic, readonly) NSArray *selectedSubtitleTracks;

+ (MMTitle *) titleWithIndex: (NSInteger) index andDuration: (NSTimeInterval) duration;

- (void) addAudioTrack: (MMAudioTrack *) soundtrack;
- (NSInteger) indexOfAudioTrack: (MMAudioTrack *) audioTrack;
- (MMAudioTrack *) audioTrackWithIndex: (NSInteger) index;

- (void) addSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;
- (NSInteger) indexOfSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;
- (MMSubtitleTrack *) subtitleTrackWithIndex: (NSInteger) index;

- (void) selectAudioTrack: (MMAudioTrack *) audioTrack;

- (void) selectSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;

@end
