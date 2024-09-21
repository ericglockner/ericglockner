
#include <iostream>
#include <string>
#include "dlfcn.h"
#import <UIKit/UIAlertView.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#import <Foundation/Foundation.h>
#import "Esp/UIColor+CZColor.h"
#import <UIKit/UIKit.h>





%hook NSBundle
+ (id)bundleWithPath:(NSString *)fullPath
{
  if ([fullPath isEqual:@"/System/Library/Frameworks/Metal.framework"]) 
  {
    NSLog(@"distable metal framework");
    return NULL;
  }

  return %orig(fullPath);
}

%end










