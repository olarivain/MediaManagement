//
//  ContentAssembler.m
//  MediaManagementCommon
//
//  Created by Kra on 4/3/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMContentAssembler.h"
#import "MMContent.h"
#import "MMMediaLibrary.h"

static MMContentAssembler *sharedInstance;

@interface MMContentAssembler()
- (void) setInDictionary: (NSMutableDictionary*) dictionary object: (id) object forKey: (id) key;
@end


@implementation MMContentAssembler

+ (id) sharedInstance
{
  @synchronized(self){
    if(sharedInstance == nil) 
    {
      sharedInstance = [[MMContentAssembler alloc] init];
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

#pragma mark - Domain -> DTO methods
- (NSDictionary*) writeContent: (MMContent*) content
{
  NSMutableDictionary *dto = [NSMutableDictionary dictionary];
  
  
  NSNumber *kind = [NSNumber numberWithInt:content.kind];
  [self setInDictionary: dto object:kind forKey:@"kind"];
  
  [self setInDictionary: dto object:content.contentId forKey:@"contentId"];

  [self setInDictionary: dto object:content.name forKey:@"name"];
  [self setInDictionary: dto object:content.genre forKey:@"genre"];
  [self setInDictionary: dto object:content.artist forKey:@"artist"];
  [self setInDictionary: dto object:content.album forKey:@"album"];
  [self setInDictionary: dto object:content.trackNumber forKey:@"trackNumber"];
  [self setInDictionary: dto object:content.description forKey:@"description"];
  [self setInDictionary: dto object:content.show forKey:@"show"];
  [self setInDictionary: dto object:content.season forKey:@"season"];
  [self setInDictionary: dto object:content.episodeNumber forKey:@"episodeNumber"];
  
  return dto;
}

- (NSArray*) writeContentArray: (NSArray*) contentList
{
  NSMutableArray *dtos = [NSMutableArray arrayWithCapacity:[contentList count]];
  for(MMContent *content in contentList)
  {
    NSDictionary *dto = [self writeContent: content];
    if(dto != nil)
    {
      [dtos addObject: dto];
    }
  }
  
  return dtos;
}

- (NSDictionary*) writeLibrary: (MMMediaLibrary*) library
{
  NSMutableDictionary *dto = [NSMutableDictionary dictionaryWithCapacity:5];
  [self setInDictionary: dto object:library.name forKey:@"name"];  
  
  NSNumber *kind = [NSNumber numberWithInt:library.kind];
  [self setInDictionary: dto object:kind forKey:@"kind"];  

  NSArray *content = [self writeContentArray: library.content];
  [self setInDictionary: dto object:content forKey:@"content"];

  return dto;
}

#pragma mark - DTO -> Domain methods
- (MMContent*) createContent: (NSDictionary*) dictionary
{
  NSNumber *kindNumber = [dictionary objectForKey:@"kind"];
  if(kindNumber == nil)
  {
    return nil;
  }
  
  MMContentKind kind = [kindNumber intValue];
  MMContent *content = [MMContent content:kind];
  
  return content;
}

- (NSArray*) createContentArray: (NSArray*) dtoList
{
  NSMutableArray *domains = [NSMutableArray arrayWithCapacity: [dtoList count]];
  for(NSDictionary *dto in dtoList)
  {
    MMContent *content = [self createContent: dto];
    if(content != nil)
    {
      [domains addObject: content];
    }
  }
  return domains;
}

@end
