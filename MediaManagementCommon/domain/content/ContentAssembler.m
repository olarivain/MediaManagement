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

- (SBJsonWriter*) jsonWriter
{
  return [[[SBJsonWriter alloc] init] autorelease];
}

#pragma mark - Domain -> DTO methods
- (NSDictionary*) writeContent: (Content*) content
{
  NSMutableDictionary *dto = [NSMutableDictionary dictionary];
  
  NSNumber *number = [NSNumber numberWithInt: content.contentId];
  [dto setObject:number forKey:@"contentId"];
  
  NSNumber *kind = [NSNumber numberWithInt:content.kind];
  [dto setObject:kind forKey:@"kind"];
  
  NSNumber *episodeNumber = [NSNumber numberWithInt:content.episodeNumber];
  [dto setObject:episodeNumber forKey:@"episodeNumber"];
  
  NSNumber *season = [NSNumber numberWithInt:content.season];  
  [dto setObject:season forKey:@"season"];
  
  NSNumber *trackNumber = [NSNumber numberWithInt:content.trackNumber];
  [dto setObject:trackNumber forKey:@"trackNumber"];
  
  [dto setObject:content.album forKey:@"album"];
  [dto setObject:content.artist forKey:@"artist"];
  [dto setObject:content.description forKey:@"description"];
  [dto setObject:content.genre forKey:@"genre"];
  [dto setObject:content.name forKey:@"name"];
  [dto setObject:content.show forKey:@"show"];
  
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
