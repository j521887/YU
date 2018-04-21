#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyCoustomTool : NSObject
+(BOOL)checkTel:(NSString *)str;
+ (UIImage*)creatBackground:(CGRect)rect fillColor:(UIColor*)fillColor;
+ (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur;
+ (UIImage*)creatBackgroundLine:(CGRect)rect fillColor:(UIColor*)fillColor;
+ (UIImage*) createImageWithColor:(UIColor*) color;
+ (UIViewController *)getCurrentVC;
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage*)creatCircleWithSize:(CGSize)size color:(UIColor*)color;
+(void)setExtraCellLineHidden: (UITableView *)tableView;
+(NSString *)uuidString;
+(NSString *)makeDiskDocumentPath:(NSString*)fullNamespace;
+(NSString *)makeDiskCachePath:(NSString*)fullNamespace;
+ (BOOL)isSupportStock:(NSString*)prodCode;
+ (UIViewController *)appRootViewController;
+ (UIImage*)creatBackgroundTopLine:(CGRect)rect fillColor:(UIColor*)fillColor;
+ (UIImage*)creatBackgroundBottomLine:(CGRect)rect fillColor:(UIColor*)fillColor;
+ (UIImage*)creatBackground:(CGRect)rect fillColor:(UIColor*)fillColor lineColor:(UIColor*)lineColor;
+ (UIImageView*)creatGifImageView:(NSString*)fileName;
+ (BOOL) isResponseValid:(NSDictionary*)dict;
+ (NSInteger) fetchStatu:(NSDictionary*)dict;
+ (NSArray*) fetchArrayData:(NSDictionary*)dict;
+ (NSDictionary*) fetchNSDictionaryData:(NSDictionary*)dict;
+(NSString *)md5HexDigest:(NSString*)Des_str;
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
extern float allSizeAdapt(float i4s,float i5,float i6,float i6p);
+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;
+(CGSize)boundingRectWithSize:(CGSize)size AndeFont:(UIFont *)font Str:(NSString *)text;
+(CGSize)boundinglabelRectWithSize:(CGSize)size AndeFont:(UIFont *)font Str:(NSString *)text;
-(UIImage *)snapImageForView:(UIView *)view;
+ (NSString *)hidePhoto:(NSString *)photo;
+ (NSAttributedString*)generalAttrStringFrom:(NSString*)targetString withColor:(UIColor*)color withFont:(UIFont*)font;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (BOOL) isMobile:(NSString *)mobileNumbel;
+ (void)preservationSearchText:(NSString *)searchText;
+ (UIWindow *)lastWindow;
+ (NSString *) paramValueOfUrl:(NSString *) url withParam:(NSString *) param;
+ (BOOL)queryPhoneNumber:(NSString *)phoneNum;
@end
