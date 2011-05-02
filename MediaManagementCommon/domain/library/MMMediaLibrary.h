//
//  MMPlaylist.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMContent.h"

@class MMLibrary;


@interface MMMediaLibrary : NSObject 
{
@private
  MMContentKind kind;
  NSString *uniqueId;
  NSString *name;
  MMLibrary *library;
  
  NSMutableArray *content;
}

@property (readonly) MMContentKind kind;
@property (readonly) NSString *uniqueId;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, assign) MMLibrary *library;
@property (readonly) NSArray *content;

+ (id) mediaLibraryWithContentKind: (MMContentKind) kind;
+ (id) mediaLibraryWithContentKind: (MMContentKind) kind andSize: (NSUInteger) size;
- (void) addContent: (MMContent*) content;
- (void) removeContent: (MMContent*) content;

@end
