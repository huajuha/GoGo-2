//
//  CoinNode.m
//  GoGo
//
//  Created by 冯斌 on 16/4/11.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import "CoinNode.h"
@interface CoinNode()
@property (strong,nonatomic)SKTexture *texture;
@end
@implementation CoinNode
- (instancetype)
initWithShape:(NSInteger)shape
       Length:
           (NSUInteger)
               length { // shape=1表示要画一个圆形，函数会根据给出个距离来测算需要绘制多少个金币
  if (self = [super init]) {
    self.zPosition = 4;
    if (shape == 1) {
      [self addCoinWithCircle:length];
    }
    if (shape == 2) { // shape=2表示要绘制一条直线
      [self addCoinWithLine:length];
    }
      if (shape==3) {//shape=3表示要绘制一个三角形
          [self addCoinWithTraingle:length];
      }
  }
  return self;
}
-(SKTexture *)texture{
    if (!_texture) {
        _texture=[SKTexture textureWithImageNamed:@"coin_2"];
    }
    return _texture;
}
- (void)addCoinWithCircle:(NSUInteger)length {
  int coinNumber = length / 50;
  float x = 0;
  float y = 0;
//    texture = [SKTexture textureWithImageNamed:@"coin_2"];
  for (int i = 0; i < coinNumber; i++) {
    x = length/2 - length/2 * cos(3.1415926 * i / coinNumber);
    y = length/2 * sin(3.1415926 * i / coinNumber);
    SKSpriteNode *coin = [SKSpriteNode spriteNodeWithTexture:self.texture];
    coin.size = CGSizeMake(50, 50);
    coin.name = @"coin";
    coin.zPosition = 3;
    coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
    coin.physicsBody.dynamic = NO;
    coin.physicsBody.categoryBitMask = coinsCategory;
    coin.position = CGPointMake(x, y);
    [self addChild:coin];
  }
}
- (void)addCoinWithLine:(NSUInteger)length {
  int coinNumber = length / 50;
  float x = 0;
  float y = 50;
//  SKTexture *texture = [SKTexture textureWithImageNamed:@"coin_2"];
  for (int i = 0; i < coinNumber; i++) {
    x = 50 * i;
    SKSpriteNode *coin = [SKSpriteNode spriteNodeWithTexture:self.texture];
    coin.size = CGSizeMake(50, 50);
    coin.name = @"coin";
    coin.zPosition = 3;
    coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
    coin.physicsBody.dynamic = NO;
    coin.physicsBody.categoryBitMask = coinsCategory;
    coin.position = CGPointMake(x, y);
    [self addChild:coin];
  }
}
-(void)addCoinWithTraingle:(NSUInteger)length{
    int coinNmuber=length/50;
    float x=0;
    float y=50;
    for (int i=0;i<coinNmuber ; i++) {
        x=50*i;
        SKSpriteNode *coin=[SKSpriteNode spriteNodeWithTexture:self.texture];
        coin.size = CGSizeMake(50, 50);
        coin.name = @"coin";
        coin.zPosition = 3;
        coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
        coin.physicsBody.dynamic = NO;
        coin.physicsBody.categoryBitMask = coinsCategory;
        coin.position = CGPointMake(x, y+i%2*50);
        [self addChild:coin];
    }
    
}

@end
