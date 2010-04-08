//
//  IGUIScrollViewElements.m
//  IGUILibrary
//
//  Created by Ondrej Rafaj on 8.4.10.
//  Copyright 2010 Home. All rights reserved.
//

#import "IGUIScrollViewElements.h"

#define kIGUIScrollViewElementsPositionIdentifier					@"kIGUIScrollViewElementsPositionIdentifier"
#define kIGUIScrollViewElementsDefaultPositionIdentifier			@"Default"

#define kIGUIScrollViewElementsDefaultSpacing						20


@implementation IGUIScrollViewElements


- (void)setWidth:(int)width andHeight:(int)height {
	scrollWidth = width;
	scrollHeight = height;
	if (!width || !height) rectScrollView = [[UIScreen mainScreen] applicationFrame];
	else rectScrollView = CGRectMake(0, 0, width, height);
}

- (void)setSizeFromScrollView:(UIScrollView *)scView {
	scrollWidth = scView.frame.size.width;
	scrollHeight = scView.frame.size.height;
	rectScrollView = CGRectMake(0, 0, scrollWidth, scrollHeight);
}

- (void)setBackGroudColor:(UIColor *)color {
	bcgColor = color;
}

- (void)enablePositionMemoryWithIdentifier:(NSString *)identifier {
	rememberPosition = YES;
	if (!identifier) identifier = kIGUIScrollViewElementsPositionIdentifier;
	positionIdentifier = identifier;
}

- (void)enablePositionMemory {
	[self enablePositionMemoryWithIdentifier:nil];
}

-(CGRect)getaaa {
	return CGRectMake(0, 0, scrollWidth, scrollHeight);
}

- (void)setSpacing:(int)spacing {
	actualSpacing = spacing;
	ownSpacing = YES;
}

- (int)getSpacing {
	if (!ownSpacing) return kIGUIScrollViewElementsDefaultSpacing;
	else return actualSpacing;
}

- (void)addHeight:(int)height {
	actualHeight += height;
}

- (int)getHeight {
	if (!actualHeight) actualHeight = kIGUIScrollViewElementsDefaultSpacing;
	return actualHeight;
}

- (void)addLabel:(UILabel *)label alignedTo:(IGUIScrollViewElementsPosition)position {
	[self addHeight:40];
}

- (void)addTextView:(UITextView *)textView alignedTo:(IGUIScrollViewElementsPosition)position {
	[self addHeight:40];
}

- (void)addButton:(UIButton *)button alignedTo:(IGUIScrollViewElementsPosition)position {
	[self addHeight:40];
}

- (void)addImage:(UIImage *)image alignedTo:(IGUIScrollViewElementsPosition)position {
	[self addHeight:40];
}

- (UIScrollView *)getWithPositionMemoryIdentifier:(NSString *)identifier {
	[self addHeight:[self getSpacing]];
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
	scrollView.contentSize = CGSizeMake(scrollWidth, [self getHeight]);
	if (!bcgColor) bcgColor = [UIColor clearColor];
	scrollView.backgroundColor = bcgColor;
	scrollView.alwaysBounceHorizontal = NO;
	scrollView.alwaysBounceVertical = YES;
	
	return scrollView;
}

- (UIScrollView *)get {
	return [self getWithPositionMemoryIdentifier:kIGUIScrollViewElementsPositionIdentifier];
}

@end
