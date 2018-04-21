#import <UIKit/UIKit.h>
@interface ADWebViewController : UIViewController
@property (nonatomic,strong) NSString *webViewURL;
+(instancetype)initWithURL:(NSString *)urlString;
@end
