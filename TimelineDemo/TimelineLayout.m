#import "TimelineLayout.h"
#import "TimelineCell.h"
#import "TimelineDataSource.h"
#import "TimelineItem.h"

@implementation TimelineLayout

- (CGSize)collectionViewContentSize
{
    // Don't scroll vertically
    CGFloat contentHeight = self.collectionView.bounds.size.height;

    CGSize fullCellSize = [TimelineCell size];
    
    // Scroll horizontally
    CGFloat contentWidth = (fullCellSize.width) * self.numberOfItems;
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    CGSize cellSize = [TimelineCell size];
    CGFloat widthPerDay = cellSize.width;
    
    CGRect frame = CGRectZero;
    frame.origin.x = widthPerDay * indexPath.item;
    frame.origin.y = 0;
    frame.size = cellSize;
    attributes.frame = frame;
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark -

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect
{
    NSInteger minVisibleDay = [self dayIndexFromXCoordinate:CGRectGetMinX(rect)];
    NSInteger maxVisibleDay = [self dayIndexFromXCoordinate:CGRectGetMaxX(rect)];
    
    TimelineDataSource *dataSource = self.collectionView.dataSource;
    NSArray *indexPaths = [dataSource indexPathsOfItemsBetweenMinDayIndex:minVisibleDay maxDayIndex:maxVisibleDay];
    
    return indexPaths;
}

- (NSInteger)dayIndexFromXCoordinate:(CGFloat)xPosition
{
    CGSize cellSize = [TimelineCell size];
    CGFloat widthPerDay = cellSize.width;
    NSInteger dayIndex = MAX((NSInteger)0, (NSInteger)((xPosition) / widthPerDay));
    return dayIndex;
}

@end
