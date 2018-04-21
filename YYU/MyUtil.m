#import "MyUtil.h"
@implementation MyUtil
+ (UIImage*)loadImageFromBundle:(NSString*)relativePath {
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:relativePath];
    return [UIImage imageWithContentsOfFile:path];
}
+ (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int redInt_, greenInt_, blueInt_;
    NSRange rangeNSRange_;
    rangeNSRange_.length = 2;  
    rangeNSRange_.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
    rangeNSRange_.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
    rangeNSRange_.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
    return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:1.0f];
}
+ (UIImage *)stretchImage:(UIImage *)image
                capInsets:(UIEdgeInsets)capInsets
             resizingMode:(UIImageResizingMode)resizingMode
{
    UIImage *resultImage = nil;
    double systemVersion = [[UIDevice currentDevice].systemVersion doubleValue];
    if (systemVersion <5.0) {
        resultImage = [image stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.right];
    }else if (systemVersion<6.0){
        resultImage = [image resizableImageWithCapInsets:capInsets];
    }else{
        resultImage = [image resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    }
    return resultImage;
}
@end
