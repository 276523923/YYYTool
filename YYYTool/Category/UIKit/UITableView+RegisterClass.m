//
//  UITableView+RegisterClass.m
//  BaoZhangWang
//
//  Created by 叶越悦 on 15/7/22.
//  Copyright (c) 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import "UITableView+RegisterClass.h"
#import <objc/runtime.h>
#import "NSDictionary+SafeAccess.h"

static const void * allCellReuseIdentifierKey = &allCellReuseIdentifierKey;

@interface UITableView ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *allCellReuseIdentifier;

@end

@implementation UITableView (RegisterClass)

- (void)registerClass:(Class)cellClass
{
    if (!cellClass) {
        return;
    }
    NSString *clsString = NSStringFromClass(cellClass);
    if ([self.allCellReuseIdentifier hasKey:clsString])
    {
        return;
    }
    [self.allCellReuseIdentifier setObj:cellClass forKey:clsString];
    [self registerClass:cellClass forCellReuseIdentifier:clsString];
}

- (UITableViewCell *)dequeueReusableCellWithCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath
{
    if (![self.allCellReuseIdentifier hasKey:NSStringFromClass(cellClass)])
    {
        [self registerClass:cellClass];
    }
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (void)setAllCellReuseIdentifier:(NSDictionary *)allCellReuseIdentifier
{
    objc_setAssociatedObject(self, @selector(allCellReuseIdentifier), allCellReuseIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)allCellReuseIdentifier
{
    NSMutableDictionary *dic =objc_getAssociatedObject(self, @selector(allCellReuseIdentifier));
    if (!dic)
    {
        dic = [NSMutableDictionary dictionary];
        self.allCellReuseIdentifier = dic;
    }
    return dic;
}

@end
