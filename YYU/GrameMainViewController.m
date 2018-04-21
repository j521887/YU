#import "GrameMainViewController.h"
#import "MyGameViewController.h"
#import "webViewController.h"
@interface GrameMainViewController ()
- (IBAction)PlayBtnClick:(id)sender;
@end
@implementation GrameMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)noticeBtnClick:(id)sender {
    webViewController *vc=[[webViewController alloc] initWithNibName:@"webViewController" bundle:nil];
    vc.str=@"1、这是一款休闲棋牌App，为了给玩家提供良好的娱乐环境，在App中使用的筹码都是娱乐的道具，没有任何属性功能，只能在我们的App中使用。我们禁止任何形式赌博的竞赛，否则我们会封禁他们。2、抵制不良App，拒绝盗版App。本App是没有利润，和私人交易请注意自我保护，谨防上当受骗。适度娱乐益脑，过度娱乐损害健康，请合理组织你的时间，享受您的健康生活。";
    vc.titles=@"使用说明";
    [self presentViewController:vc animated:YES completion:^{
    }];
}
- (void)boundingRectForCharacterRange:(NSRange)range{
    UILabel *lab=[[UILabel alloc] init];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[lab attributedText]];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[lab bounds].size];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    CGRect rect=[layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}
- (IBAction)ruleBtnClick:(id)sender {
    webViewController *vc=[[webViewController alloc] initWithNibName:@"webViewController" bundle:nil];
    vc.str=@"使用3到8副牌，每副52张牌，由庄家在牌盒中洗牌后分发，总共分发两手牌分别为2-3张，庄家一手，闲家一手。然后玩家进行下注，可选择闲、闲对、庄、庄对、和等下注，不同选项赔率不一样，其中和的赔率1：18、闲的赔率1:1、庄的赔率1:0.95、闲对的赔率1:11、庄对的赔率1:11。牌点数的计算，K、Q、J和10是0，其他牌根据卡片表面点数计算，总点数是9或接近9的一方赢。庄对即庄家有一对牌，闲对一样。玩家选择不同的赔率下注筹码后，最后会根据两手牌的实际情况给出输赢结果";
    vc.titles=@"使用规则";
    [self presentViewController:vc animated:YES completion:^{
    }];
}
- (IBAction)PlayBtnClick:(id)sender {
    MyGameViewController *vc=[[MyGameViewController alloc] initWithNibName:@"MyGameViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:^{
    }];
}
@end
