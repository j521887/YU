#import "AlertUtil.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "UserUtil.h"
#import "ColorUtil.h"
static MBProgressHUD *hudAlertView;
static MBProgressHUD *hudAlertViewInWindow;
@implementation AlertUtil
+(void) showAlertAboveView:(float) viewFrameY withText:(NSString *) text offsetY:(float) height{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showAlertAboveView 提示框显示:%@",text);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *rootVC = window.rootViewController;
        UIView *view = rootVC.view;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"";
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14];
        hud.margin = 10.f;
        CGRect bounds = view.bounds;
        NSInteger yOffset = viewFrameY - bounds.size.height / 2 - height ;
        hud.yOffset = yOffset;
        hud.removeFromSuperViewOnHide = YES;
        hud.userInteractionEnabled = NO;
        [hud hide:YES afterDelay:1.5];
    });
}
+(void) showAlertWithText:(NSString *)text afterDelay:(NSTimeInterval) delay{
    [self performSelector:@selector(showAlertWithText:) withObject:text afterDelay:delay];
}
+(void) showNoneNetWorkAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        [AlertUtil showAlertInWindowWithText:@"当前无网络，请检查网络！"];
    });
}
+ (void)showAlertInWindowWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showAlertInWindowWithText 提示框显示:%@",text);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"";
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14];
        hud.margin = 10.f;
        hud.yOffset = 130.f + (iPhone5 ? 20.0f : 0.0f);
        if (iPhone4) {
            hud.yOffset = 0.0f;
        }
        hud.removeFromSuperViewOnHide = YES;
        hud.userInteractionEnabled = NO;
        [hud hide:YES afterDelay:1.5];
    });
}
+ (void)showAlertWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showAlertWithText 提示框显示:%@",text);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *rootVC = window.rootViewController;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:rootVC.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"";
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14];
        hud.margin = 10.f;
        hud.yOffset = 130.f + (iPhone5 ? 20.0f : 0.0f);
        hud.removeFromSuperViewOnHide = YES;
        hud.userInteractionEnabled = NO;
        [hud hide:YES afterDelay:1.5];
    });
}
+ (void)showCheckmarkAlert:(NSString *)text FailOrNot:(BOOL)success
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showCheckmarkAlert 提示框显示:%@",text);
        NSString *imgFileName = @"ic_checkmark_success";
        if (!success) {
            imgFileName = @"ic_checkmark_failure";
        }
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *rootVC = window.rootViewController;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:rootVC.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgFileName]];
        [customView setBounds:CGRectMake(0, 0, 37, 37)];
        hud.customView = customView;
        hud.labelText = text;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
    });
}
+ (void)showWaitingAlertWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showWaitingAlertWithText 提示框显示:%@",text);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *rootVC = window.rootViewController;
        if (hudAlertView) {
            [hudAlertView removeFromSuperview];
            hudAlertView = nil;
        }
        hudAlertView = [MBProgressHUD showHUDAddedTo:rootVC.view animated:YES];
        hudAlertView.labelText = ((text && text.length > 0) ? text : @"请稍候");
    });
}
+ (void)performWaitingAlertDismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"performWaitingAlertDismiss");
        if (hudAlertView) {
            [hudAlertView removeFromSuperview];
            hudAlertView = nil;
        }
    });
}
+ (void)performWaitingAlertDismissInMainThread
{
    NSLog(@"performWaitingAlertDismissInMainThread");
    if (hudAlertView) {
        [hudAlertView removeFromSuperview];
        hudAlertView = nil;
    }
}
+ (void)showWaitingAlertInWindowWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showWaitingAlertInWindowWithText 提示框显示:%@",text);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        if (hudAlertViewInWindow) {
            [hudAlertViewInWindow removeFromSuperview];
            hudAlertViewInWindow = nil;
        }
        hudAlertViewInWindow = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hudAlertViewInWindow.labelText = ((text && text.length > 0) ? text : @"请稍候");
    });
}
+ (BOOL)connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    if (defaultRouteReachability) {
        CFRelease(defaultRouteReachability);
    }
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}
+ (void)showWhoWin:(NSString *)winner num:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"showAlertWithText 提示框显示:%@",text);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = winner;
        hud.detailsLabelText = text;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:20.0];
        hud.margin = 10.f;
        hud.yOffset = 0;
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabelColor = [UIColor whiteColor];
        hud.minSize = CGSizeMake(215, 60);
        hud.userInteractionEnabled = NO;
        [hud hide:YES afterDelay:1.5];
    });
}
+ (void)performWaitingAlertInWindowDismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"performWaitingAlertInWindowDismiss");
        if (hudAlertViewInWindow) {
            [hudAlertViewInWindow removeFromSuperview];
            hudAlertViewInWindow = nil;
        }
    });
}
+(void) showWaitingAlertWithTextInOldAlert:(NSString *)text {
    NSLog(@"showWaitingAlertWithTextInOldAlert:%@",text);
    if (hudAlertView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            hudAlertView.labelText = ((text && text.length > 0) ? text : @"请稍候");
        });
    } else {
        [AlertUtil showWaitingAlertWithText:text];
    }
}
@end
