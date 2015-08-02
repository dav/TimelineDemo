#import "ExerciseGroupTableViewCell.h"

@implementation ExerciseGroupTableViewCell

- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.textLabel.frame;
    frame.origin.x = 5;
    frame.size.width = self.frame.size.width - (frame.origin.x * 2);
    self.textLabel.frame = frame;
}

@end
