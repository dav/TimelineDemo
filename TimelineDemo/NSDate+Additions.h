#import <Foundation/Foundation.h>

@interface NSDate (Additions)
- (BOOL) isBefore:(NSDate*)date;
- (BOOL) isAfter:(NSDate*)date;

- (BOOL) isDaytime;

- (NSString*) fullDayDetailsString;
- (NSString*) timeOnlyString;
- (NSInteger) daysSince:(NSDate*)sinceDate;

+ (NSDate*) beginningOfThisMonth;
+ (NSDate*) beginningOfDaysAgo:(NSInteger)daysAgo;
+ (NSDate*) beginningOfToday;

+ (NSDate*) daysAgo:(NSUInteger)daysAgo;
@end
