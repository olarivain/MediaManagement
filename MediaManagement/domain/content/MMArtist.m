//
//  MMArtist.m
//  MediaManagementCommon
//
//  Created by Kra on 5/16/11.
//  Copyright 2011 kra. All rights reserved.
//

#import "MMArtist.h"
#import "MMContent.h"

@implementation MMArtist

- (BOOL) addContent:(MMContent *)content
{
  if(content.kind != MUSIC)
  {
    NSLog(@"FATAL, adding non music to artist");
  }
  
  MMContentList *album = nil;
  
  // generate album name from the content
  NSString *albumName = [content isAlbumSet] ? content.album : @"Unknown Album";
  
  // look for the album in our children list
  for(MMContentList *contentList in children)
  {
    if([contentList.name caseInsensitiveCompare: albumName] == NSOrderedSame)
    {
      album = contentList;
      break;
    }
  }
  
  // album didn't exist, create it and add it to our children list
  if(album == nil)
  {
    album = [MMContentList contentListWithType:ALBUM andName:albumName];
    album.group = self.group;
    [self addChild: album];
  }
  
  // eventually, add content to the album
  return [album addContent: content];
}

@end
