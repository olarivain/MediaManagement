//
//  MMMusicLibrary.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMMediaLibraryProtected.h"

@class MMArtist;
@interface MMMusicLibrary : MMMediaLibrary {
@private
  NSMutableArray *artists;
  MMArtist *unknownArtist;
}

@property (readonly) NSArray *artists;

- (void) removeArtist: (MMArtist*) artist;

@end
