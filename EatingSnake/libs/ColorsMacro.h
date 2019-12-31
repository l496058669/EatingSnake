//
//  ColorsMacro.h
//  澳泰养车
//
//  Created by zbin.lee on 16/10/17.
//  Copyright © 2016年 aotai. All rights reserved.
//

#ifndef ColorsMacro_h
#define ColorsMacro_h


#define kARGB(r,g,b,a) [UIColor colorWithRed:r/255.00f green:g/255.00f blue:b/255.00f alpha:a]
#define kRGB(r,g,b) [UIColor colorWithRed:r/255.00f green:g/255.00f blue:b/255.00f alpha:1]

#define kHEX(rgb) [UIColor colorWithRed:(rgb/0x10000)/255.00f green:(rgb%0x10000)/0x100/255.00f blue:(rgb%0x100)/255.00f alpha:1]

#define ColorBlack kRGB(35 ,35 ,35)
#define ColorRed kRGB(248 ,48 ,63)
#define ColorBlue kRGB(85 ,186 ,254)
#define ColorGray kRGB(239 ,239 ,239)
#define ColorWhite [UIColor whiteColor]
#define ColorClear [UIColor clearColor]

#endif /* ColorsMacro_h */
