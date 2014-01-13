//
//  ViewController.m
//  GridView
//
//  Created by Riccardo Paolillo on 06/01/14.
//  Copyright (c) 2014 Riccardo Paolillo. All rights reserved.
//

#import "ViewController.h"



@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    row   = 10;
    col   = 10;
    widht = 90;
	
    gridView            = [[GridView alloc] initWithController:self andContainer:self.container];
    gridView.delegate   = self;
    gridView.dataSourse = self;
    [gridView reloadData];
    
    [self.container refreshContentSize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionChangeRowNumber:(UIStepper *)sender
{
    row = (int)sender.value;
    [gridView reloadData];
}
- (IBAction)actionChangeColNumber:(UIStepper *)sender
{
    col = (int)sender.value;
    [gridView reloadData];
}
- (IBAction)actionChangeWidthNumber:(UIStepper *)sender
{
    widht = (int)sender.value;
    [gridView reloadData];
}


#pragma mark - TableView DataSource

- (int)numberOfRowInGridView:(GridView *)gridView
{
    return row; //Numero Di Righe
}
- (int)numberOfColumnInGridView:(GridView *)gridView
{
    return col; //Numero Di Colonne
}

- (float)widthForCellInGridView:(GridView *)gridView
{
    return widht; //Larghezza Celle
}
- (float)heightForCellInGridView:(GridView *)gridView
{
    return 45; //Alezza Celle
}

- (float)paddinBetweenCellInGridView:(GridView *)gridView
{
    return -1.0; //Spazio tra le celle
}
- (float)borderOffsetInGridView:(GridView *)gridView
{
    return 5.0; //Spazio dai bordi del container
}


- (void)gridView:(GridView *)gridView didSelectCell:(UIView *)cell atCoord:(CGPoint)coord
{
    NSLog(@"Delegate - Cella Select at index %@", NSStringFromCGPoint(coord));
}
- (UIView *)gridView:(GridView *)gridView cellAtCoord:(CGPoint)coord
{
    int type = rand() % 3;
    if (type == 0)
    {
        UIButton *button = [UIButton new];
        button.layer.borderColor = [UIColor blueColor].CGColor;
        button.layer.borderWidth = 1;
        [button setTitle:NSStringFromCGPoint(coord) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor]   forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(actionTapCell:) forControlEvents:UIControlEventTouchUpInside];
        return button;
    }
    else if (type == 1)
    {
        UILabel *label = [UILabel new];
        label.layer.borderColor = [UIColor blueColor].CGColor;
        label.layer.borderWidth = 1;
        [label setText:NSStringFromCGPoint(coord)];
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    }
    else
    {
        UITextField *text = [UITextField new];
        text.layer.borderColor = [UIColor blueColor].CGColor;
        text.layer.borderWidth = 1;
        [text setText:NSStringFromCGPoint(coord)];
        text.textAlignment = NSTextAlignmentCenter;
        text.textColor = [UIColor greenColor];
        text.delegate = self;
        text.returnKeyType = UIReturnKeyDone;
        
        return text;
    }
}

- (IBAction)actionTapCell:(UIButton *)button
{
    if (button.backgroundColor == [UIColor orangeColor])
        button.backgroundColor = [UIColor whiteColor];
    else
        button.backgroundColor = [UIColor orangeColor];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}



@end
