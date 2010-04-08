///
///  IGUIScrollViewElements.h
///
///  IGUILibrary
///
///  Created by Ondrej Rafaj on 8.4.10.
///
///  Copyright 2010 Home. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
	IGUIScrollViewElementsPositionLeft = 0,
	IGUIScrollViewElementsPositionRight = 1,
	IGUIScrollViewElementsPositionCenter = 2
} IGUIScrollViewElementsPosition;

typedef enum {
	IGUIScrollViewElementsUILabel = 0,
	IGUIScrollViewElementsUITextField = 1,
	IGUIScrollViewElementsUIButton = 2,
	IGUIScrollViewElementsUIImage = 2
} IGUIScrollViewElementsType;

@interface IGUIScrollViewElements : NSObject {
	
	UIScrollView *scrollView;
	
	CGRect rectScrollView;
	
	int scrollWidth;
	int scrollHeight;
	
	int actualHeight;
	
	int actualSpacing;
	BOOL ownSpacing;
	
	NSArray *elementsArray;
	
	UIColor *bcgColor;
	
	BOOL rememberPosition;
	NSString *positionIdentifier;
	
}

- (void)setWidth:(int)width andHeight:(int)height;

- (void)setSizeFromScrollView:(UIScrollView *)scView;

- (void)setBackGroudColor:(UIColor *)color;

- (void)enablePositionMemory;

- (void)enablePositionMemoryWithIdentifier:(NSString *)identifier;

- (void)setSpacing:(int)spacing;



- (void)addLabel:(UILabel *)label alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addTextView:(UITextView *)textView alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addButton:(UIButton *)button alignedTo:(IGUIScrollViewElementsPosition)position;

- (void)addImage:(UIImage *)image alignedTo:(IGUIScrollViewElementsPosition)position;



- (UIScrollView *)getWithPositionMemoryIdentifier:(NSString *)identifier;

- (UIScrollView *)get;


@end