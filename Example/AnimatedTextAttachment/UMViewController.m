//
//  UMViewController.m
//  AnimatedTextAttachment
//
//  Created by Chris Williams on 9/3/13.
//

#import "UMViewController.h"
#import <UMAnimatedTextAttachment/UMAnimatedTextAttachment.h>

@interface UMViewController ()
{
	UMAnimatedTextAttachment *randomAttachment;
}

@end

@implementation UMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	//Demonstrates an attachment using an animated UIImage
	//There's a couple libraries (like https://github.com/mayoff/uiimage-from-animated-gif) that can parse GIFs into this format
	NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Animated UIImage:\n"];
		
	UIImage *frame1 = [UIImage imageNamed:@"Frame1"];
	UIImage *frame2 = [UIImage imageNamed:@"Frame2"];
	UIImage *animation = [UIImage animatedImageWithImages:@[frame1, frame2] duration:1.0];
	
	NSTextAttachment *imageAttachment = [[UMAnimatedTextAttachment alloc] initWithImage:animation];
	[string appendAttributedString:[NSAttributedString attributedStringWithAttachment:imageAttachment]];
	
	//Demonstrates an animation using the drawRect functionality of the attachment directly
	[string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\nDrawRect animation:\n"]];
	
	randomAttachment = [[UMAnimatedTextAttachment alloc] initWithBounds:CGRectMake(0, 0, 100, 100)];
	[string appendAttributedString:[NSAttributedString attributedStringWithAttachment:randomAttachment]];
	
	//Every .5s, update the color used to fill this attachment
	NSTimer *randomTimer = [NSTimer timerWithTimeInterval:.5 target:self selector:@selector(updateRandom) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:randomTimer forMode:NSRunLoopCommonModes];
	[randomTimer fire];
	
	[self.textView setAttributedText:string];
	
	//Always allow scrolling to demonstrate scrolling performance
	[self.textView setAlwaysBounceVertical:YES];
}

- (void)updateRandom
{
	UIColor *newColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
	
	[randomAttachment drawBlock:^(CGRect rect) {
						
		[newColor set];
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
		
	}];
}


@end
