//
//  MMMediaLibraryProtected.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMMediaLibrary.h"

@class MMLibrary;
@class MMContent;

@interface MMMediaLibrary()
- (id) initWithContentKind: (MMContentKind) contentKind;
- (id) initWithContentKind: (MMContentKind) contentKind andSize: (NSUInteger) size;
- (void) contentAdded: (MMContent*) content;
- (void) contentRemoved: (MMContent*) content;

@end