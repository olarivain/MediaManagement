//
//  MMPlaylistContentType.h
//  MediaManagementCommon
//
//  Created by Kra on 5/15/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MMSubContentType
{
  NONE = 0,
  ARTIST = 1,
  ALBUM = 2,
  SERIES = 3,
  SEASON = 4
} MMSubContentType;

@interface MMPlaylistContentType : NSObject {
  MMSubContentType type;
  NSString *name;
}

+ (id) playlistContentTypeWithName: (NSString*) name andType: (MMSubContentType) type;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) MMSubContentType type;

@end
