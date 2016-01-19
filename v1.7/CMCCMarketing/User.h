//
//  User.h
//  CMCCMarketing
//  test
//  Created by talkweb on 14-9-29.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"
#import "CustomerManager.h"
#import "Channels.h"
#import "ChannelsManager.h"
@interface User : NSObject

@property(nonatomic,assign)int userID;
@property(nonatomic,assign)int userLoginState;   /*登录是否成功*/
@property(nonatomic,assign)int userLvl;  /*级别 领导／一线员工*/
@property(nonatomic,assign)int userEnterprise;  /*企业编码*/
@property(nonatomic,assign)int managerRole;  //经理类型

@property(nonatomic,strong)NSString* userName;
@property(nonatomic,strong)NSString* userCode;
//@property(nonatomic,strong)NSString* userSex;
@property(nonatomic,assign)int userSex;
@property(nonatomic,strong)NSString* userDeptDesc;  /*部门*/
@property(nonatomic,strong)NSString* userEmail;
@property(nonatomic,strong)NSString* userImageUrl;
@property(nonatomic,strong)NSString* userMobile;
@property(nonatomic,strong)NSString* userPassword;
//增加客户经理归宿县市id
@property(nonatomic,strong)NSString* userCntyID;

@property(nonatomic,strong)NSArray* groupInfo;
@property(nonatomic,strong)NSArray* msgroupInfo;

@property(nonatomic,strong)NSArray* customerManagerInfo;//主管登陆用户中的客户经理
@property(nonatomic,strong)NSArray* channelManagerInfo;

@property(nonatomic,strong)NSArray* chnlInfo;

@property(nonatomic,assign)BOOL gps_sta;
-(id)initWithDictionary:(NSDictionary*)userDict;
@end
