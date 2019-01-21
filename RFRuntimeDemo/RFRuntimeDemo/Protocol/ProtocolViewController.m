//
//  ProtocolViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/17.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "ProtocolViewController.h"
#import "RFTableViewController.h"
#import <objc/runtime.h>
@interface ProtocolViewController ()

@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*1. BOOL class_conformsToProtocol(Class cls, Protocol *protocol)
     作用：判断类 cls 是否遵守了 protocol 协议
     以 UITableViewController 类为例，代码示例如下：
     */
    Protocol *pro = NSProtocolFromString(@"UITableViewDataSource");
    BOOL UITableViewControllerIsConfroms = class_conformsToProtocol([UITableViewController class], pro);//yes
    
    BOOL UITableViewIsConfroms = class_conformsToProtocol([UITableView class], pro);//NO  UITableView 类本身并没有遵守 UITableViewDataSource 协议，需要程序员自己为它遵守，这点不能混淆。
    NSLog(@"UITableViewController IsConfroms:%d\nUITableView IsConfroms:%d",UITableViewControllerIsConfroms,UITableViewIsConfroms);
    
    /*另外，我们平时使用的是定义在 NSObject 协议中的方法：
     - (BOOL)conformsToProtocol:(Protocol *)aProtocol;
     与 class_conformsToProtocol 函数作用相同，并且类和类的实例都可以调用这个方法，代码示例如下：
    */
    UITableViewController *tableViewController = [[UITableViewController alloc]init];
    BOOL isConforms1 = [tableViewController conformsToProtocol:pro];//YES
    BOOL isConforms2 = [UITableViewController conformsToProtocol:pro];//YES
    
    /*2. Protocol * __unsafe_unretained *class_copyProtocolList(Class cls, unsigned int *outCount)
     作用：获取类 cls 遵守的所有协议，而 cls 的父类所遵守的协议不会获取到。该函数的使用方法和 class_copyIvarList （见这篇）等函数的使用方法相似，第二个参数需要传一个 unsigned int 类型变量的地址，用于获取类 cls 所遵守的所有协议的数量。仍以 UITableViewController 类为例，代码示例如下：
     
     */
    unsigned int count;//1
    Protocol *__unsafe_unretained *list = class_copyProtocolList([UITableViewController class], &count);//2
    for (int i = 0; i < count; i++) { // 3
        Protocol *pro = list[i]; // 4
        NSLog(@"UITableViewController‘s %@", NSStringFromProtocol(pro)); // 5
    } // 6
    free(list); // 7
    /*打印：
     2018-12-17 16:29:31.588684+0800 RFRuntimeDemo[28899:1329408] UITableViewController‘s DebugHierarchyObject_Fallback
     2018-12-17 16:29:31.588793+0800 RFRuntimeDemo[28899:1329408] UITableViewController‘s _UIKeyboardAutoRespondingScrollViewController
     2018-12-17 16:29:31.588875+0800 RFRuntimeDemo[28899:1329408] UITableViewController‘s UITableViewFocusDelegateLegacy
     2018-12-17 16:29:31.588953+0800 RFRuntimeDemo[28899:1329408] UITableViewController‘s UIViewControllerPreviewingDelegate
     2018-12-17 16:29:31.589029+0800 RFRuntimeDemo[28899:1329408] UITableViewController‘s UIViewControllerPreviewingDelegate_Deprecated
     2018-12-17 16:29:31.589104+0800 RFRuntimeDemo[28899:1329408] UITableViewController‘s UITableViewDelegate
     2018-12-17 16:29:31.589181+0800 RFRuntimeDemo[28899:1329408] UITableViewController‘s UITableViewDataSource
     */
    NSLog(@"=====================");
    unsigned int count_1;//1
    Protocol *__unsafe_unretained *list_1 = class_copyProtocolList([RFTableViewController class], &count_1);//2  RFTableViewController 是继承于 UITableViewController
    for (int i = 0; i < count_1; i++) { // 3
        Protocol *pro = list_1[i]; // 4
        NSLog(@"RFTableViewController‘s %@", NSStringFromProtocol(pro)); // 5
    } // 6
    free(list_1); // 7
    /*打印：
     空
     */
    
    /*3.Protocol *objc_getProtocol(const char *name)
     获取名称为 name 的协议
     */
    Protocol *proto = objc_getProtocol("UITableViewDataSource");
    //相对比较简单。该函数和条目1中使用的 NSProtocolFromString 作用相同，可以通过以下代码验证：
    Protocol *proto1 = objc_getProtocol("UITableViewDataSource");
    Protocol *proto2 = NSProtocolFromString(@"UITableViewDataSource");
    BOOL isEqual = proto1 == proto2; // 另一种方式见条目6
    NSLog(@"isEqual : %d", isEqual); // YES
    
   
    /*4. Protocol * __unsafe_unretained *objc_copyProtocolList(unsigned int *outCount)
     作用：获取当前 runtime 中的所有协议。
     
     */
    unsigned int count_All;
    Protocol * __unsafe_unretained *list_All = objc_copyProtocolList(&count_All);
    for (int i = 0; i < count_All; i++) {
        Protocol *pro = list_All[i];
        NSLog(@"%@", NSStringFromProtocol(pro));
    }
    free(list);
    /*打印
     2018-12-17 16:35:09.772316+0800 RFRuntimeDemo[28925:1330577] SCNAnimation
     2018-12-17 16:35:09.772401+0800 RFRuntimeDemo[28925:1330577] GEOBatchOpportunisticTileDownloaderDelegate
     2018-12-17 16:35:09.772464+0800 RFRuntimeDemo[28925:1330577] PTSettingsKeyObserver
     2018-12-17 16:35:09.772524+0800 RFRuntimeDemo[28925:1330577] _UIAlertControllerTextFieldViewControllerContaining
     2018-12-17 16:35:09.772585+0800 RFRuntimeDemo[28925:1330577] SFVerticalLayoutCardSection
     2018-12-17 16:35:09.772643+0800 RFRuntimeDemo[28925:1330577] MKInfoCardThemeListener
     2018-12-17 16:35:09.772702+0800 RFRuntimeDemo[28925:1330577] _UIHostedTextServiceSessionDelegate
     ...省略大部分
     */
    
    
    /*5. BOOL protocol_conformsToProtocol(Protocol *proto, Protocol *other)
     作用：判断一个协议 proto 是否遵守了另一个协议 other
     */
    // 利用条目3 objc_getProtocol 函数获取协议
    Protocol *tableViewDelegate = objc_getProtocol("UITableViewDelegate");
    Protocol *scrollViewDelegate = objc_getProtocol("UIScrollViewDelegate");
    BOOL isConformProtocol = protocol_conformsToProtocol(tableViewDelegate, scrollViewDelegate);
    NSLog(@"是否遵守了:%d", isConformProtocol); // YES
   
    
    /*6. BOOL protocol_isEqual(Protocol *proto, Protocol *other)
     作用：判断两个协议是否相同
     代码示例如下：（和条目3中验证部分的代码几乎相同）
     */
    Protocol *protoA = objc_getProtocol("UITableViewDataSource");
    Protocol *protoB = NSProtocolFromString(@"UITableViewDataSource");
    BOOL isEqualProtocol = protocol_isEqual(protoA, protoB);// YES
    NSLog(@"是否相同%d", isEqualProtocol);
    
   
    /*7. const char *protocol_getName(Protocol *p)
     作用：获取协议 p 的名称。该函数的作用和条目2中使用的 NSStringFromProtocol 作用相同，可以将条目2中的第5行代码替换为如下代码：
     */
    NSLog(@"%s", protocol_getName(pro));
    
    
    /*8. Protocol * __unsafe_unretained *protocol_copyProtocolList(Protocol *proto, unsigned int *outCount)
     作用：获取协议 proto 遵守的所有协议
     */
    Protocol *UITableViewDelegate = objc_getProtocol("UITableViewDelegate");
    unsigned int count_UITableViewDelegate;
    Protocol * __unsafe_unretained *list_UITableViewDelegate = protocol_copyProtocolList(UITableViewDelegate, &count_UITableViewDelegate);
    for (int i = 0; i < count_UITableViewDelegate; i++) {
        Protocol *proto = list_UITableViewDelegate[i];
        const char *name = protocol_getName(proto);
        NSLog(@"%s", name);
    }
    
    /*打印
     2018-12-17 16:48:30.219651+0800 RFRuntimeDemo[28991:1333470] NSObject
     2018-12-17 16:48:30.219676+0800 RFRuntimeDemo[28991:1333470] UIScrollViewDelegate
     */
    
}


@end
