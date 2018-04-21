#import "MyCardUtils.h"
@implementation MyCardUtils
+ (NSArray *)getRandomPokerArrayOfCount:(int)count
{
    NSArray *pokerArray = [[[self class] getPokerDic] allKeys];
    NSMutableArray *startArray = [[NSMutableArray alloc] initWithArray:pokerArray];
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<count; i++) {
        int t = arc4random()%startArray.count;
        resultArray[i] = startArray[t];
        startArray [t] = [startArray lastObject]; 
        [startArray removeLastObject];
    }
    return resultArray;
}
+ (NSDictionary *)getPokerDic
{
    NSDictionary *dic = @{@"a1.jpg":@"1",
                          @"a2.jpg":@"2",
                          @"a3.jpg":@"3",
                          @"a4.jpg":@"4",
                          @"a5.jpg":@"5",
                          @"a6.jpg":@"6",
                          @"a7.jpg":@"7",
                          @"a8.jpg":@"8",
                          @"a9.jpg":@"9",
                          @"a10.jpg":@"10",
                          @"a11.jpg":@"11",
                          @"a12.jpg":@"12",
                          @"a13.jpg":@"13",
                          @"b1.jpg":@"1",
                          @"b2.jpg":@"2",
                          @"b3.jpg":@"3",
                          @"b4.jpg":@"4",
                          @"b5.jpg":@"5",
                          @"b6.jpg":@"6",
                          @"b7.jpg":@"7",
                          @"b8.jpg":@"8",
                          @"b9.jpg":@"9",
                          @"b10.jpg":@"10",
                          @"b11.jpg":@"11",
                          @"b12.jpg":@"12",
                          @"b13.jpg":@"13",
                          @"c1.jpg":@"1",
                          @"c2.jpg":@"2",
                          @"c3.jpg":@"3",
                          @"c4.jpg":@"4",
                          @"c5.jpg":@"5",
                          @"c6.jpg":@"6",
                          @"c7.jpg":@"7",
                          @"c8.jpg":@"8",
                          @"c9.jpg":@"9",
                          @"c10.jpg":@"10",
                          @"c11.jpg":@"11",
                          @"c12.jpg":@"12",
                          @"c13.jpg":@"13",
                          @"d1.jpg":@"1",
                          @"d2.jpg":@"2",
                          @"d3.jpg":@"3",
                          @"d4.jpg":@"4",
                          @"d5.jpg":@"5",
                          @"d6.jpg":@"6",
                          @"d7.jpg":@"7",
                          @"d8.jpg":@"8",
                          @"d9.jpg":@"9",
                          @"d10.jpg":@"10",
                          @"d11.jpg":@"11",
                          @"d12.jpg":@"12",
                          @"d13.jpg":@"13"};
    return dic;
}
@end
