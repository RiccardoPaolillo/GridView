//
//  TableView.h
//  OrarioLezioni_4
//
//  Created by Riccardo Paolillo on 23/11/11.
//  Copyright (c) 2011 Università degli studi Tor Vergata. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PROPERTY_NAME_TO_STRING(prop) (@#prop)

//#define ORE    12 //dalle 8.30 alle 17.45
//#define GIORNI 6  //da lunedi a sabato

//#define L  (IS_IPAD ? (IS_LANDSCAPE ? 150 : 180)  : 120)                   //Larghezza della cella materie
//#define LO (IS_IPAD ? (IS_LANDSCAPE ? 120 : 140)  : 90)                    //Larghezza della cella orari
//#define A  (IS_IPAD ? (IS_LANDSCAPE ? 59  : 80.5) : (IS_IPHONE_5 ? 42.5 : 35.3)) //Altezza della cella

//#define S -1   //Spaziatura tra le celle sia orizzontale che verticale
//#define O 5    //Offset è il margine in alto e a destra della tabella



@interface UIScrollView (AutoContentSize)

- (void)refreshContentSize;

@end


@class GridView;

@protocol GridViewDataSouce <NSObject>

- (int)numberOfRowInGridView:(GridView *)gridView;
- (int)numberOfColumnInGridView:(GridView *)gridView;

- (float)widthForCellInGridView:(GridView *)gridView;
- (float)heightForCellInGridView:(GridView *)gridView;

- (float)paddinBetweenCellInGridView:(GridView *)gridView;
- (float)borderOffsetInGridView:(GridView *)gridView;

@end


@protocol GridViewDelegate <NSObject>

- (void)gridView:(GridView *)gridView didSelectCell:(UIView *)cell atCoord:(CGPoint)coord;
- (UIView *)gridView:(GridView *)gridView cellAtCoord:(CGPoint)coord;

@end


@interface GridView : NSObject
{
    id<GridViewDataSouce, GridViewDelegate> controller;
    
    UIView *tableContainer; //Container per la matrice
    
    int ROW;
    int COL;
    
    float L;
    float A;
    float S;
    float O;
}


@property (assign) id<GridViewDataSouce> dataSourse;
@property (assign) id<GridViewDelegate>  delegate;


//Costruttore
- (id)initWithController:(id<GridViewDataSouce, GridViewDelegate>)controller  andContainer:(UIView *)container;
- (id)initWithContainer:(UIView *)container;

//Creazine e reload della tabella
- (void)createTable;
- (void)reloadData;
- (void)resetTable;

//Gestione dei colori e dei fonts
- (void)reloadGraphicsDefault:(BOOL)isDefault;

//Gestione degli indici
- (int)getIndexFromRiga:(int)riga andColonna:(int)colonna;
- (int)getIndexFromCoord:(CGPoint)coord;
- (CGPoint)getCoordFromIndex:(int)index;

@end
