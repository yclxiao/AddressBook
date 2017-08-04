//
//  EditViewController.m
//  AddressBook
//
//  Created by yclxiao on 2017/8/3.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import "EditViewController.h"
#import "ContactModel.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.nameField.text = self.contact.name;
    self.phoneField.text = self.contact.phone;
    
    //注册通知添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    
}


- (void) textChange {
    self.saveBtn.enabled = self.nameField.text.length && self.phoneField.text.length;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if([self.delegate respondsToSelector:@selector(editContract:didAddContract:)]){
        self.contact.name = self.nameField.text;
        self.contact.phone = self.phoneField.text;
        
        [self.delegate editContract:self didAddContract:self.contact];
    }
    
}

- (IBAction)editAction:(UIBarButtonItem *)sender {
    
    if(self.nameField.enabled){
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        [self.view endEditing:YES];//结束编辑
        self.saveBtn.hidden = YES;//隐藏保存按钮
        
        sender.title = @"编辑";
        
        //还原老数据
        self.nameField.text = self.contact.name;
        self.phoneField.text = self.contact.phone;
        
    }else{
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.view endEditing:NO];//结束编辑
        self.saveBtn.hidden = NO;//隐藏保存按钮
        
        sender.title = @"取消";
    }

}
@end
