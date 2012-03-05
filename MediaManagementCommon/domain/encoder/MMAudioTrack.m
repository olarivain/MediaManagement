//
//  ITSSoundTrack.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import "MMAudioTrack.h"

@interface MMAudioTrack()
- (id) initWithIndex: (NSInteger) index codec: (MMAudioCodec) codec channelCount: (NSInteger) channelCount lfe: (BOOL) lfe andLanguage: (NSString *) language;
@end

@implementation MMAudioTrack

+ (MMAudioTrack *) audioTrackWithIndex: (NSInteger) index codec: (MMAudioCodec) codec channelCount: (NSInteger) channelCount lfe: (BOOL) lfe andLanguage: (NSString *) language
{
  return [[MMAudioTrack alloc] initWithIndex: index codec: codec channelCount: channelCount lfe: lfe andLanguage: language];
}

- (id) initWithIndex: (NSInteger) anIndex codec: (MMAudioCodec) aCodec channelCount: (NSInteger) aChannelCount lfe: (BOOL) lfe andLanguage: (NSString *) aLanguage
{
  self = [super init];
  if(self)
  {
    index = anIndex;
    codec = aCodec;
    channelCount = aChannelCount;
    hasLFE = lfe;
    language = aLanguage;
  }
  return self;
}

@synthesize index;
@synthesize channelCount;
@synthesize codec;
@synthesize hasLFE;
@synthesize language;
@synthesize selected;

@end
