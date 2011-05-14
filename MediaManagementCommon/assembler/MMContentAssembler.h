//
//  ContentAssembler.h
//  MediaManagementCommon
//
//  Created by Kra on 4/3/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMContent;
@class MMPlaylist;

@interface MMContentAssembler : NSObject 
{
@private
    
}

+ (id) sharedInstance;

- (NSDictionary*) writeLibrary: (MMPlaylist*) library;

- (NSDictionary*) writeContent: (MMContent*) content;
- (NSArray*) writeContentArray: (NSArray*) contentList;

- (MMPlaylist*) createLibrary: (NSDictionary*) dictionary;
- (MMContent*) createContent: (NSDictionary*) dictionary;
- (NSArray*) createContentArray: (NSArray*) dictionary;

@end
