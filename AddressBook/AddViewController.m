//
//  AddViewController.m
//  AddressBook
//
//  Created by yclxiao on 2017/8/3.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import "AddViewController.h"
#import "ContactModel.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    
    
    
}

- (void) textChange {
    self.btnAdd.enabled = self.nameField.text.length && self.phoneField.text.length;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //将姓名文本框设置为第一响应者
    [self.nameField becomeFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnAction {
    
    //先关闭当前控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    //通过代理传值，先判断代理是否能够相应此方法
    if([self.delegate respondsToSelector:@selector(addContract:didAddContract:)]){
        
        ContactModel* contactModel = [[ContactModel alloc] init];
        contactModel.name = self.nameField.text;
        contactModel.phone = self.phoneField.text;
        
        [self.delegate addContract:self didAddContract:contactModel];
    }
    
    
    
}

@end
