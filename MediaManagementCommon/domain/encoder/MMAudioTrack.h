//
//  ITSSoundTrack.h
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
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
  NSInteger index;
  MMAudioCodec codec;
  NSInteger channelCount;
  BOOL hasLFE;
  __strong NSString *language;
}

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) MMAudioCodec codec;
@property (nonatomic, readonly) NSInteger channelCount;
@property (nonatomic, readonly) BOOL hasLFE;
@property (nonatomic, readonly) NSString *language;

+ (MMAudioTrack *) audioTrackWithIndex: (NSInteger) index codec: (MMAudioCodec) codec channelCount: (NSInteger) channelCount lfe: (BOOL) lfe andLanguage: (NSString *) language;

@end
