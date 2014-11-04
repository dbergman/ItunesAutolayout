//
//  AlbumDetails.m
//  ItunesAutolayout
//
//  Created by Dustin Bergman on 11/4/14.
//  Copyright (c) 2014 Dustin Bergman. All rights reserved.
//

#import "AlbumDetails.h"

@implementation AlbumDetails

- (instancetype)initWithAlbumDictionary:(NSDictionary *)albumDictionary {
    self = [super init];
    if (self) {
        if([albumDictionary objectForKey:@"artistName"]) {
            self.artistName = [albumDictionary objectForKey:@"artistName"];
        }
        if([albumDictionary objectForKey:@"artworkUrl100"]) {
            self.artworkUrl100 = [albumDictionary objectForKey:@"artworkUrl100"];
        }
        if([albumDictionary objectForKey:@"artworkUrl60"]) {
            self.artworkUrl60 = [albumDictionary objectForKey:@"artworkUrl60"];
        }
        if([albumDictionary objectForKey:@"collectionName"]) {
            self.albumnName = [albumDictionary objectForKey:@"collectionName"];
        }
        if([albumDictionary objectForKey:@"trackCount"]) {
            self.trackCount = [albumDictionary objectForKey:@"trackCount"];
        }
    }
    return self;
}

@end
