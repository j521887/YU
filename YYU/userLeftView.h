#import <UIKit/UIKit.h>
@interface userLeftView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *leftHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *leftNameLab;
@property (weak, nonatomic) IBOutlet UILabel *leftCounterLab;
- (instancetype)initWithFrame:(CGRect)frame;
@end
