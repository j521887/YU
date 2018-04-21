#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
@interface ColorUtil : NSObject
+(UIColor *) hexStringToColor:(NSString *) stringToConvert;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (CAGradientLayer *)operationGradientLayer:(CGSize)size;
+ (UIColor *)getRandomColor;
@end
