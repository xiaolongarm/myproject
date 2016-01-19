//
//  W_VisitPlanAddSelectGroupContactUserViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15/7/2.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "W_VisitPlanAddSelectGroupContactUserViewController.h"

@interface W_VisitPlanAddSelectGroupContactUserViewController ()<UISearchBarDelegate,UITextFieldDelegate>{
    UISearchBar *searchbar;
    NSArray *fullArray;
}

@end

@implementation W_VisitPlanAddSelectGroupContactUserViewController

#pragma mark - notification handler

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    CGRect rctViewSendBg = self.view.frame;
    rctViewSendBg.origin.y += yOffset;
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = rctViewSendBg;
    }];
}

- (void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self refreshSelectButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    tableview.delegate=self;
    tableview.dataSource=self;
    
    txtPhone.delegate=self;
    txtUser.delegate=self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self initSubView];
}

- (void)initSubView{
    
    self.navigationItem.title = @"选择联系人";
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"查询按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    CGRect rect=self.view.frame;
    //CGRect rect=[UIScreen mainScreen].bounds.size.width;
    rect.size.height=44;
    rect.size.width=320;
    //    rect.origin.y=;
    //    rect.origin.x=0;
    rect.origin=CGPointZero;
    searchbar=[[UISearchBar alloc] init];
    searchbar.placeholder=@"请输入关键字查询";
    searchbar.frame=rect;
    searchbar.delegate=self;
    [self.view addSubview:searchbar];
    
    searchbar.hidden=YES;
    
    fullArray=self.tableArray;
    
    lbUser1.hidden=YES;
    lbUser2.hidden=YES;
    lbUser3.hidden=YES;
    
    btUser1.hidden=YES;
    btUser2.hidden=YES;
    btUser3.hidden=YES;
    
    if (!self.selectedArray) {
        self.selectedArray = [NSMutableArray new];
    }
}
#pragma mark - search delegate
-(void)goSearch{
    //searchbar.hidden=!searchbar.hidden;
//
    if(searchbar.hidden)
    {
          searchbar.hidden=NO;
        //关闭底部分的输入监听
         [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];

          }
    else{
        searchbar.hidden=YES;
        [searchbar resignFirstResponder];
        //开启底部分的输入监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        

    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)sBar{
    [sBar resignFirstResponder];
    [self searchBar:sBar textDidChange:sBar.text];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        self.tableArray=fullArray;
        [tableview reloadData];
        return;
    }
    
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    for (NSDictionary *item in fullArray) {
        
        NSString *phoneNumber=[item objectForKey:@"linkman_msisdn"];
        NSString *groupName=[item objectForKey:@"linkman"];
        NSString *jobName=[item objectForKey:@"job"];
        
        NSRange range1=[groupName rangeOfString:searchText];
        if(range1.location!= NSNotFound)
            [tmpArray addObject:item];
        
        NSRange range2=[phoneNumber rangeOfString:searchText];
        if(range2.location!= NSNotFound)
            [tmpArray addObject:item];
        
        NSRange range3=[jobName rangeOfString:searchText];
        if(range3.location!= NSNotFound)
            [tmpArray addObject:item];
    }
    
    self.tableArray=tmpArray;
    [tableview reloadData];
}
- (void)didReceiveMemoryWarning {
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
    
    return [self.tableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"W_VisitPlanAddSelectGroupContactUserTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    NSDictionary *dict = [self.tableArray objectAtIndex:indexPath.row];
    UILabel *lblPhone = (UILabel *)[cell viewWithTag:200];
    lblPhone.text =[dict objectForKey:@"linkman_msisdn"];
    UILabel *lblGroup = (UILabel *)[cell viewWithTag:600];
    lblGroup.text =self.group.groupName;
    UILabel *lblName = (UILabel *)[cell viewWithTag:300];
    lblName.text =[dict objectForKey:@"linkman"];
    UILabel *lblJob = (UILabel *)[cell viewWithTag:400];
    lblJob.text =[dict objectForKey:@"job"];
    
    UIImageView *t_imgChoose = (UIImageView *)[cell viewWithTag:500];
    
    t_imgChoose.hidden=YES;
    if([self.selectedArray count] > 0){
        NSString *msisdn =[dict objectForKey:@"linkman_msisdn"];
        BOOL isExist=NO;
        for (NSDictionary *d in self.selectedArray) {
            NSString *linkmanMsisdn =[d objectForKey:@"linkman_msisdn"];
            if([msisdn isEqualToString:linkmanMsisdn]){
                isExist=YES;
                break;
            }
        }
        
        t_imgChoose.hidden=!isExist;
    }
    
    UIImageView *userImageView=(UIImageView*)[cell viewWithTag:100];
    NSString *imageUrl=[dict objectForKey:@"userimg"];
    if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
        NSURL *url = [NSURL URLWithString:imageUrl];
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        dispatch_async(queue, ^{
            
            NSData *resultData = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:resultData];
            if(img){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    userImageView.image = img;
                });
            }
        });
    }
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *selectedDict =[self.tableArray objectAtIndex:indexPath.row];
    NSString *msisdn =[selectedDict objectForKey:@"linkman_msisdn"];
    BOOL isExist=NO;
    NSDictionary *existDict;
    for (NSDictionary *dict in self.selectedArray) {
        NSString *linkmanMsisdn =[dict objectForKey:@"linkman_msisdn"];
        if([msisdn isEqualToString:linkmanMsisdn]){
            isExist=YES;
            existDict=dict;
            break;
        }
    }
    
    if(isExist){
        [self.selectedArray removeObject:existDict];
    }
    else{
        if([self.selectedArray count] <3){
            [self.selectedArray addObject:selectedDict];
        }
    }
    
    [self refreshSelectButton];
    [tableview reloadData];
    
    [self.delegate visitPlanAddSelectGroupContactUserViewControllerDidFinished:self];
    
}

-(void)refreshSelectButton{
    lbUser1.hidden=YES;
    btUser1.hidden=YES;
    lbUser2.hidden=YES;
    btUser2.hidden=YES;
    lbUser3.hidden=YES;
    btUser3.hidden=YES;
    
    for (NSDictionary *item in self.selectedArray) {
        if([self.selectedArray indexOfObject:item] == 0){
            lbUser1.text=[item objectForKey:@"linkman"];
            lbUser1.hidden=NO;
            btUser1.hidden=NO;
        }
        if([self.selectedArray indexOfObject:item] == 1){
            lbUser2.text=[item objectForKey:@"linkman"];
            lbUser2.hidden=NO;
            btUser2.hidden=NO;
        }
        if([self.selectedArray indexOfObject:item] == 2){
            lbUser3.text=[item objectForKey:@"linkman"];
            lbUser3.hidden=NO;
            btUser3.hidden=NO;
        }
    }
    
}

- (IBAction)deleteUser1Onclick:(id)sender {
    [self.selectedArray removeObject:[self.selectedArray firstObject]];
    [self refreshSelectButton];
    [self.delegate visitPlanAddSelectGroupContactUserViewControllerDidFinished:self];
    [tableview reloadData];
}
- (IBAction)deleteUser2Onclick:(id)sender {
    [self.selectedArray removeObject:[self.selectedArray objectAtIndex:1]];
    [self refreshSelectButton];
    [self.delegate visitPlanAddSelectGroupContactUserViewControllerDidFinished:self];
    [tableview reloadData];
}
- (IBAction)deleteUser3Onclick:(id)sender {
    [self.selectedArray removeLastObject];
    [self refreshSelectButton];
    [self.delegate visitPlanAddSelectGroupContactUserViewControllerDidFinished:self];
    [tableview reloadData];
}
- (IBAction)inputUserOnclick:(id)sender {
    if(txtPhone.text.length < 1 || txtUser.text.length < 1)
        return;
    
    if([self.selectedArray count] > 2)
        return;
    [txtPhone resignFirstResponder];
    [txtUser resignFirstResponder];
    
    [txtPhone resignFirstResponder];
    [txtUser resignFirstResponder];
    NSMutableDictionary *dict =[NSMutableDictionary new];
    [dict setObject:txtUser.text forKey:@"linkman"];
    [dict setObject:txtPhone.text forKey:@"linkman_msisdn"];
    [self.selectedArray addObject:dict];
    [self refreshSelectButton];
    
    txtUser.text=@"";
    txtPhone.text=@"";
    [self.delegate visitPlanAddSelectGroupContactUserViewControllerDidFinished:self];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
