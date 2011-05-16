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
  return [[[MMPlaylist alloc] initWithContentKind:kind andSize:1000] autorelease];
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
    contentGroups = [[self initializeContentGroups] retain];
    [self initializeContentLists];
  }
  
  return self;
}



- (void)dealloc
{
  [uniqueId release];
  [name release];
  [contentGroups release];
  [super dealloc];
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

- (void) addContent:(MMContent *)added
{
  // refuse to add content if the content's kind doesn't match ours
  // OR always allow additions if we're a user plauylist
  if(added.kind != kind || kind == USER)
  {
    return;
  }
  
  MMContentGroup *defaultGroup = [self defaultContentGroup];
  MMContentList *defaultList = [defaultGroup defaultContentList];
  
  // add object to content list and callback for subclasses
  BOOL didAdd = [defaultList addContent: added];
  if(didAdd)
  {
    [self contentAdded: added];
  }
}

- (void) removeContent:(MMContent *) removed
{
  MMContentGroup *defaultGroup = [self defaultContentGroup];
  MMContentList *defaultList = [defaultGroup defaultContentList];
  
  // remove it and callback for subclasses if needed
  BOOL didRemove = [defaultList removeContent: removed];
  if(didRemove)
  {
    [self contentRemoved: removed];
  }
}

- (void) clear
{
  for(MMContentGroup *contentGroup in contentGroups)
  {
    [contentGroup clear];
  }
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

- (MMContentList*) defaultContentList
{
  MMContentGroup *contentGroup = [self defaultContentGroup];
  MMContentList *contentList = [contentGroup defaultContentList];
  return contentList;
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

- (NSArray*) initializeContentGroups
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
