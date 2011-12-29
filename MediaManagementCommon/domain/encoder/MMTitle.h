//
//  ITSEncodableContent.h
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTitle : NSObject
{
  NSInteger index;
  NSInteger chapterCount;
  __strong NSString *name;
  __strong NSArray *soundTracks;
  __strong NSArray *subtitleTrack;
  NSTimeInterval duration;
}

+ (MMTitle *) titleWithIndex: (NSInteger) index chapterCount: (NSInteger) chapterCount andDuration: (NSInteger) duration;

@end
