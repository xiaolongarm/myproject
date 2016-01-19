//
//  DeatailContrantTableViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/9/17.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DeatailContrantTableViewController.h"
#import "DetailContrantTableViewCell.h"

@interface DeatailContrantTableViewController ()

@end

@implementation DeatailContrantTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 13;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailContrantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailContrantTableViewCell" forIndexPath:indexPath];
    
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
            {
                cell.title.text=@"合同编码:";
                cell.content.text=[self.rDict objectForKey:@"contract_code"];
                
//                UIImageView *imageView=[[UIImageView alloc] init];
//                imageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width - 120 -20, 10, 120, 77);
//                int flag=[[self.contactsDict objectForKey:@"flag"]intValue];
//                if(flag == 0)
//                    imageView.image=[UIImage imageNamed:@"uncheck-tag"];
//                if(flag == 2)
//                    imageView.image=[UIImage imageNamed:@"fail-tag"];
//                [detailsTableView addSubview:imageView];
            }
                break;
            case 1:{
                cell.title.text=@"合同名称:";
                cell.content.text=[self.rDict objectForKey:@"contract_name"];
            }
                break;
            case 2:
                cell.title.text=@"合同类型:";
                cell.content.text=[self.rDict objectForKey:@"contract_type"];
                break;
            case 3:
                cell.title.text=@"开始时间:";
                cell.content.text=[self.rDict objectForKey:@"start_date"];
                break;
            case 4:
                cell.title.text=@"结束时间:";
                cell.content.text=[self.rDict objectForKey:@"end_date"];
                break;
            case 5:
                cell.title.text=@"项目实施人:";
                cell.content.text=[self.rDict objectForKey:@"linkman"];
                break;
            case 6:
                cell.title.text=@"合同金额:";
                cell.content.text=[self.rDict objectForKey:@"contract_fee"];
                break;
            case 7:
                cell.title.text=@"缴费时间:";
                cell.content.text=[self.rDict objectForKey:@"pay_time"];
                break;
            case 8:
                cell.title.text=@"缴费周期:";
                cell.content.text=[self.rDict objectForKey:@"cycle_time"];
                break;
            case 9:{
                cell.title.text=@"启用标识:";
                
            cell.content.text=[self.rDict objectForKey:@"use_flag"];
            }
                break;
            case 10:
                cell.title.text=@"产品编码:";
                cell.content.text=[self.rDict objectForKey:@"grp_prod_code"];
                break;
            case 11:
                cell.title.text=@"产品名称:";
                cell.content.text=[self.rDict objectForKey:@"grp_prod_name"];
                break;
            case 12:
                cell.title.text=@"上月实际消费金额:";
                cell.content.text=[self.rDict objectForKey:@"grp_prod_fee"];
                break;
//            case 13:
//                cell.itemTitle.text=@"第一优先";
//                cell.itemContent.text=[self.contactsDict objectForKey:@"is_first"];
//                break;
            default:
                break;
        }
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
