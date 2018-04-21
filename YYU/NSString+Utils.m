#import "NSString+Utils.h"
@implementation NSString (Utils)
+ (BOOL)isEmpty:(NSString *)str{
    if (str==nil) {
        return YES;
    }
    NSString *tmpStr = [NSString trim:str];
    if ([@"" isEqualToString:tmpStr]||[@"(null)" isEqualToString:tmpStr]) {
        return YES;
    }
    return NO;
}
- (NSString *)changeToFloatDigit
{
    if ([NSString isEmpty:self]) {
        return @"";
    }
    NSString *stringFloat = [NSString stringWithFormat:@"%0.2f",self.doubleValue];
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = (int)length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}
+(NSString *)trim:(NSString *)dirtyString{
    if (dirtyString==nil) {
        return nil;
    }
    return [dirtyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
