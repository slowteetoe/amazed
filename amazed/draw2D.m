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
    // N, S, E, W = 1, 2, 4, 8
    for(int y = 0; y < size; y ++){
        for(int x = 0; x < size; x++){
            int drawingValue = maze[y][x];
            NSLog(@"[%d][%d] = %d", x, y, drawingValue);
            if( drawingValue == 0 ){
                // do nothing
            } else if( drawingValue == 1){
                CGRect rectangle = CGRectMake(x_offset + (x*cell_size_px),
                                              y_offset + (y*cell_size_px),
                                              cell_size_px,
                                              cell_size_px);
                CGContextAddRect(context, rectangle);
            } else if( maze[y][x] == 2 ){
                CGRect rectangle = CGRectMake(x_offset + (x*cell_size_px),
                                              y_offset + (y*cell_size_px),
                                              cell_size_px,
                                              cell_size_px);
                CGContextAddRect(context, rectangle);
            } else if( drawingValue == 4){
                CGRect rectangle = CGRectMake(x_offset + (x*cell_size_px),
                                              y_offset + (y*cell_size_px),
                                              cell_size_px,
                                              cell_size_px);
                CGContextAddRect(context, rectangle);
            } else if( maze[y][x] == 8 ){
                CGRect rectangle = CGRectMake(x_offset + (x*cell_size_px),
                                              y_offset + (y*cell_size_px),
                                              cell_size_px,
                                              cell_size_px);
                CGContextAddRect(context, rectangle);
            } else {
                // oops
            }
        }
    }
}

void carvePassages(int currentX, int currentY, int size, int maze[size][size])
{
    int exp = arc4random_uniform(3);
    int value = pow(2,exp);
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
    
    carvePassages(0, 0, maze_size, maze);
    
    drawMaze(context, x_offset, y_offset, cell_size_px, maze_size, maze);

    CGContextStrokePath(context);
}


@end
