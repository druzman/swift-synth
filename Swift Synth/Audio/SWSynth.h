//
//  SWSynth.h
//  Swift Synth
//
//  Created by drago on 29/06/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWOscillatorDefinitions.h"

extern NSString* SWSynthNotificationPlaybackStateChanged;

NS_ASSUME_NONNULL_BEGIN

@interface SWSynth : NSObject

+(instancetype) shared;

-(instancetype) init;
-(instancetype) initWithSignal:(SWSignalFunctionType) signal;

-(void) setWaveformToSignal:(SWSignalFunctionType) signal;

@property(nonatomic, assign) float volume;
@property(nonatomic, readonly) BOOL isPlaying;

@end

NS_ASSUME_NONNULL_END
