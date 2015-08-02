#import "TimelineCell.h"
#import "TimelineItem.h"
#import "ExerciseGroupTableViewCell.h"

@interface TimelineCell () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UILabel *weekdayNameLabel;
@property (nonatomic) UILabel *dayOfMonthLabel;
@property (nonatomic) UITableView *exerciseGroupsTableView;
@end

@implementation TimelineCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = [TimelineCell size];
        self.frame = CGRectMake(0, 0, size.width, size.height);
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    CGSize size = [TimelineCell size];

//    self.layer.cornerRadius = 10;
//    self.layer.borderWidth = 1.0;
//    self.layer.borderColor = [[UIColor cyanColor] CGColor];
    
    self.weekdayNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, size.width, 20)];
    _weekdayNameLabel.font = [UIFont systemFontOfSize:15];
    _weekdayNameLabel.textAlignment = NSTextAlignmentCenter;
    _weekdayNameLabel.textColor = [UIColor redColor];
    [self addSubview:_weekdayNameLabel];
    
    self.dayOfMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, size.width, 30)];
    _dayOfMonthLabel.font = [UIFont systemFontOfSize:24];
    _dayOfMonthLabel.textAlignment = NSTextAlignmentCenter;
    _dayOfMonthLabel.textColor = [UIColor yellowColor];
    [self addSubview:_dayOfMonthLabel];

    self.exerciseGroupsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, size.width, size.height - 65) style:UITableViewStylePlain];
    [_exerciseGroupsTableView registerClass:[ExerciseGroupTableViewCell class] forCellReuseIdentifier:@"cell"];
    _exerciseGroupsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _exerciseGroupsTableView.delegate = self;
    _exerciseGroupsTableView.dataSource = self;
    [self addSubview:_exerciseGroupsTableView];
}

static NSDateFormatter *_weekdayNameFormatter = nil;
- (NSDateFormatter *) weekdayNameFormatter {
    if (! _weekdayNameFormatter) {
        _weekdayNameFormatter = [NSDateFormatter new];
        _weekdayNameFormatter.dateFormat = @"EEE";
    }
    return _weekdayNameFormatter;
}

- (void) setTimelineItem:(TimelineItem *)timelineItem {
    NSCalendar *theCalendar = [NSCalendar currentCalendar];

    NSUInteger dayOfMonth = [theCalendar component:NSCalendarUnitDay fromDate:timelineItem.date];
    
    self.dayOfMonthLabel.text = [NSString stringWithFormat:@"%zu", dayOfMonth];
    self.weekdayNameLabel.text = [[self weekdayNameFormatter] stringFromDate:timelineItem.date];
    
    [self willChangeValueForKey:@"timelineItem"];
    _timelineItem = timelineItem;
    [self didChangeValueForKey:@"timelineItem"];

    [self.exerciseGroupsTableView reloadData];
}

+ (CGSize) size {
    return  CGSizeMake(62, 200);
}

#pragma TableView Stuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.timelineItem.exerciseGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:11.0f];
    cell.textLabel.lineBreakMode = NSLineBreakByClipping;
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *exerciseGroup = [self.timelineItem.exerciseGroups objectAtIndex:indexPath.item];
    cell.textLabel.text = exerciseGroup;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
