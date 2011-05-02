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

- (void) contentAdded: (MMContent*) content;
- (void) contentRemoved: (MMContent*) content;

@end