#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class BFPaperCheckbox;
@protocol BFPaperCheckboxDelegate <NSObject>
@optional

- (void)paperCheckboxChangedState:(BFPaperCheckbox *)checkbox;
@end


IB_DESIGNABLE
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 100000

@interface BFPaperCheckbox : UIControl <UIGestureRecognizerDelegate>
#else
@interface BFPaperCheckbox : UIControl <UIGestureRecognizerDelegate,CAAnimationDelegate>
#endif

#pragma mark - Constants
/** A nice recommended value for size. (eg. [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(x, y, bfPaperCheckboxDefaultDiameter, bfPaperCheckboxDefaultDiameter)]; */
extern CGFloat const bfPaperCheckboxDefaultDiameter;


#pragma mark - Properties
#pragma mark Animation


@property IBInspectable CGFloat touchDownAnimationDuration;

@property IBInspectable CGFloat touchUpAnimationDuration;


@property IBInspectable BOOL rippleFromTapLocation;

#pragma mark Colors

@property IBInspectable UIColor *checkmarkColor;


@property IBInspectable UIColor *positiveColor;


@property IBInspectable UIColor *negativeColor;

#pragma mark Sizing

@property (nonatomic) IBInspectable CGFloat cornerRadius;


@property IBInspectable CGFloat startDiameter;


@property IBInspectable CGFloat endDiameter;


@property IBInspectable CGFloat burstAmount;

#pragma mark Status

@property (nonatomic, readonly) BOOL isChecked;

#pragma mark Delegate

@property (weak) id <BFPaperCheckboxDelegate> delegate;


#pragma mark - Utility Functions

- (void)switchStatesAnimated:(BOOL)animated;

- (void)checkAnimated:(BOOL)animated;


- (void)uncheckAnimated:(BOOL)animated;
@end
