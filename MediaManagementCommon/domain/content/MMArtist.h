//
//  MMArtist.h
//  MediaManagementCommon
//
//  Created by Kra on 5/16/11.
//  Copyright 2011 kra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMContentList.h"

// Represents an artist. An artist has a (unique) name and a list of albums (modeled as regular MMContentList)
// An artist does NOT have any tracks, you'll have to go through the list of albums to retrieve actual tracks
// from an artist.
@interface MMArtist : MMContentList 
{
    
}

@end
