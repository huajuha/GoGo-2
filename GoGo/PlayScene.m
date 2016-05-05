//
//  PlayScene.m
//  GoGo
//
//  Created by 王振西 on 16/2/28.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import "EndScene.h"
#import "PlayScene.h"
#import "PlayerSceneHalloween.h"

#define stagegapwidth 40
#define bigstagehigh 10
#define littestagehigh 70

@implementation PlayScene
- (void)didMoveToView:(SKView *)view {
  _backgroundSpeed = 350;
    _isJumping=YES;
    _heroShouldDefend=NO;
  self.physicsWorld.contactDelegate = self;
  _hero = [[Hero alloc] initWithCharacterNum:2];
  _hero.position = CGPointMake(CGRectGetMidX(self.frame) / 3,
                               CGRectGetMidY(self.frame) / 1.5 + 19);
  [self addChild:_hero];
  [self addbackground];
  [self addLabel];
    [self addDefendLabel];
  [self initstage];
}
-(SKSpriteNode *)slowNode{
    if (!_slowNode) {
        _slowNode=[SKSpriteNode spriteNodeWithImageNamed:@"slow"];
        _slowNode.zPosition=5;
        _slowNode.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:25];
        _slowNode.physicsBody.dynamic=NO;
        _slowNode.physicsBody.categoryBitMask=slowCategory;
        _slowNode.name=@"slow";
    }
    return _slowNode;
}
-(SKSpriteNode *)speedupNode{
    if (!_speedupNode) {
        _speedupNode=[SKSpriteNode spriteNodeWithImageNamed:@"speedup"];
        _speedupNode.zPosition=5;
        _speedupNode.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:25];
        _speedupNode.physicsBody.dynamic=NO;
        _speedupNode.physicsBody.categoryBitMask=speedupCategory;
        _speedupNode.name=@"speedup";
    }
    return _speedupNode;
}
- (void)addDefendLabel{
    self.defendNode=[SKSpriteNode spriteNodeWithImageNamed:@"defend"];
    self.defendNode.zPosition=3;
    self.defendNode.position=CGPointMake(900, 500);
    [self addChild:self.defendNode];
    self.defendNumber=2;
    self.defendLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    self.defendLabel.text=[NSString stringWithFormat:@" x %d",self.defendNumber];
    self.defendLabel.fontSize=40;
    self.defendLabel.zPosition=3;
    self.defendLabel.position=CGPointMake(980, 500);
    [self addChild:self.defendLabel];
}
- (void)addbackground {
  SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
  background.position =
      CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
  background.size =
      CGSizeMake(self.size.width, self.size.height); //设置背景图片适应屏幕
  background.zPosition = 0; //设置z轴坐标，解决遮挡关系
  background.name = @"background";
  [self addChild:background];
}
- (void)addLabel {
  _score = 0;
  _coinsCount = 0;
  _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _scoreLabel.text = [NSString stringWithFormat:@"Score:%ld", (long)_score];
  _scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
  _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
  _scoreLabel.fontSize = 50;
  _scoreLabel.zPosition = 1;
  _scoreLabel.position =
      CGPointMake(self.frame.size.width, self.frame.size.height);
  [self addChild:_scoreLabel];
  _coinsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _coinsLabel.text =
      [NSString stringWithFormat:@"Coins:%ld", (long)_coinsCount];
  _coinsLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
  _coinsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
  _coinsLabel.fontSize = 50;
  _coinsLabel.zPosition = 1;
  _coinsLabel.position = CGPointMake(0, self.frame.size.height);
  [self addChild:_coinsLabel];
}
/*向平台添加金币时需要给定的几组数据，金币coin需要绘制的形状（1代表绘制圆形）和金币绘制的长度（长度决定系统需要绘制多少个金币）
 在等到coinnode对象后，需要为它设置坐标（金币的坐标是相对于其父节点的不需要特别设置）
 */
- (void)initstage { //初始化游戏建立三个stage
  SKSpriteNode *stagenode_1 = [SKSpriteNode spriteNodeWithImageNamed:@"map_1"];
  stagenode_1.size = CGSizeMake(800, 480);
  stagenode_1.anchorPoint = CGPointZero;
  stagenode_1.position = CGPointMake(0, bigstagehigh);
  stagenode_1.zPosition = 1;
  stagenode_1.name = @"stage";
  stagenode_1.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 800, 130 + bigstagehigh)];
  stagenode_1.physicsBody.dynamic = NO;
  stagenode_1.physicsBody.categoryBitMask = stageCategory;
    CoinNode *coin1=[[CoinNode alloc]initWithShape:3 Length:400];
    coin1.position=CGPointMake(300, 130+bigstagehigh);
    [stagenode_1 addChild:coin1];
  [self addChild:stagenode_1];

  SKSpriteNode *stagenode_2 = [SKSpriteNode spriteNodeWithImageNamed:@"map_2"];
  stagenode_2.size = CGSizeMake(600, 480);
  stagenode_2.anchorPoint = CGPointZero;
  stagenode_2.zPosition = 1;
  stagenode_2.position = CGPointMake(900, littestagehigh);
  stagenode_2.name = @"stage";
  stagenode_2.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 600, 70 + littestagehigh)];
  stagenode_2.physicsBody.dynamic = NO;
  stagenode_2.physicsBody.categoryBitMask = stageCategory;
    CoinNode *coin2=[[CoinNode alloc]initWithShape:2 Length:400];
    coin2.position=CGPointMake(200, 50 +  littestagehigh);
    [stagenode_2 addChild:coin2];
  Enemy *enemy2 = [[Enemy alloc] initWithType:2 StageType:1 andLength:100];
  enemy2.position = CGPointMake(100, 90 +  littestagehigh);
  [stagenode_2 addChild:enemy2];
  [self addChild:stagenode_2];

  SKSpriteNode *stagenode_3 = [SKSpriteNode spriteNodeWithImageNamed:@"map_3"];
  stagenode_3.size = CGSizeMake(850, 480);
  stagenode_3.anchorPoint = CGPointZero;
  stagenode_3.position = CGPointMake(1600, bigstagehigh);
  stagenode_3.zPosition = 1;
  stagenode_3.name = @"stage";
  stagenode_3.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 850, 130 + bigstagehigh)];
  stagenode_3.physicsBody.dynamic = NO;
  stagenode_3.physicsBody.categoryBitMask = stageCategory;
  CoinNode *coin3 = [[CoinNode alloc] initWithShape:1 Length:200];
  coin3.position = CGPointMake(50, bigstagehigh + 150);
  [stagenode_3 addChild:coin3];
    CoinNode *coin3_1 = [[CoinNode alloc] initWithShape:1 Length:200];
    coin3_1.position = CGPointMake(250, bigstagehigh + 150);
    [stagenode_3 addChild:coin3_1];
    CoinNode *coin3_2 = [[CoinNode alloc] initWithShape:1 Length:200];
    coin3_2.position = CGPointMake(450, bigstagehigh + 150);
    [stagenode_3 addChild:coin3_2];
   
  [self addChild:stagenode_3];

  SKSpriteNode *stagenode_4 = [SKSpriteNode spriteNodeWithImageNamed:@"map_4"];
  stagenode_4.size = CGSizeMake(550, 480);
  stagenode_4.anchorPoint = CGPointZero;
  stagenode_4.zPosition = 1;
  stagenode_4.position = CGPointMake(2550, littestagehigh);
  stagenode_4.name = @"stage";
  stagenode_4.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 550, 70 + littestagehigh)];
  stagenode_4.physicsBody.dynamic = NO;
  stagenode_4.physicsBody.categoryBitMask = stageCategory;
  Enemy *enemy = [[Enemy alloc] initWithType:1 StageType:1 andLength:100];
  enemy.position = CGPointMake(100, 90 +  littestagehigh);
  [stagenode_4 addChild:enemy];
  [self addChild:stagenode_4];

  SKSpriteNode *stagenode_5 = [SKSpriteNode spriteNodeWithImageNamed:@"map_5"];
  stagenode_5.size = CGSizeMake(400, 480);
  stagenode_5.anchorPoint = CGPointZero;
  stagenode_5.zPosition = 1;
  stagenode_5.position = CGPointMake(3200, littestagehigh);
  stagenode_5.name = @"stage";
  stagenode_5.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 400, 70 + littestagehigh)];
  stagenode_5.physicsBody.dynamic = NO;
  stagenode_5.physicsBody.categoryBitMask = stageCategory;
    Enemy *enemy5=[[Enemy alloc]initWithType:2 StageType:1 andLength:100];
    enemy5.position=CGPointMake(100, 90+littestagehigh);
    [stagenode_5 addChild: enemy5];
  [self addChild:stagenode_5];
  _stagecounts = 5;
}
-(void )addCoinsAndEnemyOnBigStage:(SKSpriteNode *)bigstage{
    int t=arc4random()%5;//
//    int t=0;
    switch (t) {
        case  0:{
            CoinNode *coin = [[CoinNode alloc] initWithShape:1 Length:400];
            coin.position = CGPointMake(350, bigstagehigh + 150);
            [bigstage addChild:coin];
            Enemy *enemy=[[Enemy alloc]initWithType:2 StageType:1 andLength:300];
            enemy.position=CGPointMake(450, bigstagehigh+150);
            [bigstage addChild:enemy];
            break;
        }
        case 1:{
            Enemy *enemy_1=[[Enemy alloc]initWithType:1 StageType:1 andLength:100];
             [bigstage addChild:enemy_1];
            enemy_1.position=CGPointMake(100, bigstagehigh+150);
           
            CoinNode *coin = [[CoinNode alloc] initWithShape:1 Length:400];
             [bigstage addChild:coin];
            coin.position = CGPointMake(350, bigstagehigh + 150);
           
            Enemy *enemy=[[Enemy alloc]initWithType:2 StageType:1 andLength:300];
            [bigstage addChild:enemy];
            enemy.position=CGPointMake(450, bigstagehigh+150);
            
            break;
        }
        case 2:{
            Enemy *enemy_1=[[Enemy alloc]initWithType:1 StageType:1 andLength:100];
            enemy_1.position=CGPointMake(100, bigstagehigh+150);
            [bigstage addChild:enemy_1];
            CoinNode *coin = [[CoinNode alloc] initWithShape:1 Length:300];
            coin.position = CGPointMake(200, bigstagehigh + 150);
            [bigstage addChild:coin];
            Enemy *enemy=[[Enemy alloc]initWithType:2 StageType:1 andLength:300];
            enemy.position=CGPointMake(550, bigstagehigh+150);
            [bigstage addChild:enemy];
            break;
            
        }
        case 3:{
            CoinNode *coin_1=[[CoinNode alloc]initWithShape:2 Length:300];
            coin_1.position=CGPointMake(50, bigstagehigh+150);
            [bigstage addChild:coin_1];
            CoinNode *coin = [[CoinNode alloc] initWithShape:1 Length:400];
            coin.position = CGPointMake(350, bigstagehigh + 150);
            [bigstage addChild:coin];
            Enemy *enemy=[[Enemy alloc]initWithType:2 StageType:1 andLength:300];
            enemy.position=CGPointMake(450, bigstagehigh+150);
            [bigstage addChild:enemy];
            break;
            
        }
        case 4:{
            CoinNode *coin_1=[[CoinNode alloc]initWithShape:1 Length:700];
            coin_1.position=CGPointMake(50, bigstagehigh+150);
            [bigstage addChild:coin_1];
            CoinNode *coin_2=[[CoinNode alloc]initWithShape:1 Length:600];
            coin_2.position=CGPointMake(100, bigstagehigh+150);
            [bigstage addChild:coin_2];
            CoinNode *coin_3=[[CoinNode alloc]initWithShape:1 Length:500];
            coin_3.position=CGPointMake(150, bigstagehigh+150);
            [bigstage addChild:coin_3];
            CoinNode *coin_4=[[CoinNode alloc]initWithShape:1 Length:400];
            coin_4.position=CGPointMake(200, bigstagehigh+150);
            [bigstage addChild:coin_4];
             break;
        }
    }
}
- (void)addaddCoinsAndEnemyOnLittleStage:(SKSpriteNode *)littleStage{
    int t=arc4random()%5;//
    //    int t=0;
    switch (t) {
        case  0:{
            Enemy *enemy=[[Enemy alloc]initWithType:2 StageType:1 andLength:100];
            enemy.position=CGPointMake(200, 90 +  littestagehigh);
            [littleStage addChild:enemy];
            break;
        }
        case 1:{
            Enemy *enemy_1=[[Enemy alloc]initWithType:1 StageType:1 andLength:100];
            [littleStage addChild:enemy_1];
            enemy_1.position=CGPointMake(150, 90 +  littestagehigh);
            
            CoinNode *coin = [[CoinNode alloc] initWithShape:1 Length:300];
            [littleStage addChild:coin];
            coin.position = CGPointMake(50, 90 +  littestagehigh);
            
            break;
        }
        case 2:{

            CoinNode *coin = [[CoinNode alloc] initWithShape:3 Length:300];
            coin.position = CGPointMake(50,90 +  littestagehigh);
            [littleStage addChild:coin];
            
            break;
            
        }
        case 3:{
            CoinNode *coin_1=[[CoinNode alloc]initWithShape:2 Length:300];
            coin_1.position=CGPointMake(50, 90 +  littestagehigh);
            [littleStage addChild:coin_1];
            
            break;
            
        }
        case 4:{
            CoinNode *coin_1=[[CoinNode alloc]initWithShape:1 Length:400];
            coin_1.position=CGPointMake(50, 90 +  littestagehigh);
            [littleStage addChild:coin_1];
            
            break;
        }
    }
}
-(void)addSlowOrSpeedup:(SKSpriteNode *)stage{
    int ss=arc4random()%5;
    if (ss==2) {
         SKSpriteNode *slowNode=[SKSpriteNode spriteNodeWithImageNamed:@"slow"];
        slowNode.zPosition=5;
        slowNode.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:25];
        slowNode.physicsBody.dynamic=NO;
        slowNode.physicsBody.categoryBitMask=slowCategory;
        slowNode.name=@"slow";
        slowNode.position=CGPointMake(-50, bigstagehigh+300);
        [stage addChild:slowNode];
    }else if (ss==1){
         SKSpriteNode  *speedupNode=[SKSpriteNode spriteNodeWithImageNamed:@"speedup"];
        speedupNode.zPosition=5;
        speedupNode.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:25];
        speedupNode.physicsBody.dynamic=NO;
        speedupNode.physicsBody.categoryBitMask=speedupCategory;
        speedupNode.name=@"speedup";
        speedupNode.position=CGPointMake(-50, bigstagehigh+300);
        [stage addChild:speedupNode];
//        self.heroShouldDefend=YES;
    }
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  //    NSLog(@"ready to jump");
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (location.x>900&&location.y>500&&self.defendNumber>=1&&!self.whenAddDefend) {
            self.defendNumber--;
            self.defendLabel.text=[NSString stringWithFormat:@" x %lu",(unsigned long)self.defendNumber];
            self.heroShouldDefend=YES;
            return;
        }
        }
  if (_isJumping) {
      _isJumping=NO;
    //    通过脉冲力来完成跳跃
    [_hero runAction:[SKAction playSoundFileNamed:@"jump.wav"
                                waitForCompletion:YES]];
    [_hero.physicsBody applyImpulse:CGVectorMake(-10, 0)];
    [_hero.physicsBody applyImpulse:CGVectorMake(10, 400)];
    [_hero removeActionForKey:@"walk"];
      [_hero heroJump];
  }
}
- (void)addStageNode {
  SKSpriteNode *stagenode_1 = [SKSpriteNode spriteNodeWithImageNamed:@"map_1"];
  stagenode_1.size = CGSizeMake(800, 480);
  stagenode_1.anchorPoint = CGPointZero;
  stagenode_1.position = CGPointMake(1250, bigstagehigh);
  stagenode_1.zPosition = 1;
  stagenode_1.name = @"stage";
  stagenode_1.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 800, 130 + bigstagehigh)];
  stagenode_1.physicsBody.dynamic = NO;
  stagenode_1.physicsBody.categoryBitMask = stageCategory;
    [self addCoinsAndEnemyOnBigStage:stagenode_1];
    [self addSlowOrSpeedup:stagenode_1];
  [self addChild:stagenode_1];

  SKSpriteNode *stagenode_2 = [SKSpriteNode spriteNodeWithImageNamed:@"map_2"];
  stagenode_2.size = CGSizeMake(600, 480);
  stagenode_2.anchorPoint = CGPointZero;
  stagenode_2.zPosition = 1;
  stagenode_2.position = CGPointMake(2150, littestagehigh);
  stagenode_2.name = @"stage";
  stagenode_2.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 600, 70 + littestagehigh)];
  stagenode_2.physicsBody.dynamic = NO;
  stagenode_2.physicsBody.categoryBitMask = stageCategory;
    [self addaddCoinsAndEnemyOnLittleStage:stagenode_2];
  [self addChild:stagenode_2];

  SKSpriteNode *stagenode_3 = [SKSpriteNode spriteNodeWithImageNamed:@"map_3"];
  stagenode_3.size = CGSizeMake(850, 480);
  stagenode_3.anchorPoint = CGPointZero;
  stagenode_3.position = CGPointMake(2850, bigstagehigh);
  stagenode_3.zPosition = 1;
  stagenode_3.name = @"stage";
  stagenode_3.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 850, 130 + bigstagehigh)];
  stagenode_3.physicsBody.dynamic = NO;
  stagenode_3.physicsBody.categoryBitMask = stageCategory;
[self addCoinsAndEnemyOnBigStage:stagenode_3];
    [self addSlowOrSpeedup:stagenode_3];
  [self addChild:stagenode_3];

  SKSpriteNode *stagenode_4 = [SKSpriteNode spriteNodeWithImageNamed:@"map_4"];
  stagenode_4.size = CGSizeMake(550, 480);
  stagenode_4.anchorPoint = CGPointZero;
  stagenode_4.zPosition = 1;
  stagenode_4.position = CGPointMake(3800, littestagehigh);
  stagenode_4.name = @"stage";
  stagenode_4.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 550, 70 + littestagehigh)];
  stagenode_4.physicsBody.dynamic = NO;
  stagenode_4.physicsBody.categoryBitMask = stageCategory;
    [self addaddCoinsAndEnemyOnLittleStage:stagenode_4];
  [self addChild:stagenode_4];

  SKSpriteNode *stagenode_5 = [SKSpriteNode spriteNodeWithImageNamed:@"map_5"];
  stagenode_5.size = CGSizeMake(400, 480);
  stagenode_5.anchorPoint = CGPointZero;
  stagenode_5.zPosition = 1;
  stagenode_5.position = CGPointMake(4450, littestagehigh);
  stagenode_5.name = @"stage";
  stagenode_5.physicsBody = [SKPhysicsBody
      bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 400, 70 + littestagehigh)];
  stagenode_5.physicsBody.dynamic = NO;
  stagenode_5.physicsBody.categoryBitMask = stageCategory;
    [self addaddCoinsAndEnemyOnLittleStage:stagenode_5];
  [self addChild:stagenode_5];
  _stagecounts += 5;
}

#pragma mark - SKPhysicsContactDelegate
//在进行碰撞检测时，有两个对象需要处理碰撞检测，hero对象会处理与精灵有关影响，而scene对象会处理与自己有关的影响（包括记分盘的更改，切换到另一场景）
- (void)didBeginContact:(SKPhysicsContact *)contact {
  SKNode *attaker, *attakee;
  if (contact.bodyA.categoryBitMask == heroCategory) {
    attakee = contact.bodyA.node;
    attaker = contact.bodyB.node;
  } else {
    attakee = contact.bodyB.node;
    attaker = contact.bodyA.node;
  }

  [attakee receiveAttacker:attaker contact:contact]; // hero执行部分操作

  if (attaker.physicsBody.categoryBitMask == monsterCategory) {
      if (!self.hero.haveDefend) {
    [_hero removeFromParent];
    SKAction *wait = [SKAction waitForDuration:1];
    [self runAction:wait];
    SKAction *end = [SKAction runBlock:^{
      SKScene *endScene = [[EndScene alloc] initWithSize:self.size];
      SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:1];
      [self.view presentScene:endScene transition:doors];
    }];
    SKAction *go = [SKAction sequence:@[ wait, end ]];
    [self runAction:go];
      }
  }
  if (attaker.physicsBody.categoryBitMask == coinsCategory) {
    _coinsCount++;
    _coinsLabel.text =
        [NSString stringWithFormat:@"Coins:%ld", (long)_coinsCount];
  }
    if (attaker.physicsBody.categoryBitMask==speedupCategory) {
        self.backgroundSpeed+=50;
//        self.speedupNode=nil;
        [attaker removeFromParent];
    }
    if (attaker.physicsBody.categoryBitMask==slowCategory) {
        self.backgroundSpeed-=50;
//        self.speedupNode=nil;
        [attaker removeFromParent];
    }
    if (attaker.physicsBody.categoryBitMask==stageCategory) {
        self.isJumping=YES;
    }
}

- (void)moveBackground {
  float dt = _dt;
  [self enumerateChildNodesWithName:@"stage"
                         usingBlock:^(SKNode *node, BOOL *stop) {
                           node.position = CGPointMake(
                               node.position.x - (_backgroundSpeed * dt),
                               node.position.y);
                         }];
}

- (void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
  [self enumerateChildNodesWithName:@"stage"
                         usingBlock:^(SKNode *node, BOOL *stop) {

                           if (node.position.x <= -850) {
                             [node removeFromParent];
                             _stagecounts--;
                             if (_stagecounts == 2) {
                               [self addStageNode];
                             }
                             *stop = YES;
                             _score++;
                             _scoreLabel.text = [NSString
                                 stringWithFormat:@"Score:%ld", (long)_score];

                             return;
                           }

                         }];
  [self enumerateChildNodesWithName:@"hero"
                         usingBlock:^(SKNode *node, BOOL *stop) {
                           if (node.position.y <= 0 | node.position.x <= 0) {
                             SKScene *endScene =
                                 [[EndScene alloc] initWithSize:self.size];
                             SKTransition *doors =
                                 [SKTransition doorsOpenVerticalWithDuration:1];
                             [self.view presentScene:endScene transition:doors];
                           }
                         }];
  if (_lastUpdateTime > 0) {
    _dt = currentTime - _lastUpdateTime;
  } else {
    _lastUpdateTime = 0;
  }
  _lastUpdateTime = currentTime;
  [self moveBackground];
    if (self.heroShouldDefend) {
        self.heroShouldDefend=NO;
        [self.hero heroDefend];
        self.whenAddDefend=currentTime;
    }
    if (self.whenAddDefend) {
        if (currentTime-self.whenAddDefend>5) {
            [self.hero heroRemoveDefend];
            self.whenAddDefend=0;
        }
    }
    if (self.coinsCount>=100) {
        self.coinsCount=0;
        self.coinsLabel.text=[NSString stringWithFormat:@"Coins:%ld", (long)_coinsCount];
        self.defendNumber++;
        self.defendLabel.text=[NSString stringWithFormat:@" x %d",self.defendNumber];
    }
}

@end
