#import <Foundation/Foundation.h>
@interface AudioUtils : NSObject
+ (void)play:(NSString *)name;
+ (BOOL)allowPlayEffect;
+ (void)closeEffectWithCompleteBlock:(void (^)(BOOL isAllow)) completeBlock;
@end
