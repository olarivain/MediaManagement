//
//  ContentCollection.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Content;

@protocol ContentCollection <NSObject>
- (NSArray*) content;
- (NSArray*) subContent;

- (BOOL) addContent: (Content*) content;
- (BOOL) removeContent: (Content*) content;
- (void) updateContent: (Content*) content;
@end
