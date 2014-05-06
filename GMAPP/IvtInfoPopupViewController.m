//
//  IvtInfoPopupViewController.m
//  GMAPP
//
//  Created by hjs6877 on 5/4/14.
//  Copyright (c) 2014 황정식. All rights reserved.
//

#import "IvtInfoPopupViewController.h"

@interface IvtInfoPopupViewController ()

@end

@implementation IvtInfoPopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)returnToIvtInfoPopup:(UIStoryboardSegue*)seque
{
    
}

/**
 재물조사 실시 액션 메서드
*/
- (IBAction)executeIvt:(id)sender {
    NSString* msg = @"재물 조사를 완료하였습니다.\n관리자 승인을 기다리세요.";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg delegate:nil
                                          cancelButtonTitle:@"확인"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
