//
//  Group.h
//  CMCCMarketing
//
//  Created by talkweb on 14-10-8.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property(nonatomic,assign)double groupBaiduLatitude;
@property(nonatomic,assign)double groupBaiduLongitude;
@property(nonatomic,strong)NSString* groupContactname;
@property(nonatomic,strong)NSString* groupContactPhone;
@property(nonatomic,strong)NSString* groupCreateDocDate;
@property(nonatomic,assign)int groupDiduType;
@property(nonatomic,assign)int groupflag;
@property(nonatomic,strong)NSString* groupId;
@property(nonatomic,strong)NSString* groupName;
@property(nonatomic,strong)NSString* groupSts;
@property(nonatomic,strong)NSString* groupTypeName;
@property(nonatomic,strong)NSString* groupAddress;
@property(nonatomic,strong)NSString* groupLvl;
@property(nonatomic,strong)NSString* groupIndustrySubTypeName;
@property(nonatomic,strong)NSString* groupIndustryTypeName;
@property(nonatomic,assign)double groupLatitude;
@property(nonatomic,assign)double groupLongitude;
@property(nonatomic,assign)double groupserviceCode;
@property(nonatomic,strong)NSString* groupSuperGroupId;

@property(nonatomic,strong)NSString* groupSuperGroupName;
//增加集团人数字段
@property(assign,nonatomic)int groupNumber;
//新增 grp_key_prod 集团关键产品 grp_else_prod 集团非关键产品
@property(nonatomic,strong)NSString* grpKeyProd;
@property(nonatomic,strong)NSString* grpElseProd;

-(id)initWithDictionary:(NSDictionary*)userDict;

@end
