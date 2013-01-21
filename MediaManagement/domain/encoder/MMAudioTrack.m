//
//  ITSSoundTrack.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import "MMAudioTrack.h"

@interface MMAudioTrack()

@end

@implementation MMAudioTrack

+ (MMAudioTrack *) audioTrackWithIndex: (NSInteger) index
                                 codec: (MMAudioCodec) codec
                          channelCount: (NSInteger) channelCount
                                   lfe: (BOOL) lfe
                           andLanguage: (NSString *) language
{
    return [[MMAudioTrack alloc] initWithIndex: index
                                         codec: codec
                                  channelCount: channelCount
                                           lfe: lfe
                                   andLanguage: language];
}

- (id) initWithIndex: (NSInteger) anIndex
               codec: (MMAudioCodec) aCodec
        channelCount: (NSInteger) aChannelCount
                 lfe: (BOOL) lfe
         andLanguage: (NSString *) aLanguage
{
    self = [super init];
    if(self)
    {
        _index = anIndex;
        _codec = aCodec;
        _channelCount = aChannelCount;
        _hasLFE = lfe;
        _language = aLanguage;
    }
    return self;
}

@end
