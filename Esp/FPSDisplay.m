#import <UIKit/UIKit.h>
#import "FPSDisplay.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface FPSDisplay ()
@property (strong, nonatomic) UILabel *displayLabel;
@property (strong, nonatomic) CADisplayLink *link;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSTimeInterval lastTime;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIFont *subFont;
@end
@implementation FPSDisplay
+(void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self shareFPSDisplay];
    });
}
+ (instancetype)shareFPSDisplay {
    static FPSDisplay *shareDisplay;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDisplay = [[FPSDisplay alloc] init];
    });
    return shareDisplay;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initDisplayLabel];
    }
    return self;
}

- (void)initDisplayLabel {





    //CGRect frame = CGRectMake(width/2-100, 0, 260, 15);
        //CGRect frame = CGRectMake(SCREEN_WIDTH-300, 0.5, 350, 30);

CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 - 4,  -1, [UIScreen mainScreen].bounds.size.width / 2  + 10, 16);

    self.displayLabel = [[UILabel alloc] initWithFrame: frame];
    self.displayLabel.layer.cornerRadius = 12;
    self.displayLabel.clipsToBounds = YES;
    self.displayLabel.textAlignment = NSTextAlignmentLeft;
        self.displayLabel.textAlignment = NSTextAlignmentCenter;
    self.displayLabel.userInteractionEnabled = NO;

 self.displayLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.000]; //background

    _font = [UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }

    [self initCADisplayLink];

    [[UIApplication sharedApplication].keyWindow addSubview:self.displayLabel];
}

- (void)initCADisplayLink {
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tick:(CADisplayLink *)link
{
    if(self.lastTime == 0){
        self.lastTime = link.timestamp;
        return;
    }
    self.count += 1;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if(delta >= 1.f){
        self.lastTime = link.timestamp;
        float fps = self.count / delta;
        self.count = 0;
        [self updateDisplayLabelText: fps];
    }
}

- (void)updateDisplayLabelText: (float) fps
{



    NSMutableString *mustr = [[NSMutableString alloc] init];
    [mustr appendFormat:@"%@",self.getSystemDate];


        self.displayLabel.text = [NSString stringWithFormat:@"Rezolver - %dFPS | %@ ",(int)round(fps),mustr];//fps

    self.displayLabel.textColor = [UIColor cyanColor];

//[UIColor colorWithRed: 0.00 green: 0.00 blue: 0.00 alpha: 0.00];;


    self.displayLabel.font = [UIFont systemFontOfSize:11];
}

- (NSString *)getSystemDate
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];


    [dateFormatter setDateFormat:@"EEEE,dd/MM/yyyy | HH:mm:ss"];

    return [dateFormatter stringFromDate:currentDate];
}

@end

