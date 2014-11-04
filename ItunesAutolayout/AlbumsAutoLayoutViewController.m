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
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor redColor]];
 
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor blueColor];
    [self.refreshControl addTarget:self action:@selector(loadAlbums) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];

    [self loadAlbums];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}

- (void)loadAlbums {
    [[ItunesSearch sharedInstance] getAlbumsForArtist:[self getRandomArtId] limitOrNil:@200 successHandler:^(NSArray *result) {
        NSMutableArray *albumArray = [NSMutableArray new];
        AlbumDetails *albumDetails;
        for (NSDictionary *albumDictionary in result) {
            albumDetails = [[AlbumDetails alloc] initWithAlbumDictionary:albumDictionary];
            [albumArray addObject:albumDetails];
        }
        self.albumDetailsArray = [albumArray copy];
        [self.refreshControl endRefreshing];
    } failureHandler:^(NSError *error) {
        NSLog(@"error: %@", error);
        [self.refreshControl endRefreshing];
    }];
}

- (NSNumber *)getRandomArtId {
    return [self.artistIds objectAtIndex:arc4random() %((self.artistIds.count)-1)];
}

@end
