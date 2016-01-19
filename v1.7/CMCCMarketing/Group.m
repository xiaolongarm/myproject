//
//  Group.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-8.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "Group.h"

@implementation Group

-(id)initWithDictionary:(NSDictionary*)userDict{
    self.groupBaiduLatitude=[[userDict objectForKey:@"baidu_latitude"] doubleValue];
    self.groupBaiduLongitude=[[userDict objectForKey:@"baidu_longtitude"] doubleValue];
    self.groupContactname=[self filterNullType:[userDict objectForKey:@"contactName"]];
    self.groupContactPhone=[self filterNullType:[userDict objectForKey:@"contactPhone"]];
    self.groupCreateDocDate=[self filterNullType:[userDict objectForKey:@"create_doc_date"]];
    self.groupDiduType=[[userDict objectForKey:@"didu_type"] intValue];
    self.groupflag=[[userDict objectForKey:@"flag"] boolValue];
    self.groupId=[self filterNullType:[userDict objectForKey:@"groupID"]];
    self.groupName=[self filterNullType:[userDict objectForKey:@"groupName"]];
    self.groupSts=[self filterNullType:[userDict objectForKey:@"group_sts"]];
    self.groupTypeName=[self filterNullType:[userDict objectForKey:@"group_type_name"]];
    self.groupAddress=[self filterNullType:[userDict objectForKey:@"grp_addr"]];
    self.groupLvl=[self filterNullType:[userDict objectForKey:@"grp_lvl"]];
    self.groupIndustrySubTypeName=[self filterNullType:[userDict objectForKey:@"industry_sub_typ_name"]];
    self.groupIndustryTypeName=[self filterNullType:[userDict objectForKey:@"industry_typ_name"]];
    self.groupLatitude=[[userDict objectForKey:@"latitude"] doubleValue];
    self.groupLongitude=[[userDict objectForKey:@"longtitude"] doubleValue];
    self.groupserviceCode=[[userDict objectForKey:@"serviceCode"] doubleValue];
    self.groupSuperGroupId=[self filterNullType:[userDict objectForKey:@"super_group_id"]];
    self.groupSuperGroupName = [self filterNullType:[userDict objectForKey:@"super_group_name"]];
    //增加集团人数字段 为int 型
      self.groupNumber=[[userDict objectForKey:@"grp_num"] intValue];
    ////新增 grp_key_prod 集团关键产品 grp_else_prod 集团非关键产品
     self.grpKeyProd = [self filterNullType:[userDict objectForKey:@"grp_key_prod"]];
    self.grpElseProd = [self filterNullType:[userDict objectForKey:@"grp_else_prod"]];
    
    return self;
    
}
-(id)filterNullType:(id)object{
    if(!object || object == [NSNull null] || ((NSString*)object).length == 0)
        return @"-";
    return object;
}
//{
//    "baidu_latitude" = "";
//    "baidu_longtitude" = "";
//    contactName = "\U67f3\U7434";
//    contactPhone = 13974821522;
//    "create_doc_date" = 20040601;
//    "didu_type" = 1;
//    flag = 1;
//    groupID = 7311000008;
//    groupName = "\U6e56\U5357\U516c\U8def\U7269\U8d28\U8bbe\U5907\U516c\U53f8";
//    "group_sts" = 0;
//    "grp_addr" = "\U6e56\U5357\U7701\U957f\U6c99\U5e02\U5f00\U798f\U533a\U516b\U4e00\U8def520\U53f7";
//    "grp_lvl" = A2;
//    "industry_sub_typ_name" = "\U6279\U53d1\U4e1a";
//    "industry_typ_name" = "\U6279\U53d1\U548c\U96f6\U552e\U4e1a";
//    latitude = "";
//    longtitude = "";
//    serviceCode = 3100000031066334;
//    "super_group_id" = "";
//}

@end
