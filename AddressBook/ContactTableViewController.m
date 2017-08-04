//
//  ContactTableViewController.m
//  AddressBook
//
//  Created by yclxiao on 2017/8/3.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import "ContactTableViewController.h"
#import "ContactModel.h"
#import "AddViewController.h"
#import "EditViewController.h"

#define ContactFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]

@interface ContactTableViewController () <AddViewControllerDelegate,EditViewControllerDelegate>


@end

@implementation ContactTableViewController

- (NSMutableArray*) contactArr {
    if (!_contactArr) {
        
        _contactArr = [NSKeyedUnarchiver unarchiveObjectWithFile:ContactFilePath];
        
        if(_contactArr == nil){
            _contactArr = [NSMutableArray array];
        }
    }
    return _contactArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearExtraLine:self.tableView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //此处必须用 self.contactArr 不能用 _contactArr，用了self.contactArr才会调用上线的方法，从归档文件中获取数据
    return self.contactArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    
    ContactModel* contactModel = self.contactArr [indexPath.row];
    
    cell.textLabel.text = contactModel.name;
    cell.detailTextLabel.text = contactModel.phone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

# pragma mark - AddViewController delegate

- (void) addContract:(AddViewController*) addVc didAddContract:(ContactModel*) contact{
    [self.contactArr addObject:contact];
    [self.tableView reloadData];
    
    //归档数据
    [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
    
}

- (void) clearExtraLine: (UITableView*) tableView {
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

# pragma mark - EditViewController delegate
- (void) editContract:(AddViewController*) addVc didAddContract:(ContactModel*) contact{
    
    //不需要这行代码，直接刷新数据就可以了
//    self.contactArr[self.tableView.indexPathForSelectedRow.row] = contact;
    
    [self.tableView reloadData];
    
    
    //归档数据
    [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        //删除某行数据
        [self.contactArr removeObjectAtIndex:indexPath.row];
        
        //重新刷新表格数据
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        
        //归档数据
        [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
        
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //跳转到目标控制器之前，先是设置下目标控制器的代理对象
    id vc = segue.destinationViewController;
    
    if ([vc isKindOfClass:[AddViewController class]]) {
        AddViewController* addVc = vc;
        addVc.delegate = self;
    }else{
        EditViewController* editVc = vc;
        
        editVc.contact = self.contactArr[[[self.tableView indexPathForSelectedRow] row]];
        
        editVc.delegate = self;

    }
    
}


- (IBAction)backAction:(id)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"是否注销？"
                                                                   message:@"真的要注销吗？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                          handler:nil];
    
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                          }];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
