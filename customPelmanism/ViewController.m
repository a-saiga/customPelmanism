//
//  ViewController.m
//  customPelmanism
//
//  Created by 井上 彩加 on 2013/10/17.
//  Copyright (c) 2013年 井上彩加. All rights reserved.
//

#import "ViewController.h"

#define CARDS 6

@interface ViewController ()
{
    //location and size
    int cWidth;
    int cHeight;
    int playWidth;
    int playHeight;
    int cardWidth;
    int cardHeight;
    
    //card operator
    int stat; //0:表 1:浦 2:今浦返し
    int tCount;
    
    //cards
    NSMutableArray *cardStatuses;
    NSArray *imageNames;
    UIImage *frontImg;
    NSString *cardImage;
    UIImage *flippedImg;
    NSString *previous;
    
    //character number
    enum{
        Honoka = 1,
        Umi,
        Kotori,
        maki,
        rin,
        hanayo,
        eri,
        nozomi,
        nico
    };
    
    enum{
        Front,
        Back,
        Flipped
    };
    
}



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    cWidth = self.view.frame.size.width;
    cHeight = self.view.frame.size.height;
    playWidth = cWidth - 10;
    playHeight = cHeight - 40;
    cardWidth = (playWidth - 30)/2;
    cardHeight = (playHeight - 90)/6;
    
    //initialization
    stat = Front;
    tCount = 0;
    frontImg = [UIImage imageNamed:@"omote.jpg"];
    
    cardStatuses = [NSMutableArray array];
    
    imageNames = @[
                   @{@"imgName":@"smile_honoka.jpg", @"cName":@"honoka"},
                   @{@"imgName":@"smile_honoka_kakusei.jpg", @"cName":@"honoka"},
                   @{@"imgName":@"smile_umi.jpg", @"cName":@"umi"},
                   @{@"imgName":@"smile_umi_kakusei.jpg", @"cName":@"umi"},
                   @{@"imgName":@"smile_kotori.jpg", @"cName":@"kotori"},
                   @{@"imgName":@"smile_kotori_kakusei.jpg" ,@"cName":@"kotori"}
                   ];
    
    NSLog(@"aaa");
    
    //generating cards
    for (int i = 0; i<CARDS; i++){

        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((cWidth-cardWidth)/2, (10+cardHeight)*i, cardWidth, cardHeight)];
        [btn setBackgroundImage:frontImg forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = i;
        NSDictionary *cardStatus = @{@"cName":imageNames[i][@"cName"],@"state":@"stat", @"tapCount":@"tCount", @"img":imageNames[i][@"imgName"], @"btn":btn};
        [cardStatuses addObject:cardStatus];
        [self.view addSubview:btn];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


-(void)play
{
    
}
-(IBAction)tapBtn:(UIButton *)btn
{
    /* NSString *title = @"alert";
     NSString *msg = @"message";
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
     [alert show];*/
    
    
    
    cardImage = cardStatuses[btn.tag][@"img"];
    flippedImg = [UIImage imageNamed:cardImage];
    [btn setBackgroundImage:flippedImg forState:UIControlStateNormal];
    
    
    if(tCount < 2){
        tCount++;
        if(tCount == 2){
            if([previous isEqualToString:cardStatuses[btn.tag][@"cName"] ]){

                tCount=0;
                return;
                
            }
            for (int i = 0; i<CARDS; i++){
                [cardStatuses[i][@"btn"] setBackgroundImage:frontImg forState:UIControlStateNormal];
            }
            tCount=0;
        }
        NSLog(@"%d",tCount);
        
    }
    
    previous = [NSString stringWithFormat:@"%@",cardStatuses[btn.tag][@"cName"]];
    
    
    
}
@end
