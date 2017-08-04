//
//  EditViewController.h
//  AddressBook
//
//  Created by yclxiao on 2017/8/3.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditViewController,ContactModel;

@protocol EditViewControllerDelegate <NSObject>

@optional
- (void) editContract:(EditViewController*) addVc didAddContract:(ContactModel*) contact;

@end


@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

- (IBAction)saveAction;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
- (IBAction)editAction:(UIBarButtonItem *)sender;

@property (nonatomic,strong) ContactModel* contact;

@property (nonatomic, assign) id<EditViewControllerDelegate> delegate;

@end
