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
- (id) initWithContentKind: (MMContentKind) contentKind andSize: (NSUInteger) size;
- (void) addContentGroup: (id<MMContentGroup>) group;
- (void) removeContentGroup: (id<MMContentGroup>) group;

- (void) privateSortContent: (NSMutableArray *) groups;
@end