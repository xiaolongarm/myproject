//
//  self.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-29.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "Customer.h"

@implementation Customer

-(id)initWithDictionary:(NSDictionary*)customerObject{
    self.customerAge=[self filterNullType:[customerObject objectForKey:@"age"]];
    self.customerAgeType=[self filterNullType:[customerObject objectForKey:@"age_typ"]];
    self.customerAgeTypeDesc=[self filterNullType:[customerObject objectForKey:@"age_typ_desc"]];
    self.customerAreaId=[self filterNullType:[customerObject objectForKey:@"area_id"]];
    self.customerAreaName=[self filterNullType:[customerObject objectForKey:@"area_name"]];
    self.customerBrndId=[self filterNullType:[customerObject objectForKey:@"brnd_id"]];
    self.customerBrndName=[self filterNullType:[customerObject objectForKey:@"brnd_name"]];
    self.customerCntyId=[self filterNullType:[customerObject objectForKey:@"cnty_id"]];
    self.customerCntyName=[self filterNullType:[customerObject objectForKey:@"cnty_name"]];
    self.customerCustTypeDesc=[self filterNullType:[customerObject objectForKey:@"cust_typ_desc"]];
    self.customerCustTypeId=[self filterNullType:[customerObject objectForKey:@"cust_typ_id"]];
    self.customerDataIncm=[self filterNullType:[customerObject objectForKey:@"data_incm"]];
    
    self.customerDiscntFee=[self filterNullType:[customerObject objectForKey:@"discnt_fee"]];
    self.customerDiscntId=[self filterNullType:[customerObject objectForKey:@"discnt_id"]];
    self.customerDiscntName=[self filterNullType:[customerObject objectForKey:@"discnt_name"]];
    self.customerDiscnt4G=[self filterNullType:[customerObject objectForKey:@"discnt_4g"]];
    
    self.customerEnterprise=[self filterNullType:[customerObject objectForKey:@"enterprise"]];
    self.customerFlwDiscInTolVol=[self filterNullType:[customerObject objectForKey:@"flw_disc_in_tol_vol"]];
    self.customerFlwDiscPassTolVol=[self filterNullType:[customerObject objectForKey:@"flw_disc_pass_tol_vol"]];
    self.customerFlwDiscUseTolVol=[self filterNullType:[customerObject objectForKey:@"flw_disc_use_tol_vol"]];
    self.customerFlwDiscntId=[self filterNullType:[customerObject objectForKey:@"flw_discnt_id"]];
    
    self.customerFreeVol=[self filterNullType:[customerObject objectForKey:@"free_vol"]];
    self.customerG2Vol=[self filterNullType:[customerObject objectForKey:@"g2_vol"]];
    self.customerG3Vol=[self filterNullType:[customerObject objectForKey:@"g3_vol"]];
    self.customerG4Vol=[self filterNullType:[customerObject objectForKey:@"g4_vol"]];
    self.customerGprsFee=[self filterNullType:[customerObject objectForKey:@"gprs_fee"]];
    self.customerGprsVol=[self filterNullType:[customerObject objectForKey:@"gprs_vol"]];
    self.customerGrpCode=[self filterNullType:[customerObject objectForKey:@"grp_code"]];
    self.customerGrpName=[self filterNullType:[customerObject objectForKey:@"grp_name"]];
    
    self.customerIfAddPak=[self filterNullType:[customerObject objectForKey:@"if_add_pak"]];
    self.customerIfClrsvc=[self filterNullType:[customerObject objectForKey:@"if_clrsvc"]];
    self.customerIfGprssvc=[self filterNullType:[customerObject objectForKey:@"if_gprssvc"]];
    self.customerIfIdlePak=[self filterNullType:[customerObject objectForKey:@"if_idle_pak"]];
    self.customerIfNilVol=[self filterNullType:[customerObject objectForKey:@"if_nil_vol"]];
    self.customerIfWlanDiscnt=[self filterNullType:[customerObject objectForKey:@"if_wlan_discnt"]];
    self.customerImei=[self filterNullType:[customerObject objectForKey:@"imei"]];
    self.customerIncm=[self filterNullType:[customerObject objectForKey:@"incm"]];
    self.customerIsZnSj=[self filterNullType:[customerObject objectForKey:@"is_zn_sj"]];
    self.customerIsacctusr=[self filterNullType:[customerObject objectForKey:@"isacctusr"]];
    self.customerLacCellId=[self filterNullType:[customerObject objectForKey:@"lac_cell_id"]];
    self.customerLacCellName=[self filterNullType:[customerObject objectForKey:@"lac_cell_name"]];
    self.customerLocnTypeId=[self filterNullType:[customerObject objectForKey:@"locn_typ_id"]];
    self.customerLocnTypeName=[self filterNullType:[customerObject objectForKey:@"locn_typ_name"]];
    
    self.customerOsSys=[self filterNullType:[customerObject objectForKey:@"os_sys"]];
    self.customerOtherGprsFee=[self filterNullType:[customerObject objectForKey:@"othter_gprs_fee"]];
    self.customerProdId=[self filterNullType:[customerObject objectForKey:@"prod_id"]];
    self.customerProdName=[self filterNullType:[customerObject objectForKey:@"prod_name"]];
    self.customerPackageName=[self filterNullType:[customerObject objectForKey:@"package_name"]]; //by taoyong
    self.customerSjGprsFee=[self filterNullType:[customerObject objectForKey:@"sj_gprs_fee"]];
    self.customerSvcCode=[self filterNullType:[customerObject objectForKey:@"svc_code"]];
    self.customerTermBrnd=[self filterNullType:[customerObject objectForKey:@"term_brnd"]];
    self.customerTermSys=[self filterNullType:[customerObject objectForKey:@"term_sys"]];
    
    self.customerTimeId=[self filterNullType:[customerObject objectForKey:@"time_id"]];
    self.customerTownId=[self filterNullType:[customerObject objectForKey:@"town_id"]];
    self.customerTownName=[self filterNullType:[customerObject objectForKey:@"town_name"]];
    self.customerUseVol=[self filterNullType:[customerObject objectForKey:@"use_vol"]];
    self.customerUsrId=[self filterNullType:[customerObject objectForKey:@"usr_id"]];
    self.customerVipLvlId=[self filterNullType:[customerObject objectForKey:@"vip_lvl_id"]];
    self.customerVipLvlName=[self filterNullType:[customerObject objectForKey:@"vip_lvl_name"]];
    
    
    self.customerIf_2g_high_flow = [self filterNullType:[customerObject objectForKey:@"if_2g_high_flow"]];
    self.customerIf_bind = [self filterNullType:[customerObject objectForKey:@"if_bind"]];
    self.customerChang_term_date = [self filterNullType:[customerObject objectForKey:@"chang_term_date"]];

    self.customerBind_name = [self filterNullType:[customerObject objectForKey:@"bind_name"]];
    self.customerIf_abc_group = [self filterNullType:[customerObject objectForKey:@"if_abc_group"]];
    self.customerIf_inport_cust = [self filterNullType:[customerObject objectForKey:@"if_inport_cust"]];

    
    self.customerSale_active = [self filterNullType:[customerObject objectForKey:@"sale_active"]];
    self.customerActive_name = [self filterNullType:[customerObject objectForKey:@"active_name"]];
    
    self.customerIf_3gUser=[self filterNullType:[customerObject objectForKey:@"if_3guser"]];
    self.customerIf_4gUser=[self filterNullType:[customerObject objectForKey:@"if_4guser"]];
    self.customerIf_4gCard=[self filterNullType:[customerObject objectForKey:@"if_4gcard"]];
    self.customerIf_4gTerm=[self filterNullType:[customerObject objectForKey:@"if_4gterm"]];
    
    return self;
}
-(id)filterNullType:(id)object{
    if(!object || object == [NSNull null] || ((NSString*)object).length == 0)
        return @"-";
    return object;
}
@end
