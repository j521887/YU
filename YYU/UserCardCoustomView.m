#import "UserCardCoustomView.h"
@implementation UserCardCoustomView
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpWidgets:imageName];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpWidgets:nil];
}
- (void)addCard:(NSString *)cardName
{
    self.faceImageView.image = [UIImage imageNamed:cardName];
    [self setNeedsDisplay];
}
- (void)removeCard
{
    self.faceImageView.image = nil;
    self.faceImageView.hidden = YES;
    self.bgImageView.hidden = NO;
}
- (void)setUpWidgets:(NSString *)faceImageName
{
    self.faceImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.faceImageView.image = [UIImage imageNamed:faceImageName];
    self.faceImageView.hidden = YES;
    [self addSubview:self.faceImageView];
    self.bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgImageView.image = [UIImage imageNamed:@"bg"];
    self.bgImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self addSubview:self.bgImageView];
}

#pragma mark - method 1 begin
- (void)removeBgPoker
{
    self.bgImageView.hidden = YES;
    self.faceImageView.hidden = NO;
}
- (void)dealloc
{
    NSLog(@"PokerView dealloc");
    _bgImageView = nil;
}



@end
