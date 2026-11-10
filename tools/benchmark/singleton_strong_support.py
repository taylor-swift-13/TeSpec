"""Strict singleton ABI/strong-left binding helpers. No proof or model execution."""
from pathlib import Path
import hashlib
import json
import re
import sys

ROOT = Path('/home/yangfp/teSpec')
sys.path.insert(0, str(ROOT))
from spectest.core import _coq_dependency_code
from spectest.layout import generate_layout_source
from spectest.layout_libraries import elaborate_library

MODULES = ['LayoutAddress', 'GeneratedLayout', 'DLLSupplement']
SELECTED = 'proof_of_singleton_return_wit_1'
STATEMENT = 'singleton_return_wit_1'
LEGACY = ROOT / 'arxiv/benchmark-support/selection/qcp-migration/supplemental/dll_singleton/DLLSupplement.v'
LEGACY_SHA = 'b1ff9c5edbf101e755eb529d08897857db5ee7c6f444f8a5ac8e3a0acfac4005'


def require(ok, message):
    if not ok:
        raise ValueError(message)


def load(path):
    return json.loads(Path(path).read_text(encoding='utf-8'))


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def sha_bytes(value):
    return hashlib.sha256(value).hexdigest()


def save(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')


def binding_layout(bundle, target_layout):
    """Require exact existing API derivation, canonical runtime helper, and real ABI."""
    bundle = Path(bundle).resolve()
    preparation = load(bundle / 'layout-libraries.json')
    require(preparation['schema'] == 'tespec-layout-library-preparation/v1', 'Wrong preparation schema')
    require(preparation['interpretation'] == 'computational field layout; legacy equivalence not certified', 'Wrong interpretation scope')
    require(preparation['transformation'] == 'insert layout imports after unique Local Open Scope sac', 'Wrong transformation')
    require(preparation['status'] == 'PREPARED_UNCHECKED', 'Preparation is not a proof certificate')
    expected_files = {'target-layout.json', 'GeneratedLayout.v', 'LayoutAddress.v', 'DLLSupplement.v'}
    copied_original = 'original/DLLSupplement.v' in preparation['files']
    require(set(preparation['files']) == expected_files | ({'original/DLLSupplement.v'} if copied_original else set()), 'Unexpected preparation file inventory')
    for name, expected in preparation['files'].items():
        require(sha(bundle / name) == expected, 'Prepared file changed: ' + name)
    layout = load(bundle / 'target-layout.json')
    require(layout == target_layout, 'Prepared interpretation differs from actual native target layout')
    require(layout['architecture_bits'] == 32 and layout['pointer_size'] == 4, 'Singleton requires exported 32-bit ABI')
    nodes = [a for a in layout['aggregates'] if a.get('name') == 'node']
    require(len(nodes) == 1 and nodes[0]['kind'] == 'struct' and nodes[0]['defined'], 'node identity is ambiguous')
    node = nodes[0]
    require(node['size'] == 12 and node['alignment'] == 4, 'Unexpected node layout')
    require({f['name']: (f['offset'], f['size'], f['alignment'], f['computational']) for f in node['fields']} ==
            {'data': (0, 4, 4, True), 'prev': (4, 4, 4, True), 'next': (8, 4, 4, True)}, 'Unexpected singleton field layout')
    require((bundle / 'GeneratedLayout.v').read_bytes() == generate_layout_source(layout).encode(), 'GeneratedLayout is not the canonical ABI translation')
    require((bundle / 'LayoutAddress.v').read_bytes() == (ROOT / 'runtime/tespec/LayoutAddress.v').read_bytes(), 'LayoutAddress differs from pinned runtime source')
    original = bundle / 'original/DLLSupplement.v' if copied_original else LEGACY
    if not copied_original:
        references = preparation.get('original_sources', [])
        require(len(references) == 1 and (ROOT / references[0]['path']).resolve() == LEGACY.resolve() and
                references[0]['sha256'] == LEGACY_SHA, 'Original source reference differs')
    if (bundle / 'LayoutAddress.v').is_symlink():
        shared = preparation.get('shared_sources', [])
        require(len(shared) == 1 and shared[0]['module'] == 'LayoutAddress' and shared[0]['local_path'] == 'LayoutAddress.v' and
                (ROOT / shared[0]['path']).resolve() == (ROOT / 'runtime/tespec/LayoutAddress.v').resolve() and
                shared[0]['sha256'] == sha(bundle / 'LayoutAddress.v'), 'Shared runtime source reference differs')
        require((bundle / 'LayoutAddress.v').resolve() == (ROOT / 'runtime/tespec/LayoutAddress.v').resolve(), 'Shared runtime symlink points elsewhere')
    require(sha(original) == LEGACY_SHA == sha(LEGACY), 'Original DLL definition changed')
    require((bundle / 'DLLSupplement.v').read_bytes() == elaborate_library(original.read_text()).encode(), 'DLL definition is not the exact existing API re-elaboration')
    require(len(preparation['modules']) == 1, 'Unexpected selected libraries')
    item = preparation['modules'][0]
    require(item['module'] == 'DLLSupplement' and item['original_sha256'] == LEGACY_SHA and
            item['transformed_sha256'] == sha(bundle / 'DLLSupplement.v'), 'Library transformation digest differs')
    return {'bundle': str(bundle), 'preparation_manifest_sha256': sha(bundle / 'layout-libraries.json'),
            'target_layout_sha256': sha(bundle / 'target-layout.json'),
            'target_layout_canonical_sha256': sha_bytes(json.dumps(layout, sort_keys=True, separators=(',', ':')).encode()),
            'legacy_definition_sha256': LEGACY_SHA,
            'scope': 'explicit-target-layout-context; legacy equivalence not certified',
            'modules': {name: sha(bundle / (name + '.v')) for name in MODULES}}


def verify_native_dependencies(original, context):
    deps = original.get('coq_dependencies', [])
    require([d['module'] for d in deps] == MODULES, 'Actual native manifest must stage exactly the three dependencies in dependency order')
    for dep in deps:
        expected = context['modules'][dep['module']]
        require(dep['sha256'] == expected == sha(dep['staged']), 'Actual staged ABI dependency changed: ' + dep['module'])
        require(Path(dep['source']).resolve() == (Path(context['bundle']) / (dep['module'] + '.v')).resolve(), 'Native dependency resolves outside selected case bundle/shared runtime')
        require(sha(dep['source']) == expected, 'Native dependency source changed')


def strong_template(goal_bytes):
    """Extract exact parent L in (L \/ R), preserving Goal bytes and L text.

    This intentionally rejects unfamiliar output rather than heuristically
    selecting a convenient clause. Strings/comments retain their byte positions.
    """
    text = goal_bytes.decode('utf-8')
    code = _coq_dependency_code(text)
    matches = list(re.finditer(r'\bDefinition\s+' + STATEMENT + r'\s*:=', code))
    require(len(matches) == 1, 'Expected one original singleton return definition')
    start = matches[0].end()
    stack, disjunctions, end = [], [], None
    pairs = {')': '(', ']': '[', '}': '{'}
    i = start
    while i < len(code):
        ch = code[i]
        if ch in '([{':
            stack.append(ch)
        elif ch in ')]}':
            require(stack and stack.pop() == pairs[ch], 'Unbalanced original proposition')
        elif not stack and code[i:i+2] == '\\/':
            disjunctions.append(i)
            i += 1
        elif not stack and ch == '.' and (i + 1 == len(code) or code[i+1].isspace()):
            end = i
            break
        i += 1
    require(end is not None and not stack and len(disjunctions) == 1, 'Expected exactly two top-level parent alternatives')
    split = disjunctions[0]
    left = text[start:split]
    right = text[split+2:end]
    left_code = code[start:split]
    right_code = code[split+2:end]
    require(left.strip().startswith('(') and left.strip().endswith(')') and right.strip().startswith('(') and right.strip().endswith(')'), 'Unexpected original parent grouping')
    require(len(re.findall(r'\|--', left_code)) == 1 and re.search(r'\|--\s*\(Dll\s+retval\b', left_code), 'Left branch is not the actual Dll return entailment')
    require('forall' in left_code and all(x in left_code for x in ['retval + 0', 'retval + 4', 'retval + 8']), 'Left branch lacks expected original finite return heap')
    require(re.search(r'TT\s*&&\s*emp\s*\|--\s*TT\s*&&\s*emp', right_code), 'Unexpected alternate parent branch')
    first = re.search(r'\bDefinition\s+', code)
    require(first is not None and first.start() < matches[0].start(), 'Unexpected original Goal header')
    header = text[:first.start()]
    require('GeneratedLayout.AddressNotations' not in header, 'Goal must retain abstract local-stack notation')
    prefix = ('Require Import Goal.\n' + header + '\nLemma original_return_entailment :' + left + '.\nProof.\n').encode()
    suffix = ('\nQed.\n\nModule Proofs.\n\nLemma ' + SELECTED + ' : Goal.' + STATEMENT + '.\nProof.\n'
              '  exact (or_introl original_return_entailment).\nQed.\n\nEnd Proofs.\n').encode()
    metadata = {'schema': 'tespec-singleton-strong-left-template/v1',
                'original_goal_sha256': sha_bytes(goal_bytes),
                'left_expression_sha256': sha_bytes(left.encode()),
                'fixed_prefix_sha256': sha_bytes(prefix), 'fixed_suffix_sha256': sha_bytes(suffix),
                'selected_parent': SELECTED, 'strong_lemma': 'original_return_entailment',
                'left_character_range': [start, split], 'parent_definition_character_range': [matches[0].start(), end+1],
                'policy': 'Only the strong lemma proof body is editable; exact original left expression and deterministic or_introl parent wrapper are immutable.'}
    return prefix, suffix, metadata


def verify_candidate(candidate_bytes, goal_bytes):
    prefix, suffix, metadata = strong_template(goal_bytes)
    require(candidate_bytes.startswith(prefix) and candidate_bytes.endswith(suffix), 'Model changed fixed imports, original left type, or parent wrapper')
    body = candidate_bytes[len(prefix):-len(suffix)]
    code = _coq_dependency_code(body.decode('utf-8'))
    require(code.strip(), 'Strong proof body is empty')
    require(re.search(r'\b(?:Qed|Defined|Abort|Admitted|Proof|Require|Import|Export|Module|Section|End|Notation|Axiom|Parameter|Variable|Context|Hypothesis|Definition|Theorem|Lemma|Fact|Remark|Corollary)\b', code) is None,
            'Editable region contains vernacular commands or an early proof terminator')
    require('MODEL_PROOF_REQUIRED' not in body.decode(), 'Strong lemma remains unfilled')
    return {**metadata, 'proof_body_sha256': sha_bytes(body), 'candidate_sha256': sha_bytes(candidate_bytes)}
