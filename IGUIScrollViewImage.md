# Introduction #

Use this class if you want to horizontal UIScrollView with images and pagination.


# Details #

**Example:**

```

- (NSArray *)getImages {
	NSMutableArray *arr = [[[NSMutableArray alloc] init] autorelease];
	[arr addObject:[UIImage imageNamed:@"1.jpg"]];
	[arr addObject:[UIImage imageNamed:@"2.jpg"]];
	[arr addObject:[UIImage imageNamed:@"3.jpg"]];
	[arr addObject:[UIImage imageNamed:@"4.jpg"]];
	[arr addObject:[UIImage imageNamed:@"5.jpg"]];
	[arr addObject:[UIImage imageNamed:@"6.jpg"]];
	[arr addObject:[UIImage imageNamed:@"7.jpg"]];
	return (NSArray *)arr;
}

- (void)viewDidLoad {
	IGUIScrollViewImage *svimage = [[IGUIScrollViewImage alloc] init];
	[svimage setContentArray:[self getImages]];
	[svimage setSizeFromParentView:self.myUIView];
	[svimage enablePageControlOnBottom];
	[self.myUIView addSubview:[svimage getWithPositionMemory]];
}


```

Please look at the header file as there is few more methods you can use to customize your view.

