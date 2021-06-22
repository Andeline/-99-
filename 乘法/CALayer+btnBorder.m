//
//  CALayer+btnBorder.m
//  乘法
//
//  Created by 蔡佳穎 on 2021/6/19.
//

#import "CALayer+btnBorder.h"
#import <UIKit/UIKit.h>
@implementation CALayer (borderColor)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
 self.borderColor = color.CGColor;
}
@end
