//
//  MMContentGroup.h
//  MediaManagement
//
//  Created by Olivier Larivain on 1/20/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContent;

@protocol MMContentGroup <NSObject>

@property (nonatomic, readonly) NSString *name;

- (BOOL) addContent: (MMContent *) content;
- (BOOL) removeContent: (MMContent *) content;

- (void) sortContent;
@end
