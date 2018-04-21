#import <Foundation/Foundation.h>
@interface AlertUtil : NSObject
+(void) showAlertAboveView:(float) viewFrameY withText:(NSString *) text offsetY:(float) height;
+(void) showNoneNetWorkAlert;
+(void) showAlertWithText:(NSString *)text afterDelay:(NSTimeInterval) delay;
+ (void)showAlertWithText:(NSString *)text;
+ (void)performWaitingAlertDismiss;
+ (void)performWaitingAlertDismissInMainThread;
+ (void)showCheckmarkAlert:(NSString *)text FailOrNot:(BOOL)success;
+ (void)showWaitingAlertWithText:(NSString *)text;
+ (void)performWaitingAlertInWindowDismiss;
+ (BOOL)connectedToNetwork;
+ (void)showWaitingAlertInWindowWithText:(NSString *)text;
+ (void)showWhoWin:(NSString *)winner num:(NSString *)text;
+(void) showWaitingAlertWithTextInOldAlert:(NSString *)text;
+ (void)showAlertInWindowWithText:(NSString *)text;
@end
