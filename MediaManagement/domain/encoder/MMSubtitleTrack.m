//
//  ITSSubtitleTrack.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import "MMSubtitleTrack.h"

@interface MMSubtitleTrack()
@property (nonatomic, assign, readwrite) NSInteger index;
@property (nonatomic, strong, readwrite) NSString *language;
@property (nonatomic, assign, readwrite) MMSubtitleType type;
@end

@implementation MMSubtitleTrack

+ (MMSubtitleTrack *) subtitleTrackWithIndex: (NSInteger) index
                                    language: (NSString *) language
                                     andType: (MMSubtitleType) type
{
    return [[MMSubtitleTrack alloc] initWithIndex: index
                                         language: language
                                          andType: type];
}

- (id) initWithIndex: (NSInteger) anIndex
            language: (NSString *) aLanguage
             andType: (MMSubtitleType) aType
{
    self = [super init];
    if(self)
    {
        self.language = aLanguage;
        self.index = anIndex;
        self.type = aType;
    }
    return self;
}

@end
