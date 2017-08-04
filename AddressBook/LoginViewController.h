//
//  LoginViewController.h
//  AddressBook
//
//  Created by yclxiao on 2017/8/3.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UISwitch *rembSwitch;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)loginAction;

@end
