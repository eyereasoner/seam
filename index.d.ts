export interface SeamStats {
  [key: string]: number;
}

export interface SeamRunOptions {
  proof?: boolean;
  why?: boolean;
  explain?: boolean;
  maxDepth?: number;
  solutionLimit?: number;
  registry?: BuiltinRegistry;
  sourceMetadata?: boolean;
  markRecursive?: boolean;
  strictNegation?: boolean;
  analyzeNegation?: boolean;
  [key: string]: unknown;
}

export interface SeamRunResult {
  stdout: string;
  stats: SeamStats;
}

export interface SeamSourcePart {
  text?: string;
  source?: string;
  filename?: string;
}

export interface SeamClause {
  head: SeamTerm;
  body: SeamTerm[];
  index?: number;
  filename?: string;
  clauseNumber?: number;
}

export interface SeamPredicateGroup {
  name: string;
  arity: number;
  clauses: SeamClause[];
  argIndexes: unknown[];
  pairIndexes: unknown[];
  tabled: boolean;
  mode: string[] | null;
  determinism: 'det' | 'semidet' | null;
  recursive: boolean;
  negationStratum: number | null;
}

export type SeamTerm = Term | { type: string; name: string; args?: SeamTerm[]; arity?: number };

export class Term {
  constructor(type: string, name?: unknown, args?: SeamTerm[]);
  type: string;
  name: string;
  args: SeamTerm[];
  get arity(): number;
}

export class Env {
  constructor(bindings?: Iterable<readonly [string, SeamTerm]> | null);
  bindings: Map<string, SeamTerm>;
  clone(): Env;
  has(name: string): boolean;
  get(name: string): SeamTerm | undefined;
  bind(name: string, term: SeamTerm): void;
}

export class Program {
  constructor(clauses?: SeamClause[], options?: SeamRunOptions);
  clauses: SeamClause[];
  groups: Map<string, SeamPredicateGroup>;
  materializedGroups: Set<string>;
  hasMaterialize: boolean;
  negationDependencies: Array<{ from: string; to: string; negative: boolean }>;
  negationStratificationErrors: Array<{ from: string; to: string }>;
  stratifiedNegation: boolean;
  static parse(source: string, options?: SeamRunOptions): Program;
  static parseSources(sources?: Array<string | SeamSourcePart>, options?: SeamRunOptions): Program;
  makeGroup(name: string, arity: number): SeamPredicateGroup;
  indexClause(clause: SeamClause): void;
  findGroup(name: string, arity: number): SeamPredicateGroup | null;
  applyDeclarations(options?: SeamRunOptions): void;
  markRecursivePredicates(): void;
  analyzeNegationStratification(): Array<{ from: string; to: string }>;
  assertStratifiedNegation(): true;
  isStratifiedNegation(): boolean;
  hasMaterializeDeclarations(): boolean;
  groupIsMaterialized(group: SeamPredicateGroup): boolean;
  groupHasRule(group: SeamPredicateGroup): boolean;
  sourceFactLines(predicateKeys?: Set<string> | null): Set<string>;
  materializationGoals(): SeamTerm[];
}

export interface BuiltinDefinition {
  name: string;
  arity: number;
  handler: BuiltinHandler;
  deterministic: boolean;
  ready: ((solver: Solver, goal: SeamTerm, env: Env) => boolean) | null;
  fallbackWhenNotReady: boolean;
  shouldUse: ((solver: Solver, goal: SeamTerm, env: Env) => boolean) | null;
}

export type BuiltinHandler = (context: { solver: Solver; goal: SeamTerm; env: Env }) => Iterable<Env>;

export class BuiltinRegistry {
  constructor();
  defs: Map<string, BuiltinDefinition>;
  add(name: string, arity: number, handler: BuiltinHandler, options?: Partial<BuiltinDefinition>): this;
  get(name: string, arity: number): BuiltinDefinition | null;
}

export class Solver {
  constructor(program: Program, options?: SeamRunOptions);
  program: Program;
  registry: BuiltinRegistry;
  maxDepth: number;
  solutionLimit: number;
  solutionsSeen: number;
  active: unknown[];
  memo: Map<string, unknown>;
  stats: SeamStats;
  cloneForInnerGoal(solutionLimit?: number): Solver;
  solve(goals: SeamTerm | SeamTerm[], env?: Env, depth?: number): Iterable<Env>;
  activeVariant(goal: SeamTerm, env: Env): boolean;
}

export const VAR: 'var';
export const ATOM: 'atom';
export const STRING: 'string';
export const NUMBER: 'number';
export const COMPOUND: 'compound';

export function variable(name: string): Term;
export function atom(name: string): Term;
export function stringTerm(value: string): Term;
export function numberTerm(value: string | number): Term;
/** Construct a compound term; an empty argument list is canonicalized to atom(name). */
export function compound(name: string, args?: SeamTerm[]): Term;
export function emptyList(): Term;
export function cons(head: SeamTerm, tail: SeamTerm): Term;
export function deref(term: SeamTerm, env: Env): SeamTerm;
export function isScalar(term: SeamTerm | null | undefined): boolean;
export function isEmptyList(term: SeamTerm | null | undefined): boolean;
export function isCons(term: SeamTerm | null | undefined): boolean;
export function isConjunction(term: SeamTerm | null | undefined): boolean;
export function unify(left: SeamTerm, right: SeamTerm, env: Env): boolean;
export function cloneTerm(term: SeamTerm): Term;
export function freshTerm(term: SeamTerm, suffix: string | number): Term;
export function copyResolved(term: SeamTerm, env: Env): Term;
export function termIsGround(term: SeamTerm, env?: Env): boolean;
export function termToString(term: SeamTerm, env?: Env, quoteStrings?: boolean): string;
export function lexicalValue(term: SeamTerm, env: Env): string | null;
export function properListItems(list: SeamTerm, env: Env): SeamTerm[] | null;
export function listFromItems(items: SeamTerm[], start?: number, end?: number, tail?: SeamTerm): Term;
export function flattenConjunction(goal: SeamTerm): SeamTerm[];
export function termSignature(term: SeamTerm | null | undefined): string | null;
export function variantTerms(left: SeamTerm, leftEnv: Env, right: SeamTerm, rightEnv: Env, pairs?: Map<string, string>, reverse?: Map<string, string>): boolean;
export function compareTerms(left: SeamTerm, right: SeamTerm): number;
export function isDecimalInteger(text: string | null | undefined): boolean;
export function compareIntegerText(left: string, right: string): number;
export function parseFiniteNumber(text: string | null | undefined): number | null;
export function numberTextFromDouble(value: number): string | null;
export function compareNumberText(left: string, right: string): number;

export function makeProgram(source: string, options?: SeamRunOptions): Program;
export function parseClauses(source: string, options?: SeamRunOptions): SeamClause[];
export function parseProgramText(source: string, options?: SeamRunOptions): SeamClause[];
export function createDefaultRegistry(): BuiltinRegistry;
export function getDefaultRegistry(): BuiltinRegistry;
export function run(source: string | Program, options?: SeamRunOptions): SeamRunResult;
export function whyProof(program: Program, goal: SeamTerm, options?: SeamRunOptions): { ok: boolean; text: string };
export function whyNoProof(goal: SeamTerm): string;
export function explainProof(program: Program, goal: SeamTerm, options?: SeamRunOptions): { ok: boolean; text: string };

declare const seam: {
  VAR: typeof VAR;
  ATOM: typeof ATOM;
  STRING: typeof STRING;
  NUMBER: typeof NUMBER;
  COMPOUND: typeof COMPOUND;
  Term: typeof Term;
  Env: typeof Env;
  Program: typeof Program;
  Solver: typeof Solver;
  BuiltinRegistry: typeof BuiltinRegistry;
  variable: typeof variable;
  atom: typeof atom;
  stringTerm: typeof stringTerm;
  numberTerm: typeof numberTerm;
  compound: typeof compound;
  emptyList: typeof emptyList;
  cons: typeof cons;
  deref: typeof deref;
  isScalar: typeof isScalar;
  isEmptyList: typeof isEmptyList;
  isCons: typeof isCons;
  isConjunction: typeof isConjunction;
  unify: typeof unify;
  cloneTerm: typeof cloneTerm;
  freshTerm: typeof freshTerm;
  copyResolved: typeof copyResolved;
  termIsGround: typeof termIsGround;
  termToString: typeof termToString;
  lexicalValue: typeof lexicalValue;
  properListItems: typeof properListItems;
  listFromItems: typeof listFromItems;
  flattenConjunction: typeof flattenConjunction;
  termSignature: typeof termSignature;
  variantTerms: typeof variantTerms;
  compareTerms: typeof compareTerms;
  isDecimalInteger: typeof isDecimalInteger;
  compareIntegerText: typeof compareIntegerText;
  parseFiniteNumber: typeof parseFiniteNumber;
  numberTextFromDouble: typeof numberTextFromDouble;
  compareNumberText: typeof compareNumberText;
  makeProgram: typeof makeProgram;
  parseClauses: typeof parseClauses;
  parseProgramText: typeof parseProgramText;
  createDefaultRegistry: typeof createDefaultRegistry;
  getDefaultRegistry: typeof getDefaultRegistry;
  run: typeof run;
  whyProof: typeof whyProof;
  whyNoProof: typeof whyNoProof;
  explainProof: typeof explainProof;
};

export default seam;
