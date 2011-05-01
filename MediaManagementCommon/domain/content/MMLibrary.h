//
//  MMLibrary.h
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContent;

@interface MMLibrary : NSObject {
@private
  NSString *uniqueId;
  NSString *name;
  
  NSMutableArray *collections;
}

@property (nonatomic, readonly) NSString *uniqueId;
@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readonly) NSArray *collections;

- (void) updateContent: (MMContent*) content;
@end
