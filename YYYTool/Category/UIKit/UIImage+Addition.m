//
//  UIImage+Addition.m
//  Pods
//
//  Created by 叶越悦 on 2017/7/21.
//
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

+ (instancetype)yyy_templateImageWithImageName:(NSString *)name
{
    return [[UIImage imageNamed:name] yyy_renderingModeAlwaysTemplateImage];
}
+ (instancetype)yyy_OriginalImageWithImageName:(NSString *)name
{
    return [[UIImage imageNamed:name] yyy_renderingModeAlwaysOriginalImage];
}

- (instancetype)yyy_renderingModeAlwaysOriginalImage
{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
- (instancetype)yyy_renderingModeAlwaysTemplateImage
{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
