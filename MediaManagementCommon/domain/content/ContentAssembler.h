//
//  ContentAssembler.h
//  MediaManagementCommon
//
//  Created by Kra on 4/3/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Content;

@interface ContentAssembler : NSObject 
{
@private
    
}

+ (id) sharedInstance;

- (NSData*) writeObject: (NSObject*) object;
- (NSDictionary*) writeContent: (Content*) content;
- (NSArray*) writeContentArray: (NSArray*) contentList;

- (Content*) createContent: (NSDictionary*) dictionary;
- (NSArray*) createContentArray: (NSArray*) dictionary;

@end
