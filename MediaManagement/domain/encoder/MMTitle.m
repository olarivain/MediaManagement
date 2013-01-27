//
//  ITSEncodableContent.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//

#import <KraCommons/NSArray+BoundSafe.h>
#import "MMTitle.h"

#import "MMAudioTrack.h"
#import "MMSubtitleTrack.h"

@interface MMTitle() {
}

@property (nonatomic, assign, readwrite) NSInteger index;
@property (nonatomic, assign, readwrite) NSInteger duration;

@end

@implementation MMTitle

+ (MMTitle *) titleWithIndex: (NSInteger) index andDuration: (NSTimeInterval) duration
{
    return [[MMTitle alloc] initWithIndex: index andDuration:duration];
}

- (id) initWithIndex: (NSInteger) anIndex andDuration: (NSTimeInterval) aDuration
{
    self = [super init];
    if(self)
    {
        self.eta = -1;
        self.progress = 0;
        self.completed = NO;
        _audioTracks = [NSMutableArray arrayWithCapacity: 5];
        _subtitleTracks = [NSMutableArray arrayWithCapacity: 5];
        
        self.index = anIndex;
        self.duration = aDuration;
    }
    return self;
}

#pragma mark - Synthetic getters
- (NSString *) formattedEta
{
    return [self formatTimeInterval: self.eta];
}

- (NSString *) formatedDuration {
	return [self formatTimeInterval: self.duration];
}

- (NSString *) formatTimeInterval: (NSInteger) interval {
	if(interval < 0) {
		return @"";
	}
	
	NSInteger hours = interval / (60 * 60);
    NSInteger leftOver = interval % (60 * 60);
    NSInteger minutes = leftOver / 60;
    NSInteger seconds = leftOver % 60;
    
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat: @"%i:%02i:%02i", hours, minutes, seconds];
#else
    return [NSString stringWithFormat: @"%dl:%02dl:%02dl", hours, minutes, seconds];
#endif

	
}

#pragma mark - track management
#pragma mark Audio
- (void) addAudioTrack: (MMAudioTrack *) soundtrack
{
    if(soundtrack == nil || [self.audioTracks containsObject: soundtrack])
    {
        return;
    }
    
    [_audioTracks addObject: soundtrack];
}

- (NSInteger) indexOfAudioTrack:(MMAudioTrack *)audioTrack
{
    return [self.audioTracks indexOfObject: audioTrack];
}

- (MMAudioTrack *) audioTrackWithIndex: (NSInteger) anIndex
{
    for(MMAudioTrack *track in self.audioTracks)
    {
        if(track.index == anIndex)
        {
            return track;
        }
    }
    return nil;
}

#pragma mark Subtitle
- (void) addSubtitleTrack: (MMSubtitleTrack *) subtitleTrack
{
    if(subtitleTrack == nil || [self.subtitleTracks containsObject: subtitleTrack])
    {
        return;
    }
    
    [_subtitleTracks addObject: subtitleTrack];
}

- (NSInteger) indexOfSubtitleTrack:(MMSubtitleTrack *)subtitleTrack
{
    return [_subtitleTracks indexOfObject: subtitleTrack];
}

- (MMSubtitleTrack *) subtitleTrackWithIndex: (NSInteger) anIndex
{
    for(MMSubtitleTrack *track in self.subtitleTracks)
    {
        if(track.index == anIndex)
        {
            return track;
        }
    }
    return nil;
}

#pragma mark - selecting tracks
#pragma mark Audio
- (void) selectAudioTrack: (MMAudioTrack *) audioTrack
{
    // flip the switch on selected track
    BOOL isSelected = !audioTrack.selected;
    audioTrack.selected = isSelected;
    
    if(isSelected)
    {
        self.selected = YES;
    }
    else
    {
        self.selected = [[self selectedAudioTracks] count] > 0;
    }
}

- (NSArray *) selectedAudioTracks
{
    NSMutableArray *selectedAudioTracks = [NSMutableArray arrayWithCapacity: self.audioTracks.count];
    for(MMAudioTrack *track in self.audioTracks)
    {
        if(track.selected)
        {
            [selectedAudioTracks addObject: track];
        }
    }
    return selectedAudioTracks;
}

#pragma mark Subtitles
- (void) selectSubtitleTrack: (MMSubtitleTrack *) subtitleTrack
{
    BOOL isSelected = !subtitleTrack.selected;
    subtitleTrack.selected = isSelected;
    
    // CC was selected, unselect ALL vobsubs, but let other CCs selected
    if(subtitleTrack.type == SUBTITLE_CLOSED_CAPTION)
    {
        for(MMSubtitleTrack *track in self.subtitleTracks)
        {
            if(track != subtitleTrack && track.type == SUBTITLE_VOBSUB)
            {
                track.selected = NO;
            }
        }
    }
    // otherwise, we have a vobsub, unselect all other subtitles - VOBSUB is mutually exclusive
    else
    {
        for(MMSubtitleTrack *track in self.subtitleTracks)
        {
            if(track != subtitleTrack)
            {
                track.selected = NO;
            }
        }
    }
}

- (NSArray *) selectedSubtitleTracks
{
    NSMutableArray *selectedSubtitleTracks = [NSMutableArray arrayWithCapacity: self.subtitleTracks.count];
    for(MMSubtitleTrack *track in self.subtitleTracks)
    {
        if(track.selected)
        {
            [selectedSubtitleTracks addObject: track];
        }
    }
    return selectedSubtitleTracks;
}

@end
