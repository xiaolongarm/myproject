//
//  ManagerMonthlyTasksCreatorTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-1-12.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ManagerMonthlyTasksCreatorTableViewController.h"
#import "ManagerMonthlyTasksCreatorTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface ManagerMonthlyTasksCreatorTableViewController ()<MBProgressHUDDelegate,UITextFieldDelegate>{
    BOOL hubFlag;
    UITextField *txtField;
    NSMutableArray *tableArray;
}

@end

@implementation ManagerMonthlyTasksCreatorTableViewController

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
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(goPost)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    tableArray=[[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.currentMonthArray) {
        NSMutableDictionary *tmp=[[NSMutableDictionary alloc] initWithDictionary:dict];
        [tableArray addObject:tmp];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    ManagerMonthlyTasksCreatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManagerMonthlyTasksCreatorTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    NSDictionary *lastDict=[self.lastMonthArray objectAtIndex:indexPath.row];
    
//    cell.itemIndex.text=[NSString stringWithFormat:@"%d",[[dict objectForKey:@"rank"] intValue]];
    cell.itemName.text=[dict objectForKey:@"name"];
    cell.itemUnit.text=[dict objectForKey:@"unit"];
    cell.itemBeforeQuantity.text=[NSString stringWithFormat:@"%d",[[lastDict objectForKey:@"finish"] intValue]];
    cell.itemQuantity.text=[NSString stringWithFormat:@"%d",[[dict objectForKey:@"target"] intValue]];
    cell.itemQuantity.delegate=self;
    cell.itemQuantity.tag=indexPath.row;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)goPost{
//    dispatch_async(dispatch_get_main_queue(), ^{
    if(txtField)
        [txtField resignFirstResponder];
//    });
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(postData) onTarget:self withObject:nil animated:YES];
 
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(void)postData{
//enterprise: 2
//taskCNT: "13,25,30,25"
//taskDate: "2015-02"
//typeID: 3
//userID: 2
//vip_mngr_id: "3,4,5,57"
    

    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    
    NSDate *dt=[dateFormatter dateFromString:self.title];

    NSDateFormatter *dateFormatter1=[[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM"];
    NSString *dtString=[dateFormatter1 stringFromDate:dt];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:dtString forKey:@"taskDate"];
    [bDict setObject:[NSNumber numberWithInt:self.typeId] forKey:@"typeID"];
    
    NSString *cnt=@"";
    NSString *mngr=@"";
    for (NSDictionary *dict in tableArray) {
        if(cnt.length)
            cnt=[cnt stringByAppendingFormat:@",%d",[[dict objectForKey:@"target"] intValue]];
        else
            cnt=[NSString stringWithFormat:@"%d",[[dict objectForKey:@"target"] intValue]];
        if(mngr.length)
            mngr=[mngr stringByAppendingFormat:@",%d",[[dict objectForKey:@"uid"] intValue]];
        else
            mngr=[NSString stringWithFormat:@"%d",[[dict objectForKey:@"uid"] intValue]];
    }

    [bDict setObject:mngr forKey:@"vip_mngr_id"];
    [bDict setObject:cnt forKey:@"taskCNT"];
    
    
    [NetworkHandling sendPackageWithUrl:@"monthlyplay/CreateMonthlyPlay" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        NSDictionary *dict=[result objectForKey:@"Response"];
        BOOL flag=[[dict objectForKey:@"returnFlag"] boolValue];
        if(!error&&flag){
            NSLog(@"sign in success");
//            timesArray =[result objectForKey:@"times"];
//            nextMonthArray =[result objectForKey:@"nextMonth"];
//            currentMonthArray =[result objectForKey:@"currentMonth"];
            [self performSelectorOnMainThread:@selector(goBack) withObject:nil waitUntilDone:YES];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    txtField=textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(!textField.text.length)
        return;
    int target=[textField.text intValue];
    NSMutableDictionary *dict=[tableArray objectAtIndex:textField.tag];
    [dict setObject:[NSNumber numberWithInt:target] forKey:@"target"];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
