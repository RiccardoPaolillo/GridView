//
//  TableView.m
//  OrarioLezioni_4
//
//  Created by Riccardo Paolillo on 23/11/11.
//  Copyright (c) 2011 Università degli studi Tor Vergata. All rights reserved.
//

#import "GridView.h"


@implementation UIScrollView (AutoContentSize)

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    [self refreshContentSize];
}

- (void)refreshContentSize
{
    int max_x = 0, max_y   = 0;
    int witdh = 0, height = 0;
    
    for (UIView *v in self.subviews)
    {
        if (v.frame.origin.x > max_x)
        {
            max_x = v.frame.origin.x;
            witdh = v.frame.size.width;
        }
        if (v.frame.origin.y > max_y)
        {
            max_y  = v.frame.origin.y;
            height = v.frame.size.height;
        }
    }
    
    self.contentSize                    = CGSizeMake(max_x+witdh+4, max_y+height+4);
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
}

@end


@implementation GridView


//Legenda:
//S = spazio tra le celle
//A = altezza della cella
//L = lunghezza della cella
//O = offset iniziale destro e sinistro con il bordo del container

//================================COSTRUTTORI======================================//
- (id)initWithController:(id<GridViewDataSouce, GridViewDelegate>)ctrl andContainer:(UIView *)container
{
    self = [self initWithContainer:container];
    
    if (self)
    {
        //Set delegate and datasource
        self.delegate   = ctrl;
        self.dataSourse = ctrl;
    }
    
    return self;
}

- (id)initWithContainer:(UIView *)container
{
    self = [super init];
    if (self)
    {
        //Save the grid container
        tableContainer = container;
        
        ROW = 0;
        COL = 0;
        
        L  = 0;
        A  = 0;
        S  = 0;
        O  = 0;
        
        //Clear dei container view
        [self clearContainer];
    }
    
    [self createTable];
    
    return self;
}


//Serve per eliminare tutte le view presenti nei due container
- (void)clearContainer
{
    for (UIView *v in tableContainer.subviews)
        [v removeFromSuperview];
}



- (void)resetTable
{
    [self clearContainer];
    [self createTable];
    [self reloadData];
}

//---------------Unico-Costruttore-della-tabella---------------//
- (void)createTable
{
    [self getSizeAndDimensionFromDelegate];
    
    if (tableContainer.subviews.count > 0)
        [self clearContainer];
    
    //Create the grid
    for (int i = 0; i < COL; i++)
    {
        for (int j = 0; j < ROW; j++)
        {
            UIView *cell = [self.delegate gridView:self cellAtCoord:CGPointMake(i, j)];
            
            if (cell)
                cell.frame = CGRectMake(O+S+(S+L)*i,O+S+(S+A)*j, L, A);
            if (tableContainer)
                [tableContainer addSubview:cell];
        }
    }
}

- (void)reloadData
{
    [self createTable];
    [self reloadGraphicsDefault:NO];
}

- (void)reloadGraphicsDefault:(BOOL)isDefault
{
    [self getSizeAndDimensionFromDelegate];
}


- (void)getSizeAndDimensionFromDelegate
{
    ROW = [self.dataSourse numberOfRowInGridView:self];
    COL = [self.dataSourse numberOfColumnInGridView:self];
    
    L  = [self.dataSourse widthForCellInGridView:self];
    A  = [self.dataSourse heightForCellInGridView:self];
    S  = [self.dataSourse paddinBetweenCellInGridView:self];
    O  = [self.dataSourse borderOffsetInGridView:self];
}


- (int)getIndexFromRiga:(int)riga andColonna:(int)colonna
{
    return colonna*ROW + riga;
}

- (int)getIndexFromCoord:(CGPoint)coord
{
    return coord.x*ROW + coord.y;
}

- (CGPoint)getCoordFromIndex:(int)index
{
    return CGPointMake(ceil(index/ROW), index%ROW);
}

@end
