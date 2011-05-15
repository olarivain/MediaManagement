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

@interface MMLibrary : NSObject {
@private
  NSString *uniqueId;
  NSString *name;
  
  NSMutableArray *mediaLibraries;
}

@property (nonatomic, readonly) NSString *uniqueId;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readonly) NSArray *mediaLibraries;

- (void) addPlaylist: (MMPlaylist*) mediaLibrary;

@end
