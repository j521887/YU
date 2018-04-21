#import "MyGameViewController.h"
#import "ColorUtil.h"
#import "UserMoney.h"
#import "UserUtil.h"
#import "AudioUtils.h"
#import "userRightView.h"
#import "sys/utsname.h"
#import "MyRule.h"
#import "MyCardUtils.h"
#import "AlertUtil.h"
#import "UserCardCoustomView.h"
#import "NSString+Utils.h"
#import "userLeftView.h"

#define CardDuration      1.2
#define TierRatio         8.0
#define BankerPairRatio   0.92
#define PlayerRatio       1.0
#define PlayerPairRatio   0.88
#define BankerRatio       0.95

static CGFloat GoldWidth = 20;
static CGFloat GoleHeight = 20;
static float LeftTimes = 0.2;
typedef NS_ENUM(NSInteger, PageStatus) {
    PageStatusPrepare = 0,     
    PageStatusStartBet = 1,    
    PageStatusStopBet = 2,     
    PageStatusOpenCard = 3,    
    PageStatusShowResult = 4
};

@interface MyGameViewController ()<CAAnimationDelegate> {
    float ratioW;
    float ratioH;
}

@property (strong, nonatomic) UILabel *resultPNum;
@property (strong, nonatomic) UILabel *resultBNum;
@property (assign, nonatomic) BOOL needToAddCoin;
@property (strong, nonatomic) UserCardCoustomView *leftCard1;
@property (strong, nonatomic) UserCardCoustomView *leftCard2;
@property (strong, nonatomic) UserCardCoustomView *leftCard3;
@property (strong, nonatomic) UserCardCoustomView *rightCard1;
@property (strong, nonatomic) UserCardCoustomView *rightCard2;
@property (strong, nonatomic) UserCardCoustomView *rightCard3;
@property (strong, nonatomic) userLeftView  *leftTopUser;
@property (strong, nonatomic) userLeftView  *leftBottomUser;
@property (strong, nonatomic) userRightView *rightTopUser;
@property (strong, nonatomic) userRightView  *rightBottomUser;
@property (strong, nonatomic) UserMoney *currentUser;
@property (strong, nonatomic) NSMutableDictionary *users;
@property (strong, nonatomic) NSMutableDictionary *userRoleDic;
@property (strong, nonatomic) NSMutableDictionary *userChooseRoles;
@property (strong, nonatomic) NSMutableArray *goldBtns;
@property (strong, nonatomic) UIView *tipView;
@property (strong, nonatomic) NSArray *allRoles;
@property (strong, nonatomic) NSMutableArray *shiningLayers;
@property (strong, nonatomic) UILabel *playerLabel;
@property (strong, nonatomic) UILabel *playerPairLabel;
@property (assign, nonatomic) float costTime;
@property (assign, nonatomic) BOOL playerNeedAddCard;
@property (assign, nonatomic) BOOL bankerNeedAddCard;
@property (assign, nonatomic) double playMoney;
@property (strong, nonatomic) UIButton *tempSelectedGoldBtn;
@property (assign, nonatomic) RedChoosePoker choosePorB;
@property (strong, nonatomic) UIView *balanceView;
@property (strong, nonatomic) UILabel *tieLabel;
@property (strong, nonatomic) UILabel *bankerLabel;
@property (strong, nonatomic) UILabel *bankerPairLabel;
@property (nonatomic) NSMutableArray *goldPlayer;
@property (nonatomic) NSMutableArray *goldPlayerPair;
@property (nonatomic) NSMutableArray *goldTier;
@property (nonatomic) NSMutableArray *goldBanker;
@property (nonatomic) NSMutableArray *goldBankerPair;
@property (strong, nonatomic) UIImageView     *goldHightlight;
@property (nonatomic)NSDictionary *pokersDic;
@property (assign, nonatomic) NSInteger cardIndex;

@property (strong, nonatomic) IBOutlet UIView *getCoinView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *getCoinViewHint;
@property (weak, nonatomic) IBOutlet UIButton *musicBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCoinBtn;
@property (strong, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic)   IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UIButton *playerBtn;
@property (weak, nonatomic) IBOutlet UIButton *playerPairBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankerBtn;
@property (weak, nonatomic) IBOutlet UIButton *abovePlayerBtn;
@property (weak, nonatomic) IBOutlet UIButton *aboveBankerBtn;
@property (weak, nonatomic) IBOutlet UIButton *tieBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankerPairBtn;
@property (weak, nonatomic) IBOutlet UIButton *gold100;
@property (weak, nonatomic) IBOutlet UIButton *gold1000;
@property (weak, nonatomic) IBOutlet UIButton *gold10000;
@property (weak, nonatomic) IBOutlet UIButton *gold100000;
@property (weak, nonatomic) IBOutlet UIButton *gold1000000;
- (IBAction)playStartBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goldBottom;
@property (weak, nonatomic) IBOutlet UILabel *counterlab;
@property (strong, nonatomic) IBOutlet UIView     *cardView;
@property (weak, nonatomic) IBOutlet UIView *clockView;
@property (strong, nonatomic) IBOutlet UIView *aboutGameView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *aboutViewBgImage;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tierBtnBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tierBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankerPairHeight;

@end
@implementation MyGameViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    float orightW = 667;
    float orightH = 375;
    ratioW = ScreenWidth / orightW;
    ratioH = ScreenHeight / orightH;
    [self OpenOrCloseMusice];
    [self InitPlayUsers];
    [self CreatResultView];
    [self CreatCoinView];
    [AudioUtils play:@"welcome"];
    [self CreatBetBtn:YES];
    [self CreatPlayMessge];
}


- (void)CreatCoinView
{
    self.getCoinView.frame = CGRectMake((ScreenWidth - 500) * 0.5, (ScreenHeight - 352) * 0.5, 500, 352);
}
- (void)CreatResultView
{
    self.resultView.frame = CGRectMake(ScreenWidth/2-135, ScreenHeight/2-80, 275, 156);
    self.resultView.hidden = YES;
    [self.view addSubview:self.resultView];
    self.resultPNum = [[UILabel alloc] initWithFrame:CGRectMake(179 * ratioW, 100 * ratioH, 42, 30)];
    self.resultPNum.textColor = [ColorUtil hexStringToColor:@"#F4E628"];
    self.resultPNum.font = [UIFont boldSystemFontOfSize:30.0];
    self.resultPNum.textAlignment = NSTextAlignmentCenter;
    self.resultBNum = [[UILabel alloc] initWithFrame:CGRectMake(516 * ratioW, 100 * ratioH, 42, 30)];
    self.resultBNum.textColor = [ColorUtil hexStringToColor:@"#F4E628"];
    self.resultBNum.font = [UIFont boldSystemFontOfSize:30.0];
    self.resultBNum.textAlignment = NSTextAlignmentCenter;
}


- (void)CreatPlayMoney:(UserMoney *)user
{
    if ([user.userId isEqualToString:@"Hujun"]) {
        _leftTopUser.leftCounterLab.text = [self formatMoney:user.totalMoney];
    } else if ([user.userId isEqualToString:@"Jicky"]) {
        _leftBottomUser.leftCounterLab.text = [self formatMoney:user.totalMoney];
    }else if ([user.userId isEqualToString:@"Mini"]) {
        _rightTopUser.rightCouterLab.text = [self formatMoney:user.totalMoney];
    }else {
        _rightBottomUser.rightCouterLab.text = [self formatMoney:user.totalMoney];
    }
}

- (void)CreatPlayMessge
{
    self.cardIndex = 0;
    self.goldPlayer     = [[NSMutableArray alloc] init];
    self.goldBanker     = [[NSMutableArray alloc] init];
    self.goldBankerPair = [[NSMutableArray alloc] init];
    self.goldPlayerPair = [[NSMutableArray alloc] init];
    self.goldTier       = [[NSMutableArray alloc] init];
    self.allRoles = @[@(RedChoosePokerBanker), @(RedChoosePokerPlayer), @(RedChoosePokerTier), @(RedChoosePokerBankerPair), @(RedChoosePokerPlayerPair)];
    self.shiningLayers = [[NSMutableArray alloc] init];
    self.pokersDic = [MyCardUtils getPokerDic];
    WEAKSELF
    [[MyRule shareAction] setCompletionBlock:^(int playerNum, int bankerNum, NSArray *winners) {
        [weakSelf handlePlayerNum:playerNum bankerNum:bankerNum winners:winners];
    }];
    self.goldBtns = [NSMutableArray array];
    [self.goldBtns addObject:self.gold100];
    [self.goldBtns addObject:self.gold1000];
    [self.goldBtns addObject:self.gold10000];
    [self.goldBtns addObject:self.gold100000];
    [self.goldBtns addObject:self.gold1000000];
    self.costTime = 0.0;
    if(iPhone5){
        self.gold100000.frame=CGRectMake(self.gold100000.frame.origin.x, self.gold100000.frame.origin.y+20, 40, 40);
        self.gold1000000.frame=CGRectMake(self.gold1000000.frame.origin.x, self.gold1000000.frame.origin.y+20, 40, 40);
        self.gold100.frame=CGRectMake(self.gold100.frame.origin.x, self.gold100.frame.origin.y+20, 40, 40);
        self.gold1000.frame=CGRectMake(self.gold1000.frame.origin.x, self.gold1000.frame.origin.y+20, 40, 40);
        self.gold10000.frame=CGRectMake(self.gold10000.frame.origin.x, self.gold10000.frame.origin.y+20, 40, 40);
        self.playerBtn.frame=CGRectMake(self.playerBtn.frame.origin.x-8, self.playerBtn.frame.origin.y-20, 95, 77);
        self.bankerBtn.frame=CGRectMake(self.bankerBtn.frame.origin.x+5, self.bankerBtn.frame.origin.y-20, 95, 77);
        self.bankerPairBtn.frame=CGRectMake(self.bankerPairBtn.frame.origin.x+5, self.bankerPairBtn.frame.origin.y-20, 95, 77);
        self.tieBtn.frame=CGRectMake(self.tieBtn.frame.origin.x+10, self.tieBtn.frame.origin.y, 200, 107);
        self.aboveBankerBtn.frame=CGRectMake(self.aboveBankerBtn.frame.origin.x+5, self.aboveBankerBtn.frame.origin.y, 95, 107);
        self.abovePlayerBtn.frame=CGRectMake(self.abovePlayerBtn.frame.origin.x-5, self.abovePlayerBtn.frame.origin.y, 95, 107);
        self.playerPairBtn.frame=CGRectMake(self.playerPairBtn.frame.origin.x, self.playerPairBtn.frame.origin.y-20, 95, 77);
    }
}


- (void)InitPlayUsers
{
    self.users = [NSMutableDictionary dictionary];
    self.userRoleDic = [NSMutableDictionary dictionary];
    self.userChooseRoles = [NSMutableDictionary dictionary];
    CGFloat crenW=430;
    if(iPhone6P){
        crenW=430;
    }else if(iPhone6){
        crenW=475;
    }else if (iPhoneX){
        crenW=812;
    }else if(iPhone5){
        crenW=560;
    }
    UserMoney *vicky = [[UserMoney alloc] initWithUserId:@"Vicky" userName:@"Vicky"];
    vicky.totalMoney = 80000.00;
    [self.users setObject:vicky forKey:vicky.userId];
    _rightBottomUser=[[NSBundle mainBundle] loadNibNamed:@"userRightView" owner:self options:nil][0];
    _rightBottomUser.frame=CGRectMake(crenW* ratioW, 170 * ratioH, 124, 79);
    _rightBottomUser.rightNameLab.text=@"多伦";
    _rightBottomUser.rightHeadImg.image=[UIImage imageNamed:@"head4"];
    _rightBottomUser.rightCouterLab.text=[self formatMoney:vicky.totalMoney];
    [self.view addSubview:_rightBottomUser];
    UserMoney *bean = [[UserMoney alloc] initWithUserId:@"Hujun" userName:@"Hujun"];
    bean.totalMoney = 80000.00;
    [self.users setObject:bean forKey:bean.userId];
    _leftTopUser=[[NSBundle mainBundle] loadNibNamed:@"userLeftView" owner:self options:nil][0];
    _leftTopUser.frame=CGRectMake(1 * ratioW, 70 * ratioH, 124, 79);
    _leftTopUser.leftNameLab.text=@"老杨";
    _leftTopUser.leftHeadImg.image=[UIImage imageNamed:@"head1"];
    _leftTopUser.leftCounterLab.text=[self formatMoney:bean.totalMoney];
    [self.view addSubview:self.leftTopUser];
    UserMoney *mini = [[UserMoney alloc] initWithUserId:@"Mini" userName:@"Mini"];
    mini.totalMoney = 80000.00;
    [self.users setObject:mini forKey:mini.userId];
    _rightTopUser=[[NSBundle mainBundle] loadNibNamed:@"userRightView" owner:self options:nil][0];
    _rightTopUser.frame=CGRectMake(crenW* ratioW, 70 * ratioH, 124, 79);
    _rightTopUser.rightNameLab.text=@"帕克";
    _rightTopUser.rightHeadImg.image=[UIImage imageNamed:@"head3"];
    _rightTopUser.rightCouterLab.text=[self formatMoney:mini.totalMoney];
    [self.view addSubview:_rightTopUser];
    UserMoney *jicky = [[UserMoney alloc] initWithUserId:@"Jicky" userName:@"Jicky"];
    jicky.totalMoney = 80000.00;
    self.currentUser = jicky;
    [self.users setObject:jicky forKey:jicky.userId];
    _leftBottomUser=[[NSBundle mainBundle] loadNibNamed:@"userLeftView" owner:self options:nil][0];
    _leftBottomUser.frame=CGRectMake(1 * ratioW, 170 * ratioH, 124, 79);
    _leftBottomUser.leftNameLab.text=@"玩家";
    _leftBottomUser.leftHeadImg.image=[UIImage imageNamed:@"head2"];
    _leftBottomUser.leftCounterLab.text=[self formatMoney:jicky.totalMoney];
    [self.view addSubview:_leftBottomUser];
}
- (void)OpenOrCloseMusice
{
    if ([AudioUtils allowPlayEffect]) {
        [self.musicBtn setImage:[UIImage imageNamed:@"musiceOpen"] forState:UIControlStateNormal];
    } else {
        [self.musicBtn setImage:[UIImage imageNamed:@"musice"] forState:UIControlStateNormal];
    }
}

-(void)titleFiledserea
{
}
-(void)titleLabel
{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    titleLabel.center = CGPointMake(self.view.frame.size.width /2, 40);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @" ";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor clearColor];
    [self.view addSubview:titleLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)saveBtn
{
    UIButton * saveBn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveBn  setFrame:CGRectMake(self.view.frame.size.width - 65 , 30, 60, 30)];
    [saveBn setTitle:@"Save" forState:UIControlStateNormal];
    saveBn.tintColor = [UIColor whiteColor];
    saveBn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [saveBn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBn];
}
+(NSString *)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceModel isEqualToString:@"iPhone1,1"]) return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"]) return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([deviceModel isEqualToString:@"iPhone9,1"] || [deviceModel isEqualToString:@"iPhone9,3"])
        return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"] || [deviceModel isEqualToString:@"iPhone9,4"])
        return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([deviceModel isEqualToString:@"iPod7,1"]) return @"iPod Touch 6";
    if ([deviceModel isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"]) return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"]) return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"]) return @"iPad mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"]) return @"iPad mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"]) return @"iPad mini (CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"]) return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"]) return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"]) return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"]) return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"]) return @"iPad 4 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"i386"]) return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"]) return @"Simulator";
    if ([deviceModel isEqualToString:@"iPad4,4"]
        ||[deviceModel isEqualToString:@"iPad4,5"]
        ||[deviceModel isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"]
        ||[deviceModel isEqualToString:@"iPad4,8"]
        ||[deviceModel isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"]
        ||[deviceModel isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    if ([deviceModel isEqualToString:@"iPad6,3"]
        ||[deviceModel isEqualToString:@"iPad6,4"]
        ||[deviceModel isEqualToString:@"iPad6,7"]
        ||[deviceModel isEqualToString:@"iPad6,8"]) return @"iPad Pro";
    return deviceModel;
}

- (void)CreatBetBtn:(BOOL)isOk
{
    self.playerBtn.enabled = isOk;
    self.bankerBtn.enabled = isOk;
    self.playerPairBtn.enabled = isOk;
    self.bankerPairBtn.enabled = isOk;
    self.tieBtn.enabled = isOk;
}
- (void)hideTipView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.tipView.hidden = YES;
    }];
}
#pragma mark - 按钮事件
- (IBAction)backBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)getCoinClick:(id)sender {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy_MM_dd";
    NSString *dayStr = [formatter stringFromDate:date];
    [AudioUtils play:@"sound_jinbi"];
    NSString *key = [NSString stringWithFormat:@"%@_%@", dayStr, HaveGetCoin];
    self.needToAddCoin = YES;
    self.getCoinViewHint.text = @"恭喜您获得 20000 筹码";
    [UserDefaults setBool:YES forKey:key];
    [UserDefaults synchronize];
    double total = ((UserMoney *)self.users[@"Jicky"]).totalMoney;
    total += 20000;
    ((UserMoney *)self.users[@"Jicky"]).totalMoney = total;
    self.leftBottomUser.leftCounterLab.text = [self formatMoney:total];
    CGRect finalFrame = self.getCoinView.frame;
    self.getCoinView.frame = CGRectMake(finalFrame.origin.x, ScreenHeight, 554 * 0.2, 352 * 0.2);
    [self.view addSubview:self.getCoinView];
    [UIView animateWithDuration:0.4 animations:^{
        self.getCoinView.frame = finalFrame;
    }];
}
- (IBAction)closeCoinView:(id)sender {
    [self.getCoinView removeFromSuperview];
}
- (IBAction)tieBtnClick:(UIButton *)sender
{
    self.choosePorB = RedChoosePokerTier;
    [self whichGoldClick];
}
- (IBAction)playerPairBtnClick:(UIButton *)sender
{
    self.choosePorB = RedChoosePokerPlayerPair;
    [self whichGoldClick];
}
- (IBAction)playerBtnClick:(UIButton *)sender
{
    self.choosePorB = RedChoosePokerPlayer;
    [self whichGoldClick];
}
- (IBAction)goldClick:(UIButton *)sender
{
    [AudioUtils play:@"squeeze_open"];
    NSInteger tag = sender.tag;
    self.tempSelectedGoldBtn = sender;
    [self hightlightButton:sender];
    [self displayGold:sender forUser:self.currentUser forRole:self.choosePorB];
}

- (IBAction)bankerPairBtnClick:(UIButton *)sender
{
    self.choosePorB = RedChoosePokerBankerPair;
    [self whichGoldClick];
}

- (IBAction)bankerBtnClick:(UIButton *)sender
{
    self.choosePorB = RedChoosePokerBanker;
    [self whichGoldClick];
}
- (IBAction)playStartBtnClick:(id)sender {
    if(self.playMoney==0){
        [AudioUtils play:@"place_bet"];
        return;
    }
    [self CreatPlayGo];
    UserMoney *Hujun=self.users[@"Hujun"];
    UserMoney *Mini=self.users[@"Mini"];
    UserMoney *Vicky=self.users[@"Vicky"];
    if(Hujun.totalMoney>=1000){
        [self autoBetForUser:self.users[@"Hujun"]];
    }
    if(Mini.totalMoney>=1000){
        [self autoBetForUser:self.users[@"Mini"]];
    }
    if(Vicky.totalMoney>=1000){
        [self autoBetForUser:self.users[@"Vicky"]];
    }
}

- (IBAction)closeEffect:(id)sender {
    WEAKSELF
    [AudioUtils closeEffectWithCompleteBlock:^(BOOL isAllow) {
        if (isAllow) {
            [weakSelf.musicBtn setImage:[UIImage imageNamed:@"musiceOpen"] forState:UIControlStateNormal];
        } else {
            [weakSelf.musicBtn setImage:[UIImage imageNamed:@"musice"] forState:UIControlStateNormal];
        }
    }];
}

- (void)CreatPlayGo
{
    WEAKSELF
    NSArray *arr = [MyCardUtils getRandomPokerArrayOfCount:6];
    NSArray *bOldCards = @[_pokersDic[arr[2]], _pokersDic[arr[3]]];
    NSArray *pOldCards = @[_pokersDic[arr[0]], _pokersDic[arr[1]]];
    NSMutableArray *bankerArray =  [NSMutableArray arrayWithArray:bOldCards];
    NSMutableArray *playerArray = [NSMutableArray arrayWithArray:pOldCards];
    [self CreatUserCard];
    [self.leftCard1 addCard:arr[0]];
    [self.leftCard2 addCard:arr[1]];
    [self.rightCard1 addCard:arr[2]];
    [self.rightCard2 addCard:arr[3]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf flipCards];
    });
    self.playerNeedAddCard = [[MyRule shareAction] playerNeedAddCards:pOldCards bankerCards:bOldCards];
    int pAddCard = [_pokersDic[arr[4]] intValue];
    self.bankerNeedAddCard = [[MyRule shareAction] bankerNeedToAddCard:bOldCards playerCards:pOldCards pAddCard:pAddCard];
    if (self.playerNeedAddCard || self.bankerNeedAddCard) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.playerNeedAddCard) {
                NSLog(@"Player Need To AddCard : yes, add card: %@", arr[4]);
                [weakSelf playerNeedAddCard:arr[4]];
                [playerArray addObject:weakSelf.pokersDic[arr[4]]];
            }
            if (weakSelf.bankerNeedAddCard) {
                NSLog(@"Banker Need To AddCard : yes, add card: %@", arr[5]);
                [weakSelf bankerNeedAddCard:arr[5]];
                [bankerArray addObject:weakSelf.pokersDic[arr[5]]];
            }
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [weakSelf PlanBetBalance];
                [[MyRule shareAction] showResultOfBankerCards:bankerArray playerCards:playerArray users:[weakSelf.users allValues] isNeedPair:YES];
            });
        });
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [weakSelf PlanBetBalance];
            [[MyRule shareAction] showResultOfBankerCards:bankerArray playerCards:playerArray users:[weakSelf.users allValues] isNeedPair:YES];
        });
    }
}


#pragma mark - buttons click events
- (void)hightlightButton:(UIButton *)gold
{
    if (gold) {
        [self.goldHightlight removeFromSuperview];
        self.goldHightlight.center = gold.center;
        [self.view insertSubview:self.goldHightlight belowSubview:gold];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0];
        animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
        animation.duration = 0.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.repeatCount = ULONG_MAX;
        [self.goldHightlight.layer addAnimation:animation forKey:@"hightlightGold"];
    }
}

- (void)CreatBegainPay
{
    [self CreatBetBtn:YES];
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.needToAddCoin) {
            double total = ((UserMoney *)weakSelf.users[@"Jicky"]).totalMoney;
            total += 5000;
            ((UserMoney *)weakSelf.users[@"Jicky"]).totalMoney = total;
            weakSelf.leftBottomUser.leftCounterLab.text = [weakSelf formatMoney:total];
            weakSelf.needToAddCoin = NO;
        }
    });
}

- (void)autoBetForUser:(UserMoney *)user
{
    RedChoosePoker userChoosePoker = [self getRandomNumber:1 to:5];
    int random = [self getRandomNumber:0 to:1500];
    int num1000 = random / 1000;
    int num100 = (random - num1000 * 1000)/100;
    int num10 = (random - num1000 * 1000 - num100 * 100)/10;
    if (num1000 > 0) {
        [self displayGold:self.gold1000 forUser:user forRole:userChoosePoker];
    }
    if (num100 > 0) {
        for (int i=0; i<num100; i++) {
            [self displayGold:self.gold100 forUser:user forRole:userChoosePoker];
        }
    }
    if (num10 > 0) {
        for (int j=0; j<num10; j++) {
            [self displayGold:self.gold100 forUser:user forRole:userChoosePoker];
        }
    }
}
- (void)whichGoldClick
{
    if (self.tempSelectedGoldBtn) {
        [self goldClick:self.tempSelectedGoldBtn];
    }
}
- (void)showTip:(NSString *)tip
{
    UILabel *label;
    if (!self.tipView) {
        self.tipView = [[UIView alloc] initWithFrame:CGRectMake(20, (ScreenHeight - 60) * 0.5, ScreenWidth - 40, 60)];
        [self.tipView.layer addSublayer:[ColorUtil operationGradientLayer:CGSizeMake(ScreenWidth - 40, 60)]];
        label = [[UILabel alloc] initWithFrame:self.tipView.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.tag = 200;
        label.textAlignment = NSTextAlignmentCenter;
        [self.tipView addSubview:label];
        [self.view addSubview:self.tipView];
    } else {
        label = [self.tipView viewWithTag:200];
    }
    label.text = tip;
    self.tipView.hidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.tipView.hidden = NO;
    }];
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hideTipView];
    });
}

#pragma mark - gold click events
- (void)displayGold:(UIButton *)sender forUser:(UserMoney *)user forRole:(RedChoosePoker)role
{
    if (user.totalMoney - sender.tag < 0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"对不起你没有足够的筹码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alert.delegate=self;
        [alert show];
    }else{
        CGRect frame = CGRectZero;
        if ([user.userId isEqualToString:@"Hujun"]) {
            frame = CGRectMake(46, 91, 0, 0);
        } else if ([user.userId isEqualToString:@"Mini"]) {
            frame = CGRectMake(639, 100, 0, 0);
        } else if ([user.userId isEqualToString:@"Vicky"]) {
            frame = CGRectMake(639, 271, 0, 0);
        } else {
            frame = sender.frame;
        }
        NSString  *imgUrl;
        NSInteger counterCount=1000;
        switch (sender.tag) {
            case 1:
                imgUrl=@"counter1";
                counterCount=1000;
                break;
            case 2:
                imgUrl=@"counter5";
                counterCount=5000;
                break;
            case 3:
                imgUrl=@"counter10";
                counterCount=10000;
                break;
            case 4:
                imgUrl=@"counter50";
                counterCount=50000;
                break;
            case 5:
                imgUrl=@"counter100";
                counterCount=100000;
                break;
            default:
                break;
        }
        UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:frame];
        NewGoldImg.image = [UIImage imageNamed:imgUrl];
        NewGoldImg.tag = counterCount;
        [self.view addSubview:NewGoldImg];
        [self addGoldToArray:NewGoldImg forRole:role];
        [self setPlaceForGold:NewGoldImg forUser:user forRole:role];
    }
}
- (void)setPlaceForGold:(UIImageView *)goldImage forUser:(UserMoney *)user forRole:(RedChoosePoker)role
{
    if (!goldImage || !user) {
        return;
    }
    if(goldImage.tag>user.totalMoney){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"sorry your have no enough Counter" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alert.delegate=self;
        [alert show];
        return;
    }
    float tempRatio = 1.0;
    if (role == RedChoosePokerPlayer) {
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.playerBtn.frame;
            goldImage.frame = [self getFrameOfGold:frame];
        }];
        float oldMoney = [self.playerLabel.text floatValue];
        float totalMoney = oldMoney + goldImage.tag;
        self.playerLabel.text = [NSString stringWithFormat:@"%0.2f", totalMoney];
        tempRatio = PlayerRatio;
    }else if(role == RedChoosePokerBanker){
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.bankerBtn.frame;
            goldImage.frame = [self getFrameOfGold:frame];
        }];
        float oldMoney = [self.bankerLabel.text floatValue];
        float totalMoney = oldMoney + goldImage.tag;
        self.bankerLabel.text = [NSString stringWithFormat:@"%0.2f", totalMoney];
        tempRatio = BankerRatio;
    } else if (role == RedChoosePokerTier) {
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.tieBtn.frame;
            goldImage.frame = [self getFrameOfGold:frame];
        }];
        float oldMoney = [self.tieLabel.text floatValue];
        float totalMoney = oldMoney + goldImage.tag;
        self.tieLabel.text = [NSString stringWithFormat:@"%0.2f", totalMoney];
        tempRatio = TierRatio;
    } else if (role == RedChoosePokerPlayerPair) {
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.playerPairBtn.frame;
            goldImage.frame = [self getFrameOfGold:frame];
        }];
        float oldMoney = [self.playerPairLabel.text floatValue];
        float totalMoney = oldMoney + goldImage.tag;
        self.playerPairLabel.text = [NSString stringWithFormat:@"%0.2f", totalMoney];
        tempRatio = PlayerPairRatio;
    } else if (role == RedChoosePokerBankerPair) {
        [UIView animateWithDuration:LeftTimes animations:^{
            CGRect frame = self.bankerPairBtn.frame;
            goldImage.frame = [self getFrameOfGold:frame];
        }];
        float oldMoney = [self.bankerPairLabel.text floatValue];
        float totalMoney = oldMoney + goldImage.tag;
        self.bankerPairLabel.text = [NSString stringWithFormat:@"%0.2f", totalMoney];
        tempRatio = BankerPairRatio;
    } else {
        return;
    }
    [self resetUser:user money:goldImage.tag ratio:tempRatio role:role];
    [self reDisplayUser:user playMoney:goldImage.tag];
}


- (void)addGoldToArray:(UIImageView *)sender forRole:(RedChoosePoker)role
{
    switch (role) {
        case RedChoosePokerPlayer:
            [self.goldPlayer addObject:sender];
            break;
        case RedChoosePokerPlayerPair: {
            [self.goldPlayerPair addObject:sender];
            break;
        }
        case RedChoosePokerTier: {
            [self.goldTier addObject:sender];
            break;
        }
        case RedChoosePokerBanker:
        {
            [self.goldBanker addObject:sender];
            break;
        }
        case RedChoosePokerBankerPair: {
            [self.goldBankerPair addObject:sender];
            break;
        }
        default:
            break;
    }
}


- (void)reDisplayUser:(UserMoney*)user playMoney:(double)playMoney
{
    double money = user.totalMoney;
    money -= playMoney;
    user.totalMoney = money;
    if ([user.userId isEqualToString:@"Hujun"]) {
        self.leftTopUser.leftCounterLab.text = [self formatMoney:user.totalMoney];
    } else if ([user.userId isEqualToString:@"Mini"]) {
        self.rightTopUser.rightCouterLab.text = [self formatMoney:user.totalMoney];
    } else if ([user.userId isEqualToString:@"Jicky"]) {
        self.playMoney += playMoney;
        self.leftBottomUser.leftCounterLab.text = [self formatMoney:user.totalMoney];
    } else {
        self.rightBottomUser.rightCouterLab.text = [self formatMoney:user.totalMoney];
    }
}
#pragma mark - play game
- (void)resetUser:(UserMoney *)user money:(double)money ratio:(double)ratio role:(RedChoosePoker)role
{
    NSMutableDictionary *mutableDic = [self.userRoleDic objectForKey:user.userId];
    if (!mutableDic) {
        mutableDic = [NSMutableDictionary dictionary];
        [self.userRoleDic setObject:mutableDic forKey:user.userId];
    }
    RoleMoney *roleMoney = [mutableDic objectForKey:@(role)];
    if (!roleMoney) {
        roleMoney = [[RoleMoney alloc] initWithRatio:ratio money:money role:role];
        [mutableDic setObject:roleMoney forKey:@(role)];
    } else {
        roleMoney.money += money;
    }
}

- (void)bankerNeedAddCard:(NSString *)bCard
{
    self.rightCard3 = [[UserCardCoustomView alloc] initWithFrame:CGRectMake((ScreenWidth - 36)*0.5, 0, 36, 48) imageName:nil];
    self.rightCard3.tag = 2005;
    [self.rightCard3 addCard:bCard];
    [self.view addSubview:self.rightCard3];
    [UIView animateWithDuration:0.3 animations:^{
        NSInteger rightY=480;
        if(iPhone5){
            rightY=480;
        }else if (iPhone6){
            rightY=500;
        }
        self.rightCard3.frame = CGRectMake(rightY * ratioW, 80 * ratioH, 36, 48);
    }];
    float time = self.playerNeedAddCard ? 1.7 : 0.5;
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UserCardCoustomView *pokerView = [weakSelf.view viewWithTag:2005];
        [UIView transitionWithView:pokerView duration:CardDuration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [pokerView removeBgPoker];
        } completion:^(BOOL finished) {
        }];
    });
}
- (NSString *)formatMoney:(double)money
{
    NSString *string = nil;
    if (money >= 100000) {
        string = [NSString stringWithFormat:@"%.2fk", money/10000];
    } else {
        string = [NSString stringWithFormat:@"%.2f", money];
    }
    return string;
}


- (void)resetWigets
{
    self.choosePorB = RedChoosePokerNone;
    [self.resultBNum removeFromSuperview];
    [self.resultPNum removeFromSuperview];
    [self.leftCard1 removeFromSuperview];
    [self.leftCard2 removeFromSuperview];
    [self.leftCard3 removeFromSuperview];
    [self.rightCard1 removeFromSuperview];
    [self.rightCard2 removeFromSuperview];
    [self.rightCard3 removeFromSuperview];
    self.cardIndex = 0;
    self.costTime = 0.0;
    self.playMoney = 0.0;
    [self.userRoleDic removeAllObjects];
    for (UserMoney *user in [self.users allValues]) {
        user.roleMoneys = nil;
    }
    for (CALayer *layer in self.shiningLayers) {
        [layer removeFromSuperlayer];
    }
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf CreatBegainPay];
    });
}


- (void)CreatUserCard
{
    self.rightCard1 = [[UserCardCoustomView alloc] initWithFrame:CGRectMake((ScreenWidth - 36)*0.5, 18, 36, 48) imageName:nil];
    self.rightCard1.tag = 2002;
    [self.view addSubview:self.rightCard1];
    self.rightCard2 = [[UserCardCoustomView alloc] initWithFrame:CGRectMake((ScreenWidth - 36)*0.5, 18, 36, 48) imageName:nil];
    self.rightCard2.tag = 2003;
    [self.view addSubview:self.rightCard2];
    self.leftCard1 = [[UserCardCoustomView alloc] initWithFrame:CGRectMake((ScreenWidth - 60)*0.5, 18, 36, 48) imageName:nil];
    self.leftCard1.tag = 2000;
    [self.view addSubview:self.leftCard1];
    self.leftCard2 = [[UserCardCoustomView alloc] initWithFrame:CGRectMake((ScreenWidth - 60)*0.5, 18, 36, 48) imageName:nil];
    self.leftCard2.tag = 2001;
    [self.view addSubview:self.leftCard2];
    [UIView animateWithDuration:0.3 animations:^{
        NSInteger rightY1=460;
        NSInteger rightY2=500;
        NSInteger leftY1=118;
        NSInteger leftY2=158;
        if(iPhone5){
            rightY1=450;
            rightY2=490;
            leftY1=110;
            leftY2=153;
        }else if (iPhone6){
            rightY1=460;
            rightY2=500;
            leftY1=120;
            leftY2=163;
        }
        self.leftCard1.frame = CGRectMake(leftY1 * ratioW, 25 * ratioH, 36, 48);
        self.leftCard2.frame = CGRectMake(leftY2* ratioW, 25 * ratioH, 36, 48);
        self.rightCard1.frame = CGRectMake(rightY1 * ratioW, 25 * ratioH, 36, 48);
        self.rightCard2.frame = CGRectMake(rightY2 * ratioW, 25 * ratioH, 36, 48);
    }];
}
- (void)playerNeedAddCard:(NSString *)pCard
{
    self.leftCard3 = [[UserCardCoustomView alloc] initWithFrame:CGRectMake((ScreenWidth - 36)*0.5, 0, 36, 48) imageName:nil];
    self.leftCard3.tag = 2004;
    [self.leftCard3 addCard:pCard];
    [self.view addSubview:self.leftCard3];
    [UIView animateWithDuration:0.3 animations:^{
        NSInteger leftY=135;
        if(iPhone5){
            leftY=135;
        }else if (iPhone6){
            leftY=145;
        }
        self.leftCard3.frame = CGRectMake(leftY * ratioW, 80 * ratioH, 36, 48);
    }];
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UserCardCoustomView *pokerView = [weakSelf.view viewWithTag:2004];
        [UIView transitionWithView:pokerView duration:CardDuration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [pokerView removeBgPoker];
        } completion:^(BOOL finished) {
        }];
    });
}
- (void)flipCards
{
    WEAKSELF
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger index = 2000 + weakSelf.cardIndex;
        UserCardCoustomView *pokerView = [weakSelf.view viewWithTag:index];
        [UIView transitionWithView:pokerView duration:CardDuration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [pokerView removeBgPoker];
        } completion:^(BOOL finish){
            self.cardIndex++;
            if (self.cardIndex < 4) {
                [self flipCards];
            }
        }];
    });
}
- (void)flyResultPNum:(int)playerNum bNum:(int)bankerNum{
    self.resultPNum.frame = CGRectMake(179 * ratioW, 100 * ratioH, 42, 30);
    self.resultBNum.frame = CGRectMake(516 * ratioW, 100 * ratioH, 42, 30);
    self.resultPNum.text = [NSString stringWithFormat:@"%d", playerNum];
    self.resultBNum.text = [NSString stringWithFormat:@"%d", bankerNum];
    [self.view addSubview:self.resultPNum];
    [self.view addSubview:self.resultBNum];
    [UIView beginAnimations:@"resultNum" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.resultPNum.frame = CGRectMake(179 * ratioW, 70 * ratioH, 42, 30);
    self.resultBNum.frame = CGRectMake(516 * ratioW, 70 * ratioH, 42, 30);
    [UIView commitAnimations];
}
- (void)PlanBetBalance{
    WEAKSELF
    [self.userRoleDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = (NSMutableDictionary *)obj;
        UserMoney *user = weakSelf.users[key];
        user.roleMoneys = [dic allValues];
    }];
}
- (void)handlePlayerNum:(int)playerNum bankerNum:(int)bankerNum winners:(NSArray *)winners
{
    float time = 0;
    if (self.playerNeedAddCard || self.bankerNeedAddCard) {
        time = 7;
    } else {
        time = 5;
    }
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf flyResultPNum:playerNum bNum:bankerNum];
        [weakSelf broadcastWinner:winners];
        [weakSelf hightlightWinners:winners];
        [weakSelf showResultOfWinner:winners];
        [weakSelf.users enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            UserMoney *user = (UserMoney *)obj;
            [weakSelf CreatPlayMoney:user];
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf resetWigets];
            weakSelf.resultView.hidden = YES;
            [weakSelf handleGoldOfWinners:winners];
        });
    });
}
#pragma mark - gold remove and recycle
- (void)removeLoseGold:(NSSet *)losers
{
    for (NSNumber *loser in losers) {
        switch ([loser integerValue]) {
            case RedChoosePokerBanker:
                [self removeGoldFromArray:self.goldBanker];
                break;
            case RedChoosePokerPlayer:
                [self removeGoldFromArray:self.goldPlayer];
                break;
            case RedChoosePokerTier:
                [self removeGoldFromArray:self.goldTier];
                break;
            case RedChoosePokerBankerPair:
                [self removeGoldFromArray:self.goldBankerPair];
                break;
            case RedChoosePokerPlayerPair:
                [self removeGoldFromArray:self.goldPlayerPair];
                break;
        }
    }
}

- (void)removeGoldFromArray:(NSMutableArray *)array
{
    if (!array) {
        return;
    }
    for (UIImageView *img in array) {
        [UIView animateWithDuration:LeftTimes*2 animations:^{
            img.frame = CGRectMake(ScreenWidth * 0.5, 0, GoldWidth, GoleHeight);
        }completion:^(BOOL finished) {
            [img removeFromSuperview];
        }];
    }
    [array removeAllObjects];
}
- (void)reCycleGoldFromArray:(NSMutableArray *)array
{
    if (!array) {
        return;
    }
    for (UIImageView *img in array) {
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frame = [self getReCycleFrame:img];
            img.frame = CGRectMake(frame.origin.x, frame.origin.y, GoldWidth, GoleHeight);
        } completion:^(BOOL finished) {
            [img removeFromSuperview];
        }];
    }
    [array removeAllObjects];
}

- (void)handleGoldOfWinners:(NSArray *)winners
{
    NSMutableSet *allRolesSet = [NSMutableSet setWithArray:self.allRoles];
    NSMutableSet *winnerSet = [NSMutableSet setWithArray:winners];
    [allRolesSet minusSet:winnerSet];
    [self recycleWinnerGold:winners];
    [self removeLoseGold:allRolesSet];
}
- (void)recycleWinnerGold:(NSArray *)winners{
    for (NSNumber *winner in winners) {
        switch ([winner integerValue]) {
            case RedChoosePokerBanker:
                [self reCycleGoldFromArray:self.goldBanker];
                break;
            case RedChoosePokerPlayer:
                [self reCycleGoldFromArray:self.goldPlayer];
                break;
            case RedChoosePokerTier:
                [self reCycleGoldFromArray:self.goldTier];
                break;
            case RedChoosePokerBankerPair:
                [self reCycleGoldFromArray:self.goldBankerPair];
                break;
            case RedChoosePokerPlayerPair:
                [self reCycleGoldFromArray:self.goldPlayerPair];
                break;
        }
    }
}
#pragma mark - hightlight result block
- (void)hightlightWinners:(NSArray *)winners{
    for (NSNumber *winner in winners) {
        switch ([winner integerValue]) {
            case RedChoosePokerBanker:
                self.bankerBtn.selected=YES;
                break;
            case RedChoosePokerPlayer:
                self.playerBtn.selected=YES;
                break;
            case RedChoosePokerTier:
                self.tieBtn.selected=YES;
                break;
            case RedChoosePokerBankerPair:
                self.bankerPairBtn.selected=YES;
                break;
            case RedChoosePokerPlayerPair:
                self.playerPairBtn.selected=YES;
                break;
        }
    }
}
- (CABasicAnimation *)shiningAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat : 1.0f ];
    animation.toValue = [NSNumber numberWithFloat : 0.0f ]; 
    animation.autoreverses = YES ;
    animation.duration = 0.3;
    animation.repeatCount = 3;
    animation.removedOnCompletion = YES;
    animation.delegate = self;
    animation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}
- (void)hightlightWinnerBlock:(UIButton *)winnerBtn imageName:(NSString *)imageName
{
    CALayer *layer = [[CALayer alloc] init];
    layer.contents = (__bridge id)[UIImage imageNamed:imageName].CGImage;
    layer.frame = winnerBtn.frame;
    [self.shiningLayers addObject:layer];
    [self.view.layer addSublayer:layer];
    CABasicAnimation *shiningAnimation = [self shiningAnimation];
    [layer addAnimation:shiningAnimation forKey:@"shining"];
}

- (CGRect)getReCycleFrame:(UIImageView *)img
{
    NSInteger tag = img.tag;
    CGRect frame = CGRectZero;
    switch (tag) {
        case 1:
            frame = self.gold100.frame;
            break;
        case 2:
            frame = self.gold1000.frame;
            break;
        case 3:
            frame = self.gold10000.frame;
            break;
        case 4:
            frame = self.gold100000.frame;
            break;
        case 5:
            frame = self.gold1000000.frame;
            break;
    }
    return frame;
}
- (void)showResultOfWinner:(NSArray *)winners
{
    NSString *win = @"";
    NSString *winMoney = @"";
    if (self.choosePorB != RedChoosePokerNone) {
        double winDouble = [self.users[@"Jicky"] winMoney];
        double actualMoney = winDouble - self.playMoney;
        _resultView.hidden=NO;
        self.bankerBtn.selected=NO;
        self.playerBtn.selected=NO;
        self.tieBtn.selected=NO;
        self.bankerPairBtn.selected=NO;
        self.playerPairBtn.selected=NO;
        if (actualMoney < 0.0) {
            _resultImageView.image=[UIImage imageNamed:@"icon_lose"];
            winMoney = [NSString stringWithFormat:@"-%0.2f", fabs(actualMoney)];
        } else {
            _resultImageView.image=[UIImage imageNamed:@"ic_win"];
            winMoney = [NSString stringWithFormat:@"+%0.2f", fabs(actualMoney)];
        }
    } else {
        winMoney = @"No bets were made at this Round";
    }
    [AlertUtil showWhoWin:win num:winMoney];
}
- (void)broadcastWinner:(NSArray *)winners
{
    for (NSNumber *winnerNum in winners) {
        NSInteger winner = [winnerNum integerValue];
        switch (winner) {
            case RedChoosePokerBanker:{
                [AudioUtils play:@"banker_win"];
                break;
            }
            case RedChoosePokerPlayer:{
                [AudioUtils play:@"player_win"];
                break;
            }
            case RedChoosePokerTier: {
                [AudioUtils play:@"tie_win"];
                break;
            }
            case RedChoosePokerPlayerPair: {
                [AudioUtils play:@"player_pair_win"];
                break;
            }
            case RedChoosePokerBankerPair:
                [AudioUtils play:@"banker_pair_win"];
                break;
            default:
                break;
        }
    }
}
- (CGRect)getFrameOfGold:(CGRect)maxFrame
{
    float minX = CGRectGetMinX(maxFrame) + GoldWidth;
    float maxX = CGRectGetMaxX(maxFrame) - GoldWidth;
    float minY = CGRectGetMinY(maxFrame) + GoleHeight;
    float maxY = CGRectGetMaxY(maxFrame) - GoleHeight;
    float randomX = [self getRandomNumber:floorf(minX - GoldWidth * 0.5) to:floorf(maxX - GoldWidth * 0.5)];
    float randowY = [self getRandomNumber:floorf(minY - GoleHeight * 0.5) to:floorf(maxY - GoleHeight * 0.5)];
    return CGRectMake(randomX, randowY, GoldWidth, GoleHeight);
}
- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}


@end
