#import "TimelineDataSource.h"
#import "TimelineItem.h"
#import "NSDate+Additions.h"
#import "TimelineCell.h"
#import "NSMutableArray+Additions.h"

@interface TimelineDataSource ()
@end

@implementation TimelineDataSource


#pragma mark - CalendarDataSource

- (instancetype) init {
    self = [super init];
    if (self) {
        self.items = [NSMutableArray new];
    }
    return self;
}

- (void) generateSampleData {
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -7;

    NSDate *startDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];

    for (NSUInteger idx = 0; idx < 45; idx++) {
        dayComponent.day += 1;
        NSDate *date = [theCalendar dateByAddingComponents:dayComponent toDate:startDate options:0];
        
        uint32_t random = arc4random_uniform(10);
        if (random > 3) {
            TimelineItem *item = [TimelineItem new];
            item.date = date;

            NSMutableArray *exerciseGroups = [@[@"Pulls", @"Legs", @"Core", @"Pushes", @"Handstands"] mutableCopy];
            [exerciseGroups shuffle];
            uint32_t randomExerciseGroupCount = arc4random_uniform(5);
            for (NSUInteger g = 0; g < randomExerciseGroupCount; g++) {
                [exerciseGroups removeLastObject];
            }
            item.exerciseGroups = exerciseGroups;

            [self.items addObject:item];
        }
    }
    
}

- (TimelineItem *) itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.item];
}

- (NSArray *) indexPathsOfItemsBetween:(NSDate *)firstDay and:(NSDate *)lastDay;
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        TimelineItem *timelineItem = (TimelineItem *)item;
        BOOL itemIsGreaterOrEqualToStart = ! [timelineItem.date isBefore:firstDay];
        BOOL itemIsBeforeEnd = [timelineItem.date isBefore:lastDay];
        if (itemIsGreaterOrEqualToStart || itemIsBeforeEnd) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
            [indexPaths addObject:indexPath];
        }
    }];
    return indexPaths;
}

- (NSArray *)indexPathsOfItemsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex {
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        if (idx >= minDayIndex || idx <= maxDayIndex) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
            [indexPaths addObject:indexPath];
        }
    }];
    return indexPaths;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TimelineItem *item = self.items[indexPath.item];
    TimelineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimelineCell" forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath, item);
    }
    return cell;
}

@end
