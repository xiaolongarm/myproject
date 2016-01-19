//
//  W_VisitPlanAddSelectAccompanyUserController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-20.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanAddSelectAccompanyUserController.h"

@interface W_VisitPlanAddSelectAccompanyUserController ()<UISearchBarDelegate>{
    UISearchBar *searchbar;
    NSMutableArray *fullArray;
     NSMutableArray *useArray;
     UIButton *addContactButtonView;
}

@end

@implementation W_VisitPlanAddSelectAccompanyUserController

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
    
    [self initSubView];
     [self.tableView reloadData];
}

- (void)initSubView{
    
    self.navigationItem.title = @"选择陪同人员";
    
//    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"查询按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
//    
//    [rightButton setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setRightBarButtonItem:rightButton];
//    
//    CGRect rect=self.view.frame;
//    rect.size.height=44;
//    rect.size.width=320;
//    rect.origin=CGPointZero;
//    searchbar=[[UISearchBar alloc] init];
//    searchbar.placeholder=@"请输入关键字查询";
//    searchbar.frame=rect;
//    searchbar.delegate=self;
//    //[self.view addSubview:searchbar];
//    [self.navigationItem.titleView addSubview:searchbar];
//    searchbar.hidden=YES;
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
    //[self.view addSubview:searchbar];
//    self.tableView.tableHeaderView= searchbar;
//    self.tableView.tableHeaderView.hidden=YES;
    searchbar.hidden=YES;

    
    fullArray=self.tableArray;
}

//-(void)chooseAct{
//    
//    [self.delegate VisitPlanAddSelectAccompanyUserControllerDidFinished:self];
//    [self.navigationController popViewControllerAnimated:YES];
//}
-(void)addContactMessageButton{
    UIAlertView *contactAlertView= [[UIAlertView alloc]initWithTitle:@"输入姓名及电话号码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //[contactAlertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    contactAlertView.alertViewStyle =UIAlertViewStyleLoginAndPasswordInput;
    UITextField *nameField = [contactAlertView textFieldAtIndex:0];
    nameField.placeholder = @"请输入姓名";
    
    UITextField *cellPhoneField = [contactAlertView textFieldAtIndex:1];
    cellPhoneField.secureTextEntry = NO;
    cellPhoneField.keyboardType = UIKeyboardTypeNumberPad;
    cellPhoneField.placeholder = @"请输入电话号码";
    //cellPhoneField
    [contactAlertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        NSLog(@"click insrue.....");
        UITextField *nameField = [alertView textFieldAtIndex:0];
        UITextField *cellPhoneField = [alertView textFieldAtIndex:1];
        
        NSMutableDictionary *dict= [NSMutableDictionary new];
        [dict setObject:nameField.text forKey:@"vip_mngr_name"];
        [dict setObject:cellPhoneField.text forKey:@"vip_mngr_msisdn"];
        //[self.tableArray addObject:dict];
        //将输入数据插入到最前面
        [self.tableArray insertObject:dict atIndex:0];
        
        self.recordArray=self.tableArray;
        [self.tableView reloadData];
        
        //TODO
    }
    
}

#pragma mark - search delegate
-(void)goSearch{
    //searchbar.hidden=!searchbar.hidden;
    
     //self.tableView.tableHeaderView.hidden=NO;
    if(searchbar.hidden)
    {
        // self.tableView.tableHeaderView.hidden=YES;
        self.tableView.tableHeaderView= searchbar;
        self.tableView.tableHeaderView.hidden=NO;
        searchbar.hidden=NO;
        //[searchbar resignFirstResponder];
    }
    else{
       // self.tableView.tableHeaderView.hidden=YES;
        self.tableView.tableHeaderView=nil;
        searchbar.hidden=YES;
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)sBar{
    [sBar resignFirstResponder];
    [self searchBar:sBar textDidChange:sBar.text];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        self.tableArray=fullArray;
        [self.tableView reloadData];
        return;
    }
    
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    for (NSDictionary *item in fullArray) {
        
        NSString *phoneNumber=[item objectForKey:@"vip_mngr_msisdn"];
        NSString *groupName=[item objectForKey:@"vip_mngr_name"];
        
        NSRange range1=[groupName rangeOfString:searchText];
        if(range1.location!= NSNotFound)
            [tmpArray addObject:item];
        
        NSRange range2=[phoneNumber rangeOfString:searchText];
        if(range2.location!= NSNotFound)
            [tmpArray addObject:item];
    }
    
    self.tableArray=tmpArray;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView= [[UIView alloc]init];
        myView.backgroundColor=[UIColor whiteColor];
    
    addContactButtonView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [addContactButtonView addTarget:self action:@selector(addContactMessageButton) forControlEvents:UIControlEventTouchUpInside];
    // NSString *remindString=@"填写未在列表的陪同人员";
    [addContactButtonView setTitle:@"点击填写未在列表的陪同人员" forState:UIControlStateNormal];
    [addContactButtonView setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [myView addSubview:addContactButtonView];
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"实线条.png"]];
    lineImageView.frame= CGRectMake(0, 44, 320, 2);
    
    [myView addSubview:lineImageView];
    
    return myView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    return 44;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString * identifier = @"Cell";
//    W_VisitPlanAddSelectAccompanyUserControllerCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[W_VisitPlanAddSelectAccompanyUserControllerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//
    
    static NSString *CellIdentifier = @"W_VisitPlanAddSelectAccompanyUserControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    NSDictionary *dicAccompanyUser;

    //当recordArray不为nil时，显示recordArray中的数据
    if (self.recordArray!=nil) {
        dicAccompanyUser=[self.recordArray objectAtIndex:indexPath.row];
    }
    else{
        dicAccompanyUser=[self.tableArray objectAtIndex:indexPath.row];}
    
    UILabel *t_lblAccompanyUserName = (UILabel*)[cell viewWithTag:100];
    t_lblAccompanyUserName.text=[dicAccompanyUser objectForKey:@"vip_mngr_name"];
    
    UIImageView *t_imgChoose = (UIImageView *)[cell viewWithTag:200];
    UILabel *t_lblAccompanyUserPhone = (UILabel*)[cell viewWithTag:300];
    t_lblAccompanyUserPhone.text=[dicAccompanyUser objectForKey:@"vip_mngr_msisdn"];
//    t_imgChoose.hidden=![[self.selectAccompanyUserDic objectForKey:@"vip_mngr_msisdn"] isEqualToString: [dicAccompanyUser objectForKey:@"vip_mngr_msisdn"]];
    t_imgChoose.hidden = true;
    
//    NSString *vip_mngr_msisdnTmpTable = [[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"vip_mngr_msisdn"];
    NSString *vip_mngr_msisdnTmpTable;
    if (self.recordArray!=nil) {
       vip_mngr_msisdnTmpTable = [[self.recordArray objectAtIndex:indexPath.row] objectForKey:@"vip_mngr_msisdn"];
    }
    else{
       vip_mngr_msisdnTmpTable = [[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"vip_mngr_msisdn"];
    }

    
//    NSString *vip_mngr_msisdnTmpTable = [[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"vip_mngr_msisdn"];
    
    for (int k=0; k<self.selectAccompanyUserArr.count; k++) {
        
        NSString *vip_mngr_msisdnTmp = [[self.selectAccompanyUserArr objectAtIndex:k] objectForKey:@"vip_mngr_msisdn"];
        if ([vip_mngr_msisdnTmp isEqual:vip_mngr_msisdnTmpTable]) {//相同
            
            t_imgChoose.hidden = false;
            break;
            
        }else{
            
            t_imgChoose.hidden = true;
            
        }
    }
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //当recordArray不为nil时，显示recordArray中的数据
    
    if (self.recordArray!=nil) {
        useArray=self.recordArray;
    }
    else{
        useArray=self.tableArray;
    }

    
    if(self.selectAccompanyUserArr && self.selectAccompanyUserArr.count > 0){
        
        bool haveUser =true;
        
        for (int k=0; k<self.selectAccompanyUserArr.count; k++) {
            
            NSString *vip_mngr_msisdnTmp = [[self.selectAccompanyUserArr objectAtIndex:k] objectForKey:@"vip_mngr_msisdn"];
            
//            NSString *vip_mngr_msisdnTmpTable = [[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"vip_mngr_msisdn"];
            NSString *vip_mngr_msisdnTmpTable = [[useArray objectAtIndex:indexPath.row] objectForKey:@"vip_mngr_msisdn"];
            
            if ([vip_mngr_msisdnTmp isEqual:vip_mngr_msisdnTmpTable]) {//相同
                
                [self.selectAccompanyUserArr removeObjectAtIndex:k];//移除
                haveUser = true;
                break;
                
            }else{
                
                haveUser = false;
            }
        }
        
        if (haveUser == false) {
            
            if(self.selectAccompanyUserArr ==nil){
                
                self.selectAccompanyUserArr = [[NSMutableArray alloc] init];
            }
            
            if(self.selectAccompanyUserArr.count == 3){
                //满
                
                ;
            }else{
                
//                [self.selectAccompanyUserArr addObject:[self.tableArray objectAtIndex:indexPath.row]];
                [self.selectAccompanyUserArr addObject:[useArray objectAtIndex:indexPath.row]];
            }
            
            
        }
        
        
        
    }else{
        //空
        
        if(self.selectAccompanyUserArr ==nil){
            
            self.selectAccompanyUserArr = [[NSMutableArray alloc] init];
        }
//        NSDictionary *dicObj = [self.tableArray objectAtIndex:indexPath.row];
        NSDictionary *dicObj = [useArray objectAtIndex:indexPath.row];
        [self.selectAccompanyUserArr addObject:dicObj];
    }
    
    [self.tableView reloadData];
    
    [self.delegate VisitPlanAddSelectAccompanyUserControllerDidFinished:self];
    
   
}



@end
