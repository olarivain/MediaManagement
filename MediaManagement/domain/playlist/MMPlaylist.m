//
//  MMPlaylist.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMPlaylistProtected.h"
#import "MMContent.h"

#import "MMContentGroup.h"
#import "MMLibrary.h"

@interface MMPlaylist()
{
	__strong NSMutableArray *_contentGroups;
    __strong NSMutableArray *_content;
}

@property (nonatomic, readwrite) MMContentKind kind;

@end

@implementation MMPlaylist

+ (id) playlistWithKind:(MMContentKind)kind andSize: (NSUInteger) size;
{
    return [[self alloc] initWithContentKind:kind andSize: size];
}

- (id) initWithContentKind: (MMContentKind) contentKind andSize: (NSUInteger) size
{
    self = [super init];
    if (self)
    {
        self.kind = contentKind;
        _contentGroups = [NSMutableArray arrayWithCapacity: 50];
        _content = [NSMutableArray arrayWithCapacity: 50];
    }
    
    return self;
}

#pragma mark - Content Management
- (BOOL) belongsToPlaylist: (MMContent *) content {
    // content doesn't belong here if the kind doesn't match or if it's
    // a user content
    return content.kind == self.kind;
}

- (void) addContent:(MMContent *)added
{
    // don't add content that doesn't belong here.
    if(![self belongsToPlaylist: added]){
        return;
    }
    
    id<MMContentGroup> group = [self contentGroupForContent: added];
    
    // add object to content list and callback for subclasses
    BOOL didAdd = [group addContent: added];
    if(didAdd || group == nil)
    {
		added.playlistId = self.uniqueId;
        [_content addObjectNilSafe: added];
    }
}

- (void) removeContent:(MMContent *) removed
{
    
    id<MMContentGroup> defaultList = [self contentGroupForContent: removed];
    
    // remove it and callback for subclasses if needed
    BOOL didRemove = [defaultList removeContent: removed];
    if(didRemove || defaultList == nil)
    {
        [_content removeObject: removed];
    }
}

- (void) updateContent: (MMContent *) content
{
    // for now, remove the bastard, and readd it
    [self removeContent: content];
    [self.library addContent: content];
}

#pragma mark - content groups
- (void) addContentGroup: (id<MMContentGroup>) group {
    if([self.contentGroups containsObject: group]) {
        return;
    }
    [_contentGroups addObjectNilSafe: group];
}
- (void) removeContentGroup: (id<MMContentGroup>) group {
    [_contentGroups removeObject: group];
}

- (void) clear
{
    [_content removeAllObjects];
    [_contentGroups removeAllObjects];
}

- (void) sortContent
{
	// sort the content array, simply by name
	[_content sortUsingComparator:^NSComparisonResult(MMContent *obj1, MMContent *obj2) {
		return [obj1.name caseInsensitiveCompare: obj2.name];
	}];
	// delegate to subclasses for content group sorting
    [self privateSortContent: _contentGroups];
}

- (void) privateSortContent: (NSMutableArray *) groups {
    NSAssert(NO, @"implement content group sort in subclasses");
}

- (id<MMContentGroup>) contentGroupForContent: (MMContent *) content
{
    return nil;
}

@end
