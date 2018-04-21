#import <Foundation/Foundation.h>
#define MAX_DISPLAY_WORD_COUNT 3000
#define PASSWORD_PATTERN     @"^((?=.*?\\d)(?=.*?[A-Za-z])|(?=.*?\\d)(?=.*?[~!@#$%^&*\\;',./_+|{}\\[\\]:\"<>?])|(?=.*?[A-Za-z])(?=.*?[~!@#$%^&*\\;',./_+|{}\\[\\]:\"<>?]))[\\dA-Za-z~!@#$%^&*\\;',./_+|{}\\[\\]:\"<>?]{6,16}$"
@interface NSString (Utils)
+ (BOOL)isEmpty:(NSString *)str;
- (NSString *)changeToFloatDigit;
+ (NSString *)trim:(NSString *)dirtyString;
@end
