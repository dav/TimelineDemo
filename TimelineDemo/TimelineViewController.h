#import <UIKit/UIKit.h>

@class TimelineDataSource;

@interface TimelineViewController : UICollectionViewController

- (instancetype) initWithDataSource:(TimelineDataSource *)dataSource;

@end
