//
//  AlbumDetails.h
//  ItunesAutolayout
//
//  Created by Dustin Bergman on 11/4/14.
//  Copyright (c) 2014 Dustin Bergman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumDetails : NSObject
@property (strong) NSString *artistName;
@property (strong) NSString *artworkUrl100;
@property (strong) NSString *artworkUrl60;
@property (strong) NSString *albumnName;
@property (strong) NSNumber *trackCount;

- (instancetype)initWithAlbumDictionary:(NSDictionary *)albumDictionary;

@end
