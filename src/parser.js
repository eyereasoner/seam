// Tokenizer and recursive-descent parser for the eyelang source language.
// It preserves the compact Prolog-like syntax while producing Term objects for the solver.
import { atom, compound, cons, emptyList, numberTerm, stringTerm, variable } from './term.js';

const TOK = {
  EOF: 'eof', ATOM: 'atom', VAR: 'var', STRING: 'string', NUMBER: 'number',
  LPAREN: '(', RPAREN: ')', LBRACKET: '[', RBRACKET: ']', COMMA: ',', BAR: '|', DOT: '.', IF: ':-'
};

function isAbsoluteIriText(text) {
  return /^[A-Za-z][A-Za-z0-9+.-]*:[^\s<>"'{}|\\^`]*$/.test(text);
}

function hasAngleIriToken(source, pos) {
  if (source[pos] !== '<') return false;
  let text = '';
  for (let i = pos + 1; i < source.length; i++) {
    const ch = source[i];
    if (ch === '>') return text.length > 0 && isAbsoluteIriText(text);
    if (ch === '\n' || ch === '\r' || /\s/.test(ch) || ch === '<') return false;
    text += ch;
  }
  return false;
}

function isWhitespaceCode(code) {
  return code === 32 || code === 9 || code === 10 || code === 13 || code === 12 || code === 11;
}

function isDigitCode(code) {
  return code >= 48 && code <= 57;
}

function isAsciiLetterCode(code) {
  return (code >= 65 && code <= 90) || (code >= 97 && code <= 122);
}

function isNameContinueCode(code) {
  return code === 95 || isAsciiLetterCode(code) || isDigitCode(code);
}


function isQuestionVariableStart(source, pos) {
  if (source[pos] !== '?') return false;
  const code = (source[pos + 1] ?? '').charCodeAt(0);
  return code === 95 || isAsciiLetterCode(code);
}

function isPlainAtomStartCode(code) {
  return code >= 97 && code <= 122;
}

const graphicAtomChars = '#$&*+-/<=>?@^~\\';

function isGraphicAtomCode(code) {
  return graphicAtomChars.includes(String.fromCharCode(code));
}

class Parser {
  constructor(source, options = {}) {
    this.source = String(source ?? '');
    this.filename = options.filename ?? '<input>';
    this.pos = 0;
    this.line = 1;
    this.anonymous = 0;
    this.sourceMetadata = options.sourceMetadata !== false;
    this.token = this.nextToken();
  }
  peek(offset = 0) {
    return this.source[this.pos + offset] ?? '';
  }
  take() {
    const ch = this.peek();
    if (ch) {
      this.pos++;
      if (ch === '\n') this.line++;
    }
    return ch;
  }
  skipWhitespaceAndComments() {
    const source = this.source;
    const len = source.length;
    while (true) {
      while (this.pos < len) {
        const code = source.charCodeAt(this.pos);
        if (!isWhitespaceCode(code)) break;
        if (code === 10) this.line++;
        this.pos++;
      }
      if (source.charCodeAt(this.pos) === 37) { // % line comment
        while (this.pos < len && source.charCodeAt(this.pos) !== 10) this.pos++;
        continue;
      }
      break;
    }
  }
  nextToken() {
    // The tokenizer keeps just enough state for useful parse-line errors and
    // treats quoted atoms and quoted strings differently, as Prolog syntax does.
    this.skipWhitespaceAndComments();
    const line = this.line;
    const ch = this.peek();
    if (!ch) return { type: TOK.EOF, text: '', line };

    const punct = { '(': TOK.LPAREN, ')': TOK.RPAREN, '[': TOK.LBRACKET, ']': TOK.RBRACKET, ',': TOK.COMMA, '|': TOK.BAR, '.': TOK.DOT };
    if (punct[ch]) {
      this.take();
      return { type: punct[ch], text: ch, line };
    }
    if (ch === ':' && this.peek(1) === '-') {
      this.pos += 2;
      return { type: TOK.IF, text: ':-', line };
    }
    if (ch === ':') throw new Error('colon names are not supported; use name or prefix_name');

    if (hasAngleIriToken(this.source, this.pos)) {
      this.take(); // <
      let text = '';
      while (true) {
        if (!this.peek()) throw new Error(`parse line ${line}: unterminated IRI`);
        const value = this.take();
        if (value === '>') break;
        text += value;
      }
      return { type: TOK.ATOM, text, line };
    }

    if (ch === '"' || ch === "'") {
      const quote = this.take();
      let text = '';
      while (true) {
        if (!this.peek()) throw new Error(`parse line ${line}: unterminated quoted term`);
        let value = this.take();
        if (value === quote) {
          if (this.peek() === quote) {
            this.take();
            value = quote;
          } else {
            break;
          }
        } else if (value === '\\' && this.peek()) {
          const escaped = this.take();
          if (escaped === 'n') value = '\n';
          else if (escaped === 't') value = '\t';
          else value = escaped;
        }
        text += value;
      }
      return { type: quote === '"' ? TOK.STRING : TOK.ATOM, text, line };
    }

    if (isDigitCode(ch.charCodeAt(0)) || (ch === '-' && isDigitCode(this.peek(1).charCodeAt(0)))) {
      const start = this.pos;
      if (this.peek() === '-') this.take();
      while (isDigitCode(this.peek().charCodeAt(0))) this.take();
      if (this.peek() === '.' && isDigitCode(this.peek(1).charCodeAt(0))) {
        this.take();
        while (isDigitCode(this.peek().charCodeAt(0))) this.take();
      }
      if ((this.peek() === 'e' || this.peek() === 'E')) {
        let idx = this.pos + 1;
        if (this.source[idx] === '+' || this.source[idx] === '-') idx++;
        if (isDigitCode((this.source[idx] ?? '').charCodeAt(0))) {
          this.take();
          if (this.peek() === '+' || this.peek() === '-') this.take();
          while (isDigitCode(this.peek().charCodeAt(0))) this.take();
        }
      }
      return { type: TOK.NUMBER, text: this.source.slice(start, this.pos), line };
    }

    if (isQuestionVariableStart(this.source, this.pos)) {
      const start = this.pos;
      this.take(); // ?
      this.take();
      while (isNameContinueCode(this.peek().charCodeAt(0))) this.take();
      let text = this.source.slice(start, this.pos);
      if (text === '?_') text = `__anon${this.anonymous++}`;
      return { type: TOK.VAR, text, line };
    }

    if (isPlainAtomStartCode(ch.charCodeAt(0))) {
      const start = this.pos;
      this.take();
      while (isNameContinueCode(this.peek().charCodeAt(0))) this.take();
      return { type: TOK.ATOM, text: this.source.slice(start, this.pos), line };
    }

    if (isGraphicAtomCode(ch.charCodeAt(0))) {
      const start = this.pos;
      this.take();
      while (isGraphicAtomCode(this.peek().charCodeAt(0))) this.take();
      return { type: TOK.ATOM, text: this.source.slice(start, this.pos), line };
    }

    throw new Error(`parse line ${line}: bad character ${JSON.stringify(ch)}`);
  }
  advance() {
    this.token = this.nextToken();
  }
  expect(type, desc = type) {
    if (this.token.type !== type) throw new Error(`parse line ${this.token.line}: expected ${desc}, got ${this.token.text}`);
  }
  parseParenthesizedTerm() {
    // Parenthesized comma terms are represented as right-associated ','/2
    // compounds, which lets the solver flatten conjunctions uniformly.
    this.expect(TOK.LPAREN, '(');
    this.advance();
    const items = [];
    while (true) {
      items.push(this.parseTerm());
      if (this.token.type === TOK.COMMA) {
        this.advance();
        continue;
      }
      break;
    }
    this.expect(TOK.RPAREN, ')');
    this.advance();
    let term = items[items.length - 1];
    for (let i = items.length - 2; i >= 0; i--) term = compound(',', [items[i], term]);
    return term;
  }
  parseList() {
    // Lists are lowered to './2' cons cells and [] so list predicates can work
    // on a single canonical representation.
    this.expect(TOK.LBRACKET, '[');
    this.advance();
    if (this.token.type === TOK.RBRACKET) {
      this.advance();
      return emptyList();
    }
    const items = [];
    let tail = null;
    while (true) {
      items.push(this.parseTerm());
      if (this.token.type === TOK.COMMA) {
        this.advance();
        continue;
      }
      if (this.token.type === TOK.BAR) {
        this.advance();
        tail = this.parseTerm();
        this.expect(TOK.RBRACKET, ']');
        this.advance();
        break;
      }
      this.expect(TOK.RBRACKET, ']');
      this.advance();
      tail = emptyList();
      break;
    }
    for (let i = items.length - 1; i >= 0; i--) tail = cons(items[i], tail);
    return tail;
  }
  parseTerm() {
    if (this.token.type === TOK.LPAREN) return this.parseParenthesizedTerm();
    if (this.token.type === TOK.LBRACKET) return this.parseList();
    if (this.token.type === TOK.VAR) {
      const name = this.token.text;
      this.advance();
      return variable(name);
    }
    if (this.token.type === TOK.STRING) {
      const value = this.token.text;
      this.advance();
      return stringTerm(value);
    }
    if (this.token.type === TOK.NUMBER) {
      const value = this.token.text;
      this.advance();
      return numberTerm(value);
    }
    if (this.token.type === TOK.ATOM) {
      const name = this.token.text;
      this.advance();
      if (this.token.type === TOK.LPAREN) {
        this.advance();
        const args = [];
        if (this.token.type === TOK.RPAREN) {
          throw new Error(`parse line ${this.token.line}: zero-arity compound syntax is not supported; use atom ${JSON.stringify(name)} for arity zero data`);
        }
        while (true) {
          args.push(this.parseTerm());
          if (this.token.type === TOK.COMMA) {
            this.advance();
            continue;
          }
          break;
        }
        this.expect(TOK.RPAREN, ')');
        this.advance();
        return compound(name, args);
      }
      return atom(name);
    }
    throw new Error(`parse line ${this.token.line}: bad term`);
  }
  parseProgram() {
    const clauses = [];
    while (this.token.type !== TOK.EOF) {
      const line = this.token.line;
      const head = this.parseTerm();
      const body = [];
      if (this.token.type === TOK.IF) {
        this.advance();
        while (true) {
          body.push(this.parseTerm());
          if (this.token.type === TOK.COMMA) {
            this.advance();
            continue;
          }
          break;
        }
      }
      this.expect(TOK.DOT, '.');
      this.advance();
      const clause = { head, body };
      if (this.sourceMetadata) clause.source = { filename: this.filename, line, clause: clauses.length + 1 };
      clauses.push(clause);
    }
    return clauses;
  }
}


export function parseClauses(source, options = {}) {
  if (options.sourceMetadata === false) {
    const clauses = parseClausesFastNoSource(source);
    if (clauses) return clauses;
  }
  return new Parser(source, options).parseProgram();
}

function isSimpleName(text) {
  if (!text) return false;
  const first = text.charCodeAt(0);
  if (!(first >= 97 && first <= 122)) return false;
  for (let i = 1; i < text.length; i++) {
    const code = text.charCodeAt(i);
    if (!(code === 95 || (code >= 48 && code <= 57) || (code >= 65 && code <= 90) || (code >= 97 && code <= 122))) return false;
  }
  return true;
}

const SIMPLE_NUMBER = /^-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?$/;
const FAST_BINARY_FACT = /^([a-z][A-Za-z0-9_]*)\(\s*([^,\s()[\]|"']+)\s*,\s*([^,\s()[\]|"']+)\s*\)\.$/;
const FAST_BINARY_RULE = /^([a-z][A-Za-z0-9_]*)\(\s*([^,\s()[\]|"']+)\s*,\s*([^,\s()[\]|"']+)\s*\)\s*:-\s*([a-z][A-Za-z0-9_]*)\(\s*([^,\s()[\]|"']+)\s*,\s*([^,\s()[\]|"']+)\s*\)\.$/;
const SIMPLE_VARIABLE = /^\?[A-Za-z_][A-Za-z0-9_]*$/;
const SIMPLE_ATOM = /^[a-z][A-Za-z0-9_]*$/;
const GRAPHIC_ATOM = /^[#$&*+\-\/<=>?@^~\\]+$/;

function parseClausesFastNoSource(source) {
  source = String(source ?? '');
  const numberCache = new Map();
  const stringCache = new Map();
  const variableCache = new Map();
  const clauses = [];
  let anonymous = 0;
  let chunk = '';

  const cached = (cache, key, create) => {
    const existing = cache.get(key);
    if (existing) return existing;
    const value = create(key);
    cache.set(key, value);
    return value;
  };
  const isFastScalarToken = (text) => SIMPLE_VARIABLE.test(text) || SIMPLE_ATOM.test(text) || GRAPHIC_ATOM.test(text) || SIMPLE_NUMBER.test(text);
  const scalarOrVariableFast = (text) => {
    if (!text || !isFastScalarToken(text)) throw new Error('bad simple term');
    const first = text.charCodeAt(0);
    if (text === '?_') return variable(`__anon${anonymous++}`);
    if (SIMPLE_VARIABLE.test(text)) {
      const existing = variableCache.get(text);
      if (existing) return existing;
      const value = variable(text);
      variableCache.set(text, value);
      return value;
    }
    if ((first === 45 || isDigitCode(first)) && SIMPLE_NUMBER.test(text)) return cached(numberCache, text, numberTerm);
    return atom(text);
  };
  const scalarOrVariable = (text) => scalarOrVariableFast(text.trim());
  const parseBinaryCompound = (text) => {
    text = text.trim();
    const open = text.indexOf('(');
    if (open <= 0 || text[text.length - 1] !== ')') return null;
    const name = text.slice(0, open).trim();
    if (!isSimpleName(name)) return null;
    const inner = text.slice(open + 1, -1);
    if (inner.includes('(') || inner.includes(')') || inner.includes('[') || inner.includes(']') || inner.includes('|') || inner.includes('"') || inner.includes("'")) return null;
    const comma = inner.indexOf(',');
    if (comma < 0 || inner.indexOf(',', comma + 1) >= 0) return null;
    const left = inner.slice(0, comma).trim();
    const right = inner.slice(comma + 1).trim();
    if (!isFastScalarToken(left) || !isFastScalarToken(right)) return null;
    return compound(name, [scalarOrVariable(left), scalarOrVariable(right)]);
  };
  const parseFastBinaryMatch = (match) => {
    if (!isFastScalarToken(match[2]) || !isFastScalarToken(match[3])) return null;
    return compound(match[1], [scalarOrVariableFast(match[2]), scalarOrVariableFast(match[3])]);
  };
  const parseFastBinaryRuleMatch = (match) => {
    if (!isFastScalarToken(match[2]) || !isFastScalarToken(match[3]) || !isFastScalarToken(match[5]) || !isFastScalarToken(match[6])) return null;
    return {
      head: compound(match[1], [scalarOrVariableFast(match[2]), scalarOrVariableFast(match[3])]),
      body: [compound(match[4], [scalarOrVariableFast(match[5]), scalarOrVariableFast(match[6])])],
    };
  };
  const parseFastLine = (text) => {
    if (!text.endsWith('.')) return null;
    const ruleMatch = FAST_BINARY_RULE.exec(text);
    if (ruleMatch) {
      const parsed = parseFastBinaryRuleMatch(ruleMatch);
      if (parsed) return parsed;
    }
    const factMatch = FAST_BINARY_FACT.exec(text);
    if (factMatch) {
      const head = parseFastBinaryMatch(factMatch);
      if (head) return { head, body: [] };
    }
    return null;
  };
  const parseSimple = (text) => {
    if (!text.endsWith('.') || text.includes('\n')) return null;
    const fast = parseFastLine(text);
    if (fast) return fast;
    text = text.slice(0, -1);
    const rule = text.indexOf(':-');
    if (rule < 0) {
      const head = parseBinaryCompound(text);
      return head ? { head, body: [] } : null;
    }
    const head = parseBinaryCompound(text.slice(0, rule));
    const bodyGoal = parseBinaryCompound(text.slice(rule + 2));
    return head && bodyGoal ? { head, body: [bodyGoal] } : null;
  };

  const flush = () => {
    const text = chunk.trim();
    chunk = '';
    if (!text) return true;
    const simple = parseSimple(text);
    if (simple) {
      clauses.push(simple);
      return true;
    }
    try {
      const parsed = new Parser(text, { sourceMetadata: false }).parseProgram();
      clauses.push(...parsed);
      return true;
    } catch (_) {
      return false;
    }
  };

  let lineStart = 0;
  while (lineStart <= source.length) {
    let lineEnd = source.indexOf('\n', lineStart);
    if (lineEnd < 0) lineEnd = source.length;
    let line = source.slice(lineStart, lineEnd);
    if (line.endsWith('\r')) line = line.slice(0, -1);
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith('%')) {
      if (!chunk && trimmed.endsWith('.')) {
        const simple = parseFastLine(trimmed) ?? parseSimple(trimmed);
        if (simple) clauses.push(simple);
        else {
          chunk = line + '\n';
          if (!flush()) return null;
        }
      } else {
        chunk += line + '\n';
        if (trimmed.endsWith('.')) {
          if (!flush()) return null;
        }
      }
    }
    if (lineEnd === source.length) break;
    lineStart = lineEnd + 1;
  }
  if (chunk.trim() && !flush()) return null;
  return clauses;
}

export function parseProgramText(source) {
  return parseClauses(source);
}

export function parseGoalText(text) {
  const clauses = parseClauses(`zz_goal(${text}).`);
  const head = clauses[0]?.head;
  if (!head || head.args.length < 1) throw new Error('bad goal');
  return head.args[0];
}
