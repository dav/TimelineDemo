#import "TimelineViewController.h"
#import "TimelineDataSource.h"
#import "TimelineItem.h"
#import "TimelineCell.h"
#import "TimelineLayout.h"

@interface TimelineViewController ()
@property (nonatomic) TimelineDataSource *dataSource;
@end

@implementation TimelineViewController

static NSString * const reuseIdentifier = @"TimelineCell";

- (instancetype) initWithDataSource:(TimelineDataSource *)dataSource {
    TimelineLayout *layout = [TimelineLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithCollectionViewLayout:layout];
    
    if (self) {
        dataSource.configureCellBlock = ^(TimelineCell *cell, NSIndexPath *indexPath, TimelineItem *item) {
            cell.timelineItem = item;
        };

        self.collectionView.dataSource = dataSource;
        self.dataSource = dataSource; // The collection view does not retain its own dataSource!
        layout.numberOfItems = [self.dataSource.items count];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    
    [self.collectionView registerClass:[TimelineCell class] forCellWithReuseIdentifier:@"TimelineCell"];
}

- (void) didMoveToParentViewController:(UIViewController *)parent {
    self.view.frame = [self.view superview].bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
