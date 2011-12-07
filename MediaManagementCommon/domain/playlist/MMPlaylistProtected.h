//
//  MMMediaLibraryProtected.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMPlaylist.h"
#import "MMContentGroup.h"

@class MMLibrary;
@class MMContent;

@interface MMPlaylist()
- (id) initWithContentKind: (MMContentKind) contentKind;
- (id) initWithContentKind: (MMContentKind) contentKind andSize: (NSUInteger) size;
- (NSMutableArray*) initializeContentGroups;
- (void) initializeContentLists;

- (void) contentAdded: (MMContent*) content;
- (void) contentRemoved: (MMContent*) content;

- (MMContentList*) contentListWithType: (MMContentGroupType) type name:(NSString*) listName create: (BOOL) create;
@end