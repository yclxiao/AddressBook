//
//  AddViewController.h
//  AddressBook
//
//  Created by yclxiao on 2017/8/3.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddViewController,ContactModel;

@protocol AddViewControllerDelegate <NSObject>

@optional
- (void) addContract:(AddViewController*) addVc didAddContract:(ContactModel*) contact;

@end

@interface AddViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property (nonatomic, assign) id<AddViewControllerDelegate> delegate;

- (IBAction)btnAction;

@end
