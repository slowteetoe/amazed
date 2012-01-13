//
//  draw2D.m
//  amazed
//
//  Created by Steven Lotito on 12/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "draw2D.h"
#include <stdlib.h>
#include <math.h>

@implementation draw2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

void initializeMaze(int size, int maze[size][size])
{
    for(int y = 0; y < size; y ++){
        for(int x = 0; x < size; x++){
            maze[x][y] = 0;
        }
    }
}

void drawMaze(CGContextRef context, int x_offset, int y_offset, int cell_size_px, int size, int maze[size][size]){
    // N=1
    // S=2
    // E=4
    // W=8
    for(int y = 0; y < size; y ++){
        for(int x = 0; x < size; x++){
            // draw complete grid
            CGRect rectangle = CGRectMake(x_offset + (x*cell_size_px),
                                          y_offset + (y*cell_size_px),
                                          cell_size_px,
                                          cell_size_px);
            CGContextAddRect(context, rectangle);
        }
    }
    
    CGContextStrokePath(context);
    
    for(int y = 0; y < size; y ++){
        
        for(int x = 0; x < size; x++){
            
            CGContextSetStrokeColorWithColor(context, 
                                             [UIColor whiteColor].CGColor);
            
            int drawingValue = maze[y][x];
            
            NSLog(@"[%d][%d] = %d", x, y, drawingValue);
            
            int thisX = x_offset + x*cell_size_px;
            int thisY = y_offset + y*cell_size_px;
            
            CGContextMoveToPoint(context, thisX, thisY);
            
            int top = thisY;
            int bot = thisY + cell_size_px;
            
            int lhs = thisX;
            int rhs = thisX + cell_size_px;
            
//            NSLog(@"cell is [%d,%d],[%d,%d]  [%d,%d],[%d,%d]", lhs, top, lhs, bot, rhs, top, rhs, bot);
            
            if( drawingValue == 1){
                // draw the opening at top

                CGContextAddLineToPoint( context, rhs, top);
                CGContextStrokePath(context);
//                
//                CGContextAddLineToPoint( context, rhs, bot);
//                CGContextStrokePath(context);
//                
//                CGContextAddLineToPoint( context, rhs, top);
//                CGContextStrokePath(context);
            } else if( maze[y][x] == 2 ){
                // draw the opening at bottom

            } else if( drawingValue == 4){
                //draw opening at right

                // switch to white and 'erase' one wall


                CGContextMoveToPoint(context, rhs, top);
                
                CGContextAddLineToPoint( context, rhs, bot);
                
                CGContextStrokePath(context);

                
            } else if( maze[y][x] == 8 ){
                // draw opening at left

                CGContextMoveToPoint(context, lhs, top);
                
                CGContextAddLineToPoint( context, lhs, bot);
                
                CGContextStrokePath(context);

            } else {
                // oops
            }
        }
    }
}

void carvePassages(int currentX, int currentY, int size, int maze[size][size])
{
    int exp = arc4random_uniform(3);
    int value = pow(2,exp); // 1,2,4,8
    maze[currentX][currentY] = value;

    if( currentX + 1 < size){
        carvePassages(currentX + 1, currentY, size, maze);
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int maze_size = 16;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 7.5);
    CGContextSetStrokeColorWithColor(context, 
                                     [UIColor blueColor].CGColor);
    int cell_size_px = 40;
    int x_offset = 60;
    int y_offset = 60;
    CGRect rectangle = CGRectMake(x_offset, y_offset, maze_size*cell_size_px,maze_size*cell_size_px);
    CGContextAddRect(context, rectangle);

    int maze[maze_size][maze_size];

    initializeMaze(maze_size, maze);
    
    for(int y = 0; y < maze_size; y++){
        carvePassages(0, y, maze_size, maze);
    }
    
    drawMaze(context, x_offset, y_offset, cell_size_px, maze_size, maze);

    CGContextStrokePath(context);
}


@end
