//
//  AppDelegate.h
//  YYKit_YYCache_Learn
//
//  Created by riceFun on 2019/1/24.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

