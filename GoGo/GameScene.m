//
//  GameScene.m
//  GoGo
//
//  Created by 王振西 on 15/12/15.
//  Copyright (c) 2015年 王振西. All rights reserved.
//
#import "GameScene.h"
///ksskaaas
@interface GameScene ()
@property BOOL contentCreated;
@property(strong, nonatomic) SKSpriteNode *button;
@property(strong, nonatomic) NSArray *texturearray;
@end
@implementation GameScene
- (void)didMoveToView:(SKView *)view {
  if (!self.contentCreated) {
    [self createSceneContents];
    self.contentCreated = YES;
  }
}
- (void)createSceneContents {
  //    self.backgroundColor = [SKColor blackColor];
  //    self.scaleMode = SKSceneScaleModeAspectFit;
  [self addChild:[self newBackground]];
  [self addChild:[self newHelloNode]];
  [self addChild:[self addPosNode]];
  [self addButton];
}
- (SKSpriteNode *)newBackground {
  SKSpriteNode *background =
      [[SKSpriteNode alloc] initWithImageNamed:@"background_bg"];
  background.position =
      CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
  background.size = CGSizeMake(self.size.width, self.size.height);
  //    background.xScale=self.size.width/background.size.width;
  //    background.yScale=self.size.height/background.size.height;
  background.zPosition = 0;
  return background;
}
- (SKLabelNode *)newHelloNode {
  SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  helloNode.text = @"first chapter";
  helloNode.fontSize = 30;
  helloNode.name = @"helloNode";
  helloNode.zPosition = 3;
  helloNode.position =
      CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 200);
  return helloNode;
}
- (SKSpriteNode *)addPosNode {
  SKSpriteNode *posNode = [[SKSpriteNode alloc] initWithImageNamed:@"pos"];
  posNode.position =
      CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
  posNode.zPosition = 2;
  return posNode;
}
- (void)addButton {
  SKTexture *texture1 = [SKTexture textureWithImageNamed:@"button-start-on"];
  SKTexture *texture2 = [SKTexture textureWithImageNamed:@"button-start-off"];
  _texturearray = @[ texture1, texture2 ];
  _button = [[SKSpriteNode alloc] initWithTexture:texture1];
  _button.position = CGPointMake(CGRectGetWidth(self.frame) * 3 / 4,
                                 CGRectGetHeight(self.frame) * 1 / 4 - 10);
  _button.zPosition = 2;
  _button.anchorPoint = CGPointZero;
  [self addChild:_button];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint location = [touch locationInNode:self];
    if (location.x > CGRectGetWidth(self.frame) * 3 / 4 &&
        location.x < CGRectGetWidth(self.frame) * 3 / 4 + 120 &&
        location.y > CGRectGetHeight(self.frame) * 1 / 4 - 10 &&
        location.y < CGRectGetHeight(self.frame) * 1 / 4 + 50) {
      //            _button.xScale=1.5;
      //            _button.yScale=1.5;
      SKAction *highlight =
          [SKAction animateWithTextures:_texturearray timePerFrame:0.1];
      [_button runAction:highlight];
      [self transToPlayScene];
    }
  }
}
- (void)transToPlayScene {
  SKNode *helloNode = [self childNodeWithName:@"helloNode"];
  NSLog(@"before action");
  if (helloNode != nil) {
    helloNode.name = nil;
    SKAction *moveUp = [SKAction moveByX:0 y:100.0 duration:0.5];
    SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];
    SKAction *pause = [SKAction waitForDuration:0.5];
    SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *moveSequence =
        [SKAction sequence:@[ moveUp, zoom, pause, fadeAway, remove ]];
    NSLog(@"have touched");
    /*[helloNode runAction:moveSequence];*/
    [helloNode runAction:moveSequence
              completion:^{
                SKScene *playScene = [[PlayScene alloc] initWithSize:self.size];
                SKTransition *doors =
                    [SKTransition doorsOpenVerticalWithDuration:0.5];
                [self.view presentScene:playScene transition:doors];
              }];
  }
}

- (void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}
@end
