//
//  UICollectionView+RegisterClass.m
//  BaoZhangWang
//
//  Created by 叶越悦 on 15/7/22.
//  Copyright (c) 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import "UICollectionView+RegisterClass.h"
#import <objc/runtime.h>
#import "NSDictionary+SafeAccess.h"

@interface UICollectionView ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *allCellReuseIdentifier;

@end

@implementation UICollectionView (RegisterClass)

- (void)registerClass:(Class)cellClass
{
    if (!cellClass) {
        return;
    }
    if ([self.allCellReuseIdentifier hasKey:NSStringFromClass(cellClass)])
    {
        return;
    }
    [self.allCellReuseIdentifier setObj:cellClass forKey:NSStringFromClass(cellClass)];
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (UICollectionViewCell *)dequeueReusableCellWithCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath
{
    if (![self.allCellReuseIdentifier hasKey:NSStringFromClass(cellClass)])
    {
        [self registerClass:cellClass];
    }
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (void)setAllCellReuseIdentifier:(NSMutableDictionary *)allCellReuseIdentifier
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
