//
//  DataAcquisitionWithGroupInformationViewController+formDescriptionUsingDelegates.m
//  CMCCMarketing
//
//  Created by talkweb on 15-2-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DataAcquisitionWithGroupInformationViewController+formDescriptionUsingDelegates.h"
#import "JMFormViews.h"

@implementation DataAcquisitionWithGroupInformationViewController (formDescription)

- (JMFormDescription *)generateFormDescriptionUsingModel:(DataAcquisitionWithGroupInformationFormModel *)model
{
    JMFormDescription *formDesc = [JMFormDescription new];
    NSMutableArray *descriptions = [NSMutableArray new];
    
    JMFormSectionHeaderFormViewDescription *headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"集团单位基础信息";

    [descriptions addObject:headerDesc];
    
    JMListFormViewDescription *listDesc = [JMListFormViewDescription new];
    listDesc.title = @"单位名称";
    listDesc.placeholder = @"点击选择";
    listDesc.data = model.selectedColorNAme;
    listDesc.listStyle = JMListFormViewModalChoice;
    listDesc.formDelegate = self;
    listDesc.modelKey = @"selectedColorNAme";
    listDesc.formViewHeight = 80.0f;
    listDesc.choices = model.coloChoices;
    [descriptions addObject:listDesc];
    
    JMTextfieldWithTitleFormViewDescription * textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
    textfieldTitleDesc.title = @"单位员工总数";
//    textfieldTitleDesc.placeholder = @"Mon placeholder3";
    textfieldTitleDesc.data = model.textfieldText1;
    textfieldTitleDesc.formDelegate = self;
    textfieldTitleDesc.modelKey = @"textfieldText1";
    [descriptions addObject:textfieldTitleDesc];
    
    textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
    textfieldTitleDesc.title = @"集团成员总数";
//    textfieldTitleDesc.placeholder = @"Mon placeholder4";
    textfieldTitleDesc.data = model.textfieldText2;
    textfieldTitleDesc.formDelegate = self;
    textfieldTitleDesc.modelKey = @"textfieldText2";
    [descriptions addObject:textfieldTitleDesc];
    
    textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
    textfieldTitleDesc.title = @"移动市场占有率";
//    textfieldTitleDesc.placeholder = @"Mon placeholder3";
    textfieldTitleDesc.data = model.textfieldText3;
    textfieldTitleDesc.formDelegate = self;
    textfieldTitleDesc.modelKey = @"textfieldText3";
    [descriptions addObject:textfieldTitleDesc];
    
    JMTSwitchFormViewDescription *switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"My switch text";
    switchDescription.on = model.switch1;
    switchDescription.formDelegate = self;
    switchDescription.modelKey = @"switch1";
    [descriptions addObject:switchDescription];
    
//    JMTextfieldFormViewDescription *textfieldDesc  = [JMTextfieldFormViewDescription new];
//    textfieldDesc.placeholder = @"Mon placeholder";
//    textfieldDesc.data = model.textfieldText1;
//    textfieldDesc.formDelegate = self;
//    textfieldDesc.modelKey = @"textfieldText1";
//    [descriptions addObject:textfieldDesc];
//    
//    textfieldDesc  = [JMTextfieldFormViewDescription new];
//    textfieldDesc.placeholder = nil;
//    textfieldDesc.data = model.textfieldText2;
//    textfieldDesc.formDelegate = self;
//    textfieldDesc.modelKey = @"textfieldText2";
//    [descriptions addObject:textfieldDesc];
//    
//    textfieldDesc  = [JMTextfieldFormViewDescription new];
//    textfieldDesc.placeholder = nil;
//    textfieldDesc.data = model.textfieldText3;
//    textfieldDesc.updateBlock = ^(id modifiedValue){
//        model.textfieldText3 = modifiedValue;
//    };
//    [descriptions addObject:textfieldDesc];
    
//    headerDesc = [JMFormSectionHeaderFormViewDescription new];
//    headerDesc.title = @"Textfield tests With title";
//    [descriptions addObject:headerDesc];
//    
//    JMTextfieldWithTitleFormViewDescription * textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
//    textfieldTitleDesc.title = @"Mont titre3";
//    textfieldTitleDesc.placeholder = @"Mon placeholder3";
//    textfieldTitleDesc.data = model.textfieldText4;
//    textfieldTitleDesc.formDelegate = self;
//    textfieldTitleDesc.modelKey = @"textfieldText4";
//    [descriptions addObject:textfieldTitleDesc];
//    
//    textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
//    textfieldTitleDesc.title = @"Mon titre4";
//    textfieldTitleDesc.placeholder = @"Mon placeholder4";
//    textfieldTitleDesc.data = model.textfieldText5;
//    textfieldTitleDesc.formDelegate = self;
//    textfieldTitleDesc.modelKey = @"textfieldText5";
//    [descriptions addObject:textfieldTitleDesc];
//
//    headerDesc = [JMFormSectionHeaderFormViewDescription new];
//    headerDesc.title = @"Switch tests title";
//    [descriptions addObject:headerDesc];
//    
//    JMTSwitchFormViewDescription *switchDescription = [JMTSwitchFormViewDescription new];
//    switchDescription.data = @"My switch text";
//    switchDescription.on = model.switch1;
//    switchDescription.formDelegate = self;
//    switchDescription.modelKey = @"switch1";
//    [descriptions addObject:switchDescription];
//    
//    switchDescription = [JMTSwitchFormViewDescription new];
//    switchDescription.data = @"My switch text";
//    switchDescription.on = model.switch2;
//    switchDescription.formDelegate = self;
//    switchDescription.modelKey = @"switch2";
//    [descriptions addObject:switchDescription];
//    
//    switchDescription = [JMTSwitchFormViewDescription new];
//    switchDescription.data = @"Switch to fold/unfold";
//    switchDescription.on = model.expended;
//    switchDescription.formDelegate = self;
//    switchDescription.modelKey = @"expended";
//    [descriptions addObject:switchDescription];
//    
//    if (model.expended) {
//        JMTextfieldWithTitleFormViewDescription * textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
//        textfieldTitleDesc.title = @"Secret textfield";
//        textfieldTitleDesc.placeholder = @"Secret textfield";
//        textfieldTitleDesc.data = model.secretValue;
//        textfieldTitleDesc.formDelegate = self;
//        textfieldTitleDesc.modelKey = @"secretValue";
//        [descriptions addObject:textfieldTitleDesc];
//        
//        textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
//        textfieldTitleDesc.title = @"Secret textfield 2";
//        textfieldTitleDesc.placeholder = @"Secret textfield 2";
//        textfieldTitleDesc.data = model.secretValue2;
//        textfieldTitleDesc.formDelegate = self;
//        textfieldTitleDesc.modelKey = @"secretValue2";
//        [descriptions addObject:textfieldTitleDesc];
//    }
//    
//    switchDescription = [JMTSwitchFormViewDescription new];
//    switchDescription.data = @"Long switch text but switch is not active";
//    switchDescription.enable = NO;
//    switchDescription.on = model.switch4;
//    switchDescription.formDelegate = self;
//    switchDescription.modelKey = @"switch4";
//    [descriptions addObject:switchDescription];
//    
//    headerDesc = [JMFormSectionHeaderFormViewDescription new];
//    headerDesc.title = @"List selection tests title";
//    [descriptions addObject:headerDesc];
//    
//    JMListFormViewDescription *listDesc = [JMListFormViewDescription new];
//    listDesc.title = @"modal list using block";
//    listDesc.placeholder = @"Choose a color";
//    listDesc.data = model.selectedColorNAme;
//    listDesc.listStyle = JMListFormViewModalChoice;
//    listDesc.formDelegate = self;
//    listDesc.modelKey = @"selectedColorNAme";
//    listDesc.formViewHeight = 80.0f;
//    listDesc.choices = model.coloChoices;
//    [descriptions addObject:listDesc];
//    
//    listDesc = [JMListFormViewDescription new];
//    listDesc.title = @"push list using delegate";
//    listDesc.formDelegate = self;
//    listDesc.choices = model.coloChoices;
//    listDesc.placeholder = @"Choose a color";
//    listDesc.data = model.selectedColorNAme2;
//    listDesc.modelKey = @"selectedColorNAme2";
//    listDesc.listStyle = JMListFormViewAppleInlinePush;
//    listDesc.formViewHeight = 41.0f;
//    [descriptions addObject:listDesc];
//    
//    headerDesc = [JMFormSectionHeaderFormViewDescription new];
//    headerDesc.title = @"TextView tests";
//    [descriptions addObject:headerDesc];
//    
//    JMTextViewFormViewDescription *textDesc = [JMTextViewFormViewDescription new];
//    textDesc.formDelegate = self;
//    textDesc.placeholder = @"";
//    textDesc.data = model.bigText;
//    textDesc.modelKey = @"bigText";
//    [descriptions addObject:textDesc];
//    
//    textDesc = [JMTextViewFormViewDescription new];
//    textDesc.formDelegate = self;
//    textDesc.placeholder = @"";
//    textDesc.data = model.bigText2;
//    textDesc.modelKey = @"bigText2";
//    [descriptions addObject:textDesc];
//    
//    headerDesc = [JMFormSectionHeaderFormViewDescription new];
//    headerDesc.title = @"Button tests";
//    [descriptions addObject:headerDesc];
//    
//    JMButtonFormViewDescription *buttonDesc = [JMButtonFormViewDescription new];
//    buttonDesc.formDelegate = self;
//    buttonDesc.title = @"This is a validation button";
//    buttonDesc.formViewHeight = 50.0f;
//    [descriptions addObject:buttonDesc];
    
    
    formDesc.formViewDescriptions = descriptions;
    return formDesc;
}

@end
