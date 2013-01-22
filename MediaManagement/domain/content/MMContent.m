//
//  Content.m
//  MediaManagement
//
//  Created by Kra on 3/9/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMContent.h"

@interface MMContent()

@end
@implementation MMContent

+ (id) content: (MMContentKind) kind
{
    return [[MMContent alloc] init: kind];
}

- (id) init:(MMContentKind) contentKind
{
    self = [super init];
    if(self)
    {
        self.kind = contentKind;
    }
    return self;
}

#pragma mark - synthetic getter
- (NSString *) durationHumanReadable
{
    NSInteger hours = [self.duration integerValue] / (60 * 60);
    NSInteger leftOver = [self.duration integerValue] % (60 * 60);
    NSInteger minutes = leftOver / 60;
    NSInteger seconds = leftOver % 60;
    
    if(hours == 0)
    {
        return [NSString stringWithFormat: @"%im%02i", minutes, seconds];
    }
    
    return [NSString stringWithFormat: @"%ih%02i", hours, minutes];
}

- (NSString *) kindHumanReadable {
	switch (self.kind) {
		case MOVIE:
			return @"Movie";
		case TV_SHOW:
			return @"TV Show";
		default:
			break;
	}
	
	return @"Unknown";
}

#pragma mark - Convenience accessors to determine if an attribute is set.
- (BOOL) isSet: (NSString*) value
{
    return [[value stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0;
}

- (BOOL) isShowSet
{
    return self.show != nil && [self isSet: self.show];
}

- (BOOL) isSeasonSet
{
    return self.season != nil && [self.season intValue] > 0;
}
- (BOOL) isMovie
{
    return self.kind == MOVIE;
}

- (BOOL) isTvShow
{
    return self.kind == TV_SHOW;
}

#pragma mark - Comparison method
- (NSComparisonResult) compare: (MMContent*) other
{
    // TODO: this is pretty brutal.
    // Should sort by artist, then album, then track.
    // Same concept for TV Shows.
    // failback to name based sort if we don't have anything else.
    if(self.kind == TV_SHOW)
    {
        return [self.episodeNumber compare: other.episodeNumber];
    }
    
    return [self.name caseInsensitiveCompare: other.name];
}

@end
