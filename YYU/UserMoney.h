#import <Foundation/Foundation.h>
#import "MyRule.h"
@interface RoleMoney : NSObject
@property (nonatomic, assign) RedChoosePoker role;
@property (nonatomic, assign) double money;
@property (nonatomic, assign) double ratio;
@property (nonatomic, assign) BOOL isWin;
- initWithRatio:(double)ratio money:(double)money role:(RedChoosePoker)role;
- (double)getResultMoney;
@end
@interface UserMoney : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) double totalMoney;
@property (nonatomic, strong) NSArray *roleMoneys;
- initWithUserId:(NSString *)userId userName:(NSString *)userName;
- (double)winMoney;
@end
