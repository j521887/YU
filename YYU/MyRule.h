#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, RedChoosePoker) {    
    RedChoosePokerNone = 0,      
    RedChoosePokerPlayer = 1,    
    RedChoosePokerBanker = 2,    
    RedChoosePokerTier = 3,      
    RedChoosePokerPlayerPair = 4,    
    RedChoosePokerBankerPair = 5,    
};
typedef void (^OperateBlock) (int playerNum, int bankerNum, NSArray *winners);
@interface MyRule : NSObject
+ (instancetype)shareAction;
- (void)setCompletionBlock:(OperateBlock)block;
- (BOOL)playerNeedAddCards:(NSArray *)playerCards bankerCards:(NSArray *)bankerCards;
- (void)showResultOfBankerCards:(NSArray *)bankerCards playerCards:(NSArray *)playerCards users:(NSArray *)users isNeedPair:(BOOL)isNeedPair;
- (BOOL)bankerNeedToAddCard:(NSArray *)bankerCards playerCards:(NSArray *)playerCards pAddCard:(int)pAddCard;
@end
