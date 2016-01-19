//
//  JMFormListSelectionTableViewController.m
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormListSelectionTableViewController.h"

@interface JMFormListSelectionTableViewController ()

@end

@implementation JMFormListSelectionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
    cell.textLabel.text = [self.values objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedValue = [self.values objectAtIndex:indexPath.row];
    if (self.presentingViewController) {
        if ([self.formDelegate respondsToSelector:@selector(dismissWithChoice:forModelKey:)]) {
            [self.formDelegate dismissWithChoice:selectedValue forModelKey:self.modelKey];
//            [self.navigationController popViewControllerAnimated:YES];
        } else if (self.completionBlock) {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
                self.completionBlock(selectedValue);
            }];
        }
    } else {
        if ([self.formDelegate respondsToSelector:@selector(popWithChoice:forModelKey:)]) {
            [self.formDelegate popWithChoice:selectedValue forModelKey:self.modelKey];
        } else if (self.completionBlock) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            self.completionBlock(selectedValue);
        }
    }
}

@end
