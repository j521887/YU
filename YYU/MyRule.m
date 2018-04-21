#import "MyRule.h"
#import "UserMoney.h"
@interface MyRule()
@property (nonatomic, strong) OperateBlock  winBlock;
@property (nonatomic, strong) NSMutableArray *winners;
@end
@implementation MyRule
+ (instancetype)shareAction
{
    static MyRule *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MyRule alloc] init];
        instance.winners = [NSMutableArray array];
    });
    return instance;
}
- (void)dealloc
{
    NSLog(@"MyRule dealloc");
}
- (void)setCompletionBlock:(OperateBlock)block
{
    self.winBlock = block;
}
- (void)showResultOfBankerCards:(NSArray *)bankerCards playerCards:(NSArray *)playerCards users:(NSArray *)users isNeedPair:(BOOL)isNeedPair
{
    [self.winners removeAllObjects];
    if (!bankerCards || !playerCards) {
        return;
    }
    NSInteger playerTotalNum = [self totalNumOfArray:playerCards];
    NSInteger bankerTotalNum = [self totalNumOfArray:bankerCards];
    NSLog(@"totalNum, player: %ld --- banker: %ld", (long)playerTotalNum, (long)bankerTotalNum);
    NSInteger playerNum = playerTotalNum % 10;
    NSInteger bankerNum = bankerTotalNum % 10;
    if (isNeedPair) {
        BOOL bPair = [self hasPair:bankerCards];
        BOOL pPair = [self hasPair:playerCards];
        if (bPair) {
            [self.winners addObject:[NSNumber numberWithInteger:RedChoosePokerBankerPair]];
        }
        if (pPair) {
            [self.winners addObject:[NSNumber numberWithInteger:RedChoosePokerPlayerPair]];
        }
        [self caculateWinnerOfUsers:users playerNum:playerNum bankerNum:bankerNum];
    } else {
        [self caculateWinnerOfUsers:users playerNum:playerNum bankerNum:bankerNum];
    }
}
- (RedChoosePoker)winnerOfBanker:(NSInteger)bankerTotal player:(NSInteger)playerTotal
{
    NSInteger playerNum = playerTotal % 10;
    NSInteger bankerNum = bankerTotal % 10;
    NSLog(@"compareNum, player: %ld --- banker: %ld", (long)playerNum, (long)bankerNum);
    if (playerNum < bankerNum) {
        return RedChoosePokerBanker;
    } else if (playerNum > bankerNum) {
        return RedChoosePokerPlayer;
    } else {
        return RedChoosePokerTier;
    }
}
- (void)caculateWinnerOfUsers:(NSArray *)users playerNum:(long)playerNum bankerNum:(long)bankerNum
{
    NSLog(@"compareNum, player: %ld --- banker: %ld", (long)playerNum, (long)bankerNum);
    RedChoosePoker winner = RedChoosePokerNone;
    if (playerNum < bankerNum) {
        winner = RedChoosePokerBanker;
        [self.winners addObject:[NSNumber numberWithInteger:RedChoosePokerBanker]];
    } else if (playerNum > bankerNum) {
        winner = RedChoosePokerPlayer;
        [self.winners addObject:[NSNumber numberWithInteger:RedChoosePokerPlayer]];
    } else {
        winner = RedChoosePokerTier;
        [self.winners addObject:[NSNumber numberWithInteger:RedChoosePokerTier]];
    }
    for (UserMoney *user in users) {
        for (RoleMoney *roleMoney in user.roleMoneys) {
            roleMoney.isWin = roleMoney.role == winner;
        }
    }
    if (self.winBlock) {
        self.winBlock((int)playerNum, (int)bankerNum, self.winners);
    }
}
- (BOOL)bankerNeedToAddCard:(NSArray *)bankerCards playerCards:(NSArray *)playerCards pAddCard:(int)pAddCard
{
    if (!bankerCards || !playerCards) {
        return NO;
    }
    NSInteger playerTotalNum = [self totalNumOfArray:playerCards];
    NSInteger bankerTotalNum = [self totalNumOfArray:bankerCards];
    NSInteger playerNum = playerTotalNum % 10;
    NSInteger bankerNum = bankerTotalNum % 10;
    if (playerNum == 8 || playerNum == 9 || bankerNum == 8 || bankerNum == 9) {
        return NO;
    }
    if (bankerNum == 7) {
        return NO;
    }
    if (bankerNum <= 2) {
        return YES;
    }
    if (bankerNum == 3 && pAddCard == 8) {
        return NO;
    }
    if (bankerNum == 4 && (pAddCard == 0 || pAddCard == 1 || pAddCard == 8 || pAddCard == 9)) {
        return NO;
    }
    if (bankerNum == 5 && (pAddCard == 0 || pAddCard == 1 || pAddCard == 2 || pAddCard == 3 || pAddCard == 8 || pAddCard == 9)) {
        return NO;
    }
    if (bankerNum == 6 && (pAddCard == 6 || pAddCard == 7)) {
        return YES;
    }
    if (bankerNum == 7) {
        return NO;
    }
    return YES;
}
- (BOOL)hasPair:(NSArray *)array
{
    BOOL bPair = NO;
    for (int i=0; i<array.count-1; i++) {
        NSInteger iValue = [array[i] integerValue];
        for (int j=i+1; j<array.count; j++) {
            NSInteger jValue = [array[j] integerValue];
            if (iValue == jValue) {
                bPair = YES;
                break;
            }
        }
    }
    return bPair;
}
- (NSInteger)totalNumOfArray:(NSArray *)array
{
    NSInteger total = 0;
    for (int i=0; i<array.count; i++) {
        NSInteger iValue = [array[i] integerValue];
        if (iValue > 9) {
            iValue = 0;
        }
        total += iValue;
    }
    return total;
}
- (BOOL)playerNeedAddCards:(NSArray *)playerCards bankerCards:(NSArray *)bankerCards
{
    if (!bankerCards || !playerCards) {
        return NO;
    }
    NSInteger playerTotalNum = [self totalNumOfArray:playerCards];
    NSInteger bankerTotalNum = [self totalNumOfArray:bankerCards];
    NSInteger playerNum = playerTotalNum % 10;
    NSInteger bankerNum = bankerTotalNum % 10;
    if (playerNum == 8 || playerNum == 9 || bankerNum == 8 || bankerNum == 9) {
        return NO;
    }
    if (playerNum == 6 || playerNum == 7 ) {
        return NO;
    }
    return YES;
}
@end
