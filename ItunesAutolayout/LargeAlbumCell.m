//
//  LargeAlbumCell.m
//  ItunesAutolayout
//
//  Created by Dustin Bergman on 11/4/14.
//  Copyright (c) 2014 Dustin Bergman. All rights reserved.
//

#import "LargeAlbumCell.h"
#import "UIImageView+WebCache.h"
#import "AlbumDetails.h"

@interface LargeAlbumCell ()
@property (strong) UIImageView *albumCoverImage;
@property (strong) UILabel *albumNameLabel;
@end

@implementation LargeAlbumCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.albumCoverImage = [UIImageView new];
        self.albumNameLabel = [UILabel new];
    }
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    [self.albumCoverImage removeFromSuperview];
    [self.albumNameLabel removeFromSuperview];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.albumCoverImage sd_setImageWithURL:[NSURL URLWithString:self.albumDetails.artworkUrl60]];
    self.albumCoverImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.albumCoverImage];
    
    self.albumNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.albumNameLabel.textColor = [UIColor whiteColor];
    self.albumNameLabel.numberOfLines = 2;
    self.albumNameLabel.font =  [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
    self.albumNameLabel.text = self.albumDetails.albumnName;
    [self.contentView addSubview:self.albumNameLabel];
    
    NSDictionary *views = @{@"albumCover":self.albumCoverImage, @"albumName":self.albumNameLabel};

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[albumCover(60)]-[albumName(90)]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[albumCover(60)]|" options:0 metrics:nil views:views]];
}

@end

