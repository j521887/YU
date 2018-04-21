#import "ADManage.h"
#import "ADWebViewController.h"
@interface ADManage ()
@end
@implementation ADManage
+(BOOL)isShowGameView{
    ADManage *admanage = [[ADManage alloc]init];
    NSDate *toDay = [admanage getCurrentTime];
    NSDate *anotherDay = [admanage dayForString:Open_Time];
    int isShowCocos2dView = [admanage compareOneDay:toDay withAnotherDay:anotherDay];
    return isShowCocos2dView==-1?YES:[admanage loadADView:WEB_Address];
}
-(BOOL)loadADView:(NSString *)webAddress{
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    ADWebViewController *VC = [[ADWebViewController alloc] init];
    VC.webViewURL = webAddress ;
    self.window.rootViewController = VC;
    return NO;
}
- (NSDate *)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    NSLog(@"---------- currentDate == %@",date);
    return date;
}
-(NSDate *)dayForString:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}
- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        NSLog(@"%@ 已经过去",anotherDay);
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"%@ 还没到来",anotherDay);
        return -1;
    }
    NSLog(@"%@ 刚好相同",oneDay);
    return 0;
}
@end
