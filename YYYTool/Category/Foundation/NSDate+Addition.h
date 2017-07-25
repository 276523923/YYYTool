//
//  NSDate+Addition.h
//  Pods
//
//  Created by 叶越悦 on 2017/7/25.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

@property (nonatomic, readonly) NSInteger year; /**< 年 */
@property (nonatomic, readonly) NSInteger month; /**< 月 (1~12) */
@property (nonatomic, readonly) NSInteger day; /**< 日 (1~31) */
@property (nonatomic, readonly) NSInteger hour; /**< 小时 (0~23) */
@property (nonatomic, readonly) NSInteger minute; /**< 分钟 (0~59) */
@property (nonatomic, readonly) NSInteger second; /**< 秒 (0~59) */
@property (nonatomic, readonly) NSInteger nanosecond; /**< 纳秒 */
@property (nonatomic, readonly) NSInteger weekday; /**< 周几  (1~7, 第一天是基于用户设置的) */
@property (nonatomic, readonly) NSInteger weekdayOrdinal; /**< WeekdayOrdinal */
@property (nonatomic, readonly) NSInteger weekOfMonth; /**< WeekOfMonth component (1~5) */
@property (nonatomic, readonly) NSInteger weekOfYear; /**< WeekOfYear component (1~53) */
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; /**< YearForWeekOfYear component */
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL isLeapMonth; ///< Weather the month is leap month
@property (nonatomic, readonly) BOOL isLeapYear; ///< Weather the year is leap year
@property (nonatomic, readonly) BOOL isToday; ///< Weather date is today (based on current locale)

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)dateString;
- (NSString *)string;
- (NSDate *)dateByAddingDays:(NSInteger)days;

//返回该月的第一天
- (NSDate *)beginningOfMonth;
//返回周日的的开始时间
- (NSDate *)beginningOfWeek;
//该月的最后一天
- (NSDate *)endOfMonth;

- (NSInteger)numberOfDaysInMonth;
@end
