//
//  DataAcquisitionWithGroupInformationViewController+formDescriptionUsingDelegates.h
//  CMCCMarketing
//
//  Created by talkweb on 15-2-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DataAcquisitionWithGroupInformationViewController.h"
#import "JMFormDescription.h"
#import "DataAcquisitionWithGroupInformationFormModel.h"

@interface DataAcquisitionWithGroupInformationViewController (formDescriptionUsingDelegates)
- (JMFormDescription *)generateFormDescriptionUsingModel:(DataAcquisitionWithGroupInformationFormModel *)model;
@end
