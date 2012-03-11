//
//  ITSSoundTrack.h
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MMAudioCodec
{
  AUDIO_CODEC_AC3 = 0,
  AUDIO_CODEC_DTS = 1,
  AUDIO_CODEC_AAC = 2,
  AUDIO_CODEC_MP3 = 3,
  AUDIO_CODEC_VORBIS = 4,
  AUDIO_CODEC_LINEAR_PCM = 5,
  AUDIO_CODEC_UNKNOWN = 6
} MMAudioCodec;

@interface MMAudioTrack : NSObject
{
  __strong NSString *language;
  NSInteger index;
  MMAudioCodec codec;
  NSInteger channelCount;
  BOOL hasLFE;
  BOOL selected;
}

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) MMAudioCodec codec;
@property (nonatomic, readonly) NSInteger channelCount;
@property (nonatomic, readonly) BOOL hasLFE;
@property (nonatomic, readonly) NSString *language;
@property (nonatomic, readwrite, assign) BOOL selected;

+ (MMAudioTrack *) audioTrackWithIndex: (NSInteger) index 
                                 codec: (MMAudioCodec) codec 
                          channelCount: (NSInteger) channelCount 
                                   lfe: (BOOL) lfe 
                           andLanguage: (NSString *) language;

@end
