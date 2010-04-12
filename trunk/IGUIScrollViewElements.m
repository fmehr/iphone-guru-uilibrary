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
#define kIGUIScrollViewElementsDefaultSideSpacing					20


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
	if (oldFrame.size.width == 0) oldFrame.size.width = scrollWidth;
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

- (void)addCustom:(UIView *)element alignedTo:(IGUIScrollViewElementsPosition)position {
	element.frame = [self getNewFrameFromFrame:element.frame andPosition:position];
	[self addHeight:element.frame.size.height];
	[self addElement:element];
}

- (void)addLabel:(UILabel *)label alignedTo:(IGUIScrollViewElementsPosition)position {
	label.backgroundColor = [UIColor clearColor];
	label.numberOfLines = 0;
	if (label.frame.size.height == 0) {
		CGSize max = CGSizeMake((scrollWidth - (2 * kIGUIScrollViewElementsDefaultSideSpacing)), 9999);
		CGSize expected = [label.text sizeWithFont:label.font constrainedToSize:max lineBreakMode:label.lineBreakMode]; 
		CGRect newFrame = label.frame;
		newFrame.size.width = expected.width;
		newFrame.size.height = expected.height;
		label.frame = newFrame;
		if (position == IGUIScrollViewElementsPositionRight) label.textAlignment = UITextAlignmentRight;
		else if (position == IGUIScrollViewElementsPositionCenter) label.textAlignment = UITextAlignmentCenter;
		else label.textAlignment = UITextAlignmentLeft;
	}
	label.frame = [self getNewFrameFromFrame:label.frame andPosition:position];
	[self addHeight:label.frame.size.height];
	[self addElement:label];
}

- (void)addTextView:(UITextView *)textView alignedTo:(IGUIScrollViewElementsPosition)position {
	textView.backgroundColor = [UIColor clearColor];
	textView.frame = [self getNewFrameFromFrame:textView.frame andPosition:position];
	if (textView.frame.size.height == 0) {
		CGSize max = CGSizeMake(scrollWidth, 9999);
		CGSize expected = [textView.text sizeWithFont:textView.font constrainedToSize:max lineBreakMode:UILineBreakModeWordWrap]; 
		CGRect newFrame = textView.frame;
		if (expected.height > (expected.height -= (2 * kIGUIScrollViewElementsDefaultSpacing))) expected.height -= (2 * kIGUIScrollViewElementsDefaultSpacing);
		newFrame.size.height = expected.height;
		textView.frame = newFrame;
		if (position == IGUIScrollViewElementsPositionRight) textView.textAlignment = UITextAlignmentRight;
		else if (position == IGUIScrollViewElementsPositionCenter) textView.textAlignment = UITextAlignmentCenter;
		else textView.textAlignment = UITextAlignmentLeft;
	}
	textView.frame = [self getNewFrameFromFrame:textView.frame andPosition:position];
	textView.editable = NO;
	[self addHeight:textView.frame.size.height];
	[self addElement:textView];
}

- (void)addButton:(UIButton *)button withTarget:(id)target andSelector:(SEL)selector alignedTo:(IGUIScrollViewElementsPosition)position {
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	if (button.frame.size.height == 0) {
		CGSize max = CGSizeMake(scrollWidth, 9999);
		CGSize expected = [button.titleLabel.text sizeWithFont:button.titleLabel.font constrainedToSize:max lineBreakMode:UILineBreakModeTailTruncation];
		int diff = (37 - expected.height);
		if (position == IGUIScrollViewElementsPositionFull) expected.width = ((scrollWidth - diff) - (2 * kIGUIScrollViewElementsDefaultSideSpacing));
		button.frame = CGRectMake(0, 0, (expected.width + diff), 37);
	}
	button.backgroundColor = [UIColor clearColor];
	button.frame = [self getNewFrameFromFrame:button.frame andPosition:position];
	[self addHeight:button.frame.size.height];
	[self addElement:button];
}

- (void)addButtonWithTitle:(NSString *)title withTarget:(id)target andSelector:(SEL)selector alignedTo:(IGUIScrollViewElementsPosition)position {
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[btn setTitle:title forState:UIControlStateNormal];
	[self addButton:btn withTarget:target andSelector:selector alignedTo:position];
}

- (void)addImage:(UIImage *)image alignedTo:(IGUIScrollViewElementsPosition)position {
	UIImageView *iv = [[UIImageView alloc] initWithImage:image];
	if (iv.frame.size.width > scrollWidth) {
		int oldW = iv.frame.size.width;
		int newW = (scrollWidth - (2 * kIGUIScrollViewElementsDefaultSideSpacing));
		CGRect nf = CGRectMake(0, 0, newW, (iv.frame.size.height * newW) / oldW);
		iv.frame = nf;
		iv.contentMode = UIViewContentModeScaleToFill;
	}
	iv.frame = [self getNewFrameFromFrame:iv.frame andPosition:position];
	[self addHeight:iv.frame.size.height];
	[self addElement:iv];
	[iv release];
}

- (void)addImageFromUrl:(NSString *)imageUrl withPreloader:(BOOL)preloader alignedTo:(IGUIScrollViewElementsPosition)position {
	/*UIImageView *iv = [[UIImage alloc] initWithData:<#(NSData *)data#>];
	iv.frame = [self getNewFrameFromFrame:iv.frame andPosition:position];
	[self addHeight:iv.frame.size.height];
	[self addElement:iv];*/
}

- (UIScrollView *)getWithPositionMemoryIdentifier:(NSString *)identifier {
	[self addHeight:[self getSpacing]];
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
	scrollView.contentSize = CGSizeMake(scrollWidth, [self getHeight]);
	if (!bcgColor) bcgColor = [UIColor clearColor];
	scrollView.backgroundColor = bcgColor;
	scrollView.alwaysBounceHorizontal = NO;
	scrollView.alwaysBounceVertical = YES;
	
	//if ([scrollView setscrollType
	
	if (elementsArray) for (id object in elementsArray) {
		if ([object isKindOfClass:[UILabel class]]) {
			UILabel *o = (UILabel *)object;
			if (bcgColor == [UIColor blackColor] && o.textColor == [UIColor blackColor]) o.textColor = [UIColor whiteColor];
			[scrollView addSubview:o];
		}
		else if ([object isKindOfClass:[UITextView class]]) {
			UITextView *o = (UITextView *)object;
			if (bcgColor == [UIColor blackColor] && o.textColor == [UIColor blackColor]) o.textColor = [UIColor whiteColor];
			else if (bcgColor == [UIColor whiteColor] && o.textColor == [UIColor whiteColor]) o.textColor = [UIColor blackColor];
			[scrollView addSubview:o];
		}
		else [scrollView addSubview:object];
	}
	
	return scrollView;
}

- (UIScrollView *)get {
	return [self getWithPositionMemoryIdentifier:kIGUIScrollViewElementsPositionIdentifier];
}

@end
