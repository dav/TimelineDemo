#import <UIKit/UIKit.h>

@class TimelineItem;

@interface TimelineCell : UICollectionViewCell

@property (nonatomic) TimelineItem *timelineItem;

+ (CGSize) size;

@end
