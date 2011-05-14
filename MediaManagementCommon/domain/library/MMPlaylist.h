//
//  MMPlaylist.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMContent.h"

@class MMLibrary;


@interface MMPlaylist : NSObject 
{
@private
  MMContentKind kind;
  NSString *uniqueId;
  NSString *name;
  MMLibrary *library;
  
  NSMutableArray *content;
}

@property (readonly) MMContentKind kind;
@property (readonly) NSString *uniqueId;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, assign) MMLibrary *library;
@property (readonly) NSArray *content;

+ (id) playlist;
+ (id) playlistWithSize: (NSUInteger) size;
+ (id) playlistWithKind: (MMContentKind) kind andSize: (NSUInteger) size;
- (void) addContent: (MMContent*) content;
- (void) removeContent: (MMContent*) content;
// TODO this should take a param indicating whether we want artist, album etc
- (NSInteger) sectionsCount;
- (NSString*) titleForSection: (NSInteger) index;

@end
