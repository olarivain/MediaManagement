//
//  MMMediaLibraryProtected.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMPlaylist.h"
#import "MMPlaylistContentType.h"
@class MMLibrary;
@class MMContent;


@interface MMPlaylist()
- (id) initWithContentKind: (MMContentKind) contentKind;
- (id) initWithContentKind: (MMContentKind) contentKind andSize: (NSUInteger) size;
- (NSArray*) initializeContentTypes;
- (void) contentAdded: (MMContent*) content;
- (void) contentRemoved: (MMContent*) content;
- (MMPlaylistContentType*) contentType: (MMSubContentType) type;
- (MMContentList*) contentListWithSubContentType: (MMPlaylistContentType*) subContentType name:(NSString*) contentListName create: (BOOL) create;
@end