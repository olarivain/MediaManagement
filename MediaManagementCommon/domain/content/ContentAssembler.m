//
//  ContentAssembler.m
//  MediaManagementCommon
//
//  Created by Kra on 4/3/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "ContentAssembler.h"
#import "Content.h"

#import "SBJsonWriter.h"

static ContentAssembler *sharedInstance;

@interface ContentAssembler(private)
- (SBJsonWriter*) jsonWriter;
- (void) setInDictionary: (NSMutableDictionary*) dictionary object: (id) object forKey: (id) key;
@end


@implementation ContentAssembler

+ (id) sharedInstance
{
  @synchronized(self){
    if(sharedInstance == nil) 
    {
      sharedInstance = [[ContentAssembler alloc] init];
    }
  }
  return sharedInstance;
}

- (id)init
{
  self = [super init];
  return self;
}

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - Convenience methods
- (void) setInDictionary: (NSMutableDictionary*) dictionary object: (id) object forKey: (id) key
{
  if(object == nil)
  {
    return;
  }
  
  [dictionary setObject:object forKey: key];
}

- (SBJsonWriter*) jsonWriter
{
  return [[[SBJsonWriter alloc] init] autorelease];
}

#pragma mark - Domain -> DTO methods
- (NSDictionary*) writeContent: (Content*) content
{
  NSMutableDictionary *dto = [NSMutableDictionary dictionary];
  
  [self setInDictionary: dto object:content.contentId forKey:@"contentId"];
  
  NSNumber *kind = [NSNumber numberWithInt:content.kind];
  [self setInDictionary: dto object:kind forKey:@"kind"];
  
  NSNumber *episodeNumber = [NSNumber numberWithInteger:content.episodeNumber];
  [self setInDictionary: dto object:episodeNumber forKey:@"episodeNumber"];
  
  NSNumber *season = [NSNumber numberWithInteger:content.season];  
  [self setInDictionary: dto object:season forKey:@"season"];
  
  NSNumber *trackNumber = [NSNumber numberWithInteger:content.trackNumber];
  [self setInDictionary: dto object:trackNumber forKey:@"trackNumber"];
  
  [self setInDictionary: dto object:content.album forKey:@"album"];
  [self setInDictionary: dto object:content.artist forKey:@"artist"];
  [self setInDictionary: dto object:content.description forKey:@"description"];
  [self setInDictionary: dto object:content.genre forKey:@"genre"];
  [self setInDictionary: dto object:content.name forKey:@"name"];
  [self setInDictionary: dto object:content.show forKey:@"show"];
  
  return dto;
}

- (NSArray*) writeContentArray: (NSArray*) contentList
{
  NSMutableArray *dtos = [NSMutableArray arrayWithCapacity:[contentList count]];
  for(Content *content in contentList)
  {
    NSDictionary *dto = [self writeContent: content];
    if(dto != nil)
    {
      [dtos addObject: dto];
    }
  }
  
  return dtos;
}

- (NSData*) writeObject: (NSObject*) object
{
  NSObject *data;
  if([object isKindOfClass: [NSArray class] ])
  {
    NSArray *domains = (NSArray*) object;
    data = [self writeContentArray: domains];  
  }
  else if([object isKindOfClass: [Content class]])
  {
    Content *domain = (Content*) object;
    data = [self writeContent: domain];
  }
  
  SBJsonWriter *writer = [self jsonWriter];  
  return [writer dataWithObject:data];
}

#pragma mark - DTO -> Domain methods
- (Content*) createContent: (NSDictionary*) dictionary
{
  NSNumber *kindNumber = [dictionary objectForKey:@"kind"];
  if(kindNumber == nil)
  {
    return nil;
  }
  
  ContentKind kind = [kindNumber intValue];
  Content *content = [Content content:kind];
  
  return content;
}

- (NSArray*) createContentArray: (NSArray*) dtoList
{
  NSMutableArray *domains = [NSMutableArray arrayWithCapacity: [dtoList count]];
  for(NSDictionary *dto in dtoList)
  {
    Content *content = [self createContent: dto];
    if(content != nil)
    {
      [domains addObject: content];
    }
  }
  return domains;
}

@end
