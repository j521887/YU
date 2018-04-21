#import "MyCoustomTool.h"
#import "AppMacros.h"
#import "MyUtil.h"
#include <ImageIO/CGImageSource.h>
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
float allSizeAdapt(float i4s,float i5,float i6,float i6p)
{
    if(IS_IPHONE_4_OR_LESS){
        return i4s;
    }else if(IS_IPHONE_5){
        return i5;
    }else if(IS_IPHONE_6){
        return i6;
    }else if(IS_IPHONE_6P){
        return i6p;
    }else{
        return i5;
    }
}
@implementation MyCoustomTool
+(BOOL)checkTel:(NSString *)str
{
    if ([@"1"isEqualToString: [str substringWithRange:NSMakeRange(0,1)]]){
        return YES;
    }
    return NO;
}
+ (UIImage*)creatBackground:(CGRect)rect fillColor:(UIColor*)fillColor lineColor:(UIColor*)lineColor
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, lineColor.CGColor);
    CGContextFillRect(context, rect);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextFillRect(context, CGRectInset(rect,1.0f,1.0f));
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage*)creatBackground:(CGRect)rect fillColor:(UIColor*)fillColor
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [MyUtil getColor:@"c5c5c5"].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextFillRect(context, CGRectInset(rect,1.0f,1.0f));
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage*)creatBackgroundLine:(CGRect)rect fillColor:(UIColor*)fillColor
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(context);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage*)creatBackgroundBottomLine:(CGRect)rect fillColor:(UIColor*)fillColor
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(context);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage*)creatBackgroundTopLine:(CGRect)rect fillColor:(UIColor*)fillColor
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextStrokePath(context);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur {
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur),
                        nil];
    CIImage *outputImage = filter.outputImage;
    CIContext* context=[CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:outputImage
                                        fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}
+ (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
+ (UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}
+ (UIViewController *)appRootViewController
{
    UITabBarController* rootViewController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = [rootViewController selectedViewController];
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
+(NSString *)makeDiskCachePath:(NSString*)fullNamespace{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}
+(NSString *)uuidString{
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,cfuuid));
    return uuid;
}
+(NSString *)makeDiskDocumentPath:(NSString*)fullNamespace{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIImage*)creatCircleWithSize:(CGSize)size color:(UIColor*)color
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (BOOL)isSupportStock:(NSString*)prodCode
{
    if (([prodCode hasSuffix:@"SS"] || [prodCode hasSuffix:@"SZ"]) &&([prodCode hasPrefix:@"60"] || [prodCode hasPrefix:@"30"] || [prodCode hasPrefix:@"00"])) {
        return true;
    }else{
        return false;
    }
}
+ (NSInteger) fetchStatu:(NSDictionary*)dict
{
    NSInteger ret = 0;
    if (dict == nil || dict.count == 0) {
        ret = -1;
    }else if (dict[@"code"] == nil){
        ret = -1;
    }else{
        @try {
            ret = [dict[@"code"] integerValue];
        } @catch (NSException *exception) {
            ret = -1;
        } @finally {
        }
    }
    return ret;
}
+ (NSArray*) fetchArrayData:(NSDictionary*)dict
{
    NSArray* datas = dict[@"data"];
    if (datas == nil || [datas isKindOfClass:[NSArray class]] == NO) {
        datas = nil;
    }
    return datas;
}
+ (UIImageView*)creatGifImageView:(NSString*)fileName
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"gif"];
    if (filePath == nil) {
        return nil;
    }
    NSData *gifData = [NSData dataWithContentsOfFile: filePath];
    NSMutableArray *frames = nil;
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)gifData, NULL);
    double total = 0;
    NSTimeInterval gifAnimationDuration;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        if (l > 1){
            frames = [NSMutableArray arrayWithCapacity: l];
            for (size_t i = 0; i < l; i++) {
                CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
                NSDictionary *dict = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, 0, NULL));
                if (dict){
                    NSDictionary *tmpdict = [dict objectForKey: @"{GIF}"];
                    total += [[tmpdict objectForKey: @"DelayTime"] doubleValue] * 100;
                }
                if (img) {
                    [frames addObject: [UIImage imageWithCGImage: img]];
                    CGImageRelease(img);
                }
            }
            gifAnimationDuration = total / 100;
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.animationImages = frames;
            imageView.animationDuration = gifAnimationDuration;
            [imageView startAnimating];
            return imageView;
        }
    }
    return nil;
}
+ (BOOL) isResponseValid:(NSDictionary*)dict
{
    BOOL ret = YES;
    if (dict == nil) {
        ret = NO;
    }else if (dict.count == 0){
        ret = NO;
    }else if ([dict isKindOfClass:[NSDictionary class]] == NO){
        ret = NO;
    }
    return ret;
}
+ (NSDictionary*) fetchNSDictionaryData:(NSDictionary*)dict
{
    NSDictionary* datas = dict[@"data"];
    if (datas == nil || [datas isKindOfClass:[NSDictionary class]] == NO) {
        datas = nil;
    }
    return datas;
}
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
+ (NSString *)md5HexDigest:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); 
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+ (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}
+(CGSize)boundingRectWithSize:(CGSize)size AndeFont:(UIFont *)font Str:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return retSize;
}
+(CGSize)boundinglabelRectWithSize:(CGSize)size AndeFont:(UIFont *)font Str:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.font = font;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    [label setAttributedText:attributedString1];
    label.numberOfLines = 0;
    [label sizeToFit];
    return label.frame.size;
}
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)IDCardNumber {
    IDCardNumber = [IDCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([IDCardNumber length] != 18)
    {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:IDCardNumber])
    {
        return NO;
    }
    int summary = ([IDCardNumber substringWithRange:NSMakeRange(0,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([IDCardNumber substringWithRange:NSMakeRange(1,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([IDCardNumber substringWithRange:NSMakeRange(2,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([IDCardNumber substringWithRange:NSMakeRange(3,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([IDCardNumber substringWithRange:NSMakeRange(4,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([IDCardNumber substringWithRange:NSMakeRange(5,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([IDCardNumber substringWithRange:NSMakeRange(6,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [IDCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [IDCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6
    + [IDCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];
    return [checkBit isEqualToString:[[IDCardNumber substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}
-(UIImage *)snapImageForView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aImage;
}
+ (NSString *)hidePhoto:(NSString *)photo
{
    NSString *str = [photo stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return str;
}
+ (NSAttributedString*)generalAttrStringFrom:(NSString*)targetString withColor:(UIColor*)color withFont:(UIFont*)font
{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:targetString];
    for (int i = 0; i < targetString.length; i++) {
        unichar c = [targetString characterAtIndex:i];
        if (c >= 48 && c<=57) {
            [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(i, 1)];
            [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(i, 1)];
        }
    }
    return attrString;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (BOOL) isMobile:(NSString *)mobileNumbel{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNumbel];
}
+ (NSString *) paramValueOfUrl:(NSString *) url withParam:(NSString *) param{
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  
        return tagValue;
    }
    return @"";
}
+ (BOOL)queryPhoneNumber:(NSString *)phoneNum{
    NSMutableString *num = [[NSMutableString alloc] init];
    for(int i =0; i < [phoneNum length]; i++)
    {
        char cr = [phoneNum characterAtIndex:i];
        if (cr>='0' && cr<='9') {
            [num appendString:[NSString stringWithFormat:@"%c",cr]];
        }
    }
    if (num.length >= 11) {
        NSInteger count = num.length;
        NSInteger index = count - 11;
        for (int i = 0; i < index + 1; i++) {
            NSString *str = [num substringWithRange:NSMakeRange(i, 11)];
            if ([MyCoustomTool isMobile:str]) {
                return YES;
            }
        }
    }
    return NO;
}
@end
