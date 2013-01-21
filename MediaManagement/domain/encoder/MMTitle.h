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
    NSInteger _index;
    NSTimeInterval _duration;
    
    NSString *_formattedEta;
    
    __strong NSMutableArray *_audioTracks;
    __strong NSMutableArray *_subtitleTracks;
}

@property (nonatomic, assign, readonly) NSInteger index;
@property (nonatomic, assign, readonly) NSTimeInterval duration;
@property (nonatomic, readwrite, assign) NSInteger progress;
@property (nonatomic, readwrite, assign) NSInteger eta;

@property (nonatomic, readonly) NSArray *audioTracks;
@property (nonatomic, readonly) NSArray *subtitleTracks;
@property (nonatomic, readwrite, strong) NSString *targetPath;
@property (nonatomic, readwrite, assign) BOOL selected;
@property (nonatomic, readwrite, assign) BOOL encoding;
@property (nonatomic, readwrite, assign) BOOL completed;

@property (nonatomic, readonly) NSArray *selectedAudioTracks;
@property (nonatomic, readonly) NSArray *selectedSubtitleTracks;

@property (nonatomic, readonly) NSString *formattedProgress;
@property (nonatomic, readonly) NSString *formattedStatus;

+ (MMTitle *) titleWithIndex: (NSInteger) index
                 andDuration: (NSTimeInterval) duration;

- (void) addAudioTrack: (MMAudioTrack *) soundtrack;
- (NSInteger) indexOfAudioTrack: (MMAudioTrack *) audioTrack;
- (MMAudioTrack *) audioTrackWithIndex: (NSInteger) index;

- (void) addSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;
- (NSInteger) indexOfSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;
- (MMSubtitleTrack *) subtitleTrackWithIndex: (NSInteger) index;

- (void) selectAudioTrack: (MMAudioTrack *) audioTrack;

- (void) selectSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;

@end
