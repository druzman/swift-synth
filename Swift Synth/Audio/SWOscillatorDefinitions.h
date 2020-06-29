//
//  SWOscillatorDefinitions.h
//  Swift Synth
//
//  Created by drago on 29/06/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#ifndef SWOscillatorDefinitions_h
#define SWOscillatorDefinitions_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SWWaveform) {
    SWWaveformSine,
    SWWaveformTriangle,
    SWWaveformSawtooth,
    SWWaveformSquare,
    SWWaveformWhiteNoise
};

typedef float(^SWSignalFunctionType)(float time);

#endif /* SWOscillatorDefinitions_h */
