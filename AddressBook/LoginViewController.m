//
//  LoginViewController.m
//  AddressBook
//
//  Created by yclxiao on 2017/8/3.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import "LoginViewController.h"

//以下是导入静态库的两种方式
//#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define userNameKey @"name"
#define pwdKey @"pwd"
#define rmbPedKey @"rmb_pwd"



@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //注册通知添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
//    self.nameField.text = [defaults valueForKey:userNameKey];
//    self.pwdField.text = [defaults valueForKey:pwdKey];
    
    self.rembSwitch.on = [defaults boolForKey:rmbPedKey];
    
    //如果选择了记住，则用户名和密码，从存储的数据中获取
    if (self.rembSwitch.isOn) {
        self.nameField.text = [defaults valueForKey:userNameKey];
        self.pwdField.text = [defaults valueForKey:pwdKey];
        
        //记住密码时，登录按钮直接可用
        self.loginBtn.enabled = YES;
    }
    
    
}

- (void) textChange {
    self.loginBtn.enabled = self.nameField.text.length && self.pwdField.text.length;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UIViewController* contactVc = segue.destinationViewController;
    contactVc.title = [NSString stringWithFormat:@"%@的联系人列表",self.nameField.text];
    
}


- (IBAction)loginAction {
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    
    if(![self.nameField.text isEqualToString:@"jike"]){
        NSLog(@"账号不存在");
        
//        hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
        hud.detailsLabel.text = NSLocalizedString(@"账号不存在", @"HUD title");
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES afterDelay:1.f];
            });
        });
        
        return;
    }
    if (![self.pwdField.text isEqualToString:@"qq"]) {
        NSLog(@"密码有误");
        
//        hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
        hud.detailsLabel.text = NSLocalizedString(@"密码有误", @"HUD title");
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES afterDelay:1.f];
            });
        });
        
        return;
    }

    
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                
//                hud.detailsLabel.text = NSLocalizedString(@"努力加载中", @"HUD title");
//                
//                [hud hideAnimated:YES afterDelay:2.f];
//                
//                [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
//            });
//        });
    
    
    hud.detailsLabel.text = NSLocalizedString(@"努力加载中", @"HUD title");
    [hud hideAnimated:YES afterDelay:2.f];
    NSLog(@"111");
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"222");
        [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];

        [defaults setObject:self.nameField.text forKey:userNameKey];
        [defaults setObject:self.pwdField.text forKey:pwdKey];
        [defaults setBool:self.rembSwitch.on forKey:rmbPedKey];
        
        [defaults synchronize];

    });
    

    
}


@end
