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
#define kIGUIScrollViewElementsDefaultSideSpacing					25


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
	actualHeight += [self getSpacing];
}

- (int)getHeight {
	if (!actualHeight) actualHeight = kIGUIScrollViewElementsDefaultSpacing;
	return actualHeight;
}

- (CGRect)getNewFrameFromFrame:(CGRect)oldFrame andPosition:(IGUIScrollViewElementsPosition)position {
	[self addHeight:oldFrame.size.height];
	int pos;
	if (position == IGUIScrollViewElementsPositionLeft) pos = kIGUIScrollViewElementsDefaultSideSpacing;
	else {
		pos = ([[UIScreen mainScreen] applicationFrame].size.width - oldFrame.size.width);
		if (position == IGUIScrollViewElementsPositionRight) pos -= kIGUIScrollViewElementsDefaultSideSpacing;
		else pos = (pos / 2);
	}
	return CGRectMake(pos, [self getHeight], oldFrame.size.width, oldFrame.size.height);
}

- (void)addElement:(id)element {
	if (!elementsArray) elementsArray = [[[NSMutableArray alloc] init] autorelease];
	[elementsArray addObject:element];
}

- (void)addLabel:(UILabel *)label alignedTo:(IGUIScrollViewElementsPosition)position {
	label.frame = [self getNewFrameFromFrame:label.frame andPosition:position];
	[self addElement:label];
}

- (void)addTextView:(UITextView *)textView alignedTo:(IGUIScrollViewElementsPosition)position {
	textView.frame = [self getNewFrameFromFrame:textView.frame andPosition:position];
	[self addElement:textView];
}

- (void)addButton:(UIButton *)button alignedTo:(IGUIScrollViewElementsPosition)position {
	button.frame = [self getNewFrameFromFrame:button.frame andPosition:position];
	[self addElement:button];
}

- (void)addImage:(UIImage *)image alignedTo:(IGUIScrollViewElementsPosition)position {
	UIImageView *iv = [[UIImageView alloc] initWithImage:image];
	iv.frame = [self getNewFrameFromFrame:iv.frame andPosition:position];
	[self addElement:iv];
}

- (UIScrollView *)getWithPositionMemoryIdentifier:(NSString *)identifier {
	[self addHeight:[self getSpacing]];
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
	scrollView.contentSize = CGSizeMake(scrollWidth, [self getHeight]);
	if (!bcgColor) bcgColor = [UIColor clearColor];
	scrollView.backgroundColor = bcgColor;
	scrollView.alwaysBounceHorizontal = NO;
	scrollView.alwaysBounceVertical = YES;
	
	if (elementsArray) for (id object in elementsArray) {
		[scrollView addSubview:object];
	}
	
	return scrollView;
}

- (UIScrollView *)get {
	return [self getWithPositionMemoryIdentifier:kIGUIScrollViewElementsPositionIdentifier];
}

@end
