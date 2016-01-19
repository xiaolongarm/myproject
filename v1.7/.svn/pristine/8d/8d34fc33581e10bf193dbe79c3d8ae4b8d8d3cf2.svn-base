//
//  PreferentialPurchaseSelectDateTimeViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "PreferentialPurchaseSelectDateTimeViewController.h"

@interface PreferentialPurchaseSelectDateTimeViewController ()

@end

@implementation PreferentialPurchaseSelectDateTimeViewController

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
    // Do any additional setup after loading the view.
    
//    if (self.modeDateAndTime==0) {//0日期小时分
//        
//        self.datetimePicker.datePickerMode = UIDatePickerModeDateAndTime;
//    }
    
    switch (self.modeDateAndTime) {
        case 0:
            self.datetimePicker.datePickerMode=UIDatePickerModeDateAndTime;
            break;
        case 1:
            self.datetimePicker.datePickerMode=UIDatePickerModeDate;
            break;
        case 2:
            self.datetimePicker.datePickerMode=UIDatePickerModeTime;
            break;
        case 3:
            self.datetimePicker.datePickerMode=UIDatePickerModeCountDownTimer;
            break;
        default:
            self.datetimePicker.datePickerMode=UIDatePickerModeDate;
            break;
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    switch (self.modeDateAndTime) {
        case 0:
            self.datetimePicker.datePickerMode=UIDatePickerModeDateAndTime;
            break;
        case 1:
            self.datetimePicker.datePickerMode=UIDatePickerModeDate;
            break;
        case 2:
            self.datetimePicker.datePickerMode=UIDatePickerModeTime;
            break;
        case 3:
            self.datetimePicker.datePickerMode=UIDatePickerModeCountDownTimer;
            break;
        default:
            self.datetimePicker.datePickerMode=UIDatePickerModeDate;
            break;
    }
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
- (IBAction)cancelOnclick:(id)sender {
    [self.delegate preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}
- (IBAction)determineOnclick:(id)sender {
    [self.delegate preferentialPurchaseSelectDateTimeViewControllerDidFinished:self];
}


@end
