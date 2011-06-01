//
//  MMTVShow.m
//  MediaManagementCommon
//
//  Created by Kra on 5/31/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMTVShow.h"
#import "MMContent.h"

@implementation MMTVShow

- (BOOL) addContent:(MMContent *)content
{
  if(content.kind != TV_SHOW)
  {
    NSLog(@"FATAL, adding non tv show to MMTVShow");
  }
  
  // Generate season name
  MMContentList *season = nil;
  NSString *seasonName = nil;
  if([content isSeasonSet]) 
  {
    seasonName = [NSString stringWithFormat:@"Season %i", [content.season intValue]];
  }
  else 
  {
    seasonName = @"Unknown Season";
  }
  
  // look for existing season if it exists
  for(MMContentList *contentList in children)
  {
    if([contentList.name caseInsensitiveCompare: seasonName] == NSOrderedSame)
    {
      season = contentList;
      break;
    }
  }
  
  // create the season if it doesn't exist and add it to our children list
  if(season == nil)
  {
    season = [MMContentList contentListWithType: SEASON andName: seasonName];
    season.group = self.group;
    [self addChild: season];
  }
  
  // now we can add the content to the season :)
  return [season addContent: content];
}

@end
