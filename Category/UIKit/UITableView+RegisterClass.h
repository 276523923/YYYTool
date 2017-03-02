//
//  UITableView+RegisterClass.h
//  BaoZhangWang
//
//  Created by 叶越悦 on 15/7/22.
//  Copyright (c) 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RegisterClass)

@property (nonatomic, strong, readonly) NSDictionary *allCellReuseIdentifier;

- (void)registerClass:(Class)cellClass;
- (__kindof UITableViewCell *)dequeueReusableCellWithCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

@end
