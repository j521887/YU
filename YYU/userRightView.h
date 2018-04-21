#import <UIKit/UIKit.h>
@interface userRightView : UIView
@property (weak, nonatomic) IBOutlet UILabel *rightNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *rightHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *rightCouterLab;
- (instancetype)initWithFrame:(CGRect)frame;
@end
