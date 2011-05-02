//
//  MMAlbum.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContent;
@class MMArtist;

@interface MMAlbum : NSObject {
@private
  NSMutableArray *tracks;
  MMArtist *artist;
  NSString *name;
  NSString *albumId;
}

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *albumId;
@property (readonly) NSArray *tracks;
@property (nonatomic, readwrite, assign) MMArtist *artist;


+ (id) albumWithName: (NSString *) name;
- (void) addTrack: (MMContent *) content;
- (void) removeTrack: (MMContent *) content;

@end
