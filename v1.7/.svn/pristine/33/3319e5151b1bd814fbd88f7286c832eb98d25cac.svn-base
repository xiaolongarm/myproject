//
//  PreferentialPurchaseTabbarController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "PreferentialPurchaseViewController.h"
#import "PreferentialPurchaseTabbarController.h"

@interface PreferentialPurchaseTabbarController ()

@end

@implementation PreferentialPurchaseTabbarController

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
    self.delegate=self;
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"发件箱" style:UIBarButtonItemStylePlain target:self action:@selector(goSendBox)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    self.tabBar.tintColor=[UIColor whiteColor];

}
-(void)goSendBox{
    [self performSegueWithIdentifier:@"PreferentialPurchaseSendBoxSegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if(tabBarController.selectedIndex == 0){
        PreferentialPurchaseViewController *ppViewController=(PreferentialPurchaseViewController*)viewController;
        if(ppViewController.recordButtonConstraint.constant < 11){
            [ppViewController.recordButtonConstraint setConstant:54];
            [ppViewController.sendBoxButtonConstraint setConstant:54];
        }
    }
}

//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    NSLog(@"seleted item");
//}
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
