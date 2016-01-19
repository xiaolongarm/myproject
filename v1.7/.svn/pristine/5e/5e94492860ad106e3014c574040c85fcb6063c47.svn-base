//
//  CustomerManagerContactsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "CustomerManagerContactsTableViewCell.h"
#import "CustomerManagerContactsViewController.h"
#import "CheckLittleGrounpViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface CustomerManagerContactsViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSDictionary *passDict;
    NSMutableArray *tableArray;
}

@end

@implementation CustomerManagerContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    contactsTableView.delegate=self;
    contactsTableView.dataSource=self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 44;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (tableArray==nil) {
//    
//        return  @"暂无联系人！";
//    }
//    else{    return nil;}
//
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerManagerContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerManagerContactsTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
        NSString *linkman = nil;
    NSString *linkman_msisdn = nil;
    int sex = -1;
    if (self.listType == 0) {
        linkman=[dict objectForKey:@"linkman"];
        linkman_msisdn=[dict objectForKey:@"linkman_msisdn"];
        sex=[[dict objectForKey:@"linkman_sex"] intValue];
    }
    else if (self.listType == 1) {
        linkman=[dict objectForKey:@"boss_name"];
        linkman_msisdn=[dict objectForKey:@"boss_msisdn"];
        sex=[[dict objectForKey:@"boss_sex"] intValue];
    }
    //中小集团
    else if (self.listType == 2) {
        linkman=[dict objectForKey:@"key_name"];
        linkman_msisdn=[dict objectForKey:@"key_mobile"];
        #if (defined MANAGER_CS_VERSION)
        if ([[dict objectForKey:@"state"] isEqualToString:@"0"]) {
           cell.wheterCheck.text=@"待审核";
        }
        #endif
        //sex=[[dict objectForKey:@"boss_sex"] intValue];
    }
    if(!linkman || (NSNull*)linkman == [NSNull null])
        linkman = @"-";
//    NSString *linkman_msisdn=[dict objectForKey:@"linkman_msisdn"];
    if(!linkman_msisdn || (NSNull*)linkman_msisdn == [NSNull null])
        linkman_msisdn = @"-";
    
    cell.itemName.text=linkman;
    cell.itemPhone.text=linkman_msisdn;
    
    if(sex==1){
        cell.itemImageView.image=[UIImage imageNamed:@"m-icon"];
    }
    else if(sex==2){
        cell.itemImageView.image=[UIImage imageNamed:@"f-icon"];
    }
    
    NSString *imageUrl=[dict objectForKey:@"userimg"];
    if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
        NSURL *url = [NSURL URLWithString:imageUrl];
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        dispatch_async(queue, ^{
            
            NSData *resultData = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:resultData];
            if(img){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    cell.itemImageView.image = img;
                });
            }
        });
    }

    
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
      passDict=dict;
//    if (self.listType==2) {
////        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CustomerManager" bundle:nil];
////        // 2.创建要显示的控制器或者导航栏控制器填入UIStoryboard的ID
////        UINavigationController *controller=[sb instantiateViewControllerWithIdentifier:@"CustomerManagerViewControllerId"];
////        // 3.弹出控制器 (传递参数需将UINavigationController和viewControllers关系在storyboard设置为relateionship)
////        CheckLittleGrounpViewController * CheckLittleGrounp = [controller.viewControllers objectAtIndex:0];
////        CheckLittleGrounp.user=self.user;
////        CheckLittleGrounp.listType = self.listType;
////        CheckLittleGrounp.whichtype=@"man";
////        CheckLittleGrounp.msgDict=passDict;
////       // [self.navigationController pushViewController:CheckLittleGrounp animated:YES];
////        [self presentViewController:CheckLittleGrounp animated:YES completion:nil];
//        CheckLittleGrounpViewController *controller= [[CheckLittleGrounpViewController alloc]init];
//        controller.user=self.user;
//        [self presentViewController:controller animated:YES completion:nil];
//        //[self.navigationController pushViewController:controller animated:YES];
//        
//    } else {
[self.delegate customerManagerContactsViewControllerDidfinished:dict];
    //}
    
}

-(void)refreshTableView{
    tableArray = [[NSMutableArray alloc] initWithArray:self.userList];
    [contactsTableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    if (self.listType==2) {
        [self DelectLittleGrounpContact:dict];
        
    } else {
        [self deleteContact:dict];
    }
    
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//
//if([segue.identifier isEqualToString:@"checkLittleGrounp"]){
//    CustomerManagerGroupContactVerifyViewController *controler=segue.destinationViewController;
//    controler.user=self.user;
//    controler.listType = self.listType;
//    controler.whichtype=@"man";
//    controler.msgDict=passDict;
//}

//}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    int row_id = [[dict objectForKey:@"row_id"] intValue];
    if(row_id == -999)
        return UITableViewCellEditingStyleNone;
    return UITableViewCellEditingStyleDelete;
}

-(void)DelectLittleGrounpContact:(NSDictionary*)dict{
    /**
     删除中小集团关键人
     接口：changsha\v1_7\msgrpuserlink\delmsUserInfo
     必传参数
     row_id 行号
     返回参数
     flag true/false
     */
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    int row_id = [[dict objectForKey:@"row_id"] intValue];
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:row_id] forKey:@"row_id"];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
//    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
//    
    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/delmsUserInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                [self performSelectorOnMainThread:@selector(submitSuccess:) withObject:dict waitUntilDone:YES];
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"删除联系人失败！" waitUntilDone:YES];
            }
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
-(void)deleteContact:(NSDictionary*)dict{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

    int row_id = [[dict objectForKey:@"row_id"] intValue];
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:row_id] forKey:@"row_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/delUserInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                [self performSelectorOnMainThread:@selector(submitSuccess:) withObject:dict waitUntilDone:YES];
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"删除联系人失败！" waitUntilDone:YES];
            }
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
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)submitSuccess:(NSDictionary*)dict{
    [tableArray removeObject:dict];
    [contactsTableView reloadData];
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}

@end
