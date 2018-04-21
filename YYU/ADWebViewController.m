#import "ADWebViewController.h"
#import "Reachability.h"
@interface ADWebViewController ()<UIWebViewDelegate,UIAlertViewDelegate>
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (assign, nonatomic) BOOL isLoadFinish;
@property (assign, nonatomic) BOOL isLandscape;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UIView *noNetView;
@property (strong,nonatomic) UIAlertView *alertView;
@property (retain, nonatomic) IBOutlet UIView *bottomBarView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@end
@implementation ADWebViewController
+(instancetype)initWithURL:(NSString *)urlString{
    ADWebViewController *adWKWebViewController = [[ADWebViewController alloc]init];
    adWKWebViewController.webViewURL = urlString;
    return adWKWebViewController;
}
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doRotateAction:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.webView.scalesPageToFit=YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
    [self.view addSubview:self.webView];
    self.noNetView.hidden = YES;
    [self.view addSubview:self.noNetView];
    [self listenNetWorkingStatus]; 
    [self.view addSubview:self.activityIndicatorView];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.isLandscape) {
        self.webView.frame = self.view.bounds;
    }else{
        self.webView.frame = self.webView.frame;
    }
}
#pragma mark - ------ 网页代理方法 ------
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.activityIndicatorView.hidden = NO;
    self.isLoadFinish = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.activityIndicatorView.hidden = YES;
    self.noNetView.hidden = YES;
    self.isLoadFinish = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (!self.noNetView.hidden) {
        self.noNetView.hidden = YES;
    }
    self.activityIndicatorView.hidden = YES;
}
#pragma mark - ------ 底部 导航栏 ------
- (IBAction)goingBT:(UIButton *)sender {
    if (sender.tag ==200) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
    }else if (sender.tag ==201) {
        if ([self.webView canGoBack]) {[self.webView goBack]; }
    }else if (sender.tag ==202) {
        if ([self.webView canGoForward]) {[self.webView goForward];}
    }else if (sender.tag ==203) {
        [self.webView reload];
    }else if (sender.tag ==204) {
        self.alertView = [[UIAlertView alloc]initWithTitle:@"是否退出？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [self.alertView show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        exit(0);
    }
}
#pragma mark - ------ 网络监听 ------
- (IBAction)againBTAction:(UIButton *)sender {
    self.activityIndicatorView.hidden = NO;
    self.noNetView.hidden = YES;
    self.isLoadFinish = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewURL]]];
    [self performSelector:@selector(checkNetwork) withObject:nil afterDelay:3];
}
-(void)checkNetwork{
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
}
-(void)listenNetWorkingStatus{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    NSString *remoteHostName = @"www.apple.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    [self updateInterfaceWithReachability:curReach];
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case 0://无网络
            if (!self.isLoadFinish) { self.noNetView.hidden = NO; }
            break;
        case 1://WIFI
            NSLog(@"ReachableViaWiFi----WIFI");
            break;
        case 2://蜂窝网络
            NSLog(@"ReachableViaWWAN----蜂窝网络");
            break;
        default:
            break;
    }
}
#pragma mark - ------ 横竖屏相关 ------
-(BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return  UIInterfaceOrientationMaskLandscape |
            UIInterfaceOrientationMaskPortrait ;
}
- (void)doRotateAction:(NSNotification *)notification {
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        self.webView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-69);
        self.bottomBarView.hidden = NO;
        self.isLandscape = NO;
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
               || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        NSLog(@"横屏");
        self.webView.frame = self.view.bounds;
        self.bottomBarView.hidden = YES;
        self.isLandscape = YES;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.webView stopLoading];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
