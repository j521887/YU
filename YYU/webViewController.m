#import "webViewController.h"
#import "MBProgressHUD.h"
@interface webViewController ()<UIWebViewDelegate>
- (IBAction)closeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@end
@implementation webViewController
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleLab.text=_titles;
    _webView.delegate=self;
    _webView.opaque=NO;
    _webView.backgroundColor=[UIColor clearColor];
    [_webView loadHTMLString:_str baseURL:nil];
}

- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '120%'"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
