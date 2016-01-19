//
//  DataAcquisitionVisitedDetailsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "DataAcquisitionVisitedDetailsViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "PreferentialPurchaseSelectGroupViewController.h"
#import "Group.h"

@interface DataAcquisitionVisitedDetailsViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,PreferentialPurchaseSelectGroupViewControllerDelegate,MBProgressHUDDelegate,UITextFieldDelegate>{
    BOOL hubFlag;
    
    NSString *kUTTypeImage;
    
    PreferentialPurchaseSelectGroupViewController *filterController;
    UIView *backView;
    Group *selectedGroup;
    UIButton *selectedGroupButton;
}

@end

@implementation DataAcquisitionVisitedDetailsViewController

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
    
     kUTTypeImage=@"public.image";
    
    txtFeeType.delegate=self;
    txtProject.delegate=self;
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
}
-(void)submitData{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self postData];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
//{
//    "grp_code":集团编码
//    "grp_name":集团名称
//    "project":项目
//    "fee_type":费用类型
//    "user_id":用户ID   [必传参数]
//    "user_name":申请人姓名
//    "user_msisdn":申请人电话号码
//    "enterprise":申请人企业编码
//    "img_url":图片名
//}
//}

-(void)postData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userName forKey:@"user_name"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    if(selectedGroup){
        [bDict setObject:selectedGroup.groupId forKey:@"grp_code"];
        [bDict setObject:selectedGroup.groupName forKey:@"grp_name"];
    }
    [bDict setObject:txtProject.text forKey:@"project"];
    [bDict setObject:txtFeeType.text forKey:@"fee_type"];
    
    [bDict setObject:@"" forKey:@"img_url"];
    
    [NetworkHandling sendPackageWithUrl:@"datacollect/visitplan" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSDictionary *dict=[result objectForKey:@"Response"];
            BOOL flag=[[dict objectForKey:@"returnFlag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交信息成功！" waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交信息失败！" waitUntilDone:YES];
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

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goCameral:(id)sender {
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    
    //创建图像选取控制器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
        NSLog(@"picture saved with no error.");
    }
    else
    {
        NSLog(@"error occured while saving the picture%@", error);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    imgPic.image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectGroup:(id)sender {
    selectedGroupButton=sender;
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    filterController=[storyboard instantiateViewControllerWithIdentifier:@"MarketingGroupUserFilterViewControllerId"];
    filterController.delegate=self;
    filterController.user=self.user;
    filterController.group=selectedGroup;
    CGRect rect=filterController.view.frame;
    
    rect.origin.x=10;
    rect.origin.y=80;
    rect.size.width=300;
    rect.size.height=340;
    
    filterController.view.frame=rect;
    filterController.view.layer.borderWidth=1;
    filterController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
    filterController.view.layer.shadowOffset = CGSizeMake(2, 2);
    filterController.view.layer.shadowOpacity = 0.80;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[self.view superview]addSubview:backView];
    //    [self.view addSubview:backView];
    
    //    [self.view addSubview:filterController.view];
    [[self.view superview]addSubview:filterController.view];
}
-(void)preferentialPurchaseSelectGroupViewControllerDidCanceled{
    [backView removeFromSuperview];
    [filterController.view removeFromSuperview];
    
    backView=nil;
    filterController=nil;
}
-(void)preferentialPurchaseSelectGroupViewControllerDidFinished:(PreferentialPurchaseSelectGroupViewController *)controller{
    selectedGroup=controller.group;
    //    [greaterViewController.btGroupName setTitle:controller.group.groupName forState:UIControlStateNormal];
    //    greaterViewController.txtGroupId.text=selectedGroup.groupId;
    //    greaterViewController.txtGroupNo.text=[NSString stringWithFormat:@"%.0f",selectedGroup.groupserviceCode];
    
    [selectedGroupButton setTitle:selectedGroup.groupName forState:UIControlStateNormal];
    [self preferentialPurchaseSelectGroupViewControllerDidCanceled];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
