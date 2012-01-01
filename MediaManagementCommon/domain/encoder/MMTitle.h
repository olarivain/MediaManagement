//
//  ITSEncodableContent.h
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
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
  NSTimeInterval duration;
}

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) NSArray *audioTracks;
@property (nonatomic, readonly) NSArray *subtitleTracks;

@property (nonatomic, readonly) NSString *audioTracksCount;
@property (nonatomic, readonly) NSString *subtitleTracksCount;

+ (MMTitle *) titleWithIndex: (NSInteger) index andDuration: (NSTimeInterval) duration;

- (void) addAudioTrack: (MMAudioTrack *) soundtrack;
- (void) addSubtitleTrack: (MMSubtitleTrack *) subtitleTrack;

@end
