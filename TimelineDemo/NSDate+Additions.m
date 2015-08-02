#import "NSDate+Additions.h"

@implementation NSDate (Additions)

- (NSString*) timeOnlyString {
  NSString* template = @"h:mm a";
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:template];
  
  NSString* times = [dateFormatter stringFromDate:self];
  //[dateFormatter release];
  return times;
}

- (BOOL) isBefore:(NSDate*)date {
  return [self compare:date] == NSOrderedAscending;
}

- (BOOL) isAfter:(NSDate*)date {
  return [self compare:date] == NSOrderedDescending;
}

- (BOOL) isDaytime {
  NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents* components = [gregorian components:(NSCalendarUnitHour) fromDate:self];
  NSInteger hour = [components hour];
  return (hour >=6 && hour <=18);
}

- (NSInteger) daysSince:(NSDate*)fromDateTime {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDate *fromDate;
  NSDate *toDate;
  
  [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:fromDateTime];
  [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:self];
  
  NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
  
  return [difference day];
}



+ (NSDate*) beginningOfThisMonth {
  NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents* components = [gregorian components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:[NSDate date]];
  [components setDay:1];
  return [gregorian dateFromComponents:components];
}

+ (NSDate*) beginningOfDaysAgo:(NSInteger)daysAgo {
  NSDate* dateFromDaysAgo = [NSDate dateWithTimeIntervalSinceNow:(-86400*daysAgo)];
  NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents* components = [gregorian components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:dateFromDaysAgo];
  return [gregorian dateFromComponents:components];
}

+ (NSDate*) beginningOfToday {
  NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents* components = [gregorian components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
  return [gregorian dateFromComponents:components];
}

+ (NSDate*) daysAgo:(NSUInteger)daysAgo {
  return [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval)(-86400*daysAgo)];
}

- (NSString*) fullDayDetailsString {
  NSString* template = @"EEEE, MMM dd, yyyy";
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:template];
  
  NSString* times = [dateFormatter stringFromDate:self];
  //[dateFormatter release];
  return times;
}


@end
