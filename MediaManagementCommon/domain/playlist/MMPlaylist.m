//
//  MMPlaylist.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMPlaylistProtected.h"
#import "MMPlaylistContentType.h"
#import "MMContent.h"
#import "MMContentList.h"

@interface MMPlaylist()
- (id) initWithContentKind: (MMContentKind) kind;
//- (NSNumber*) keyForContentList: (MMContentList*) contentList;
//- (NSNumber*) keyForSubContentType: (MMSubContentType) subContentType;

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
    contentLists = [[NSMutableArray alloc] initWithCapacity: size / 5];
    contentTypes = [[self initializeContentTypes] retain];
    contentListBySubContentType = [[NSMutableDictionary alloc] initWithCapacity:5];
  }
  
  return self;
}



- (void)dealloc
{
  [uniqueId release];
  [name release];
  [contentLists release];
  [contentListBySubContentType release];
  [super dealloc];
}

@synthesize kind;
@synthesize uniqueId;
@synthesize name;
@synthesize library;
@synthesize contentLists;

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
  
  MMContentList *defaultList = [self defaultContentList];

  // add object to content list and callback for subclasses
  BOOL didAdd = [defaultList addContent: added];
  if(didAdd)
  {
    [self contentAdded: added];
  }
}

- (void) removeContent:(MMContent *) removed
{
  MMContentList *defaultList = [self defaultContentList];
  // remove it and callback for subclasses if needed
  BOOL didRemove = [defaultList removeContent: removed];
  if(didRemove)
  {
    [self contentRemoved: removed];
  }
}

#pragma mark - Content List management

- (void) addContentList: (MMContentList*) contentList
{
  // give up if we already have this dude.
  if([contentLists containsObject: contentList])
  {
    return;
  }
  
  // add new content list to global content lists list
  [contentLists addObject: contentList];
  contentList.playlist = self;
  
  // now, build local cache of subcontent -> content lists map
  MMPlaylistContentType *subContentTypeKey = contentList.contentType;
  NSMutableArray *array = [contentListBySubContentType objectForKey: subContentTypeKey];
  // create on demand
  if(array == nil)
  {
    array = [NSMutableArray array];
    [contentListBySubContentType setObject:array forKey:subContentTypeKey];
  }
  
  [array addObject: contentList];
}

- (void) removeContentList: (MMContentList*) contentList
{
  // abort if we don't know about this guy
  if(![contentLists containsObject: contentList])
  {
    return;
  }
  
  // remove from content lists list.
  [contentLists removeObject: contentList];
  contentList.playlist = nil;
  
  // remove from local map
  MMPlaylistContentType *subContentTypeKey = contentList.contentType;
  NSMutableArray *array = [contentListBySubContentType objectForKey: subContentTypeKey];
  [array removeObject: contentList];
}

- (NSArray*) contentListsWithSubContentType: (MMPlaylistContentType *) contentType
{
  NSArray *list = [contentListBySubContentType objectForKey:contentType];
  return list;
}

- (MMContentList*) contentListsWithSubContentType: (MMPlaylistContentType *) contentType andName: (NSString*) listName
{
  for(MMContentList *contentList in [self contentListsWithSubContentType: contentType])
  {
    if([contentList.name caseInsensitiveCompare: listName] == NSOrderedSame)
    {
      return contentList;
    }
  }
  return nil;
}

- (MMPlaylistContentType*) contentType: (MMSubContentType) type
{
  for(MMPlaylistContentType *contentType in contentTypes)
  {
    if(contentType.type == type)
    {
      return contentType;
    }
  }
  return nil;
}

- (MMContentList*) defaultContentList
{
  MMPlaylistContentType *contentType = [self contentType: NONE];
  return [self contentListWithSubContentType: contentType name:@"Default" create: YES];
}
 
- (MMContentList*) contentListWithSubContentType: (MMPlaylistContentType*) subContentType name:(NSString*) contentListName create: (BOOL) create
{
  MMContentList *contentList = [self contentListsWithSubContentType: subContentType andName: contentListName];
  
  // contentL list hasn't been found, create it and add it to our list
  if(create && contentList == nil)
  {
    contentList = [MMContentList contentListWithSubContentType:subContentType andName:contentListName];
    [self addContentList: contentList];
  }
  return contentList;
}

- (void) clearPlaylist
{
  [contentListBySubContentType removeAllObjects];
  [contentLists removeAllObjects];
}

#pragma mark - "Abstract" methods
- (NSArray*) initializeContentTypes
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
