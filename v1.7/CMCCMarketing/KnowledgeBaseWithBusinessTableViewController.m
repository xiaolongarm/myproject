//
//  KnowledgeBaseWithBusinessTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-11-1.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "KnowledgeBaseWithBusinessTableViewController.h"
#import "KnowledgeBaseWithBusinessTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "UIButtonExt.h"

#import "KnowledgeBaseWithBusinessDetailsViewController.h"

@interface KnowledgeBaseWithBusinessTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *rootTypeArray;
    UIButtonExt *selectedButton;
    NSArray *detailsArray;
}

@end

@implementation KnowledgeBaseWithBusinessTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadNewDicsData];
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)loadNewDicsData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    //type  查询类型 1是大类  0是内容
    [bDict setObject:@"1" forKey:@"type"];
    
    [NetworkHandling sendPackageWithUrl:@"knowledge/bussList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            rootTypeArray =[result objectForKey:@"buss_result"];
            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
}
-(void)loadNewDicsDataWithType:(NSString*)type bussinessType:(int)bsType{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    //type  查询类型 1是大类  0是内容
    [bDict setObject:type forKey:@"type"];
    [bDict setObject:[NSNumber numberWithInt:bsType] forKey:@"buss_type_id"];
    
    [NetworkHandling sendPackageWithUrl:@"knowledge/bussList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            detailsArray =[result objectForKey:@"result"];
            [self performSelectorOnMainThread:@selector(goDetialView) withObject:nil waitUntilDone:YES];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
}

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)refreshTableView{
    [self.tableView reloadData];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(void)goDetialView{
    [self performSegueWithIdentifier:@"KnowledgeBaseWithBusinessDetailsSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [rootTypeArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict=[rootTypeArray objectAtIndex:section];
    NSArray *array=[dict objectForKey:@"list"];
    int count = [array count]/2;
    count=[array count]%2>0?count+1:count;
    return count;
    
}
// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 40;
//    }
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = nil;
    v = [[UIView alloc] initWithFrame:CGRectMake(0, -10, 320, 30)];
//    [v setBackgroundColor:[UIColor lightGrayColor]];
    [v setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]];
    //    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 200.0f, 20.0f)];
    UILabel *labelTitle = [[UILabel alloc] init];
//    if(section!=0)
//        labelTitle.frame=CGRectMake(10.0f, -5.0f, 200.0f, 30.0f);
//    else
        labelTitle.frame=CGRectMake(10.0f, 0.0f, 200.0f, 30.0f);
    
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    labelTitle.textAlignment = NSTextAlignmentLeft;
//    labelTitle.textColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0];
    labelTitle.textColor=[UIColor darkGrayColor];
    labelTitle.font=[UIFont systemFontOfSize:14];
    
    NSDictionary *dict=[rootTypeArray objectAtIndex:section];
    labelTitle.text=[dict objectForKey:@"buss_type"];
    
    [v addSubview:labelTitle];
    return v;
}

//{
//    attachment =     (
//                      {
//                          filename = "mold.doc";
//                          filesize = "1.85MB";
//                          uid = 1;
//                          url = "http://192.168.146.167:8080/kite/uploadImage/OrderBusiness/knowledge/buss/1/mold.doc";
//                          version = 20140816101011;
//                      },
//                      {
//                          filename = "mold.ppt";
//                          filesize = "1.39MB";
//                          uid = 2;
//                          url = "http://192.168.146.167:8080/kite/uploadImage/OrderBusiness/knowledge/buss/1/mold.ppt";
//                          version = 20140816101011;
//                      }
//                      );
//    "buss_title" = "\U624b\U673a\U5bf9\U8bb2";
//    "row_id" = 1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnowledgeBaseWithBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KnowledgeBaseWithBusinessTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dict=[rootTypeArray objectAtIndex:indexPath.section];
//    NSString *title=[dict objectForKey:@"buss_type"];
    NSArray *array=[dict objectForKey:@"list"];
    
    int count = [array count]/2;
    count=[array count]%2>0?count+1:count;
    
    int itemIndex1=indexPath.row*2;
    NSDictionary *itemDict1=[array objectAtIndex:itemIndex1];
    [cell.itemName1 setTitle:[itemDict1 objectForKey:@"buss_title"] forState:UIControlStateNormal];
    cell.itemName1.tag=[[itemDict1 objectForKey:@"row_id"] intValue];
    [cell.itemName1 addTarget:self action:@selector(goDetials:) forControlEvents:UIControlEventTouchUpInside];
    [(UIButtonExt*)cell.itemName1 setDict:itemDict1];
    
    int itemIndex2=indexPath.row*2+1;
    if(itemIndex2<[array count]){
        NSDictionary *itemDict2=[array objectAtIndex:itemIndex2];
        [cell.itemName2 setTitle:[itemDict2 objectForKey:@"buss_title"] forState:UIControlStateNormal];
        cell.itemName2.tag=[[itemDict2 objectForKey:@"row_id"] intValue];
        cell.itemName2.hidden=NO;
        [cell.itemName2 addTarget:self action:@selector(goDetials:) forControlEvents:UIControlEventTouchUpInside];
        [(UIButtonExt*)cell.itemName2 setDict:itemDict2];
    }
    else{
        cell.itemName2.hidden=YES;
    }
    
    return cell;
}

-(void)goDetials:(id)sender{
    selectedButton=sender;
    NSLog(@"tag:%d",selectedButton.tag);
    
    //buss_type_id
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    [self loadNewDicsDataWithType:@"0" bussinessType:selectedButton.tag];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"KnowledgeBaseWithBusinessDetailsSegue"]){
        KnowledgeBaseWithBusinessDetailsViewController *controller=segue.destinationViewController;
        controller.detailsDict=selectedButton.dict;
        controller.detailsArray=detailsArray;
        controller.user=self.user;
        controller.fromFlag=@"nothing";
    }
}


@end
