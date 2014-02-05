

#import <Foundation/Foundation.h>


@interface ALToastView : UIView {
@private
	UILabel *_textLabel;
}

+ (void)toastInView:(UIView *)parentView withText:(NSString *)text;

@end
