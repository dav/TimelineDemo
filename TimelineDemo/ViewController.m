#import "ViewController.h"
#import "TimelineDataSource.h"
#import "TimelineViewController.h"
#import "TimelineCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.bounds;
    CGSize timelineCellSize = [TimelineCell size];
    frame.origin.y = frame.size.height - timelineCellSize.height;
    frame.size.height = timelineCellSize.height;
    
    UIView* timelineContainerView = [[UIView alloc] initWithFrame:frame];
    [self.view addSubview:timelineContainerView];
    
    TimelineDataSource *dataSource = [TimelineDataSource new];
    [dataSource generateSampleData];

    TimelineViewController *timelineVC = [[TimelineViewController alloc] initWithDataSource:dataSource];

    [self addChildViewController:timelineVC];
    [timelineContainerView addSubview:timelineVC.view];
    [timelineVC didMoveToParentViewController:self];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
