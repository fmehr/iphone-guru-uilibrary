///
///  IGUIScrollViewImage.h
///
///  IGUILibrary
///
///  Created by Ondrej Rafaj on 7.4.10.
///
///  Copyright 2010 Home. All rights reserved.
///
/// @todo enable margin and center the image to the middle of the view

/*
 
 <b>Examples:</b>
 
 <i>This is just a short example how to use this class</i>
 
 <pre>
 - (NSArray *)getImages {
	NSMutableArray *arr = [[[NSMutableArray alloc] init] autorelease];
	[arr addObject:[UIImage imageNamed:@"image-1.jpg"]];
	[arr addObject:[UIImage imageNamed:@"image-2.png"]];
	[arr addObject:[UIImage imageNamed:@"image-3.png"]];
	[arr addObject:[UIImage imageNamed:@"image-4.jpg"]];
	return (NSArray *)arr;
 }
 
 - (void)viewDidLoad {
	IGUIScrollViewImage *svimage = [[IGUIScrollViewImage alloc] init];
 
	[svimage setSizeFromScrollView:self.scrView]; // takes size of the scroll view you've already placed on stage via Interface Builder
	// or
	//[svimage setWidth:320 andHeight:240]; // half screen
 
	[svimage enablePositionMemory]; // enables position (pagination) memory for this scroll view
	// or
	//[svimage enablePositionMemoryWithIdentifier:@"myIdentifier"]; if you have more instances of this scroll view in your application
 
	[svimage enablePageControlOnBottom];
	// or
	//[svimage enablePageControlOnTop];
 
	[self.myUIView addSubview:[svimage get]]; // and place it on the stage :)
	[super viewDidLoad];
 }
 </pre>
 
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface IGUIScrollViewImage : NSObject <UIScrollViewDelegate> {
	
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	
	CGRect rectScrollView;
	CGRect rectPageControl;
	
	int scrollWidth;
	int scrollHeight;
	
	NSArray *contentArray;
	
	UIColor *bcgColor;
	
	BOOL pageControlEnabledTop;
	BOOL pageControlEnabledBottom;
	
	BOOL rememberPosition;
	NSString *positionIdentifier;
	
}

@property (nonatomic, retain) UIScrollView *scrollView;

- (int)getScrollViewWidth;

- (void)setWidth:(int)width andHeight:(int)height;

- (void)setSizeFromScrollView:(UIScrollView *)scView;

- (void)setBackGroudColor:(UIColor *)color;

- (void)setContentArray:(NSArray *)images;

- (void)enablePageControlOnTop;

- (void)enablePageControlOnBottom;

- (void)enablePositionMemory;

- (void)enablePositionMemoryWithIdentifier:(NSString *)identifier;

- (UIScrollView *)getWithPosition:(int)page;

- (UIScrollView *)getWithPositionMemory;

- (UIScrollView *)getWithPositionMemoryIdentifier:(NSString *)identifier;

- (UIScrollView *)get;

@end
