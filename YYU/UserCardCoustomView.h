#import <UIKit/UIKit.h>
@interface UserCardCoustomView : UIView
@property (nonatomic, strong) UIImageView *faceImageView;
@property (nonatomic, strong) UIImageView *bgImageView;
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;
- (void)removeBgPoker;
- (void)removeCard;
- (void)addCard:(NSString *)cardName;
@end
