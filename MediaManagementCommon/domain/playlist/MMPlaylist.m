//
//  MMPlaylist.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMPlaylistProtected.h"
#import "MMContent.h"
#import "MMContentList.h"

@interface MMPlaylist()

- (id) initWithContentKind: (MMContentKind) kind;
- (MMContentList*) contentListForContent: (MMContent *) content;
@end

@implementation MMPlaylist


+( id) playlist 
{
  return [MMPlaylist playlistWithKind:MUSIC andSize: 1000];
}

+ (id) playlistWithSize:(NSUInteger)size {
  return [MMPlaylist playlistWithKind:MUSIC andSize:size];
}

+ (id) playlistWithKind:(MMContentKind)kind andSize: (NSUInteger) size;
{
  return [[MMPlaylist alloc] initWithContentKind:kind andSize:1000];
}

- (id) initWithContentKind: (MMContentKind) contentKind
{
  self = [self initWithContentKind: contentKind andSize: 1000];
  if (self) 
  {
  }
  
  return self;
}

- (id) initWithContentKind: (MMContentKind) contentKind andSize: (NSUInteger) size
{
  self = [super init];
  if (self) 
  {
    kind = contentKind;
    contentGroups = [self initializeContentGroups];
    [self initializeContentLists];
  }
  
  return self;
}

@synthesize kind;
@synthesize uniqueId;
@synthesize name;
@synthesize library;
@synthesize contentGroups;

#pragma mark - Content Management
- (BOOL) isSystem
{
  return  kind != USER && kind != UNKNOWN;
}

- (BOOL) belongsToPlaylist: (MMContent *) content {
  // content doesn't belong here if the kind doesn't match or if it's
  // a user content
  return content.kind == kind && kind != USER;
}

- (void) addContent:(MMContent *)added
{
  // don't add content that doesn't belong here.
  if(![self belongsToPlaylist: added]){
    return;
  }
  
  MMContentList *defaultList = [self contentListForContent: added];
  
  // add object to content list and callback for subclasses
  BOOL didAdd = [defaultList addContent: added];
  if(didAdd || defaultList == nil)
  {
    added.playlistId = self.uniqueId;
    added.parent = self;
    [self contentAdded: added];
  }
}

- (void) removeContent:(MMContent *) removed
{
  
  MMContentList *defaultList = [self contentListForContent: removed];
  
  // remove it and callback for subclasses if needed
  BOOL didRemove = [defaultList removeContent: removed];
  if(didRemove)
  {
    [self contentRemoved: removed];
  }
}

#warning maybe add this to the client side categories? not sure it makes any sense in the common lib since it's a pure client side operation
- (void) updateContent: (MMContent *) content
{
  // for now, remove the bastard, and readd it
  [self removeContent: content];
  [self addContent: content];
}

- (void) clear
{
  for(MMContentGroup *contentGroup in contentGroups)
  {
    [contentGroup clear];
  }
  contentGroups = [self initializeContentGroups];
  [self initializeContentLists];
}

- (void) sortContent
{
  for(MMContentGroup *contentGroup in contentGroups)
  {
    [contentGroup sortContentLists];
  }
}

#pragma mark - Content List management
- (void) addContentList: (MMContentList*) contentList
{
  // find gorup for this content list
  MMContentGroup *group = [self contentGroupForType: contentList.type];
  // and add it there
  [group addContentList: contentList];
}

- (void) removeContentList: (MMContentList*) contentList
{
  // find gorup for this content list
  MMContentGroup *group = [self contentGroupForType: contentList.type];
  // and remove it from there
  [group removeContentList: contentList];
}

#pragma mark - ContentGroup accessor key generation
- (MMContentGroup*) contentGroupForType: (MMContentGroupType) type
{
  for(MMContentGroup *contentGroup in contentGroups)
  {
    if(contentGroup.type == type)
    {
      return contentGroup;
    }
  }
  return nil;
}

#pragma mark - Various Subcontent Accessors
- (MMContentGroup*) defaultContentGroup
{
  MMContentGroup *contentGroup = [self contentGroupForType: NONE];
  return contentGroup;
}

- (MMContentList*) contentListForContent: (MMContent *) content
{
  MMContentGroup *contentGroup = [self defaultContentGroup];
  MMContentList *contentList = [contentGroup defaultContentList];
  return contentList;
}

- (MMContentList *) defaultContentList
{
  return [[self defaultContentGroup] defaultContentList];
}

- (MMContentList*) contentListsWithType: (MMContentGroupType) contentType andName: (NSString*) listName
{
  return [self contentListWithType: contentType name: listName create: NO];
}

- (MMContentList*) contentListWithType: (MMContentGroupType) type name:(NSString*) listName create: (BOOL) create
{
  MMContentGroup *contentGroup = [self contentGroupForType: type];
  MMContentList *contentList = [contentGroup contentListWithName: listName];
  
  if(contentList == nil && create)
  {
    contentList = [MMContentList contentListWithType: type andName: listName];
    [contentGroup addContentList: contentList];
  } 
  
  return contentList;
}

#pragma mark - "Abstract" methods
- (void) initializeContentLists
{
  [self contentListWithType:NONE name:@"" create: YES];
}

- (NSMutableArray*) initializeContentGroups
{
  @throw [NSException exceptionWithName:@"IllegalOperationException" reason:@"MMMediaLibrary.initializeContentTypes MUST be overriden." userInfo:nil];

}

- (void) contentAdded:(MMContent *)content
{
  @throw [NSException exceptionWithName:@"IllegalOperationException" reason:@"MMMediaLibrary.contentAdded: MUST be overriden." userInfo:nil];
}

- (void) contentRemoved:(MMContent *)content
{
    @throw [NSException exceptionWithName:@"IllegalOperationException" reason:@"MMMediaLibrary.contentRemoved: MUST be overriden." userInfo:nil];
}

@end
