//
//  NSDate+Addition.m
//  Pods
//
//  Created by 叶越悦 on 2017/7/25.
//
//

#import "NSDate+Addition.h"

/// Parse string to date.
static __attribute__((always_inline)) NSDate *YYY_NSDateFromString(NSString *string) {
    typedef NSDate* (^YYYNSDateParseBlock)(NSString *string);
#define kParserNum 34
    static YYYNSDateParseBlock blocks[kParserNum + 1] = {0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            /*
             2014-01-20  // Google
             */
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"yyyy-MM-dd";
            blocks[10] = ^(NSString *string) { return [formatter dateFromString:string]; };
        }
        
        {
            /*
             2014-01-20 12:24:48
             2014-01-20T12:24:48   // Google
             2014-01-20 12:24:48.000
             2014-01-20T12:24:48.000
             */
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
            
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
            formatter3.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter3.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter3.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
            
            NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
            formatter4.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter4.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter4.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
            
            blocks[19] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter1 dateFromString:string];
                } else {
                    return [formatter2 dateFromString:string];
                }
            };
            
            blocks[23] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter3 dateFromString:string];
                } else {
                    return [formatter4 dateFromString:string];
                }
            };
        }
        
        {
            /*
             2014-01-20T12:24:48Z        // Github, Apple
             2014-01-20T12:24:48+0800    // Facebook
             2014-01-20T12:24:48+12:00   // Google
             2014-01-20T12:24:48.000Z
             2014-01-20T12:24:48.000+0800
             2014-01-20T12:24:48.000+12:00
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
            
            blocks[20] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[24] = ^(NSString *string) { return [formatter dateFromString:string]?: [formatter2 dateFromString:string]; };
            blocks[25] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[28] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
            blocks[29] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }
        
        {
            /*
             Fri Sep 04 00:12:21 +0800 2015 // Weibo, Twitter
             Fri Sep 04 00:12:21.000 +0800 2015
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"EEE MMM dd HH:mm:ss.SSS Z yyyy";
            
            blocks[30] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[34] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }
    });
    if (!string) return nil;
    if (string.length > kParserNum) return nil;
    YYYNSDateParseBlock parser = blocks[string.length];
    if (!parser) return nil;
    return parser(string);
#undef kParserNum
}

@implementation NSDate (Addition)

- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear
{
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday
{
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (NSString *)stringWithFormat:(NSString *)format {
    static NSDateFormatter *outputFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        outputFormatter = [NSDateFormatter new];
        outputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        outputFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    [outputFormatter setDateFormat:format];
    return [outputFormatter stringFromDate:self];
}

+ (NSDate *)dateFromString:(NSString *)string {
    return YYY_NSDateFromString(string);
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format{
    static NSDateFormatter *inputFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputFormatter = [NSDateFormatter new];
        inputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        inputFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    return [inputFormatter dateFromString:string];
}


- (NSString *)dateString
{
    return [self stringWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)string
{
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
