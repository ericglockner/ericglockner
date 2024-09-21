//
//  PubgLoad.m
//  pubg
//
//  Created by 李良林 on 2021/2/14.
//

#import "PubgLoad.h"
#import <UIKit/UIKit.h>
//#import "../API/APIKey.h"
#import "JHPP.h"
#import "mahoa.h"
#import "JHDragView.h"
#import "ImGuiLoad.h"
#import "ImGuiDrawView.h"
#import "FTNotificationIndicator.h"
#import "iconbase.h"


@interface PubgLoad()
@property (nonatomic, strong) ImGuiDrawView *vna;
@end

@implementation PubgLoad
static BOOL MenDeal;
static PubgLoad *extraInfo;

UIWindow *pidorik;


  NSString *tendv = [[UIDevice currentDevice] name]; 

  NSString *lqicon1 = lqmbconfig;
    NSData* datalq1 = [[NSData alloc] initWithBase64EncodedString:lqicon1 options:0];
    UIImage* img2 = [UIImage imageWithData:datalq1];



+ (void)load
{
[super load];
 

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
 
pidorik = [UIApplication sharedApplication].keyWindow;
            extraInfo =  [PubgLoad new];
            [extraInfo initTapGes];
            [extraInfo tapIconView];
            [extraInfo initTapGes2];
            [extraInfo tapIconView2];
            [extraInfo tapmenuicon];



             

        });
        
    }


-(void)tapmenuicon
{
    JHDragView *view = [[JHPP currentViewController].view viewWithTag:100];
    if (!view) {
        view = [[JHDragView alloc] init];
        view.tag = 100;
        [[JHPP currentViewController].view addSubview:view];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconView)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
    }
    if (!MenDeal) {
        view.hidden = NO;
    } else {
        view.hidden = YES;
    }
    MenDeal = !MenDeal;
}





+(void)Show_Times{  

 
UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4 - 5, 0, [UIScreen mainScreen].bounds.size.width / 2  + 10, 20)];

myLabel.textColor = [UIColor greenColor];
myLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:13.0];
myLabel.numberOfLines = 0;
myLabel.text = @"";
myLabel.textAlignment = NSTextAlignmentCenter;
myLabel.shadowColor = [UIColor blackColor];
myLabel.shadowOffset = CGSizeMake(1.0,1.0); 


[pidorik addSubview:myLabel];
  [[[[UIApplication sharedApplication] windows]lastObject] addSubview:myLabel];


        
}
-(void)initTapGes
{
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 99;//số ngón chạm
    tap.numberOfTouchesRequired = 99;//số lần chạm
    [[JHPP currentViewController].view addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapIconView)];
}

-(void)initTapGes2
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 2;//点击次数
    tap.numberOfTouchesRequired = 2;//手指数
    [[JHPP currentViewController].view addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapIconView2)];
}

-(void)tapIconView2
{
 if (!_vna) {
     ImGuiDrawView *vc = [[ImGuiDrawView alloc] init];
     _vna = vc;
 }
 
 [ImGuiDrawView showChange:false];
 [[UIApplication sharedApplication].windows[0].rootViewController.view addSubview:_vna.view];
}

-(void)tapIconView
{
 if (!_vna) {
     ImGuiDrawView *vc = [[ImGuiDrawView alloc] init];
     _vna = vc;
 }
 
 [ImGuiDrawView showChange:true];
 [[UIApplication sharedApplication].windows[0].rootViewController.view addSubview:_vna.view];
}









@end
