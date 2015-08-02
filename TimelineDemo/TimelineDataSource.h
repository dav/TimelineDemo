#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TimelineItem, TimelineCell;

typedef void (^ConfigureCellBlock)(TimelineCell *cell, NSIndexPath *indexPath, TimelineItem *item);



@interface TimelineDataSource : NSObject <UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *items;
@property (copy, nonatomic) ConfigureCellBlock configureCellBlock;

- (void) generateSampleData;
- (TimelineItem *) itemAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *) indexPathsOfItemsBetween:(NSDate *)firstDay and:(NSDate *)lastDay;
- (NSArray *)indexPathsOfItemsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex;

@end
