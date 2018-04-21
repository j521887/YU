#import "AudioUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UserUtil.h"
static SystemSoundID shake_sound_male_id = 0;
@implementation AudioUtils
+ (void)play:(NSString *)name{
    if ([self allowPlayEffect]) {
        NSLog(@"play: %@", name);
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
        if (path) {
            AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:path]),&shake_sound_male_id);
            AudioServicesPlaySystemSound(shake_sound_male_id);
            AudioServicesPlaySystemSound(shake_sound_male_id);
        }
        AudioServicesPlaySystemSound(shake_sound_male_id);   
    }
}
+ (void)closeEffectWithCompleteBlock:(void (^)(BOOL isAllow))completeBlock
{
    BOOL isAllow = [self allowPlayEffect];
    [UserDefaults setBool:isAllow forKey:KEY_CLOSE_EFFECT];
    [UserDefaults synchronize];
    if (completeBlock) {
        completeBlock(!isAllow);
    }
}
+ (BOOL)allowPlayEffect
{
    return ![UserDefaults boolForKey:KEY_CLOSE_EFFECT];
}
@end
