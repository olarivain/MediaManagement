//
//  MMArtist.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMMusicLibrary;
@class MMAlbum;
@class MMContent;

@interface MMArtist : NSObject 
{
@private
  NSMutableArray *albums;
  NSString *name;
  NSString *artistId;
  MMAlbum *unknownAlbum;
  MMMusicLibrary *library;
}

@property (nonatomic, readwrite, assign) MMMusicLibrary *library;
@property (nonatomic, readwrite, retain) NSString *name;
@property (readonly) NSArray *albums;
@property (readonly) NSString *artistId;

+ (id) artistWithName: (NSString*) name;

- (void) addTrack: (MMContent*) content;
- (void) removeTrack: (MMContent*) content;
- (void) removeAlbum: (MMAlbum*) album;
@end
