//
//  draw2D.h
//  amazed
//
//  Created by Steven Lotito on 12/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface draw2D : UIView

void initializeMaze(int size, int maze[size][size]);

void carvePassages(int currentX, int currentY, int size, int maze[size][size]);

void drawMaze(CGContextRef context, int x_offset, int y_offset, int cell_size_px, int size, int maze[size][size]);

@end
