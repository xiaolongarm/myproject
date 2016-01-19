//
//  DataAcquisitionWithGroupInformationViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-2-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DataAcquisitionWithGroupInformationViewController.h"
#import "DataAcquisitionWithGroupInformationViewController+formDescriptionUsingDelegates.h"
#import "JMFormListSelectionTableViewController.h"
#import "JMFormDescriptions.h"
#import "DataAcquisitionWithGroupInformationFormModel.h"

@interface DataAcquisitionWithGroupInformationViewController ()
@property (weak, nonatomic) IBOutlet JMFormScrollView *formScrollView;
@property (strong, nonatomic) DataAcquisitionWithGroupInformationFormModel *formModel;
@property (strong, nonatomic) JMFormDescription *formDescription;
@end

@implementation DataAcquisitionWithGroupInformationViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Complete your model
    self.formModel = [DataAcquisitionWithGroupInformationFormModel new];
    self.formModel.coloChoices = @[@"blue",@"red", @"grey"];
//    self.formModel.listPlaceholder = @"choose a color";
//    self.formModel.textfieldText1 = @"test";
    
    self.title = @"集团信息采集";
    self.formScrollView.formViewSpace = 1.0f;

    UIBarButtonItem *rightyButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(goPost)];
    [rightyButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightyButton];
}
-(void)goPost{

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //generate Layout description
    self.formDescription = [self generateFormDescriptionUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}
- (void)reloadContent
{
    self.formDescription = [self generateFormDescriptionUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

#pragma mark - Keyboard ...

- (BOOL)nextFormViewAvailableAfterFormView:(JMFormView *)formView
{
    JMFormView *nextForm = [self.formScrollView nextFirstResponderFormViewFromView:formView];
    return nextForm!=nil;
}

- (BOOL)previousFormViewAvailableBeforeFormView:(JMFormView *)formView
{
    JMFormView *previousForm = [self.formScrollView previousFirstResponderFormViewFromView:formView];
    return previousForm!=nil;
}

- (void)presentNextFormViewAvailableAfterFormView:(JMFormView *)formView
{
    JMFormView *nextForm = [self.formScrollView nextFirstResponderFormViewFromView:formView];
    [nextForm formViewBecomeFirstResponder];
}

- (void)presentPreviousFormViewAvailableBeforeFormView:(JMFormView *)formView
{
    JMFormView *previousForm = [self.formScrollView previousFirstResponderFormViewFromView:formView];
    [previousForm formViewBecomeFirstResponder];
}

#pragma mark - JMListFormView delegate full demos

- (void)listPressedFromFormView:(JMListFormView *)formView withSelectedValue:(NSString *)value
{
    NSLog(@"%@ listPressedFromCell Pressed to %@",formView,value);
    NSInteger index = [self.formScrollView indexForFormView:formView];
    [self.view endEditing:NO];
    
    JMFormListSelectionTableViewController *listVc = [JMFormListSelectionTableViewController new];
    JMListFormViewDescription *desc = [self.formDescription.formViewDescriptions objectAtIndex:index];
    listVc.values = desc.choices;
    listVc.formDelegate = self;
    listVc.modelKey = desc.modelKey;
    listVc.title = desc.title;
    
    if (formView.listStyle == JMListFormViewModalChoice) {
        UINavigationController *nacV = [[UINavigationController alloc] initWithRootViewController:listVc];
        [self presentViewController:nacV animated:YES completion:NULL];
    } else {
        [self.navigationController pushViewController:listVc animated:YES];
    }
}

- (void)dismissWithChoice:(id)currentChoice forModelKey:(NSString *)modelKey
{
    [self.view endEditing:NO];
    [self.formModel setValue:currentChoice forKeyPath:modelKey];
//    [self reloadContent];
    [self dismissViewControllerAnimated:YES completion:^{
        [self reloadContent];
    }];
    
}

//- (void)presentListChoices:(NSArray *)choices forModelKey:(NSString *)modelKey currentChoice:(id)currentChoice
//{
//    JMFormListSelectionTableViewController *listVc = [JMFormListSelectionTableViewController new];
//    listVc.values = choices;
//    listVc.formDelegate = self;
//    listVc.modelKey = modelKey;
//    //listVc.title = title;
//    UINavigationController *nacV = [[UINavigationController alloc] initWithRootViewController:listVc];
//    [self presentViewController:nacV animated:YES completion:NULL];
//}
//
//- (void)pushListChoices:(NSArray *)choices forModelKey:(NSString *)modelKey currentChoice:(id)currentChoice
//{
//    JMFormListSelectionTableViewController *listVc = [JMFormListSelectionTableViewController new];
//    listVc.values = choices;
//    listVc.formDelegate = self;
//    listVc.modelKey = modelKey;
//    [self.navigationController pushViewController:listVc animated:YES];
//}

//- (void)popWithChoice:(id)currentChoice forModelKey:(NSString *)modelKey
//{
//    [self.formModel setValue:currentChoice forKeyPath:modelKey];
//    [self reloadContent];
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
