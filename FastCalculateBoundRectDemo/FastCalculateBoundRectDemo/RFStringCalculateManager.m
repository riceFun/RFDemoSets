//
//  RFStringCalculateManager.m
//  FastCalculateBoundRectDemo
//
//  Created by riceFun on 2019/1/22.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "RFStringCalculateManager.h"

@interface RFStringCalculateManager ()
@property (nonatomic,strong) NSMutableDictionary *fontDictionary;
@property (nonatomic,assign) NSUInteger numsNeedToSave;

@end

@implementation RFStringCalculateManager
+(instancetype)sharedInstance{
    static RFStringCalculateManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RFStringCalculateManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        [self readFontDictionaryFromDisk];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveFontDictionaryToDisk) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveFontDictionaryToDisk) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark public
//限定最大行数的场景下计算label的bounds
-(CGRect)fastCalculateSizeWithString:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font maxLine:(int)maxLine{
    
    NSDictionary *widthDictionary = [self fetchWidthDictionaryWithFont:font];
    
    CGFloat totalWidth = [self calculateTotalWidthString:string font:font];
    CGFloat singleLineHeight = [widthDictionary[@"singleLineHeight"] floatValue];
    CGFloat numsOfLine = ceil(totalWidth/maxWidth);
    CGFloat maxLineCGFloat = maxLine;
    CGFloat resultwidth = numsOfLine <= 1 ? totalWidth : maxWidth;//小于最大宽度时，取实际宽度的值
    CGFloat resultLine = numsOfLine < maxLineCGFloat ? numsOfLine : maxLineCGFloat;
    return CGRectMake(0, 0, resultwidth, resultLine * singleLineHeight);
}

//行数不限的场景下计算Label的bounds
-(CGRect)fastCalculateSizeWithString:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font {
    NSDictionary *widthDictionary = [self fetchWidthDictionaryWithFont:font];
    CGFloat totalWidth = [self calculateTotalWidthString:string font:font];
    CGFloat singleLineHeight = [widthDictionary[@"singleLineHeight"] floatValue];
    CGFloat numsOfLine = ceil(totalWidth/maxWidth);
    CGFloat resultwidth = numsOfLine <= 1 ? totalWidth : maxWidth;//小于最大宽度时，取实际宽度的值
    return CGRectMake(0, 0, resultwidth, numsOfLine * singleLineHeight);
}

//限定最大高度的场景下计算Label的bounds
-(CGRect)fastCalculateSizeWithString:(NSString *)string maxSize:(CGSize)maxSize font:(UIFont *)font {
    NSDictionary *widthDictionary = [self fetchWidthDictionaryWithFont:font];
    CGFloat totalWidth = [self calculateTotalWidthString:string font:font];
    CGFloat singleLineHeight = [widthDictionary[@"singleLineHeight"] floatValue];
    CGFloat numsOfLine = ceil(totalWidth/maxSize.width);//行数
    CGFloat maxLineCGFloat = floor(maxSize.height/singleLineHeight);
    CGFloat resultwidth = numsOfLine <= 1 ? totalWidth : maxSize.width;//小于最大宽度时，取实际宽度的值
    CGFloat resultLine = numsOfLine < maxLineCGFloat ? numsOfLine : maxLineCGFloat;
    return CGRectMake(0, 0, resultwidth, resultLine * singleLineHeight);
}

#pragma mark privite
//计算排版在一行的总宽度
-(CGFloat)calculateTotalWidthString:(NSString *)string font:(UIFont *)font{
    CGFloat totalWidth = 0;
    NSString *fontDicKey = [NSString stringWithFormat:@"%@-%f",font.fontName,font.pointSize];
    NSMutableDictionary *widthDictionary = [NSMutableDictionary dictionaryWithDictionary:[self fetchWidthDictionaryWithFont:font]];
    CGFloat chineseWidth = [widthDictionary[@"中"] floatValue];
    for(int i =0; i < [string length]; i++){
        NSString *tempShortString = [string substringWithRange:NSMakeRange(i, 1)];
//                   NSLog(@"第%d个字是:%@",i,tempShortString);
        if ([RFStringCalculateManager isChinese:tempShortString]) {//中文
            totalWidth += chineseWidth;
        }else if (widthDictionary[tempShortString] != nil){//数字，小写字母，大写字母，及常见符号
            totalWidth += [widthDictionary[tempShortString] floatValue];
        }else{//符号及其他没有预先计算好的字符，对它们进行计算并且缓存到宽度字典中去
            NSDictionary *attrs  = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
            CGFloat width = [tempShortString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attrs  context:nil].size.width;
            totalWidth += width;
            widthDictionary[tempShortString] = [NSString stringWithFormat:@"%f",width];
            self.numsNeedToSave += 1;
        }
    }
   
    self.fontDictionary[fontDicKey] = [widthDictionary copy];
    if (self.numsNeedToSave > 10) {
        [self saveFontDictionaryToDisk];
    }
    return totalWidth;
}

+ (BOOL)isChinese:(NSString *)string{
    if (string.length < 1) {
        return NO;
    }
    int a = [string characterAtIndex:0];
    if( a > 0x4e00 && a < 0x9fff){//判断输入的是否是中文
        return YES;
    }
    return NO;
        
    //下面这种判断方式太慢
//    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
//    return [predicate evaluateWithObject:string];
}

//取
-(NSDictionary *)fetchWidthDictionaryWithFont:(UIFont *)font{
    //fontDicKeyformatter @"font.fontName-font.pointSize"
    NSString *fontDicKey = [NSString stringWithFormat:@"%@-%f",font.fontName,font.pointSize];
    NSDictionary *widthDictionary = [RFStringCalculateManager sharedInstance].fontDictionary[fontDicKey];
    if (!widthDictionary) {
        widthDictionary = [[RFStringCalculateManager sharedInstance] createNewFont:font];
    }
    return widthDictionary;
}

//新建字体字典   //第一次使用字体时预先计算该字体中各种字符的宽度
-(NSDictionary *)createNewFont:(UIFont *)font{
    NSArray *array = @[@"中", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"a", @"b", @"c", @"d", @"e",  @"f",  @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"“", @";", @"？", @",", @"［", @"]", @"、", @"【", @"】", @"?", @"!", @":", @"|"];
    
    NSMutableDictionary *fontWidthHeightDictionary = [NSMutableDictionary dictionary];//{String: CGFloat}
    CGRect singleWordRect = CGRectZero;
    for (NSString *string in array) {
        NSDictionary *attrs  = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        singleWordRect = [string boundingRectWithSize:CGSizeMake(100,100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attrs  context:nil];
        NSString *singleWordRectSizeWidthString = [NSString stringWithFormat:@"%f",singleWordRect.size.width];
        fontWidthHeightDictionary[string] = singleWordRectSizeWidthString;//相同font的情况下每个字符符号height 是相同的   但是width是不同的
    }
    NSString *singleWordRectSizeHeightString = [NSString stringWithFormat:@"%f",singleWordRect.size.height];
    fontWidthHeightDictionary[@"singleLineHeight"] = singleWordRectSizeHeightString;
    //fontDicKeyformatter @"font.fontName-font.pointSize"
    NSString *fontDicKey = [NSString stringWithFormat:@"%@-%f",font.fontName,font.pointSize];
    self.fontDictionary[fontDicKey] = fontWidthHeightDictionary;
    self.numsNeedToSave = array.count;//代表有更新，需要存入到磁盘
    [self saveFontDictionaryToDisk];
    return [fontWidthHeightDictionary copy];
}

//读 磁盘内容
-(void)readFontDictionaryFromDisk{
    NSData *data = [NSData dataWithContentsOfURL:[self fileUrl]];
    if (data == nil) {
        return;
    }
    NSError *error;
    NSMutableDictionary *dataFontDictionary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:&error];
    if (error) {
        NSLog(@"第一次运行时font_dictionary不存在或者读取失败");
        return;
    }
    self.fontDictionary = [dataFontDictionary mutableCopy];
    NSLog(@"font_dictionarys读取成功,font_dictionarys=%@",dataFontDictionary);
}

//写 磁盘内容
-(void)saveFontDictionaryToDisk{
    //判断当前需要更新的数据条数
    if (self.numsNeedToSave == 0) {
        return;
    }
    self.numsNeedToSave = 0;
    
    dispatch_queue_t queue = dispatch_queue_create("com.RFStringCalculateManager.queue", NULL);
    dispatch_async(queue, ^{//异步串行队列  防止多线程同时写入造成冲突
        NSData *data;
        NSError *error;
        if (@available(iOS 11.0, *)) {
            data = [NSJSONSerialization dataWithJSONObject:self.fontDictionary options:(NSJSONWritingSortedKeys) error:&error];
        }else{
            data = [NSJSONSerialization dataWithJSONObject:self.fontDictionary options:(NSJSONWritingPrettyPrinted) error:&error];
        }
        
        if (error) {
            NSLog(@"font_dictionary json to data 失败 %@",error);
        }
        NSError *writeError;
//        BOOL isSuccess = [data writeToURL:[self fileUrl] options:0 error:&writeError];
        BOOL isSuccess = [data writeToURL:[self fileUrl] atomically:YES];
        if (writeError) {
            NSLog(@"font_dictionary存储失败error :%@",writeError);
        }
        
        if (!isSuccess) {
            NSLog(@"font_dictionary存储失败");
        }else{
            NSLog(@"font_dictionary存储 成功");
        }
    });
}

//磁盘路径
-(NSURL *)fileUrl{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documetsDirectory = [paths objectAtIndex:0];
    NSString *filePathString = [documetsDirectory stringByAppendingPathComponent:@"font_dictionary.json"];
    NSLog(@"font_dictionary.json的路径是===%@",filePathString);
    NSURL *filePathUrl = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",filePathString]];
    return filePathUrl;
}

#pragma mark getter
-(NSMutableDictionary *)fontDictionary{
    if (!_fontDictionary) {
        _fontDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _fontDictionary;
}

@end
