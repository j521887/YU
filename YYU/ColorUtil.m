#import "ColorUtil.h"
@implementation ColorUtil
+(UIColor *) hexStringToColor: (NSString *) stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor blackColor];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    float alpha = 1.0f;
    NSRange range;
    range.length = 2;
    if ([cString length] == 8) {  
        range.location = 0;
        NSString *aString = [cString substringWithRange:range];
        unsigned int a;
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        alpha = (float)a / 255.0f;
        cString = [cString substringFromIndex:2];
    } else if([cString length] != 6){
        return [UIColor blackColor];
    }
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}
+ (CAGradientLayer *)operationGradientLayer:(CGSize)size
{   
    CAGradientLayer *gradientLayer = nil;
    @autoreleasepool {
        gradientLayer = [[CAGradientLayer alloc] init];
        CGRect newGradientLayerFrame = CGRectMake(0, 0, size.width, size.height);
        gradientLayer.frame = newGradientLayerFrame;
        CGColorRef outerColor = [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1] CGColor];
        CGColorRef innerColor = [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8] CGColor];
        gradientLayer.colors = @[(__bridge id)outerColor,
                             (__bridge id)innerColor,
                             (__bridge id)innerColor,
                             (__bridge id)outerColor];
        gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.4], [NSNumber numberWithFloat:0.6], [NSNumber numberWithFloat:1.0], nil];
        gradientLayer.startPoint = CGPointMake(0,0);
        gradientLayer.endPoint = CGPointMake(1,0);
    }
    return gradientLayer;
}
+ (UIImage *)createImageWithColor:(UIColor *)color {
    UIImage *theImage = nil;
    @autoreleasepool {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return theImage;
}
+ (UIColor *)getRandomColor
{
    float red = arc4random() % 255;
    float green = arc4random() % 255;
    float blue = arc4random() % 255;
    UIColor *color = [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
    return color;
}
@end
