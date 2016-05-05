//
//  Hero.m
//  GoGo
//
//  Created by 王振西 on 16/4/12.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import "Hero.h"

@implementation Hero
-(instancetype)initWithCharacterNum :(NSUInteger) characterNum{
    
    SKTexture *f1,*f2,*f3,*f4,*f5,*f6;
    NSString *img1=[NSString stringWithFormat:@"run%d_1",characterNum];//范围在1～4
    NSString *img2=[NSString stringWithFormat:@"run%d_2",characterNum];
    NSString *img3=[NSString stringWithFormat:@"run%d_3",characterNum];
    NSString *img4=[NSString stringWithFormat:@"run%d_4",characterNum];
    NSString *img5=[NSString stringWithFormat:@"run%d_5",characterNum];
    NSString *img6=[NSString stringWithFormat:@"run%d_6",characterNum];
    f1 = [SKTexture textureWithImageNamed: img1];
    f2 = [SKTexture textureWithImageNamed: img2];
    f3 = [SKTexture textureWithImageNamed: img3];
    f4 = [SKTexture textureWithImageNamed: img4];
    f5 = [SKTexture textureWithImageNamed: img5];
    f6 = [SKTexture textureWithImageNamed: img6];
    _textureArray = @[f1,f2,f3,f4,f5,f6];
    
    // an Action using our array of textures with each frame lasting 0.1 seconds
    _runRightAction = [SKAction animateWithTextures:_textureArray timePerFrame:0.1];
    // don't run just once but loop indefinetely
    _runForever = [SKAction repeatActionForever:_runRightAction];
    // attach the completed action to our sprite
   
    self=[super initWithTexture:f1];
    self.name=@"hero";
    [self runAction:_runForever withKey:@"walk"];
    self.zPosition=5;
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    body.dynamic = YES;
    body.allowsRotation = NO;
    body.categoryBitMask=heroCategory;
    body.collisionBitMask=monsterCategory | stageCategory ;
    body.contactTestBitMask=monsterCategory|stageCategory | coinsCategory |slowCategory |speedupCategory;
    self.physicsBody = body;
    self.haveDefend=NO;
    return self;
}
-(SKTexture *)jump{
    if (!_jump) {
        _jump=[SKTexture textureWithImageNamed:@"jump"];
    }
    return _jump;
}
-(SKSpriteNode *)jumpNode{
    if (!_jumpNode) {
        _jumpNode=[SKSpriteNode spriteNodeWithTexture:self.jump];
//        _jumpNode.anchorPoint=CGPointZero;
        _jumpNode.size=CGSizeMake(20, 50);
        _jumpNode.position=CGPointMake(-35, -40);
        _jumpNode.zPosition=5;
    }
    return _jumpNode;
}
- (SKSpriteNode *)defendTao{
    if (!_defendTao) {
        _defendTao=[SKSpriteNode spriteNodeWithImageNamed:@"taozi" ];
        _defendTao.position=CGPointMake(30, 0);
        _defendTao.zPosition=6;
    }
    return _defendTao;
}
-(void)heroJump{
    [self addChild:self.jumpNode];
}
- (void)heroDefend{
    [self addChild:self.defendTao];
    self.haveDefend=YES;
}
- (void)heroRemoveDefend{
    [self.defendTao removeFromParent];
    self.haveDefend=NO;
}
-(void)receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact{
    
    if (attacker.physicsBody.categoryBitMask == stageCategory) {
        [self.jumpNode removeFromParent];
        [self runAction:_runForever withKey:@"walk"];
        
    }
    if (attacker.physicsBody.categoryBitMask == monsterCategory){
        if (self.haveDefend) {
            [attacker removeFromParent];
        }
        NSString *path=[[NSBundle mainBundle] pathForResource:@"heroDied1" ofType:@"sks"];
        SKEmitterNode *explosion=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        explosion.numParticlesToEmit=20;
        explosion.position=contact.contactPoint;
        explosion.zPosition=4;
        [self.scene addChild:explosion];
        
    }
    if (attacker.physicsBody.categoryBitMask==coinsCategory) {
        [attacker removeFromParent];
        [self runAction:[SKAction playSoundFileNamed:@"coins.wav" waitForCompletion:NO]];
    }
    
}
@end
