//! Code generated by `tools/generate` - manual edits will be overwritten

const std = @import("std");
const gen1 = @import("../../gen1/data.zig");

const assert = std.debug.assert;

const Move = gen1.Move;
const Type = gen1.Type;

pub const Moves = enum(u8) {
    None,
    Pound,
    KarateChop,
    DoubleSlap,
    CometPunch,
    MegaPunch,
    PayDay,
    FirePunch,
    IcePunch,
    ThunderPunch,
    Scratch,
    ViseGrip,
    Guillotine,
    RazorWind,
    SwordsDance,
    Cut,
    Gust,
    WingAttack,
    Whirlwind,
    Fly,
    Bind,
    Slam,
    VineWhip,
    Stomp,
    DoubleKick,
    MegaKick,
    JumpKick,
    RollingKick,
    SandAttack,
    Headbutt,
    HornAttack,
    FuryAttack,
    HornDrill,
    Tackle,
    BodySlam,
    Wrap,
    TakeDown,
    Thrash,
    DoubleEdge,
    TailWhip,
    PoisonSting,
    Twineedle,
    PinMissile,
    Leer,
    Bite,
    Growl,
    Roar,
    Sing,
    Supersonic,
    SonicBoom,
    Disable,
    Acid,
    Ember,
    Flamethrower,
    Mist,
    WaterGun,
    HydroPump,
    Surf,
    IceBeam,
    Blizzard,
    Psybeam,
    BubbleBeam,
    AuroraBeam,
    HyperBeam,
    Peck,
    DrillPeck,
    Submission,
    LowKick,
    Counter,
    SeismicToss,
    Strength,
    Absorb,
    MegaDrain,
    LeechSeed,
    Growth,
    RazorLeaf,
    SolarBeam,
    PoisonPowder,
    StunSpore,
    SleepPowder,
    PetalDance,
    StringShot,
    DragonRage,
    FireSpin,
    ThunderShock,
    Thunderbolt,
    ThunderWave,
    Thunder,
    RockThrow,
    Earthquake,
    Fissure,
    Dig,
    Toxic,
    Confusion,
    Psychic,
    Hypnosis,
    Meditate,
    Agility,
    QuickAttack,
    Rage,
    Teleport,
    NightShade,
    Mimic,
    Screech,
    DoubleTeam,
    Recover,
    Harden,
    Minimize,
    Smokescreen,
    ConfuseRay,
    Withdraw,
    DefenseCurl,
    Barrier,
    LightScreen,
    Haze,
    Reflect,
    FocusEnergy,
    Bide,
    Metronome,
    MirrorMove,
    SelfDestruct,
    EggBomb,
    Lick,
    Smog,
    Sludge,
    BoneClub,
    FireBlast,
    Waterfall,
    Clamp,
    Swift,
    SkullBash,
    SpikeCannon,
    Constrict,
    Amnesia,
    Kinesis,
    SoftBoiled,
    HighJumpKick,
    Glare,
    DreamEater,
    PoisonGas,
    Barrage,
    LeechLife,
    LovelyKiss,
    SkyAttack,
    Transform,
    Bubble,
    DizzyPunch,
    Spore,
    Flash,
    Psywave,
    Splash,
    AcidArmor,
    Crabhammer,
    Explosion,
    FurySwipes,
    Bonemerang,
    Rest,
    RockSlide,
    HyperFang,
    Sharpen,
    Conversion,
    TriAttack,
    SuperFang,
    Slash,
    Substitute,
    Struggle,

    const data = [_]Move{
        Move{
            // Pound
            .bp = 40,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // KarateChop
            .bp = 50,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // DoubleSlap
            .bp = 15,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // CometPunch
            .bp = 18,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // MegaPunch
            .bp = 80,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // PayDay
            .bp = 40,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // FirePunch
            .bp = 75,
            .type = .Fire,
            .acc = 14,
        },
        Move{
            // IcePunch
            .bp = 75,
            .type = .Ice,
            .acc = 14,
        },
        Move{
            // ThunderPunch
            .bp = 75,
            .type = .Electric,
            .acc = 14,
        },
        Move{
            // Scratch
            .bp = 40,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // ViseGrip
            .bp = 55,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Guillotine
            .bp = 0,
            .type = .Normal,
            .acc = 0,
        },
        Move{
            // RazorWind
            .bp = 80,
            .type = .Normal,
            .acc = 9,
        },
        Move{
            // SwordsDance
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Cut
            .bp = 50,
            .type = .Normal,
            .acc = 13,
        },
        Move{
            // Gust
            .bp = 40,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // WingAttack
            .bp = 35,
            .type = .Flying,
            .acc = 14,
        },
        Move{
            // Whirlwind
            .bp = 0,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // Fly
            .bp = 70,
            .type = .Flying,
            .acc = 13,
        },
        Move{
            // Bind
            .bp = 15,
            .type = .Normal,
            .acc = 9,
        },
        Move{
            // Slam
            .bp = 80,
            .type = .Normal,
            .acc = 9,
        },
        Move{
            // VineWhip
            .bp = 35,
            .type = .Grass,
            .acc = 14,
        },
        Move{
            // Stomp
            .bp = 65,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // DoubleKick
            .bp = 30,
            .type = .Fighting,
            .acc = 14,
        },
        Move{
            // MegaKick
            .bp = 120,
            .type = .Normal,
            .acc = 9,
        },
        Move{
            // JumpKick
            .bp = 70,
            .type = .Fighting,
            .acc = 13,
        },
        Move{
            // RollingKick
            .bp = 60,
            .type = .Fighting,
            .acc = 11,
        },
        Move{
            // SandAttack
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Headbutt
            .bp = 70,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // HornAttack
            .bp = 65,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // FuryAttack
            .bp = 15,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // HornDrill
            .bp = 0,
            .type = .Normal,
            .acc = 0,
        },
        Move{
            // Tackle
            .bp = 35,
            .type = .Normal,
            .acc = 13,
        },
        Move{
            // BodySlam
            .bp = 85,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Wrap
            .bp = 15,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // TakeDown
            .bp = 90,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // Thrash
            .bp = 90,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // DoubleEdge
            .bp = 100,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // TailWhip
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // PoisonSting
            .bp = 15,
            .type = .Poison,
            .acc = 14,
        },
        Move{
            // Twineedle
            .bp = 25,
            .type = .Bug,
            .acc = 14,
        },
        Move{
            // PinMissile
            .bp = 14,
            .type = .Bug,
            .acc = 11,
        },
        Move{
            // Leer
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Bite
            .bp = 60,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Growl
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Roar
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Sing
            .bp = 0,
            .type = .Normal,
            .acc = 5,
        },
        Move{
            // Supersonic
            .bp = 0,
            .type = .Normal,
            .acc = 5,
        },
        Move{
            // SonicBoom
            .bp = 0,
            .type = .Normal,
            .acc = 12,
        },
        Move{
            // Disable
            .bp = 0,
            .type = .Normal,
            .acc = 5,
        },
        Move{
            // Acid
            .bp = 40,
            .type = .Poison,
            .acc = 14,
        },
        Move{
            // Ember
            .bp = 40,
            .type = .Fire,
            .acc = 14,
        },
        Move{
            // Flamethrower
            .bp = 95,
            .type = .Fire,
            .acc = 14,
        },
        Move{
            // Mist
            .bp = 0,
            .type = .Ice,
            .acc = 14,
        },
        Move{
            // WaterGun
            .bp = 40,
            .type = .Water,
            .acc = 14,
        },
        Move{
            // HydroPump
            .bp = 120,
            .type = .Water,
            .acc = 10,
        },
        Move{
            // Surf
            .bp = 95,
            .type = .Water,
            .acc = 14,
        },
        Move{
            // IceBeam
            .bp = 95,
            .type = .Ice,
            .acc = 14,
        },
        Move{
            // Blizzard
            .bp = 120,
            .type = .Ice,
            .acc = 12,
        },
        Move{
            // Psybeam
            .bp = 65,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // BubbleBeam
            .bp = 65,
            .type = .Water,
            .acc = 14,
        },
        Move{
            // AuroraBeam
            .bp = 65,
            .type = .Ice,
            .acc = 14,
        },
        Move{
            // HyperBeam
            .bp = 150,
            .type = .Normal,
            .acc = 12,
        },
        Move{
            // Peck
            .bp = 35,
            .type = .Flying,
            .acc = 14,
        },
        Move{
            // DrillPeck
            .bp = 80,
            .type = .Flying,
            .acc = 14,
        },
        Move{
            // Submission
            .bp = 80,
            .type = .Fighting,
            .acc = 10,
        },
        Move{
            // LowKick
            .bp = 50,
            .type = .Fighting,
            .acc = 12,
        },
        Move{
            // Counter
            .bp = 1,
            .type = .Fighting,
            .acc = 14,
        },
        Move{
            // SeismicToss
            .bp = 1,
            .type = .Fighting,
            .acc = 14,
        },
        Move{
            // Strength
            .bp = 80,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Absorb
            .bp = 20,
            .type = .Grass,
            .acc = 14,
        },
        Move{
            // MegaDrain
            .bp = 40,
            .type = .Grass,
            .acc = 14,
        },
        Move{
            // LeechSeed
            .bp = 0,
            .type = .Grass,
            .acc = 12,
        },
        Move{
            // Growth
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // RazorLeaf
            .bp = 55,
            .type = .Grass,
            .acc = 13,
        },
        Move{
            // SolarBeam
            .bp = 120,
            .type = .Grass,
            .acc = 14,
        },
        Move{
            // PoisonPowder
            .bp = 0,
            .type = .Poison,
            .acc = 9,
        },
        Move{
            // StunSpore
            .bp = 0,
            .type = .Grass,
            .acc = 9,
        },
        Move{
            // SleepPowder
            .bp = 0,
            .type = .Grass,
            .acc = 9,
        },
        Move{
            // PetalDance
            .bp = 70,
            .type = .Grass,
            .acc = 14,
        },
        Move{
            // StringShot
            .bp = 0,
            .type = .Bug,
            .acc = 13,
        },
        Move{
            // DragonRage
            .bp = 1,
            .type = .Dragon,
            .acc = 14,
        },
        Move{
            // FireSpin
            .bp = 15,
            .type = .Fire,
            .acc = 8,
        },
        Move{
            // ThunderShock
            .bp = 40,
            .type = .Electric,
            .acc = 14,
        },
        Move{
            // Thunderbolt
            .bp = 95,
            .type = .Electric,
            .acc = 14,
        },
        Move{
            // ThunderWave
            .bp = 0,
            .type = .Electric,
            .acc = 14,
        },
        Move{
            // Thunder
            .bp = 120,
            .type = .Electric,
            .acc = 8,
        },
        Move{
            // RockThrow
            .bp = 50,
            .type = .Rock,
            .acc = 7,
        },
        Move{
            // Earthquake
            .bp = 100,
            .type = .Ground,
            .acc = 14,
        },
        Move{
            // Fissure
            .bp = 0,
            .type = .Ground,
            .acc = 0,
        },
        Move{
            // Dig
            .bp = 100,
            .type = .Ground,
            .acc = 14,
        },
        Move{
            // Toxic
            .bp = 0,
            .type = .Poison,
            .acc = 11,
        },
        Move{
            // Confusion
            .bp = 50,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // Psychic
            .bp = 90,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // Hypnosis
            .bp = 0,
            .type = .Psychic,
            .acc = 6,
        },
        Move{
            // Meditate
            .bp = 0,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // Agility
            .bp = 0,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // QuickAttack
            .bp = 40,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Rage
            .bp = 20,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Teleport
            .bp = 0,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // NightShade
            .bp = 1,
            .type = .Ghost,
            .acc = 14,
        },
        Move{
            // Mimic
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Screech
            .bp = 0,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // DoubleTeam
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Recover
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Harden
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Minimize
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Smokescreen
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // ConfuseRay
            .bp = 0,
            .type = .Ghost,
            .acc = 14,
        },
        Move{
            // Withdraw
            .bp = 0,
            .type = .Water,
            .acc = 14,
        },
        Move{
            // DefenseCurl
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Barrier
            .bp = 0,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // LightScreen
            .bp = 0,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // Haze
            .bp = 0,
            .type = .Ice,
            .acc = 14,
        },
        Move{
            // Reflect
            .bp = 0,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // FocusEnergy
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Bide
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Metronome
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // MirrorMove
            .bp = 0,
            .type = .Flying,
            .acc = 14,
        },
        Move{
            // SelfDestruct
            .bp = 130,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // EggBomb
            .bp = 100,
            .type = .Normal,
            .acc = 9,
        },
        Move{
            // Lick
            .bp = 20,
            .type = .Ghost,
            .acc = 14,
        },
        Move{
            // Smog
            .bp = 20,
            .type = .Poison,
            .acc = 8,
        },
        Move{
            // Sludge
            .bp = 65,
            .type = .Poison,
            .acc = 14,
        },
        Move{
            // BoneClub
            .bp = 65,
            .type = .Ground,
            .acc = 11,
        },
        Move{
            // FireBlast
            .bp = 120,
            .type = .Fire,
            .acc = 11,
        },
        Move{
            // Waterfall
            .bp = 80,
            .type = .Water,
            .acc = 14,
        },
        Move{
            // Clamp
            .bp = 35,
            .type = .Water,
            .acc = 9,
        },
        Move{
            // Swift
            .bp = 60,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // SkullBash
            .bp = 100,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // SpikeCannon
            .bp = 20,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Constrict
            .bp = 10,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Amnesia
            .bp = 0,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // Kinesis
            .bp = 0,
            .type = .Psychic,
            .acc = 10,
        },
        Move{
            // SoftBoiled
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // HighJumpKick
            .bp = 85,
            .type = .Fighting,
            .acc = 12,
        },
        Move{
            // Glare
            .bp = 0,
            .type = .Normal,
            .acc = 9,
        },
        Move{
            // DreamEater
            .bp = 100,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // PoisonGas
            .bp = 0,
            .type = .Poison,
            .acc = 5,
        },
        Move{
            // Barrage
            .bp = 15,
            .type = .Normal,
            .acc = 11,
        },
        Move{
            // LeechLife
            .bp = 20,
            .type = .Bug,
            .acc = 14,
        },
        Move{
            // LovelyKiss
            .bp = 0,
            .type = .Normal,
            .acc = 9,
        },
        Move{
            // SkyAttack
            .bp = 140,
            .type = .Flying,
            .acc = 12,
        },
        Move{
            // Transform
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Bubble
            .bp = 20,
            .type = .Water,
            .acc = 14,
        },
        Move{
            // DizzyPunch
            .bp = 70,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Spore
            .bp = 0,
            .type = .Grass,
            .acc = 14,
        },
        Move{
            // Flash
            .bp = 0,
            .type = .Normal,
            .acc = 8,
        },
        Move{
            // Psywave
            .bp = 1,
            .type = .Psychic,
            .acc = 10,
        },
        Move{
            // Splash
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // AcidArmor
            .bp = 0,
            .type = .Poison,
            .acc = 14,
        },
        Move{
            // Crabhammer
            .bp = 90,
            .type = .Water,
            .acc = 11,
        },
        Move{
            // Explosion
            .bp = 170,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // FurySwipes
            .bp = 18,
            .type = .Normal,
            .acc = 10,
        },
        Move{
            // Bonemerang
            .bp = 50,
            .type = .Ground,
            .acc = 12,
        },
        Move{
            // Rest
            .bp = 0,
            .type = .Psychic,
            .acc = 14,
        },
        Move{
            // RockSlide
            .bp = 75,
            .type = .Rock,
            .acc = 12,
        },
        Move{
            // HyperFang
            .bp = 80,
            .type = .Normal,
            .acc = 12,
        },
        Move{
            // Sharpen
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Conversion
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // TriAttack
            .bp = 80,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // SuperFang
            .bp = 1,
            .type = .Normal,
            .acc = 12,
        },
        Move{
            // Slash
            .bp = 70,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Substitute
            .bp = 0,
            .type = .Normal,
            .acc = 14,
        },
        Move{
            // Struggle
            .bp = 50,
            .type = .Normal,
            .acc = 14,
        },
    };

    // @test-only
    const pp_data = [_]u8{
        35, // Pound
        25, // KarateChop
        10, // DoubleSlap
        15, // CometPunch
        20, // MegaPunch
        20, // PayDay
        15, // FirePunch
        15, // IcePunch
        15, // ThunderPunch
        35, // Scratch
        30, // ViseGrip
        5, // Guillotine
        10, // RazorWind
        30, // SwordsDance
        30, // Cut
        35, // Gust
        35, // WingAttack
        20, // Whirlwind
        15, // Fly
        20, // Bind
        20, // Slam
        10, // VineWhip
        20, // Stomp
        30, // DoubleKick
        5, // MegaKick
        25, // JumpKick
        15, // RollingKick
        15, // SandAttack
        15, // Headbutt
        25, // HornAttack
        20, // FuryAttack
        5, // HornDrill
        35, // Tackle
        15, // BodySlam
        20, // Wrap
        20, // TakeDown
        20, // Thrash
        15, // DoubleEdge
        30, // TailWhip
        35, // PoisonSting
        20, // Twineedle
        20, // PinMissile
        30, // Leer
        25, // Bite
        40, // Growl
        20, // Roar
        15, // Sing
        20, // Supersonic
        20, // SonicBoom
        20, // Disable
        30, // Acid
        25, // Ember
        15, // Flamethrower
        30, // Mist
        25, // WaterGun
        5, // HydroPump
        15, // Surf
        10, // IceBeam
        5, // Blizzard
        20, // Psybeam
        20, // BubbleBeam
        20, // AuroraBeam
        5, // HyperBeam
        35, // Peck
        20, // DrillPeck
        25, // Submission
        20, // LowKick
        20, // Counter
        20, // SeismicToss
        15, // Strength
        20, // Absorb
        10, // MegaDrain
        10, // LeechSeed
        40, // Growth
        25, // RazorLeaf
        10, // SolarBeam
        35, // PoisonPowder
        30, // StunSpore
        15, // SleepPowder
        20, // PetalDance
        40, // StringShot
        10, // DragonRage
        15, // FireSpin
        30, // ThunderShock
        15, // Thunderbolt
        20, // ThunderWave
        10, // Thunder
        15, // RockThrow
        10, // Earthquake
        5, // Fissure
        10, // Dig
        10, // Toxic
        25, // Confusion
        10, // Psychic
        20, // Hypnosis
        40, // Meditate
        30, // Agility
        30, // QuickAttack
        20, // Rage
        20, // Teleport
        15, // NightShade
        10, // Mimic
        40, // Screech
        15, // DoubleTeam
        20, // Recover
        30, // Harden
        20, // Minimize
        20, // Smokescreen
        10, // ConfuseRay
        40, // Withdraw
        40, // DefenseCurl
        30, // Barrier
        30, // LightScreen
        30, // Haze
        20, // Reflect
        30, // FocusEnergy
        10, // Bide
        10, // Metronome
        20, // MirrorMove
        5, // SelfDestruct
        10, // EggBomb
        30, // Lick
        20, // Smog
        20, // Sludge
        20, // BoneClub
        5, // FireBlast
        15, // Waterfall
        10, // Clamp
        20, // Swift
        15, // SkullBash
        15, // SpikeCannon
        35, // Constrict
        20, // Amnesia
        15, // Kinesis
        10, // SoftBoiled
        20, // HighJumpKick
        30, // Glare
        15, // DreamEater
        40, // PoisonGas
        20, // Barrage
        15, // LeechLife
        10, // LovelyKiss
        5, // SkyAttack
        10, // Transform
        30, // Bubble
        10, // DizzyPunch
        15, // Spore
        20, // Flash
        15, // Psywave
        40, // Splash
        40, // AcidArmor
        10, // Crabhammer
        5, // Explosion
        15, // FurySwipes
        10, // Bonemerang
        10, // Rest
        10, // RockSlide
        15, // HyperFang
        30, // Sharpen
        30, // Conversion
        10, // TriAttack
        10, // SuperFang
        20, // Slash
        10, // Substitute
        10, // Struggle,
    };

    comptime {
        assert(@sizeOf(Moves) == 1);
        assert(@sizeOf(@TypeOf(data)) == 330);
    }

    pub fn get(id: Moves) Move {
        assert(id != .None);
        return data[@enumToInt(id) - 1];
    }

    // @test-only
    pub fn pp(id: Moves) u8 {
        assert(id != .None);
        return pp_data[@enumToInt(id) - 1];
    }
};
