//
//  AlbumsAutoLayoutViewController.m
//  ItunesAutolayout
//
//  Created by Dustin Bergman on 11/4/14.
//  Copyright (c) 2014 Dustin Bergman. All rights reserved.
//

#import "AlbumsAutoLayoutViewController.h"
#import "ItunesSearch.h"
#import "AlbumDetails.h"
#import "LargeAlbumCell.h"

@interface AlbumsAutoLayoutViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong) UICollectionView *collectionView;
@property (strong) UIRefreshControl *refreshControl;
@property (strong) NSArray *albumDetailsArray;
@property (strong) NSArray *artistIds;
@end

@implementation AlbumsAutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.artistIds = @[[NSNumber numberWithInt:522000], [NSNumber numberWithInt:311145], [NSNumber numberWithInt:78500], [NSNumber numberWithInt:551695], [NSNumber numberWithInt:136975]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.collectionView];
    
    NSDictionary *views = @{@"collectionView":self.collectionView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:0 metrics:nil views:views]];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView registerClass:[LargeAlbumCell class] forCellWithReuseIdentifier:@"largeAlbumCell"];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
 
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(loadAlbums) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];

    [self loadAlbums];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumDetailsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LargeAlbumCell *cell = (LargeAlbumCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"largeAlbumCell" forIndexPath:indexPath];
    [cell setAlbumDetails:[self.albumDetailsArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10.0, 0, 10.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (void)loadAlbums {
    [[ItunesSearch sharedInstance] getAlbumsForArtist:[self getRandomArtId] limitOrNil:@200 successHandler:^(NSArray *result) {
        NSMutableArray *albumArray = [NSMutableArray new];
        AlbumDetails *albumDetails;

        self.title = [NSString stringWithFormat:@"%@ Albums", [(NSDictionary *)[result lastObject]objectForKey:@"artistName"]];
                      
        for (NSDictionary *albumDictionary in result) {
            albumDetails = [[AlbumDetails alloc] initWithAlbumDictionary:albumDictionary];
            [albumArray addObject:albumDetails];
        }
        self.albumDetailsArray = [albumArray copy];
        [self.refreshControl endRefreshing];
        [self.collectionView reloadData];
    } failureHandler:^(NSError *error) {
        NSLog(@"error: %@", error);
        [self.refreshControl endRefreshing];
    }];
}

- (NSNumber *)getRandomArtId {
    return [self.artistIds objectAtIndex:arc4random() %((self.artistIds.count))];
}

@end
