//
//  MMContentList.h
//  MediaManagementCommon
//
//  Created by Kra on 5/13/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMPlaylist.h"

@class MMContent;

@interface MMContentList : NSObject {
@private
  NSMutableArray *content;
  NSString *name;
  MMSubContentType subContentType;
  MMPlaylist *playlist;
}

+ (id) contentListWithSubContentType: (MMSubContentType) contentType andName: (NSString*) name;
- (id) initWithSubContentType: (MMSubContentType) contentType andName: (NSString*) contentName;

@property (nonatomic, readonly) MMSubContentType subContentType;
@property (nonatomic, readonly, retain) NSString *name;
@property (nonatomic, readonly, retain) NSArray *content;
@property (nonatomic, readwrite, assign) MMPlaylist *playlist;

- (void) addContent: (MMContent*)  content;
- (void) removeContent: (MMContent*)  content;
@end
