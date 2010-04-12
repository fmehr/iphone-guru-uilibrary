//
//  IGUIMapKit.h
//  IGUILibrary
//
//  Created by Ondrej Rafaj on 12.4.10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "IGUIMapKitAnnotation.h"



@interface IGUIMapKit : NSObject {
	
	NSMutableArray *traceRoute;
	
}

- (void)setWidth:(int)width andHeight:(int)height;

- (void)setSizeFromView:(UIView *)view;

- (void)addAnnotation:(IGUIMapKitAnnotation *)annotation;

- (void)addTraceRoute:(IGUIMapKitAnnotation *)annotation;

- (UIView *)get;


@end
