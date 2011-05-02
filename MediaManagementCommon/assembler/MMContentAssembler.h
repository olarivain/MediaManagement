//
//  ContentAssembler.h
//  MediaManagementCommon
//
//  Created by Kra on 4/3/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContent;
@class MMMediaLibrary;

@interface MMContentAssembler : NSObject 
{
@private
    
}

+ (id) sharedInstance;

- (NSData*) writeLibrary: (MMMediaLibrary*) library;

- (NSData*) writeObject: (NSObject*) object;
- (NSDictionary*) writeContent: (MMContent*) content;
- (NSArray*) writeContentArray: (NSArray*) contentList;

- (MMContent*) createContent: (NSDictionary*) dictionary;
- (NSArray*) createContentArray: (NSArray*) dictionary;

@end
