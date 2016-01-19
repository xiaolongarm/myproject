//
//  SettingHelpTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-3-9.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "SettingHelpTableViewController.h"
#import "SettingHelpTableViewCell.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "NSString+Ext.h"
//屏幕的宽、高
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SettingHelpTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
}

@end

@implementation SettingHelpTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"SettingHelpTableViewCell"];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self loadHelpData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tableArray count];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    NSString *titleStr =  [NSString stringWithFormat:@"Q:%@",[[tableArray objectAtIndex:section] objectForKey:@"question"]];
    UILabel *headerSectionView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    headerSectionView.numberOfLines=0;
    headerSectionView.textColor=[UIColor colorWithRed:102.0/255 green:188.0/255 blue:230.0/255 alpha:1];
    headerSectionView.backgroundColor=[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1];
    headerSectionView.text=titleStr;
    [headerSectionView sizeToFit];
    return headerSectionView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
//
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSString *titleStr =  [NSString stringWithFormat:@"Q:%@",[[tableArray objectAtIndex:section] objectForKey:@"question"]];
    UILabel *headerSectionView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    headerSectionView.text = titleStr;
    
    CGSize title = [titleStr calculateSize:CGSizeMake(headerSectionView.frame.size.width, FLT_MAX) font:headerSectionView.font];
    return title.height;
    //return 44;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingHelpTableViewCell *cell = (SettingHelpTableViewCell *)self.prototypeCell;
    
    NSString *contentStr =  [NSString stringWithFormat:@"A:%@", [[tableArray objectAtIndex:indexPath.section] objectForKey:@"answer"]];
    cell.itemConten.text = contentStr;
    CGSize content = [contentStr calculateSize:CGSizeMake(cell.itemConten.frame.size.width, FLT_MAX) font:cell.itemConten.font];
    
    CGFloat totalHeight=content.height;
    
    CGFloat defaultHeight = cell.contentView.frame.size.height;
    
    
    CGFloat height = totalHeight > defaultHeight ? totalHeight : defaultHeight;
    NSLog(@"h=%f", height);
    return 2+ height;
    }

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
       return 66;
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellWithIdentifier = @"SettingHelpTableViewCell";
    SettingHelpTableViewCell *cell = [self.tableView  dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    cell.itemConten.text =[NSString stringWithFormat:@"A:%@", [[tableArray objectAtIndex:indexPath.section] objectForKey:@"answer"]];
    
    [cell.itemConten sizeToFit];
    return cell;
    
}

-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)loadHelpData{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

    
//    NSString *oldpass=[Base64codeFunc md5:txtPassword.text];
//    NSString *newpass=[Base64codeFunc md5:txtNewPassword.text];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userid"];
//    [bDict setObject:oldpass forKey:@"old_password"];
//    [bDict setObject:newpass forKey:@"new_password"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    //    [bDict setObject:txtFeedbackContent.text forKey:@"content"];
    
    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/help/helplist" sendBody:bDict sendWithPostType:2 processHandler:^(NSDictionary *result, NSError *error) {
//      [NetworkHandling sendPackageWithUrl:@"help/helplist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        if(!error){
            NSLog(@"sign in success");
            
            tableArray=[result objectForKey:@"help"];
            
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
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)refreshTableView{
    [self.tableView reloadData];
}
@end
