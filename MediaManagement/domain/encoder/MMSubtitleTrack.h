//
//  ITSSubtitleTrack.h
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MMSubtitleType
{
    SUBTITLE_VOBSUB = 0,
    SUBTITLE_CLOSED_CAPTION = 1
} MMSubtitleType;

@interface MMSubtitleTrack : NSObject
{
}

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly, strong) NSString *language;
@property (nonatomic, readonly) MMSubtitleType type;
@property (nonatomic, readwrite, assign) BOOL selected;

+ (MMSubtitleTrack *) subtitleTrackWithIndex: (NSInteger) index
                                    language: (NSString *) language
                                     andType: (MMSubtitleType) type;

@end
