//
//  ViewController.m
//  YYYToolDemo
//
//  Created by 叶越悦 on 2017/3/3.
//  Copyright © 2017年 叶越悦. All rights reserved.
//

#import "ViewController.h"
#import <CommonMacro.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
    [self test2];
    
    // Do any additional  wefwe 111 setup after loading the view, typically from a nib.
}

- (void)test1
{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    NSInteger j = 0;
    for (NSInteger i = 0; i < 10000; i ++)
    {
        if (iphone6AndUper)
        {
            j ++;
        }
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"1time cost: %0.3f", end - start);
}

- (void)test2
{
    BOOL ios7 = NO;
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    ios7 = iphone6AndUper;
    NSInteger j = 0;
    for (NSInteger i = 0; i < 10000; i ++)
    {
        if (ios7)
        {
            j ++;
        }
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"2time cost: %0.3f", end - start);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
