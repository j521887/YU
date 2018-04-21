#ifndef UserUtil_h
#define UserUtil_h
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define UserDefaults        [NSUserDefaults standardUserDefaults]
#define WEAKSELF            __weak typeof(self) weakSelf = self;
#define KEY_CLOSE_BG_MUSIC   @"KEY_CLOSE_BG_MUSIC"
#define KEY_CLOSE_EFFECT     @"KEY_CLOSE_EFFECT"
#define ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define ScreenHeight        [UIScreen mainScreen].bounds.size.height
#define KEY_HAS_OPEN     @"KEY_HAS_OPEN"
#define ParamValue         @"PARAM_VALUE"
#define HaveGetCoin       @"HaveGetCoin"
#endif 
