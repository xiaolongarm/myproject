//
//  CustomerManagerContactsEditSubViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomerManagerContactsEditSubViewController.h"

@interface CustomerManagerContactsEditSubViewController (){
//    NSString *kUTTypeImage;
}

@end

@implementation CustomerManagerContactsEditSubViewController

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
    
    self.txtName.delegate=self;
    self.txtPhone.delegate=self;
    self.txtOtherPhone.delegate=self;
    self.txtOtherContact.delegate=self;
    self.txtDepart.delegate=self;
    self.txtGroup.delegate=self;
    self.txtJob.delegate=self;
    if (self.listType == 1) {
        [self performSelector:@selector(startLoad:) withObject:nil afterDelay:0];
    }
    
}

-(void)startLoad:(NSDictionary*)dict{
    self.labelTitle1.text = @"BOSS工号 ：";
    self.labelTitle7.hidden = YES;
    self.labelTitle2.hidden = YES;
    self.labelTitle4.hidden = YES;
    self.swIsFirst.hidden = YES;
    self.image4.hidden = YES;
    self.txtJob.hidden = YES;
    self.btType.hidden = YES;
//    self.labelTitle3.frame = CGRectMake(self.labelTitle3.frame.origin.x,self.labelTitle2.frame.origin.y + 13,self.labelTitle3.frame.size.width,self.labelTitle3.frame.size.height);
//    self.btBirthday.frame = CGRectMake(self.btBirthday.frame.origin.x,self.labelTitle3.frame.origin.y - 7  ,self.btBirthday.frame.size.width,self.btBirthday.frame.size.height);
//    self.image3.frame = CGRectMake(self.image3.frame.origin.x,self.btBirthday.frame.origin.y + self.btBirthday.frame.size.height/4,self.image3.frame.size.width,self.image3.frame.size.height);
    
    self.labelTitle5.frame = CGRectMake(self.labelTitle5.frame.origin.x,self.labelTitle5.frame.origin.y - 10,self.labelTitle5.frame.size.width,self.labelTitle5.frame.size.height);
    self.swIsDiffKey.frame = CGRectMake(self.swIsDiffKey.frame.origin.x,self.swIsDiffKey.frame.origin.y - 10,self.swIsDiffKey.frame.size.width,self.swIsDiffKey.frame.size.height);
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

-(void)setEditData{
    if (self.listType == 0) {
        self.txtName.text=[self.contactsDict objectForKey:@"linkman"];
        int sex=[[self.contactsDict objectForKey:@"linkman_sex"] intValue];
        if(sex==1)
            self.swSex.on=YES;
        else
            self.swSex.on=NO;
        
        self.txtPhone.text=[self.contactsDict objectForKey:@"linkman_msisdn"];
        self.txtOtherPhone.text=[self.contactsDict objectForKey:@"linkman_tel"];
        self.txtOtherContact.text=[self.contactsDict objectForKey:@"linkman_tel_bak"];
        self.txtDepart.text=[self.contactsDict objectForKey:@"depart"];
        self.txtJob.text=[self.contactsDict objectForKey:@"job"];
        [self.btBirthday setTitle:[self.contactsDict objectForKey:@"linkman_birthday"] forState:UIControlStateNormal];
        [self.btType setTitle:[self.contactsDict objectForKey:@"key_type"] forState:UIControlStateNormal];
        self.swIsDiffKey.on=[[self.contactsDict objectForKey:@"is_diff_key"] isEqualToString:@"是"]?YES:NO;
        [self.btOperators setTitle:[self.contactsDict objectForKey:@"chinamobile"] forState:UIControlStateNormal];
        self.btOperators.titleLabel.text=[self.contactsDict objectForKey:@"chinamobile"];
        self.swIsFirst.on=[[self.contactsDict objectForKey:@"is_first"] isEqualToString:@"是"]?YES:NO;
        BOOL is_birthday_remind = [[self.contactsDict objectForKey:@"is_birthday_remind"] boolValue];
        self.swBirthdayRemind.on = is_birthday_remind;
        [self setRemark:[self.contactsDict objectForKey:@"remark"]];
        
        NSString *imageUrl=[self.contactsDict objectForKey:@"userimg"];
        if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
            NSURL *url = [NSURL URLWithString:imageUrl];
            dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
            dispatch_async(queue, ^{
                
                NSData *resultData = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:resultData];
                if(img){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        self.userImageView.image = img;
                    });
                }
            });
        }
    }
    else if(self.listType == 1){
        self.txtName.text=[self.contactsDict objectForKey:@"boss_name"];
        int sex=[[self.contactsDict objectForKey:@"boss_sex"] intValue];
        if(sex==1)
            self.swSex.on=YES;
        else
            self.swSex.on=NO;
        
        self.txtPhone.text=[self.contactsDict objectForKey:@"boss_msisdn"];
        self.txtOtherPhone.text=[self.contactsDict objectForKey:@"boss_tel"];
        self.txtOtherContact.text=[self.contactsDict objectForKey:@"boss_tel_bak"];
        self.txtDepart.text=[self.contactsDict objectForKey:@"boss_card"];
//        self.txtJob.text=[self.contactsDict objectForKey:@"job"];
        [self.btBirthday setTitle:[self.contactsDict objectForKey:@"boss_birthday"] forState:UIControlStateNormal];
//        [self.btType setTitle:[self.contactsDict objectForKey:@"key_type"] forState:UIControlStateNormal];
        self.swIsDiffKey.on=[[self.contactsDict objectForKey:@"is_diff_key"] isEqualToString:@"是"]?YES:NO;
        [self.btOperators setTitle:[self.contactsDict objectForKey:@"chinamobile"] forState:UIControlStateNormal];
        self.btOperators.titleLabel.text=[self.contactsDict objectForKey:@"chinamobile"];
        self.swIsFirst.on=[[self.contactsDict objectForKey:@"is_first"] isEqualToString:@"是"]?YES:NO;
        BOOL is_birthday_remind = [[self.contactsDict objectForKey:@"is_birthday_remind"] boolValue];
        self.swBirthdayRemind.on = is_birthday_remind;
        [self setRemark:[self.contactsDict objectForKey:@"remark"]];
        
        NSString *imageUrl=[self.contactsDict objectForKey:@"userimg"];
        if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
            NSURL *url = [NSURL URLWithString:imageUrl];
            dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
            dispatch_async(queue, ^{
                
                NSData *resultData = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:resultData];
                if(img){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        self.userImageView.image = img;
                    });
                }
            });
        }
    }
    
}

-(void)setRemark:(NSString*)remark{
    NSArray *remarkArray=[remark componentsSeparatedByString:@","];
    for (NSString *string in remarkArray) {
        if([string isEqualToString:@"一卡双号用户"]){
            self.bt1c2n.selected=YES;
        }
        if([string isEqualToString:@"多移动号码用户"]){
            self.btMultipleNumber.selected=YES;
        }
        if([string isEqualToString:@"联通双枪用户"]){
            self.btUnicom2n.selected=YES;
        }
        if([string isEqualToString:@"电信双枪用户"]){
            self.btTeleCom2n.selected=YES;
        }
        if([string isEqualToString:@"三枪用户"]){
            self.bt3n.selected=YES;
        }
    }
    
}
//if(subviewController.bt1c2n.selected)
//remark=[remark stringByAppendingString:@"一卡双号用户"];
//if(subviewController.btMultipleNumber.selected)
//remark=[remark stringByAppendingString:@",多移动号码用户"];
//if(subviewController.btUnicom2n.selected)
//remark=[remark stringByAppendingString:@",联通双枪用户"];
//if(subviewController.btTeleCom2n.selected)
//remark=[remark stringByAppendingString:@",电信双枪用户"];
//if(subviewController.bt3n.selected)
//remark=[remark stringByAppendingString:@",三枪用户"];

//决策关键人
//业务关键人
//联系关键人

- (IBAction)btTypeOnclick:(id)sender {
    [self.delegate selectType:sender];
}

- (IBAction)btOperatorsOnclick:(id)sender {
    [self.delegate selectOperators:sender];
}
- (IBAction)btBirthdayOnclick:(id)sender {
    [self.delegate selectDate:sender];
}

- (IBAction)bt1c2nOnclick:(id)sender {
    if(self.bt1c2n.selected)
        self.bt1c2n.selected=NO;
    else
        self.bt1c2n.selected=YES;
}
- (IBAction)btMultipleNumberOnclick:(id)sender {
    self.btMultipleNumber.selected=!self.btMultipleNumber.selected;
}
- (IBAction)btUnicom2nOnclick:(id)sender {
    self.btUnicom2n.selected=!self.btUnicom2n.selected;
}
- (IBAction)btTeleCom2nOnclick:(id)sender {
    self.btTeleCom2n.selected=!self.btTeleCom2n.selected;
}
- (IBAction)bt3nOnclick:(id)sender {
    self.bt3n.selected=!self.bt3n.selected;
//    self.bt3nImageView.image=self.bt3n.selected?[UIImage imageNamed:@"勾选"]:[UIImage imageNamed:@"未勾选"];
}
- (IBAction)btnCameraOnClick:(id)sender {
    [self.delegate goCamera];
}
@end
