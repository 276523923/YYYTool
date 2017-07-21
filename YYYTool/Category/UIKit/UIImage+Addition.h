//
//  UIImage+Addition.h
//  Pods
//
//  Created by 叶越悦 on 2017/7/21.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

+ (instancetype)yyy_templateImageWithImageName:(NSString *)name;
+ (instancetype)yyy_OriginalImageWithImageName:(NSString *)name;

- (instancetype)yyy_renderingModeAlwaysOriginalImage;
- (instancetype)yyy_renderingModeAlwaysTemplateImage;


@end
