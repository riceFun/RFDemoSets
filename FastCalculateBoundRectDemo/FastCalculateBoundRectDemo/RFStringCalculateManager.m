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

-(void)readFontDictionaryFromDisk{
    NSData *data = [NSData dataWithContentsOfURL:[self fileUrl]];
    NSError *error;
    NSMutableDictionary *dataFontDictionary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:&error];
    if (error) {
        NSLog(@"第一次运行时font_dictionary不存在或者读取失败");
        return;
    }
    self.fontDictionary = [dataFontDictionary copy];
    NSLog(@"font_dictionarys读取成功,font_dictionarys=%@",dataFontDictionary);
}

-(NSURL *)fileUrl{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documetsDirectory = [paths objectAtIndex:0];
    NSString *filePathString = [documetsDirectory stringByAppendingPathComponent:@"font_dictionary.json"];
    NSLog(@"font_dictionary.json的路径是===%@",filePathString);
    NSURL *filePathUrl = [NSURL URLWithString:filePathString];
}

-(void)saveFontDictionaryToDisk{
    
}

#pragma mark getter
-(NSMutableDictionary *)fontDictionary{
    if (!_fontDictionary) {
        _fontDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _fontDictionary;
}

@end
