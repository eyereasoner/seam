#!/usr/bin/env node
// Example-output test runner.
// It compares examples byte-for-byte against golden output so answer and proof changes cannot silently alter results.
import fs from 'node:fs';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { Program, run } from '../src/index.js';
import { fileURLToPath } from 'node:url';
import { TestReporter, isMainModule } from './test-style.mjs';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)));
const packageRoot = path.resolve(root, '..');
const examplesDir = path.join(packageRoot, 'examples');
const expectedDir = path.join(examplesDir, 'output');
const expectedProofDir = path.join(examplesDir, 'proof');
const fixedExampleDate = '2026-05-30';

const proofExamples = [
  'access-control-policy.eye',
  'age.eye',
  'aliases-and-namespaces.eye',
  'ancestor.eye',
  'animal.eye',
  'annotation.eye',
  'backward.eye',
  'bayes-diagnosis.eye',
  'cat-koko.eye',
  'context-association.eye',
  'data-negotiation.eye',
  'deontic-logic.eye',
  'derived-backward-rule.eye',
  'derived-rule.eye',
  'dog.eye',
  'electrical-rc-filter.eye',
  'existential-rule.eye',
  'floating-point.eye',
  'good-cobbler.eye',
  'graph-reachability.eye',
  'greatest-lower-bound-uniqueness.eye',
  'group-inverse-uniqueness.eye',
  'list-collection.eye',
  'proof-contrapositive.eye',
  'reusable-builtins.eye',
  'socket-age.eye',
  'socket-family.eye',
  'socrates.eye',
  'term-tools.eye',
  'witch.eye',
  'beam-deflection.eye',
  'cache-performance.eye',
  'canary-release.eye',
  'chart-parser.eye',
  'clinical-trial-screening.eye',
  'composition-of-injective-functions-is-injective.eye',
  'diamond-property.eye',
  'dpv-odrl-purpose-mapping.eye',
  'epidemic-policy.eye',
  'equivalence-classes-overlap-implies-same-class.eye',
  'expression-eval.eye',
  'gdpr-compliance.eye',
  'hanoi.eye',
  'heat-loss.eye',
  'ideal-gas-law.eye',
  'intuitionistic-logic-kripke.eye',
  'linear-logic-resources.eye',
  'modal-logic-kripke.eye',
  'nixon-diamond.eye',
  'security-incident-correlation.eye',
];

export function runExamples(reporter = new TestReporter()) {
  const files = fs.readdirSync(examplesDir)
    .filter((name) => exampleIsRunnable(name))
    .sort();

  reporter.section('Examples');
  for (const name of files) reporter.test(name, () => runExample(name));
  reporter.sectionTotal('examples');

  reporter.section('Proof examples');
  for (const name of proofExamples) reporter.test(name, () => runProofExample(name));
  reporter.sectionTotal('proof examples');
}


function exampleIsRunnable(name) {
  return name.endsWith('.eye');
}

function runExample(name) {
  const programFile = path.join(examplesDir, name);
  const expected = path.join(expectedDir, name);
  const actual = runProgramExample(programFile, name, { proof: false });
  compareOutput(name, expected, actual, 'output');
}

function runProofExample(name) {
  const programFile = path.join(examplesDir, name);
  const expected = path.join(expectedProofDir, name);
  const actual = runProgramExample(programFile, name, { proof: true });
  compareOutput(name, expected, actual, 'proof output');
}

function runProgramExample(programFile, filename, options) {
  const oldLocalTime = process.env.EYELANG_LOCAL_TIME;
  process.env.EYELANG_LOCAL_TIME = fixedExampleDate;
  try {
    const text = fs.readFileSync(programFile, 'utf8');
    const program = Program.parseSources([{ text, filename }], {
      sourceMetadata: options.proof,
      markRecursive: options.proof,
    });
    return run(program, options).stdout;
  } finally {
    if (oldLocalTime == null) delete process.env.EYELANG_LOCAL_TIME;
    else process.env.EYELANG_LOCAL_TIME = oldLocalTime;
  }
}

function compareOutput(name, expected, actual, label) {
  if (!fs.existsSync(expected)) {
    throw new Error(`missing expected ${label} file: ${path.relative(root, expected)}`);
  }

  const expectedText = fs.readFileSync(expected, 'utf8');
  if (expectedText !== actual) {
    throw new Error(`${label} mismatch for ${name}\n${diffText(expected, actual)}`.trimEnd());
  }
}

function diffText(expected, actualText) {
  const diff = spawnSync('diff', ['-u', expected, '-'], { input: actualText, encoding: 'utf8' });
  if (diff.stdout) return diff.stdout;

  const expectedText = fs.readFileSync(expected, 'utf8').split('\n');
  const actualLines = actualText.split('\n');
  const limit = Math.max(expectedText.length, actualLines.length);
  for (let i = 0; i < limit; i++) {
    if (expectedText[i] !== actualLines[i]) {
      return `first difference at line ${i + 1}\nexpected: ${expectedText[i] ?? '<missing>'}\nactual:   ${actualLines[i] ?? '<missing>'}`;
    }
  }

  return 'outputs differ';
}

if (isMainModule(import.meta.url)) {
  const reporter = new TestReporter();
  try {
    runExamples(reporter);
    reporter.totalLine();
  } catch (_) {
    process.exit(1);
  }
}
