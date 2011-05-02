//
//  MMPlaylist.m
//  MediaManagementCommon
//
//  Created by Kra on 5/1/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMMediaLibraryProtected.h"
#import "MMContent.h"

@interface MMMediaLibrary()
- (id) initWithContentKind: (MMContentKind) kind;
@end

@implementation MMMediaLibrary


+ (id) mediaLibraryWithContentKind: (MMContentKind) kind
{
  return [MMMediaLibrary mediaLibraryWithContentKind:kind andSize:1000];
}

+ (id) mediaLibraryWithContentKind: (MMContentKind) kind andSize: (NSUInteger) size
{
  return [[[MMMediaLibrary alloc] initWithContentKind: kind andSize: size] autorelease];

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
    content = [[NSMutableArray alloc] initWithCapacity: size];
  }
  
  return self;
}

- (void)dealloc
{
  [uniqueId release];
  [name release];
  [content release];
  [super dealloc];
}

@synthesize kind;
@synthesize uniqueId;
@synthesize name;
@synthesize library;
@synthesize content;

#pragma mark - Public business methods
- (void) addContent:(MMContent *)added
{
  // refuse to add content if the content's kind doesn't match ours
  // OR always allow additions if we're a user plauylist
  if(added.kind != kind || kind == USER)
  {
    return;
  }
  
  // double check for duplicates
  if([content containsObject: added])
  {
    return;
  }
  
  // eventually, we can add the object and callback for subclasses.
  [content addObject: added];
  [self contentAdded: added];
}

- (void) removeContent:(MMContent *) removed
{
  // make sure the object exists
  if(![content containsObject: removed])
  {
    // log the developer about this issue
    NSLog(@"Warning, content \"%@\" is not present in media library \"%@\".", removed.name, self.name);
    return;
  }
  
  // remove it and callback for subclasses
  [content removeObject: removed];
  [self contentRemoved: removed];
}

#pragma mark - "Abstract" methods
- (void) contentAdded:(MMContent *)content
{
  @throw [NSException exceptionWithName:@"IllegalArgument" reason:@"MMMediaLibrary.contentAdded MUST be overriden." userInfo:nil];
}

- (void) contentRemoved:(MMContent *)content
{
    @throw [NSException exceptionWithName:@"IllegalArgument" reason:@"MMMediaLibrary.contentRemoved MUST be overriden." userInfo:nil];
}

@end
