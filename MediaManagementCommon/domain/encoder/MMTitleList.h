//
//  ITSTitleList.h
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 Edmunds. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMTitle;

/**
 Root aggregate for titles. So far, holds only a list of titles. I'm sure more will be coming in.
 */
@interface MMTitleList : NSObject
{
  __strong NSMutableArray *titles;
}

+ (MMTitleList *) titleList;

@property (nonatomic, readonly) NSArray *titles;

- (void) addtitle: (MMTitle *) title;

@end