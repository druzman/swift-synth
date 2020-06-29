//
//  SWOscillator.h
//  Swift Synth
//
//  Created by drago on 29/06/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWOscillatorDefinitions.h"

NS_ASSUME_NONNULL_BEGIN

extern float SWOscillatorAmplitude;
extern float SWOscillatorFrequency;

@interface SWOscillator : NSObject

+(SWSignalFunctionType) sine;
+(SWSignalFunctionType) triangle;
+(SWSignalFunctionType) sawtooth;
+(SWSignalFunctionType) square;
+(SWSignalFunctionType) whiteNoise;

@end

NS_ASSUME_NONNULL_END
