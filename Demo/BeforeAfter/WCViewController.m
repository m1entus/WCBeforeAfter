//
//  WCViewController.m
//  BeforeAfter
//
//  Created by Michał Zaborowski on 21.11.2012.
//  Copyright (c) 2012 whitecode. All rights reserved.
//

#import "WCViewController.h"
#import "WCBeforeAfter.h"
#import "WCSlider.h"

@interface WCViewController ()

@end

@implementation WCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    WCBeforeAfter *before = [[WCBeforeAfter alloc] initWithLeftSideImage:[UIImage imageNamed:@"final.jpg"] rightSideImage:[UIImage imageNamed:@"original.jpg"]];
    
    UIImageView *slider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider"]];
    
    before.sliderView = [[WCSlider alloc] initWithFrame:CGRectMake(0, 0, slider.frame.size.width, before.frame.size.height)];
    [before.sliderView addSubview:slider];
    before.sliderView.contentMode = UIViewContentModeCenter;
    
    slider.center = CGPointMake(slider.center.x, before.sliderView.center.y);
    
    [self.view addSubview:before];
    before.center = self.view.center;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
