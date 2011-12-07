//
//  MMLibrary.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContent;
@class MMPlaylist;

// Library is the top level root aggregate. It provides access 
// to the iTunes library - ALL libraries, may it be user defined playlists or system libraries.
@interface MMLibrary : NSObject {
  NSString *uniqueId;
  NSString *name;
  
  NSMutableArray *playlists;
}

@property (nonatomic, readonly, strong) NSString *uniqueId;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readonly, strong) NSArray *playlists;

- (void) addPlaylist: (MMPlaylist*) mediaLibrary;

- (void) clear;

@end
