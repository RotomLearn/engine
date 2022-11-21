import {BoostID, Generation, ID, StatID, TypeName} from '@pkmn/data';
import {Sprites, Icons} from '@pkmn/img';

import {Battle, Pokemon, Side} from '../pkg';

const POSITIONS = ['a', 'b', 'c', 'd', 'e', 'f'];
const VOLATILES: {[id in keyof Pokemon['volatiles']]: [string, 'good' | 'bad' | 'neutral']} = {
  bide: ['Bide', 'good'],
  thrashing: ['Thrashing', 'neutral'],
  flinch: ['Flinch', 'bad'],
  charging: ['Charging', 'good'],
  trapping: ['Trapping', 'bad'],
  invulnerable: ['Invulnerable', 'good'],
  confusion: ['Confusion', 'bad'],
  mist: ['Mist', 'good'],
  focusenergy: ['Focus Energy', 'good'],
  substitute: ['Substitute', 'good'],
  recharging: ['Recharging', 'bad'],
  rage: ['Rage', 'neutral'],
  leechseed: ['Leech Seed', 'bad'],
  lightscreen: ['Light Screen', 'good'],
  reflect: ['Reflect', 'good'],
  transform: ['Transformed', 'neutral'],
};

export const STYLES = `
#content {
  font-family: "Roboto", "Helvetica Neue", "Helvetica", "Arial", sans-serif;
  margin: 4em auto;
  max-width: 1300px;
  line-height: 1.4em;
  --hp-bar: 151px;
  --hp-text: 32px;
}
details > summary {
  list-style: none;
}
details > summary::-webkit-details-marker {
  display: none;
}
.battle > .details {
  background: #eee;
  border-bottom: 3px solid black;
  padding: 0 0.5em;
  display: flex;
  justify-content: space-between;
}
.inner {
  display: flex;
  justify-content: center;
  flex-direction: column;
}
.side > .details {
  padding: 0.5em;
  display: flex;
  justify-content: space-between;
  text-align: center;
  flex: 0 1 auto;
}
.active {
  flex: 1 1 auto;
}
details {
  flex: 0 1 auto;
}
.sides {
  display: flex;
}
.side {
  flex: 1;
  display: flex;
  flex-flow: column;
}
.side.p1 {
  border-right: 1px solid black;
}
.battle {
  border: 3px solid black;
}
summary {
  border-top: 1px solid black;
  text-align: center;
  padding: 0.25em;
}
.good {
  color: green;
}
.bad {
  color: red;
}
.pokemon {
  position: relative;
  padding: 0.5em;
  border-top: 1px solid black;
  display: flex;
}

table {
  border-collapse: collapse;
  border-style: hidden;
  border-spacing: 0px;
  line-height: 1.5em;
}
th, td {
  border: 1px solid black;
  padding: 0 0.5em;
}
.statbar {
  display: none;
  width: calc(var(--hp-bar) + var(--hp-text));
  padding: 2px 0;
  line-height: normal;
}
.statbar .name {
  display: block;
  text-align: center;
  line-height: 1.25em;
}
.statbar strong {
  color: #222222;
  text-shadow: #FFFFFF 1px 1px 0, #FFFFFF 1px -1px 0, #FFFFFF -1px 1px 0, #FFFFFF -1px -1px 0;
}
.statbar strong small {
  font-weight: normal;
}
.statbar .hpbar {
  position: relative;
  border: 1px solid #777777;
  background: #FCFEFF;
  padding: 1px;
  height: 8px;
  margin: 0 0 0 0;
  width: calc(var(--hp-bar) + var(--hp-text) + 1px);
  border-radius: 4px;
}
.statbar .hpbar .hp {
  height: 4px;
  border-top: 2px solid #00dd60;
  background: #00bb51;
  border-bottom: 2px solid #007734;
  border-right: 1px solid #007734;
  border-radius: 3px;
}
.statbar .hpbar .hp-yellow {
  border-top-color: #f8e379;
  background-color: #f5d538;
  border-bottom-color: #be9f0a;
  border-right-color: #be9f0a;
}
.statbar .hpbar .hp-red {
  border-top-color: #f37f67;
  background-color: #ee4928;
  border-bottom-color: #a3260d;
  border-right-color: #a3260d;
}
.statbar .hpbar .prevhp {
  background: #BBEECC;
  height: 8px;
  border-radius: 3px;
}
.statbar .hpbar .prevhp-yellow {
  background-color: #fcf4ca;
}
.statbar .hpbar .prevhp-red {
  background-color: #facec5;
}
.statbar .hpbar .hptext {
  position: absolute;
  background: #777777;
  color: #EEEEEE;
  text-shadow: #000000 0 1px 0;
  font-size: 10px;
  width: 32px;
  height: 12px;
  top: -1px;
  text-align: center;
}
.status, .volatile {
  padding: 0px 1px;
  border: 1px solid #FF4400;
  border-radius: 3px;
}
.status {
  min-height: 10px;
  font-size: 7pt;
  vertical-align: middle;
  padding: 1px 2px;
  border: 0;
  border-radius: 3px;
  text-transform: uppercase;
  margin: 0 2px;
}
.status.brn {
  background: #EE5533;
  color: #FFFFFF;
}
.status.psn {
  background: #A4009A;
  color: #FFFFFF;
}
.status.par {
  background: #9AA400;
  color: #FFFFFF;
}
.status.slp {
  background: #AA77AA;
  color: #FFFFFF;
}
.status.frz {
  background: #009AA4;
  color: #FFFFFF;
}
.volatile {
  display: inline-block;
  padding: 0 5px;
  margin: 2px
}
.volatile.bad {
  background: #FFE5E0;
  color: #FF4400;
  border-color: #FF4400;
}
.volatile.good {
  background: #E5FFE0;
  color: #33AA00;
  border-color: #33AA00;
}
.volatile.neutral {
  background: #F0F0F0;
  color: #555555;
  border-color: #555555;
}
.rstatbar .hpbar .hptext {
  right: 0px;
  border-radius: 0 4px 4px 0;
}
.moves ul {
  column-count: 2;
  column-gap: 2em;
}
.left {
  padding-right: 32px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.stats {
  display: flex;
  padding: 0 1em;
  justify-content: space-between;
  text-align: center;
  width: 100%;
}
.types {
  display: inherit;
}
.disabled {
  color: #AAAAAA;
}
.log {
  display: flex;
  justify-content: center;
  padding-bottom: 2em;
}
.position {
  position: absolute;
  right: 10px;
  color: #AAAAAA;
}
.left .position {
  display: none;
}
.right .position {
  display: block;
}
.teamicons {
  display: inline-block;
}
@media(max-width: 1300px) {
  #content {
    font-size: 0.85em;
    max-width: 95%;
    margin: 2em auto;
  }
}
@media(max-width: 1200px) {
  .moves ul {
    column-count: 1;
  }
}
@media(max-width: 1100px) {
  .pokemon {
    flex-direction: column;
  }
  .stats {
    justify-content: center;
    padding: 0;
  }
  .boosts {
    margin-left: 5px;
  }
  .moves ul {
    column-count: 2;
  }
  .left {
    padding-right: 0;
  }
  .right {
    padding-top: 1em;
  }
  .volatiles {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
  }
  .left .position {
    display: block;
  }
  .right .position {
    display: none;
  }
}
@media(max-width: 800px) {
  .moves {
    display: flex;
    justify-content: center;
  }
  .moves ul {
    column-count: 1;
    display: inline-block;
    padding: 0;
  }
}
@media(max-width: 680px) {
  .stats {
    flex-direction: column;
    padding: 0;
  }
  .boosts {
    display: flex;
    justify-content: space-between;
    margin-top: 0.5em;
  }
}
@media(max-width: 550px) {
  #content {
    font-size: 0.65em;
    max-width: 95%;
    margin: 1em auto;
    --hp-bar: 101px;
  }
}
@media(max-width: 425px) {
  .stats {
    font-size: 0.9em;
  }
}`;

export const SCRIPTS = `
for (const details of document.getElementsByTagName('details')) {
  details.addEventListener('toggle', e => {
    for (const d of details.parentElement.parentElement.getElementsByTagName('details')) {
      if (d.open !== details.open) d.open = details.open;
    }
  });
}`;

export function displayBattle(gen: Generation, showdown: boolean, battle: Battle, last?: Battle) {
  const buf = [];
  buf.push('<div class="battle">');
  if (battle.turn) {
    buf.push('<div class="details">');
    buf.push(`<h2>Turn ${battle.turn}</h2>`);
    buf.push('<div class="inner">');
    buf.push(`<div><strong>Last Damage:</strong> ${battle.lastDamage}</div>`);
    buf.push(`<div><strong>Seed:</strong> ${battle.prng.join(', ')}</div>`);
    buf.push('</div>');
    buf.push('</div>');
  }
  buf.push('<div class="sides">');
  const [p1, p2] = Array.from(battle.sides);
  const [o1, o2] = last ? Array.from(last.sides) : [undefined, undefined];
  buf.push(displaySide(gen, showdown, !!battle.turn, 'p1', p1, o1));
  buf.push(displaySide(gen, showdown, !!battle.turn, 'p2', p2, o2));
  buf.push('</div>');
  buf.push('</div>');
  return buf.join('');
}

function displaySide(
  gen: Generation,
  showdown: boolean,
  started: boolean,
  player: 'p1' | 'p2',
  side: Side,
  last?: Side,
) {
  const buf = [];
  buf.push(`<div class="side ${player}">`);
  if (started) {
    buf.push('<div class="details">');
    const used = side.lastUsedMove ? gen.moves.get(side.lastUsedMove)!.name : '<em>None</em>';
    buf.push(`<div><strong>Last Used</strong><br />${used}</div>`);
    const selected =
      side.lastSelectedMove ? gen.moves.get(side.lastSelectedMove)!.name : '<em>None</em>';
    const index =
      side.lastSelectedIndex ? ` (${side.lastSelectedIndex})` : '';
    buf.push(`<div><strong>Last Selected</strong><br />${selected}${index}</div>`);
    buf.push('</div>');
  }
  if (side.active) {
    buf.push('<div class="active">');
    let prev = undefined;
    if (last) {
      for (const pokemon of last.pokemon) {
        if (pokemon.position === side.active.position) {
          prev = pokemon;
          break;
        }
      }
    }
    buf.push(displayPokemon(gen, showdown, side.active, true, prev));
    buf.push('</div>');
  }
  buf.push('<details class="team">');
  buf.push('<summary><div class="teamicons">');
  let i = 0;
  const b = [];
  for (const pokemon of side.pokemon) {
    if (i === 3) b.push('</div><div class="teamicons">');
    b.push(icon(gen, player, pokemon));
    i++;
  }
  buf.push(b.join(''));
  buf.push('</div></summary>');
  for (const pokemon of side.pokemon) {
    buf.push(displayPokemon(gen, showdown, pokemon, false));
  }
  buf.push('</details>');
  buf.push('</div>');
  return buf.join('');
}

const STATS = ['hp', 'atk', 'def', 'spa', 'spd', 'spe'] as const;

function displayPokemon(
  gen: Generation,
  showdown: boolean,
  pokemon: Pokemon,
  active: boolean,
  last?: Pokemon,
) {
  const buf = [];
  buf.push('<div class="pokemon">');
  const species = active ? pokemon.species : pokemon.stored.species;

  // HP Bar
  const {title, percent, width, color} = getHP(pokemon);
  buf.push(`<div class="left" title="${title}">`);
  if (!active) buf.push(`<div class="position">${POSITIONS[pokemon.position - 1]}</div>`);
  buf.push('<div class="statbar rstatbar" style="display: block; opacity: 1;">');
  buf.push('<span class="name">');
  if (pokemon.status) buf.push(displayStatus(pokemon));
  let name: string = gen.species.get(species)!.name;
  if (active && pokemon.species !== pokemon.stored.species) name = `<em>${name}</em>`;
  buf.push(`<strong>${name}&nbsp;<small>L${pokemon.level}</small></strong>`);
  if (active && pokemon.species !== pokemon.stored.species) buf.push('</em>');
  buf.push('</span>');
  buf.push('<div class="hpbar">');
  const style = `width: ${width}; border-right-width: ${percent === 100 ? 1 : 0}px;`;
  const hp = `<div class="hp ${color}" style="${style}"></div>`;
  if (last && last.position === pokemon.position && pokemon.hp < last.hp) {
    const prev = getHP(last);
    const style = `width: ${prev.width}; border-right-width: ${prev.percent === 100 ? 1 : 0}px;`;
    buf.push(`<div class="prevhp ${prev.color ? 'prev' + prev.color : ''}" style="${style}">`);
    buf.push(hp);
    buf.push('</div>');
  } else {
    buf.push(hp);
  }
  buf.push(`<div class="hptext">${percent}%</div>`);
  buf.push('</div></div>');

  // Sprite & Types
  buf.push(sprite(showdown, species, pokemon.hp === 0));
  const types = active ? pokemon.types : pokemon.stored.types;
  buf.push('<div class="types">');
  buf.push(typicon(types[0]));
  if (types[0] !== types[1]) buf.push(typicon(types[1]));
  buf.push('</div>');
  buf.push('</div>');

  buf.push('<div class="right">');
  if (!active) buf.push(`<div class="position">${POSITIONS[pokemon.position - 1]}</div>`);

  // Stats & Boosts
  buf.push('<div class="stats"><table><tr>');
  const stats = active ? pokemon.stats : pokemon.stored.stats;
  for (const stat of STATS) {
    if (gen.num === 1 && stat === 'spd') continue;
    buf.push(`<th>${gen.stats.display(stat)}</th>`);
  }
  buf.push('</tr><tr>');
  for (const stat of STATS) {
    if (gen.num === 1 && stat === 'spd') continue;
    const boost = active ? pokemon.boosts[stat as BoostID] : 0;
    buf.push(`<td>${displayStat(stats[stat as StatID], boost)}</td>`);
  }
  buf.push('</tr></table>');
  if (active) {
    buf.push('<div class="boosts">');
    if (pokemon.boosts.accuracy) {
      buf.push(`<div><strong>Accuracy:</strong> ${displayBoost(pokemon.boosts.accuracy)}</div>`);
    }
    if (pokemon.boosts.evasion) {
      buf.push(`<div><strong>Evasion:</strong> ${displayBoost(pokemon.boosts.evasion)}</div>`);
    }
    buf.push('</div>');
  }
  buf.push('</div>');

  // Moves
  buf.push('<div class="moves"><ul>');
  const moves = active ? pokemon.moves : pokemon.stored.moves;
  for (const move of moves) {
    const name = gen.moves.get(move.id)!.name;
    const maxpp = Math.min(gen.moves.get(move.id)!.pp / 5 * 8, gen.num === 1 ? 61 : 64);
    const disabled = !move.pp || (move as any).disabled ? 'disabled' : '';
    const title =
      (move as any).disabled ? `title="Disabled: ${(move as any).disabled as number}"` : '';
    const pp = `<small>(${move.pp}/${maxpp})</small>`;
    buf.push(`<li class="${disabled}" ${title}>${name} ${pp}</li>`);
  }
  buf.push('</ul></div>');

  // Volatiles
  if (active) {
    buf.push('<div class="volatiles">');
    for (const v in pokemon.volatiles) {
      const volatile = v as keyof Pokemon['volatiles'];
      const [name, type] = VOLATILES[volatile]!;
      let data = '';
      if (['trapping', 'confusion', 'substitute', 'rage'].includes(volatile)) {
        data = Object.values(pokemon.volatiles[volatile]!)[0].toString();
      } else if (volatile === 'bide') {
        const val = pokemon.volatiles[volatile]!;
        data = `${val.duration} (${val.damage})`;
      } else if (volatile === 'thrashing') {
        const val = pokemon.volatiles[volatile]!;
        data = `${val.duration} (${val.accuracy})`;
      } else if (volatile === 'transform') {
        const slot = POSITIONS[pokemon.volatiles[volatile]!.slot];
        data = `${pokemon.volatiles[volatile]!.player}${slot}`;
      }
      data = (data ? `${name}: ${data}` : name).replace(' ', '&nbsp;');
      buf.push(`<span class="volatile ${type}">${data}</span>`);
    }
    buf.push('</div>');
  }

  buf.push('</div>');
  buf.push('</div>');
  return buf.join('');
}

export function escapeHTML(str: string) {
  return (str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;')
    .replace(/\//g, '&#x2f;')
    .replace(/\n/g, '<br />'));
}

function getHP(pokemon: Pokemon) {
  const title = `${pokemon.hp}/${pokemon.stats.hp}`;
  const ratio = pokemon.hp / pokemon.stats.hp;
  let percent = Math.ceil(ratio * 100);
  if ((percent === 100) && (ratio < 1.0)) {
    percent = 99;
  }
  const width = (pokemon.hp === 1 && pokemon.stats.hp > 45)
    ? '1px' : ratio === 1.0
      ? 'var(--hp-bar)' : `calc(${ratio} * var(--hp-bar))`;
  const color = ratio > 0.5 ? '' : ratio > 0.2 ? 'hp-yellow' : 'hp-red';
  return {title, percent, width, color};
}

function displayStatus(pokemon: Pokemon) {
  const c = pokemon.status === 'tox' ? 'psn' : pokemon.status!;
  let t = '';
  if (pokemon.statusData.sleep) t += `Sleep: ${pokemon.statusData.sleep}`;
  if (pokemon.status === 'tox' || pokemon.statusData.toxic) {
    t += `Toxic: ${pokemon.statusData.toxic}`;
  }
  if (t) t = `title="${t}"`;
  const s = pokemon.statusData.self ? 'slf' : pokemon.status!;
  return `<span class="status ${c}" ${t}>${s}</span>`;
}

function displayStat(stat: number, boost: number) {
  if (!boost) return `${stat}`;
  if (boost > 0) return `<span class="good">${stat} (+${boost})</span>`;
  return `<span class="bad">${stat} (${boost})</span>`;
}

function displayBoost(boost: number) {
  if (boost > 0) return `<span class="good">+${boost}</span>`;
  return `<span class="bad">${boost}</span>`;
}

function icon(gen: Generation, player: 'p1' | 'p2', pokemon: Pokemon) {
  const fainted = pokemon.hp === 0;
  // custom icon sheet for old gen sprites
  if (gen.num <= 2) {
    const size = 24;
    const url = 'https://pkmn.cc/sprites/gsicons-sheet.png';
    const num = gen.species.get(pokemon.stored.species)!.num - 1;
    const top = -Math.floor(num / 17) * size;
    const left = -(num % 17) * size;
    const css: {[attr: string]: string} = {
      display: 'inline-block',
      width: `${size}px`,
      height: `${size}px`,
      imageRendering: 'pixelated',
      background: `transparent url(${url}) no-repeat scroll ${left}px ${top}px`,
      margin: `${(30 - size) / 2}px ${(40 - size) / 2}px`,
    };
    if (fainted) {
      css.opacity = '0.3';
      css.filter = 'grayscale(100%) brightness(.5)';
    }
    return `<span style="${toStyle(css)}"></span>`;
  } else {
    const icon =
      Icons.getPokemon(pokemon.stored.species, {side: player, fainted, domain: 'pkmn.cc'});
    return `<span style="${icon.style}"></span>`;
  }
}

function toStyle(css: {[attr: string]: number | string}) {
  const style = [];
  for (const attr in css) {
    style.push(`${attr === 'imageRendering' ? 'image-rendering' : attr}:${css[attr]}`);
  }
  return `${style.join(';')};`;
}

function sprite(showdown: boolean, species: ID, fainted: boolean) {
  const s = Sprites.getPokemon(species, {gen: showdown ? 'gen1' : 'gen1rb'});
  let style = s.pixelated ? 'image-rendering: pixelated;' : '';
  if (fainted) style += 'opacity: 0.3; filter: grayscale(100%) brightness(.5);';
  return `<img class="sprite" src="${s.url}" width="${s.w}" height="${s.h}" style="${style}" />`;
}

function typicon(type: TypeName) {
  const i = Icons.getType(type);
  const style = 'image-rendering: pixelated;';
  return `<img class="icon" src="${i.url}" width="${i.w}" height="${i.h}" style="${style}" />`;
}
