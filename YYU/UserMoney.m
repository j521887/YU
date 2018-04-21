#import "UserMoney.h"
@implementation RoleMoney
- (double)getResultMoney
{
    double tempMoney = _money;
    if (_ratio != 0) {
        if (_isWin) {
            tempMoney += tempMoney * _ratio;
        } else {
            tempMoney -= tempMoney;
        }
    }
    return tempMoney;
}
- initWithRatio:(double)ratio money:(double)money role:(RedChoosePoker)role
{
    self = [super init];
    if (self) {
        self.ratio = ratio;
        self.money = money;
        self.role = role;
    }
    return self;
}
@end
@implementation UserMoney
- (double)totalMoney
{
    double sum = 0;
    for (int i=0; i<_roleMoneys.count; i++) {
        RoleMoney *roleMoney = _roleMoneys[i];
        sum += [roleMoney getResultMoney];
    }
    _totalMoney += sum;
    return _totalMoney;
}
- (id)initWithUserId:(NSString *)userId userName:(NSString *)userName
{
    self = [super init];
    if (self) {
        self.userId = userId;
        self.userName = userName;
    }
    return self;
}
- (double)winMoney
{
    double sum = 0;
    for (int i=0; i<_roleMoneys.count; i++) {
        RoleMoney *roleMoney = _roleMoneys[i];
        sum += [roleMoney getResultMoney];
    }
    return sum;
}
@end
