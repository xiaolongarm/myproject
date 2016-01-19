//
//  PreferentialPurchaseCustomerInformationViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-17.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "PreferentialPurchaseCustomerInformationViewController.h"

@interface PreferentialPurchaseCustomerInformationViewController ()<UITextFieldDelegate>{
//    UIButton *doneButton;
//    BOOL isShowDoneButton;
}

@end

@implementation PreferentialPurchaseCustomerInformationViewController

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
    
    UILongPressGestureRecognizer *longpressGesutre1=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongpressGesture1:)];
    UILongPressGestureRecognizer *longpressGesutre2=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongpressGesture2:)];
    
//    UIImageView *userImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"三角（灰色）"]];
//    self.txtGroupName.rightViewMode=UITextFieldViewModeAlways;
//    self.txtGroupName.rightView=userImageView;
    
//    [self.txtGroupName setDelegate:self];
    [self.txtCustomerName setDelegate:self];
    [self.txtCustomerPhone setDelegate:self];
    [self.txtIDCard setDelegate:self];
//    [self.txtPassword setDelegate:self];
//    [self.txtPasswordRetry setDelegate:self];
    
    [self.imgIdCard1 addGestureRecognizer:longpressGesutre1];
    [self.imgIdCard2 addGestureRecognizer:longpressGesutre2];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardDidShowNotification
//                                               object:nil];
//    isShowDoneButton=NO;
}
//- (void)keyboardWillShow:(NSNotification *)note {
//    if(!isShowDoneButton)
//        return;
//    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    doneButton.frame = CGRectMake(0, 163, 106, 53);
//    doneButton.adjustsImageWhenHighlighted = NO;
//    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
//    [doneButton setBackgroundColor:[UIColor blueColor]];
//    
////    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
////    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
//    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
//    UIView *keyboard;
//    for(int i = 0; i < [tempWindow.subviews count]; i++) {
//        keyboard = [tempWindow.subviews objectAtIndex:i];
//        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) || ([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES))
//            [keyboard addSubview:doneButton];
//    }
//}
//
//- (void)doneButton:(id)sender {
//    [self.txtCustomerPhone resignFirstResponder];
//    [self.txtIDCard resignFirstResponder];
//}
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

- (IBAction)goCamera:(id)sender {
    [self.delegate goCamera];
}
-(void)handleLongpressGesture1:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        [self.delegate deleteIDCard1];
    }
}
-(void)handleLongpressGesture2:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        [self.delegate deleteIDCard2];
    }
}
//-(void)handleSingleTap:(UITapGestureRecognizer*)gestureRecognizer{
//    [self.delegate selectGroup];
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    if(textField.tag==10){
//        [textField resignFirstResponder];
//        [self.delegate selectGroup];
//    }
//    if(textField.tag==12 || textField.tag==13){
//        isShowDoneButton=YES;
//    }
    if(IS_IPHONE4 && textField.tag > 11){
        [self.delegate beginEdit];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if(doneButton){
//        [doneButton removeFromSuperview];
//        doneButton=nil;
//    }
    if(IS_IPHONE4 && textField.tag > 11){
        [self.delegate endEdit];
    }
}
- (IBAction)selectGroupOnclick:(id)sender {
    [self.delegate selectGroup];
}


@end
