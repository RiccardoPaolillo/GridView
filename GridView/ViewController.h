//
//  ViewController.h
//  GridView
//
//  Created by Riccardo Paolillo on 06/01/14.
//  Copyright (c) 2014 Riccardo Paolillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "GridView.h"


@class GridView;


@interface ViewController : UIViewController <GridViewDataSouce, GridViewDelegate, UITextFieldDelegate>
{
    GridView *gridView;
    
    int row, col, widht;
}


@property (nonatomic, retain) IBOutlet UIScrollView *container;


- (IBAction)actionChangeRowNumber:(id)sender;
- (IBAction)actionChangeColNumber:(id)sender;
- (IBAction)actionChangeWidthNumber:(id)sender;

@end
