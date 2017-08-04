//
//  ContactTableViewController.h
//  AddressBook
//
//  Created by yclxiao on 2017/8/3.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewController : UITableViewController

- (IBAction)backAction:(id)sender;

@property (nonatomic,strong) NSMutableArray* contactArr;

@end
