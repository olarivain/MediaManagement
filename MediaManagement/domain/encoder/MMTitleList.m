//
//  ITSTitleList.m
//  iTunesServer
//
//  Created by Larivain, Olivier on 12/26/11.
//  Copyright (c) 2011 kra. All rights reserved.
//
#import <KraCommons/NSString+URLEncoding.h>
#import "MMTitleList.h"

#import "MMTitle.h"

@interface MMTitleList() {
    __strong NSMutableArray *_titles;
    __strong NSMutableArray *_selectedTitles;
}

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) NSString *titleListId;
@property (nonatomic, readwrite) NSString *encodedTitleListId;
@end

@implementation MMTitleList

+ (MMTitleList *) titleListWithId: (NSString *) titleListId
{
    return [[MMTitleList alloc] initWithId: titleListId];
}

- (id) initWithId: (NSString *) aTitleListId
{
    self = [super init];
    if(self)
    {
        _titles = [NSMutableArray arrayWithCapacity: 10];
        self.titleListId = aTitleListId;
        self.name = [self.titleListId lastPathComponent];
    }
    return self;
}

- (NSString *) encodedTitleListId
{
    return [self.titleListId stringByURLEncoding];
}

#pragma mark - Title management
- (MMTitle *) activeTitle {
	for(MMTitle *title in self.titles) {
		if(title.encoding) {
			return title;
		}
	}
	
	return nil;
}

- (NSInteger) selectedCount {
	return self.selectedTitles.count;
}

- (NSInteger) completedCount {
	NSInteger count = 0;
	for(MMTitle *title in self.titles) {
		count += title.selected && title.completed;
	}
	return count;
}

- (void) addtitle:(MMTitle *)title
{
    if(title == nil || [self.titles containsObject: title])
    {
        return;
    }
    
    [_titles addObject: title];
}

- (NSInteger) indexOfTitle: (MMTitle *) title
{
    return [self.titles indexOfObject: title];
}

- (MMTitle *) titleWithIndex: (NSInteger) index
{
    for(MMTitle *title in _titles)
    {
        if(title.index == index)
        {
            return title;
        }
    }
    return nil;
}

- (BOOL) isCompleted
{
    for(MMTitle *title in self.selectedTitles)
    {
        if (!title.completed)
        {
            return NO;
        }
    }
    return YES;
}

- (MMTitle *) nextTitleToEncode
{
    for(MMTitle *title in self.selectedTitles)
    {
        if(!title.completed)
        {
            return title;
        }
    }
    return nil;
}

#pragma mark - Selected titles
- (NSArray *) selectedTitles
{
    NSMutableArray *selectedTitles = [NSMutableArray arrayWithCapacity: _titles.count];
    for(MMTitle *title in _titles)
    {
        if(title.selected)
        {
            [selectedTitles addObject: title];
        }
    }
    return selectedTitles;
}

#pragma mark - ID equality
- (NSUInteger) hash
{
    return [self.titleListId hash];
}

- (BOOL) isEqual:(id)object
{
    if(![object isKindOfClass: [MMTitleList class]])
    {
        return NO;
    }
    
    MMTitleList *other = (MMTitleList *) object;
    return [self.titleListId isEqualToString: other.titleListId];
}

@end
