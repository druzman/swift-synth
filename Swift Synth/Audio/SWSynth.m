//
//  SWSynth.m
//  Swift Synth
//
//  Created by drago on 29/06/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "SWSynth.h"
#import "SWOscillator.h"
#import <AVFoundation/AVFoundation.h>

NSString* SWSynthNotificationPlaybackStateChanged = @"SWSynthNotificationPlaybackStateChanged";

@interface SWSynth ()

@property(nonatomic, copy) SWSignalFunctionType signal;
@property(nonatomic, retain) AVAudioEngine* audioEngine;
@property(nonatomic, retain) AVAudioSourceNode* sourceNode;

@property(nonatomic, assign) float time;
@property(nonatomic, assign) double sampleRate;
@property(nonatomic, assign) float deltaTime;

@property(nonatomic, assign) BOOL isPlaying;

@end


@implementation SWSynth

+(instancetype) shared {
    static SWSynth* shared = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SWSynth alloc] init];
    });

    return shared;
}

-(instancetype) init {
    return [self initWithSignal:[SWOscillator sine]];
}

-(instancetype) initWithSignal:(SWSignalFunctionType) signal {
    if (self = [super init]) {
        self.signal = signal;

        [self setupEngine];
    }

    return self;
}

-(void) setWaveformToSignal:(SWSignalFunctionType) signal {
    self.signal = signal;
}

#pragma mark - Volume

- (float) volume {
    return self.audioEngine.mainMixerNode.outputVolume;
}

-(void) setVolume:(float) volume {
    self.audioEngine.mainMixerNode.outputVolume = volume;

    BOOL isPlaying = (volume > 0.001);

    [self updatePlaybackState:isPlaying];
}

#pragma mark - Playback state

-(void) updatePlaybackState:(BOOL) isPlaying {
    if (self.isPlaying == isPlaying) {
        return;
    }

    self.isPlaying = isPlaying;

    [[NSNotificationCenter defaultCenter] postNotificationName:SWSynthNotificationPlaybackStateChanged object:self];
}

#pragma mark - Private

-(void) setupEngine {
    self.audioEngine = [AVAudioEngine new];

    AVAudioMixerNode* mainNode = self.audioEngine.mainMixerNode;
    AVAudioOutputNode* outputNode = self.audioEngine.outputNode;
    AVAudioFormat* format = [outputNode outputFormatForBus:0];

    self.sampleRate = format.sampleRate;
    self.deltaTime = 1.0 / (float)self.sampleRate;

    AVAudioFormat* inputFormat = [[AVAudioFormat alloc] initWithCommonFormat:format.commonFormat
                                                                  sampleRate:self.sampleRate
                                                                    channels:1
                                                                 interleaved:format.isInterleaved];

    [self setupSourceNode];

    [self.audioEngine attachNode:self.sourceNode];
    [self.audioEngine connect:self.sourceNode to:mainNode format:inputFormat];
    [self.audioEngine connect:mainNode to:outputNode format:nil];

    NSError* startError = nil;
    [self.audioEngine startAndReturnError:&startError];

    if (startError != nil) {
        NSLog(@"Could not start audioEngine: %@", startError.localizedDescription);
    }
}

-(void) setupSourceNode {
    __weak typeof(self) weakSelf = self;

    self.sourceNode = [[AVAudioSourceNode alloc] initWithRenderBlock:^OSStatus(BOOL * _Nonnull isSilence,
                                                                               const AudioTimeStamp * _Nonnull timestamp,
                                                                               AVAudioFrameCount frameCount,
                                                                               AudioBufferList * _Nonnull outputData) {

        __strong typeof(weakSelf) strongSelf = weakSelf;

        for (int frame=0; frame<frameCount; ++frame) {
            float sampleVal = strongSelf.signal(strongSelf.time);
            strongSelf.time += strongSelf.deltaTime;

            for (int bufferIndex=0; bufferIndex<outputData->mNumberBuffers; ++bufferIndex) {
                float* buffer = (float*)(outputData->mBuffers[bufferIndex].mData);
                buffer[frame] = sampleVal;
            }
        }

        return noErr;
    }];
}

@end
