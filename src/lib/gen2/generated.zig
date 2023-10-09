//! Code generated by `tools/generate` - manual edits will be overwritten

const common = @import("../common/data.zig");

const data = @import("data.zig");
const mechanics = @import("mechanics.zig");

const Player = common.Player;
const Result = common.Result;

const Move = data.Move;

const Effects = mechanics.Effects;
const State = mechanics.State;

const checkHit = mechanics.checkHit;
const checkCriticalHit = mechanics.checkCriticalHit;
const calcDamage = mechanics.calcDamage;
const adjustDamage = mechanics.adjustDamage;
const randomizeDamage = mechanics.randomizeDamage;
const applyDamage = mechanics.applyDamage;
const buildRage = mechanics.buildRage;
const rageDamage = mechanics.rageDamage;
const kingsRock = mechanics.kingsRock;
const destinyBond = mechanics.destinyBond;

pub fn doMove(battle: anytype, player: Player, state: *State, options: anytype) !?Result {
    _ = .{ battle, player, options };

    switch (Move.get(state.move).effect) {
        .AlwaysHit, .HighCritical, .Priority, .JumpKick, .None => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .DoubleHit, .MultiHit => {
            // TODO usedmovetext
            // TODO doturn
            // TODO startloop
            // TODO checkhit
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO clearmissdamage
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO cleartext
            // TODO supereffectivelooptext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO endloop
            // TODO kingsrock
        },
        .PayDay => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO payday
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .BurnChance => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO burntarget
        },
        .FreezeChance => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO freezetarget
        },
        .ParalyzeChance => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO paralyzetarget
        },
        .OHKO => {
            // TODO usedmovetext
            // TODO doturn
            // TODO stab
            // TODO ohko
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
        },
        .RazorWind => {
            // TODO checkcharge
            // TODO doturn
            // TODO charge
            // TODO usedmovetext
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Gust => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO doubleflyingdamage
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
        },
        .ForceSwitch => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO forceswitch
        },
        .FlyDig => {
            // TODO checkcharge
            // TODO doturn
            // TODO charge
            // TODO usedmovetext
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Binding => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO clearmissdamage
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO traptarget
        },
        .Stomp => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO doubleminimizedamage
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO flinchtarget
        },
        .FlinchChance => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO flinchtarget
        },
        .Recoil => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO recoil
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Thrashing => {
            // TODO checkrampage
            // TODO doturn
            // TODO rampage
            // TODO usedmovetext
            // TODO checkhit
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO clearmissdamage
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .PoisonChance => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO poisontarget
        },
        .Twineedle => {
            // TODO usedmovetext
            // TODO doturn
            // TODO startloop
            // TODO checkhit
            // TODO effectchance
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO clearmissdamage
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO cleartext
            // TODO supereffectivelooptext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO endloop
            // TODO kingsrock
            // TODO poisontarget
        },
        .Sleep => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO checksafeguard
            // TODO sleeptarget
        },
        .Confusion => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO checksafeguard
            // TODO confuse
        },
        .SuperFang, .LevelDamage, .Psywave, .FixedDamage => {
            // TODO usedmovetext
            // TODO doturn
            // TODO constantdamage
            // TODO checkhit
            // TODO resettypematchup
            // TODO failuretext
            // TODO applydamage
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Disable => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO disable
        },
        .Mist => {
            // TODO usedmovetext
            // TODO doturn
            // TODO mist
        },
        .ConfusionChance => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO confusetarget
        },
        .HyperBeam => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO rechargenextturn
            // TODO checkfaint
            // TODO buildopponentrage
        },
        .Counter => {
            // TODO usedmovetext
            // TODO doturn
            // TODO counter
            // TODO failuretext
            // TODO applydamage
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .DrainHP => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO draintarget
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .LeechSeed => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO leechseed
        },
        .Solarbeam => {
            // TODO checkcharge
            // TODO doturn
            // TODO skipsuncharge
            // TODO charge
            // TODO usedmovetext
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Toxic, .Poison => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO stab
            // TODO checksafeguard
            // TODO poison
        },
        .Paralyze => {
            // TODO usedmovetext
            // TODO doturn
            // TODO stab
            // TODO checkhit
            // TODO checksafeguard
            // TODO paralyze
        },
        .Thunder => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO thunderaccuracy
            // TODO checkhit
            // TODO effectchance
            // TODO stab
            // TODO damagevariation
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO paralyzetarget
        },
        .Earthquake => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO doubleundergrounddamage
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
        },
        .Rage => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO checkhit
            // TODO ragedamage
            // TODO damagevariation
            // TODO failuretext
            // TODO rage
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Teleport => {
            // TODO usedmovetext
            // TODO doturn
            // TODO teleport
        },
        .Mimic => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO mimic
        },
        .Heal => {
            // TODO usedmovetext
            // TODO doturn
            // TODO heal
        },
        .DefenseCurl => {
            // TODO usedmovetext
            // TODO doturn
            // TODO defenseup
            // TODO curl
            // TODO statupanim
            // TODO statupmessage
            // TODO statupfailtext
        },
        .Haze => {
            // TODO usedmovetext
            // TODO doturn
            // TODO resetstats
        },
        .LightScreen, .Reflect => {
            // TODO usedmovetext
            // TODO doturn
            // TODO screen
        },
        .FocusEnergy => {
            // TODO usedmovetext
            // TODO doturn
            // TODO focusenergy
        },
        .Bide => {
            // TODO storeenergy
            // TODO doturn
            // TODO usedmovetext
            // TODO unleashenergy
            // TODO resettypematchup
            // TODO checkhit
            // TODO bidefailtext
            // TODO applydamage
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Metronome => {
            // TODO usedmovetext
            // TODO doturn
            // TODO metronome
        },
        .MirrorMove => {
            // TODO usedmovetext
            // TODO doturn
            // TODO mirrormove
        },
        .Explode => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO selfdestruct
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .SkullBash => {
            // TODO checkcharge
            // TODO doturn
            // TODO charge
            // TODO usedmovetext
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
            // TODO endturn
            // TODO defenseup
            // TODO statupmessage
        },
        .DreamEater => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO eatdream
            // TODO checkfaint
            // TODO buildopponentrage
        },
        .SkyAttack => {
            // TODO checkcharge
            // TODO doturn
            // TODO charge
            // TODO usedmovetext
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO flinchtarget
            // TODO kingsrock
        },
        .Transform => {
            // TODO usedmovetext
            // TODO doturn
            // TODO transform
        },
        .Splash => {
            // TODO usedmovetext
            // TODO doturn
            // TODO splash
        },
        .Conversion => {
            // TODO usedmovetext
            // TODO doturn
            // TODO conversion
        },
        .TriAttack => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO tristatuschance
        },
        .Substitute => {
            // TODO usedmovetext
            // TODO doturn
            // TODO substitute
        },
        .Sketch => {
            // TODO usedmovetext
            // TODO doturn
            // TODO sketch
        },
        .TripleKick => {
            // TODO usedmovetext
            // TODO doturn
            // TODO startloop
            // TODO checkhit
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO triplekick
            // TODO stab
            // TODO damagevariation
            // TODO clearmissdamage
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO cleartext
            // TODO supereffectivelooptext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kickcounter
            // TODO endloop
            // TODO kingsrock
        },
        .Thief => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO thief
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .MeanLook => {
            // TODO usedmovetext
            // TODO doturn
            // TODO arenatrap
        },
        .LockOn => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO lockon
        },
        .Nightmare => {
            // TODO usedmovetext
            // TODO doturn
            // TODO nightmare
        },
        .FlameWheel => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO defrost
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO burntarget
        },
        .Snore => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO snore
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO flinchtarget
            // TODO kingsrock
        },
        .Curse => {
            // TODO usedmovetext
            // TODO doturn
            // TODO curse
        },
        .Reversal => {
            // TODO usedmovetext
            // TODO doturn
            // TODO constantdamage
            // TODO stab
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Conversion2 => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO conversion2
        },
        .Spite => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO spite
        },
        .Protect => {
            // TODO usedmovetext
            // TODO doturn
            // TODO protect
        },
        .BellyDrum => {
            // TODO usedmovetext
            // TODO doturn
            // TODO bellydrum
        },
        .Spikes => {
            // TODO usedmovetext
            // TODO doturn
            // TODO spikes
        },
        .Foresight => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO foresight
        },
        .DestinyBond => {
            // TODO usedmovetext
            // TODO doturn
            // TODO destinybond
        },
        .PerishSong => {
            // TODO usedmovetext
            // TODO doturn
            // TODO perishsong
        },
        .Sandstorm => {
            // TODO usedmovetext
            // TODO doturn
            // TODO startsandstorm
        },
        .Endure => {
            // TODO usedmovetext
            // TODO doturn
            // TODO endure
        },
        .Rollout => {
            // TODO checkcurl
            // TODO doturn
            // TODO usedmovetext
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO checkhit
            // TODO rolloutpower
            // TODO damagevariation
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .FalseSwipe => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO falseswipe
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Swagger => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO switchturn
            // TODO attackup2
            // TODO switchturn
            // TODO statupanim
            // TODO failuretext
            // TODO switchturn
            // TODO statupmessage
            // TODO switchturn
            // TODO confusetarget
        },
        .FuryCutter => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO checkhit
            // TODO furycutter
            // TODO damagevariation
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Attract => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO attract
        },
        .SleepTalk => {
            // TODO usedmovetext
            // TODO doturn
            // TODO sleeptalk
        },
        .HealBell => {
            // TODO usedmovetext
            // TODO doturn
            // TODO healbell
        },
        .Frustration, .Return => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO happinesspower
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Present => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO critical
            // TODO damagestats
            // TODO present
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO clearmissdamage
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Safeguard => {
            // TODO usedmovetext
            // TODO doturn
            // TODO safeguard
        },
        .PainSplit => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO painsplit
        },
        .SacredFire => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO defrost
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO burntarget
        },
        .Magnitude => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO getmagnitude
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO doubleundergrounddamage
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .BatonPass => {
            // TODO usedmovetext
            // TODO doturn
            // TODO batonpass
        },
        .Encore => {
            // TODO usedmovetext
            // TODO doturn
            // TODO checkhit
            // TODO encore
        },
        .Pursuit => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO pursuit
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .RapidSpin => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO clearhazards
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .MorningSun => {
            // TODO usedmovetext
            // TODO doturn
            // TODO healmorn
        },
        .Synthesis => {
            // TODO usedmovetext
            // TODO doturn
            // TODO healday
        },
        .Moonlight => {
            // TODO usedmovetext
            // TODO doturn
            // TODO healnite
        },
        .HiddenPower => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO hiddenpower
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .Twister => {
            // TODO usedmovetext
            // TODO doturn
            // TODO critical
            // TODO damagestats
            // TODO damagecalc
            // TODO stab
            // TODO damagevariation
            // TODO doubleflyingdamage
            // TODO checkhit
            // TODO effectchance
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO flinchtarget
        },
        .RainDance => {
            // TODO usedmovetext
            // TODO doturn
            // TODO startrain
        },
        .SunnyDay => {
            // TODO usedmovetext
            // TODO doturn
            // TODO startsun
        },
        .MirrorCoat => {
            // TODO usedmovetext
            // TODO doturn
            // TODO mirrorcoat
            // TODO failuretext
            // TODO applydamage
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO kingsrock
        },
        .PsychUp => {
            // TODO usedmovetext
            // TODO doturn
            // TODO psychup
        },
        .FutureSight => {
            // TODO checkfuturesight
            // TODO usedmovetext
            // TODO doturn
            // TODO damagestats
            // TODO damagecalc
            // TODO futuresight
            // TODO damagevariation
            // TODO checkhit
            // TODO failuretext
            // TODO applydamage
            // TODO checkfaint
            // TODO buildopponentrage
        },
        .BeatUp => {
            // TODO usedmovetext
            // TODO movedelay
            // TODO doturn
            // TODO startloop
            // TODO checkhit
            // TODO critical
            // TODO beatup
            // TODO damagecalc
            // TODO damagevariation
            // TODO clearmissdamage
            // TODO failuretext
            // TODO applydamage
            // TODO criticaltext
            // TODO cleartext
            // TODO supereffectivetext
            // TODO checkfaint
            // TODO buildopponentrage
            // TODO endloop
            // TODO beatupfailtext
            // TODO kingsrock
        },
        // zig fmt: off
        .AllStatUpChance, .AttackUp1, .AttackUp2, .AttackUpChance, .DefenseUp1,
        .DefenseUp2, .DefenseUpChance, .EvasionUp1, .SpAtkUp1, .SpDefUp2, .SpeedUp2 => {}, // TODO
        // zig fmt: on
        // zig fmt: off
        .AccuracyDown1, .AccuracyDownChance, .AttackDown1, .AttackDown2,
        .AttackDownChance, .DefenseDown1, .DefenseDown2, .DefenseDownChance,
        .EvasionDown1, .SpDefDownChance, .SpeedDown1, .SpeedDown2, .SpeedDownChance => {}, // TODO
        // zig fmt: on
    }

    return null;
}
