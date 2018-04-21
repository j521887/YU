#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyUtil : NSObject
+ (UIImage*)loadImageFromBundle:(NSString*)relativePath;
+ (UIColor *)getColor:(NSString *)hexColor;
+ (UIImage *)stretchImage:(UIImage *)image
                capInsets:(UIEdgeInsets)capInsets
             resizingMode:(UIImageResizingMode)resizingMode;
@end
