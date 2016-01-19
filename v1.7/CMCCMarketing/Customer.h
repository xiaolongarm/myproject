//
//  Customer.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-29.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject

@property(nonatomic,strong)NSString* customerAge;
@property(nonatomic,strong)NSString* customerAgeType;
@property(nonatomic,strong)NSString* customerAgeTypeDesc;
@property(nonatomic,strong)NSString* customerAreaId;
@property(nonatomic,strong)NSString* customerAreaName;
@property(nonatomic,strong)NSString* customerName;
@property(nonatomic,strong)NSString* customerBrndId;
@property(nonatomic,strong)NSString* customerBrndName;
@property(nonatomic,strong)NSString* customerCntyId;
@property(nonatomic,strong)NSString* customerCntyName;
@property(nonatomic,strong)NSString* customerCustTypeDesc;
@property(nonatomic,strong)NSString* customerCustTypeId;
@property(nonatomic,strong)NSString* customerDataIncm;
@property(nonatomic,strong)NSString* customerDiscntFee;
@property(nonatomic,strong)NSString* customerDiscntId;
@property(nonatomic,strong)NSString* customerDiscntName;
@property(nonatomic,strong)NSString* customerDiscnt4G;
@property(nonatomic,strong)NSString* customerEnterprise;
@property(nonatomic,strong)NSString* customerFlwDiscInTolVol;
@property(nonatomic,strong)NSString* customerFlwDiscPassTolVol;
@property(nonatomic,strong)NSString* customerFlwDiscUseTolVol;
@property(nonatomic,strong)NSString* customerFlwDiscntId;
@property(nonatomic,strong)NSString* customerFreeVol;
@property(nonatomic,strong)NSString* customerG2Vol;
@property(nonatomic,strong)NSString* customerG3Vol;
@property(nonatomic,strong)NSString* customerG4Vol;
@property(nonatomic,strong)NSString* customerGprsFee;
@property(nonatomic,strong)NSString* customerGprsVol;
@property(nonatomic,strong)NSString* customerGrpCode;
@property(nonatomic,strong)NSString* customerGrpName;
@property(nonatomic,strong)NSString* customerIfAddPak;
@property(nonatomic,strong)NSString* customerIfClrsvc;
@property(nonatomic,strong)NSString* customerIfGprssvc;
@property(nonatomic,strong)NSString* customerIfIdlePak;
@property(nonatomic,strong)NSString* customerIfNilVol;
@property(nonatomic,strong)NSString* customerIfWlanDiscnt;
@property(nonatomic,strong)NSString* customerImei;
@property(nonatomic,strong)NSString* customerIncm;
@property(nonatomic,strong)NSString* customerIsZnSj;
@property(nonatomic,strong)NSString* customerIsacctusr;
@property(nonatomic,strong)NSString* customerLacCellId;
@property(nonatomic,strong)NSString* customerLacCellName;
@property(nonatomic,strong)NSString* customerLocnTypeId;
@property(nonatomic,strong)NSString* customerLocnTypeName;
@property(nonatomic,strong)NSString* customerOsSys;
@property(nonatomic,strong)NSString* customerOtherGprsFee;
@property(nonatomic,strong)NSString* customerProdId;
@property(nonatomic,strong)NSString* customerProdName;
@property(nonatomic,strong)NSString* customerPackageName;//by taoyong
@property(nonatomic,strong)NSString* customerSjGprsFee;
@property(nonatomic,strong)NSString* customerSvcCode;
@property(nonatomic,strong)NSString* customerTermBrnd;
@property(nonatomic,strong)NSString* customerTermSys;
@property(nonatomic,strong)NSString* customerTimeId;
@property(nonatomic,strong)NSString* customerTownId;
@property(nonatomic,strong)NSString* customerTownName;
@property(nonatomic,strong)NSString* customerUseVol;
@property(nonatomic,strong)NSString* customerUsrId;
@property(nonatomic,strong)NSString* customerVipLvlId;
@property(nonatomic,strong)NSString* customerVipLvlName;

@property(nonatomic,strong)NSString* customerIf_2g_high_flow;//是否2g高流量客户
@property(nonatomic,strong)NSString* customerIf_bind;//是否预存
@property(nonatomic,strong)NSString* customerChang_term_date;//更换终端月份
@property(nonatomic,strong)NSString* customerBind_name;//预存类型
@property(nonatomic,strong)NSString* customerIf_abc_group;//是否是abc类集团客户
@property(nonatomic,strong)NSString* customerIf_inport_cust;//是否关键人


@property(nonatomic,strong)NSString* customerSale_active;//促销活动：sale_active
@property(nonatomic,strong)NSString* customerActive_name;//活动名称：active_name

//"if_3guser" = "\U5426";
//"if_4gcard" = "\U5426";
//"if_4gterm" = "\U5426";
//"if_4guser" = "\U5426";

@property(nonatomic,strong)NSString * customerIf_3gUser;
@property(nonatomic,strong)NSString * customerIf_4gCard;
@property(nonatomic,strong)NSString * customerIf_4gTerm;
@property(nonatomic,strong)NSString * customerIf_4gUser;


-(id)initWithDictionary:(NSDictionary*)customerObject;

@end
