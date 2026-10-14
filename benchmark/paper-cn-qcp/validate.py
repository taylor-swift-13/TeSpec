#!/usr/bin/env python3
"""Validate dataset integrity, C-body correspondence and mutation manifests."""

import hashlib
import json
import re
import sys

from run import HERE, c_body, read, sha


def validate_list_input(suite, item):
    """Check owned graph bindings and labels against list contract semantics."""
    assert suite['graph_schema'] == {'c_type': 'struct list',
                                    'value_fields': ['data'], 'link_fields': ['next']}
    graph = item['graph']
    nodes = graph['nodes']
    by_id = {n['id']: n for n in nodes}
    assert len(by_id) == len(nodes)
    assert len({n['address'] for n in nodes}) == len(nodes)
    assert all(n['address'] > 0 and n['address'] % 4 == 0 for n in nodes)
    assert all(-2147483648 <= n['data'] <= 2147483647 for n in nodes)
    assert all(n['next'] is None or n['next'] in by_id for n in nodes)
    assert set(graph['heads']) == set(suite['parameter_order'])
    assert set(item['logical_lists']) == set(graph['heads'])

    def walk(head, heap):
        mapping = {n['id']: n for n in heap}
        seen, values = [], []
        while head is not None:
            if head not in mapping or head in seen:
                return None, seen
            seen.append(head)
            values.append(mapping[head]['data'])
            head = mapping[head]['next']
        return values, seen

    owned = set()
    sequences = {}
    for pointer, head in graph['heads'].items():
        values, ids = walk(head, nodes)
        assert values == item['logical_lists'][pointer]
        assert owned.isdisjoint(ids)
        owned.update(ids)
        sequences[pointer] = ids
        assert item['args'][pointer] == (by_id[head]['address'] if head else 0)
    assert owned == set(by_id)
    assert item['qcp_bind']['values'] == {
        logical: item['logical_lists'][pointer]
        for pointer, logical in suite['list_logical_values'].items()}
    expected_nodes = [dict(n) for n in nodes]
    expected_by_id = {n['id']: n for n in expected_nodes}
    ident = suite['id']
    if ident in ('cn_list_length', 'qcp_list_length'):
        pointer = suite['parameter_order'][0]
        expected_return = len(sequences[pointer])
        assert item['impl_mutation_violated'] == (
            item['native_mutant_return'] != expected_return or
            any(walk(graph['heads'][p], item['native_mutant_graph_nodes'])[0] !=
                item['logical_lists'][p] for p in graph['heads']))
    else:
        if ident == 'qcp_list_reverse':
            ids = list(reversed(sequences['p']))
            expected_values = list(reversed(item['logical_lists']['p']))
        else:
            assert ident == 'qcp_list_append'
            ids = sequences['x'] + sequences['y']
            expected_values = item['logical_lists']['x'] + item['logical_lists']['y']
        for index, node_id in enumerate(ids):
            expected_by_id[node_id]['next'] = ids[index + 1] if index + 1 < len(ids) else None
        head = ids[0] if ids else None
        expected_return = by_id[head]['address'] if head else 0
        assert item['expected_return_node'] == item['native_reference_return_node'] == head
        mutant_head = item['native_mutant_return_node']
        assert mutant_head is None or mutant_head in by_id
        assert item['native_mutant_return'] == (by_id[mutant_head]['address'] if mutant_head else 0)
        assert item['impl_mutation_violated'] == (
            walk(mutant_head, item['native_mutant_graph_nodes'])[0] != expected_values)
    assert item['expected_return'] == item['native_reference_return'] == expected_return
    assert item['expected_graph_nodes'] == item['native_reference_graph_nodes'] == expected_nodes
    mutant_nodes = item['native_mutant_graph_nodes']
    assert len(mutant_nodes) == len(nodes)
    assert {n['id'] for n in mutant_nodes} == set(by_id)
    assert all(n['address'] == by_id[n['id']]['address'] and
               n['data'] == by_id[n['id']]['data'] and
               (n['next'] is None or n['next'] in by_id) for n in mutant_nodes)
    # Each frozen spec mutation adds one to the length or appends one output item.
    # A finite list cannot satisfy either changed postcondition on these executions.
    assert item['spec_mutation_violated'] is True


def validate_tree_input(suite, item):
    assert suite['graph_schema'] == {'c_type': 'struct tree',
        'value_fields': ['key', 'value'], 'link_fields': ['left', 'right']}
    graph = item['graph']
    nodes = graph['nodes']
    mapping = {n['id']: n for n in nodes}
    assert len(mapping) == len(nodes) <= 100
    assert len({n['address'] for n in nodes}) == len(nodes)
    assert all(n['address'] > 0 and n['address'] % 4 == 0 for n in nodes)
    assert all(-2147483648 <= n[field] <= 2147483647
               for n in nodes for field in ('key', 'value'))
    assert graph['heads'].keys() == {'p'}
    owned = set()

    def term(head):
        if head is None:
            return 'empty'
        assert head in mapping and head not in owned
        owned.add(head)
        node = mapping[head]
        left, right = term(node['left']), term(node['right'])
        return f"make_tree({left},{node['key']},{node['value']},{right})"

    head = graph['heads']['p']
    assert item['qcp_bind']['values'] == {'t': term(head)}
    assert owned == set(mapping)
    assert item['args'] == {'p': mapping[head]['address'] if head else 0}
    assert item['expected_return'] == item['native_reference_return'] == len(nodes)
    assert item['expected_graph_nodes'] == item['native_reference_graph_nodes'] == nodes
    assert item['native_mutant_graph_nodes'] == nodes
    left_count = 0
    while head is not None:
        left_count += 1
        head = mapping[head]['left']
    assert item['native_mutant_return'] == left_count
    assert item['impl_mutation_violated'] == (left_count != len(nodes))
    assert item['spec_mutation_violated'] is True


def validate_expansion_catalog(manifest):
    folder = HERE / "expansion80"
    catalog = read(folder / "catalog.json")
    programs = catalog["programs"]
    assert catalog["target_programs"] == len(programs) == 80
    assert len({row["id"] for row in programs}) == 80
    assert catalog["new_source_candidates"] == 64
    assert catalog["paired_draft_count"] == 63
    assert catalog["industrial_subjects"] == 1
    assert sum(row["status"] == "source_screened" for row in programs) == 0
    assert catalog["completed_pairs"] == 15
    assert catalog["case_studies_without_direct_pair"] == sum(
        row["status"] == "case_study" and not row.get("paired_translation_path")
        for row in programs)
    ids = {row["id"] for row in manifest["cases"] + manifest.get("expressibility_items", [])}
    assert ids == {row["id"] for row in programs if row["status"] in {"paired_replayed", "case_study"}}
    assert catalog.get("paired_draft_count", 0) == sum(
        row["status"] == "paired_draft_unverified" for row in programs
    )
    seen_bodies = {}
    for row in programs:
        assert row["category"] in {
            "arithmetic_boundary", "array_functional", "scalar_control",
            "pointer_ownership", "recursive_list", "search_sort", "string",
            "tree_map", "queue_stack", "industrial_allocator",
        }
        if row["status"] in {"source_screened", "paired_draft_unverified"}:
            source = folder / row["source_snapshot"]
            assert source.is_file() and sha(source) == row["source_sha256"], row["id"]
            assert row["has_contract"]
            assert row["tool_runs_checked"] is False
            if row["status"] == "source_screened":
                assert row["paired_contract_checked"] is False
            else:
                assert row["paired_contract_checked"] == "author_judgment_only"
                draft = folder / row["draft_path"]
                receipt = read(draft / "draft.json")
                assert receipt["id"] == row["id"]
                assert receipt["source_sha256"] == row["source_sha256"]
                cn, qcp = draft / "subject.cn.c", draft / "subject.qcp.c"
                assert sha(cn) == receipt["cn_sha256"]
                assert sha(qcp) == receipt["qcp_sha256"]
                for name, digest in receipt.get("coq_dependencies", {}).items():
                    assert sha(draft / name) == digest, (row["id"], name)
                assert c_body(cn.read_text()) == c_body(qcp.read_text())
                body = c_body(qcp.read_text())
                assert body not in seen_bodies, (seen_bodies.get(body), row["id"])
                seen_bodies[body] = row["id"]
        elif row["status"] == "paired_replayed":
            assert (HERE / row["case_path"] / "subject.cn.c").is_file()
            assert (HERE / row["case_path"] / "subject.qcp.c").is_file()
            body = c_body((HERE / row["case_path"] / "subject.qcp.c").read_text())
            assert body not in seen_bodies, (seen_bodies.get(body), row["id"])
            seen_bodies[body] = row["id"]
        elif row["status"] == "industrial_source_frozen_translation_pending":
            candidate = read(folder / row["candidate_path"])
            assert candidate["id"] == row["id"]
            assert candidate["industrial"] is True
            assert candidate["source_revision"] == row["source_revision"]
            assert candidate["paired_contract_checked"] is False
            assert candidate["tool_runs_checked"] is False
            snapshot = folder / candidate["source_snapshot"]
            for original in candidate["snapshot_files"]:
                assert sha(snapshot / original["path"]) == original["sha256"]
            assert {m["kind"] for m in candidate["mutations"]} == {"spec", "impl"}
            for mutant in candidate["mutations"]:
                # These headers are local benchmark source dependencies, not
                # the ABI headers resolved by the paired runner's c_body().
                def strip_comments(path):
                    return re.sub(r"\s+", "", re.sub(
                        r"/\*.*?\*/|//[^\n]*", "", path.read_text(), flags=re.S
                    ))
                same = strip_comments(snapshot / mutant["target"]) == strip_comments(
                    snapshot / mutant["replacement"]
                )
                assert same == mutant["normalized_c_body_unchanged"]
                assert same == (mutant["kind"] == "spec")
                assert mutant["local_negative_verified"] is False
        else:
            assert row["status"] == "case_study"
            if row.get('paired_translation_path'):
                translated = folder / row['paired_translation_path']
                cn, qcp = translated / 'subject.cn.c', translated / 'subject.qcp.c'
                assert c_body(cn.read_text()) == c_body(qcp.read_text())
                assert qcp.read_bytes() == (HERE / row['case_path'] / 'subject.qcp.c').read_bytes()
                body = c_body(qcp.read_text())
                assert body not in seen_bodies
                seen_bodies[body] = row['id']
                receipt = read(folder / row['paired_translation_receipt'])
                assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
                assert receipt['assumptions'] == []
                assert sha(folder / receipt['theory_path']) == receipt['theory_sha256']
                assert sha(HERE / receipt['original_qcp_path']) == receipt['original_qcp_sha256']
                assert sha(HERE / receipt['original_spec_path']) == receipt['original_spec_sha256']
                for name, digest in receipt['translated_sources'].items():
                    assert sha(folder / name) == digest
                for name, digest in receipt['files'].items():
                    assert sha((folder / row['paired_translation_receipt']).parent / name) == digest
    assert len(seen_bodies) == 78 + sum(bool(r.get('paired_translation_path')) for r in programs)


def validate_list_layout_evidence(expansion):
    survivors_folder = expansion / 'evidence/list-mutant-survivors-atp-itp32-20261013'
    if survivors_folder.exists():
        from pathlib import Path
        receipt = read(survivors_folder / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['files'].items():
            assert sha(survivors_folder / name) == digest
        total = 0
        for row in receipt['runs']:
            folder = survivors_folder / row['case'] / 'proofs'
            suite = read(expansion / 'suites' / row['case'] / 'suite.json')
            expected = {i['id']: i for i in suite['inputs'] if not i['impl_mutation_violated']}
            final = read(folder / 'report.json')
            assert len(final['results']) == final['summary']['PASS'] == row['inputs'] == row['PASS'] == len(expected)
            assert {r['id'] for r in final['results']} == set(expected)
            for r in final['results']:
                assert r['status'] == 'PASS' and r['precondition_result'] == 'SAT'
                assert r['arguments'] == expected[r['id']]['qcp_bind']['args']
                assert r['bindings'] == expected[r['id']]['qcp_bind']['values']
                assert r['evidence']['certificate'] == 'CHECKED_RESIDUAL_VCS_WITH_ATP'
            request = read(folder / 'run-manifest.json')
            assert request['automatic_sha256'] == sha(folder / 'automatic.json')
            assert len(request['certificates']) == row['inputs']
            assert final['proof_completion']['run_manifest_sha256'] == sha(folder / 'run-manifest.json')
            for entry in request['certificates']:
                case_folder = folder / Path(entry['manifest']).parent.name
                report = read(case_folder / 'certificate-report.json')
                assert report['status'] == 'PASS' and not report['unexpected_assumptions']
                assert report['assumptions_audited_goals'] == 1
                assert all(s['exit_code'] == 0 for s in report['stages'])
                assert entry['manifest_sha256'] == sha(case_folder / 'manifest.json') == report['manifest_sha256']
                assert report['candidate_sha256'] == sha(case_folder / 'Candidate.v')
                assert report['original_goal_sha256'] == sha(case_folder / 'Goal.v')
                assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', (case_folder / 'Candidate.v').read_text())
            total += len(expected)
        assert total == receipt['survivors'] == receipt['PASS'] == 45
    structural = expansion / 'evidence/list-structural-entry32-20261013'
    if structural.exists():
        receipt = read(structural / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(structural / name) == digest
        manifest = read(structural / 'manifest.json')
        report = read(structural / 'certificate-report.json')
        assert manifest['selected_goals'] == ['proof_of_append_precondition_wit_1']
        assert report['status'] == 'PASS' and not report['unexpected_assumptions']
        assert report['assumptions_audited_goals'] == 1
        assert report['kernel_replay_mode'] == 'full'
        assert all(s['exit_code'] == 0 for s in report['stages'])
        assert report['manifest_sha256'] == sha(structural / 'manifest.json')
        assert report['candidate_sha256'] == sha(structural / 'Candidate.v')
        assert report['original_goal_sha256'] == sha(structural / 'Goal.v')
        assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', (structural / 'Candidate.v').read_text())
    for archive_name, case_name, function_name in [
        ('list-length-atp-itp-all32-20261013', 'cn_list_length', 'length'),
        ('qcp-list-length-atp-itp-all32-20261013', 'qcp_list_length', 'length'),
        ('qcp-list-reverse-atp-itp-all32-20261013', 'qcp_list_reverse', 'reverse'),
    ]:
        length_all = expansion / 'evidence' / archive_name
        if not length_all.exists():
            continue
        from pathlib import Path
        receipt = read(length_all / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(length_all / name) == digest
        automatic = read(length_all / 'automatic.json')
        final = read(length_all / 'report.json')
        suite = read(expansion / 'suites' / case_name / 'suite.json')
        inputs = {i['id']: i for i in suite['inputs']}
        assert len(inputs) == len(final['results']) == receipt['inputs'] == 128
        assert {r['id'] for r in final['results']} == set(inputs)
        assert final['summary']['PASS'] == receipt['PASS'] == 128
        request = read(length_all / 'run-manifest.json')
        assert len(request['certificates']) == 128
        assert request['automatic_sha256'] == sha(length_all / 'automatic.json')
        assert final['proof_completion']['run_manifest_sha256'] == sha(length_all / 'run-manifest.json')
        assert len(final['proof_completion']['certificates']) == 128
        originals = {r['id']: r for r in automatic['results']}
        for r in final['results']:
            assert r['status'] == 'PASS' and r['precondition_result'] == 'SAT'
            assert r['arguments'] == inputs[r['id']]['qcp_bind']['args']
            assert r['bindings'] == inputs[r['id']]['qcp_bind']['values']
            assert r['vc_results'] == originals[r['id']]['vc_results']
            assert all(v['status'] == 'VALID' for v in r['vc_results'])
            assert r['residual_vcs'] == []
            assert r['evidence']['certificate'] == 'CHECKED_RESIDUAL_VCS_WITH_ATP'
        for entry in request['certificates']:
            folder = length_all / Path(entry['manifest']).parent.name
            manifest = read(folder / 'manifest.json')
            report = read(folder / 'certificate-report.json')
            assert entry['proof_scope'] == 'residual'
            assert entry['manifest_sha256'] == report['manifest_sha256'] == sha(folder / 'manifest.json')
            assert report['status'] == 'PASS' and not report['unexpected_assumptions']
            assert report['assumptions_audited_goals'] == 1
            assert report['candidate_sha256'] == sha(folder / 'Candidate.v')
            assert report['original_goal_sha256'] == sha(folder / 'Goal.v')
            assert manifest['selected_goals'] == [f'proof_of_{function_name}_precondition_wit_1']
            assert all(s['exit_code'] == 0 for s in report['stages'])
            assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', (folder / 'Candidate.v').read_text())
            assert report['kernel_replay_mode'] in ['full', 'checked-dependency-reuse']
            if report['kernel_replay_mode'] == 'checked-dependency-reuse':
                import gzip
                import hashlib
                reuse = report['kernel_dependency_reuse']
                assert reuse['checked_task_modules'] == 3 and reuse['reused_dependencies'] > 0
                origin = reuse['full_replay_origin']
                matches = [length_all / Path(e['manifest']).parent.name for e in request['certificates']
                           if e['manifest_sha256'] == origin['manifest_sha256']]
                assert len(matches) == 1
                original_folder = matches[0]
                original_report = read(original_folder / 'certificate-report.json')
                assert original_report['kernel_replay_mode'] == 'full'
                assert origin['goal_sha256'] == sha(original_folder / 'Goal.v')
                assert origin['candidate_sha256'] == sha(original_folder / 'Candidate.v')
                original_log = gzip.decompress((original_folder / 'kernel_replay.log.gz').read_bytes())
                assert hashlib.sha256(original_log).hexdigest() == origin['kernel_log_sha256']
    tree_layout = expansion / 'evidence/tree-layout-theory32-20261013'
    if tree_layout.exists():
        import gzip
        receipt = read(tree_layout / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(tree_layout / name) == digest
        rows = read(tree_layout / 'compile-result.json')
        assert [r['module'] for r in rows] == ['TreeMeasure', 'TreeLayout32']
        assert all(r['exit_code'] == 0 for r in rows)
        assert read(tree_layout / 'kernel-result.json')['exit_code'] == 0
        assert sha(tree_layout / 'TreeLayout32.v') == sha(expansion / 'layout-profiles/tree32/TreeLayout32.v')
        assert sha(tree_layout / 'TreeMeasure.v') == sha(expansion / 'suites/control_tree_size/TreeMeasure.v')
        source = (tree_layout / 'TreeLayout32.v').read_text()
        assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', source)
        assert source.count('Print Assumptions ') == 1
        assumptions = gzip.decompress((tree_layout / 'TreeLayout32-compile.log.gz').read_bytes()).decode()
        assert assumptions.count('Axioms:') == 1
        assumptions = assumptions.split('Axioms:', 1)[1]
        names = set(re.findall(r'(?m)^([A-Za-z_][\w.]*)\s*:', assumptions))
        names.discard('Axioms')
        assert names == {'FunctionalExtensionality.functional_extensionality_dep', 'eval_addr_expr'}
        profile = read(tree_layout / 'profile/profile.json')
        suite = read(expansion / 'suites/control_tree_size/suite.json')
        assert profile['suite_sha256'] == sha(expansion / 'suites/control_tree_size/suite.json')
        assert profile['input_ids'] == [i['id'] for i in suite['inputs']]
        assert len(profile['input_ids']) == receipt['inputs'] == 128
        assert read(tree_layout / 'profile/binds.json') == [i['qcp_bind'] for i in suite['inputs']]
        observed = gzip.decompress((tree_layout / 'profile/layout-run.log.gz').read_bytes()).decode()
        assert list(map(int, observed.split())) == [4, 4, 16, 0, 4, 8, 12]
        for row in profile['sources']:
            original = expansion / row['original_path']
            changed = tree_layout / 'profile' / (row['variant'] + '.qcp.c')
            assert sha(original) == row['original_sha256']
            assert sha(changed) == row['profile_source_sha256']
            assert c_body(original.read_text()) == c_body(changed.read_text())
        for name, digest in profile['profile_dependencies'].items():
            location = tree_layout / name if name.endswith('.v') else tree_layout / 'profile' / name
            assert sha(location) == digest
    industrial_guard = expansion / 'evidence/pkvm-heap-ownership-guard32-20261013'
    if industrial_guard.exists():
        import gzip
        receipt = read(industrial_guard / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
            assert sha(industrial_guard / name.removeprefix('theory/')) == digest
        for name, digest in receipt['files'].items():
            assert sha(industrial_guard / name) == digest
        rows = read(industrial_guard / 'compile-result.json')
        assert len(rows) == 4 and all(row['exit_code'] == 0 for row in rows)
        assert read(industrial_guard / 'kernel-result.json')['exit_code'] == 0
        source = (industrial_guard / 'IndustrialHeapOwnershipGuard32.v').read_text()
        assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', source)
        assert source.count('Print Assumptions ') == 2
        assumptions = gzip.decompress((industrial_guard / 'IndustrialHeapOwnershipGuard32-compile.log.gz').read_bytes()).decode()
        allowed = {'PropExtensionality.propositional_extensionality',
                   'FunctionalExtensionality.functional_extensionality_dep'}
        names = set(re.findall(r'(?m)^([A-Za-z_][\w.]*)\s*:', assumptions))
        names.discard('Axioms')  # Coq's section heading, not an assumption name.
        assert names == allowed
    combined = expansion / 'evidence/list-atp-itp-controller32-20261013'
    if combined.exists():
        receipt = read(combined / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['controller_sources'].items():
            assert sha(combined / 'controller-snapshot' / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(combined / name) == digest
        automatic = read(combined / 'proofs/automatic.json')
        final = read(combined / 'proofs/report.json')
        request = read(combined / 'proofs/run-manifest.json')
        assert len(automatic['results']) == len(final['results']) == 1
        assert len(request['certificates']) == 1
        assert request['certificates'][0]['proof_scope'] == 'residual'
        assert request['automatic_sha256'] == sha(combined / 'proofs/automatic.json')
        original, checked = automatic['results'][0], final['results'][0]
        assert original['id'] == checked['id'] == receipt['input_id'] == 'input_007'
        assert original['execution_completed'] is True
        assert original['residual_vcs'] == ['proof_of_length_precondition_wit_1']
        assert original['status'] == 'UNKNOWN'
        assert len(original['vc_results']) == receipt['automatic_valid_execution_vcs'] == 98
        assert all(v['status'] == 'VALID' for v in original['vc_results'])
        assert checked['vc_results'] == original['vc_results']
        assert checked['status'] == receipt['execution_status'] == 'PASS'
        assert checked['precondition_result'] == receipt['precondition_status'] == 'SAT'
        assert checked['residual_vcs'] == []
        assert checked['evidence']['certificate'] == 'CHECKED_RESIDUAL_VCS_WITH_ATP'
        certificate = read(combined / 'proofs/case_0000/certificate-report.json')
        assert certificate['status'] == 'PASS'
        assert certificate['assumptions_audited_goals'] == receipt['itp_original_goals_checked'] == 1
        assert certificate['kernel_replay_mode'] == 'full'
        assert not certificate['unexpected_assumptions']
        assert all(s['exit_code'] == 0 for s in certificate['stages'])
        manifest = read(combined / 'proofs/case_0000/manifest.json')
        assert manifest['selected_goals'] == ['proof_of_length_precondition_wit_1']
        assert certificate['manifest_sha256'] == sha(combined / 'proofs/case_0000/manifest.json')
        assert certificate['candidate_sha256'] == sha(combined / 'proofs/case_0000/Candidate.v')
        assert certificate['original_goal_sha256'] == sha(combined / 'proofs/case_0000/Goal.v')
        suite = read(expansion / 'suites/cn_list_length/suite.json')
        item = next(i for i in suite['inputs'] if i['id'] == original['id'])
        assert original['arguments'] == item['qcp_bind']['args']
        assert original['bindings'] == item['qcp_bind']['values']
        assert len(item['graph']['nodes']) == receipt['node_count'] == 32
    performance = expansion / 'evidence/list-fold-performance32-20261013'
    if performance.exists():
        receipt = read(performance / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(performance / name) == digest
        for attempt in ['frame-search', 'direct-frame']:
            assert read(performance / attempt / 'result.json')['exit_code'] == 'diagnostic_timeout'
            assert sha(performance / attempt / 'Goal.v') == sha(expansion / 'evidence/list-suffix-entry32-20261013/Goal.v')
    audit_folder = expansion / 'evidence/list-guarded-outcome-audit32-20261013'
    if audit_folder.exists():
        import gzip
        from collections import Counter
        receipt = read(audit_folder / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(audit_folder / name) == digest
        audit = read(audit_folder / 'audit.json')
        full = expansion / 'evidence/list-guarded-all-bindings32-20261013'
        source_rows = {(r['case'], r['variant']): r for r in read(full / 'report.json')['runs']}
        assert len(audit['runs']) == len(source_rows) == 12
        negative = survivors = reference = 0
        seen = set()
        for row in audit['runs']:
            key = row['case'], row['variant']
            assert key not in seen
            seen.add(key)
            suite_path = expansion / 'suites' / row['case'] / 'suite.json'
            assert row['suite_sha256'] == sha(suite_path)
            items = {i['id']: i for i in read(suite_path)['inputs']}
            source = source_rows[key]
            raw = gzip.decompress((full / (source['report_path'] + '.gz')).read_bytes())
            results = {r['id']: r for r in json.loads(raw)['results']}
            assert row['automatic_report_sha256'] == source['report_sha256']
            assert len(row['inputs']) == len(items) == 128
            assert {r['input_id'] for r in row['inputs']} == set(items)
            counts = Counter()
            for result in row['inputs']:
                item = items[result['input_id']]
                violated = row['variant'] != 'reference' and item[row['variant'] + '_violated']
                expected = 'FAIL' if violated else 'PASS'
                original = results[result['input_id']]
                assert result['expected'] == expected
                assert result['actual'] == original['status']
                assert result['entry'] == original['precondition_result']
                assert result['execution_completed'] == original['execution_completed']
                assert result['residual_vcs'] == original['residual_vcs']
                counts[expected + '/' + result['actual']] += 1
                negative += bool(violated)
                survivors += row['variant'] != 'reference' and not violated
                reference += row['variant'] == 'reference'
            assert dict(counts) == row['outcomes']
        assert negative == receipt['negative_inputs'] == 979
        assert survivors == receipt['mutant_survivors'] == 45
        assert reference == receipt['positive_reference_inputs'] == 512
    fields = expansion / 'evidence/list-field-witness32-20261013'
    if fields.exists():
        receipt = read(fields / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(fields / name) == digest
        manifest = read(fields / 'manifest.json')
        report = read(fields / 'certificate-report.json')
        assert len(manifest['goals']) == receipt['original_goal_count'] == 13
        assert manifest['selected_goals'] is None
        assert report['status'] == 'PASS'
        assert report['manifest_sha256'] == sha(fields / 'manifest.json')
        assert report['candidate_sha256'] == sha(fields / 'Candidate.v')
        assert report['original_goal_sha256'] == sha(fields / 'Goal.v')
        assert report['assumptions_audited_goals'] == 13
        assert not report['unexpected_assumptions']
        assert all(s['exit_code'] == 0 for s in report['stages'])
        assert report['kernel_replay_mode'] == 'full'
        assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', (fields / 'Candidate.v').read_text())
    suffix = expansion / 'evidence/list-suffix-entry32-20261013'
    if suffix.exists():
        receipt = read(suffix / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        assert receipt['execution_status'] == 'NOT_CERTIFIED'
        assert receipt['precondition_status'] == 'SAT'
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(suffix / name) == digest
        manifest = read(suffix / 'manifest.json')
        report = read(suffix / 'certificate-report.json')
        assert report['status'] == 'PASS'
        assert report['scope'] == manifest['scope'] == 'selected-original-vcs'
        assert manifest['selected_goals'] == ['proof_of_length_precondition_wit_1']
        assert report['manifest_sha256'] == sha(suffix / 'manifest.json')
        assert report['candidate_sha256'] == sha(suffix / 'Candidate.v')
        assert report['original_goal_sha256'] == sha(suffix / 'Goal.v')
        generation = read(suffix / 'generation.json')
        suite = expansion / 'suites/cn_list_length/suite.json'
        assert generation['suite_sha256'] == sha(suite)
        assert generation['generator_sha256'] == sha(expansion / 'layout-profiles/list32/prepare-entry-proof-v2.py')
        item = next(i for i in read(suite)['inputs'] if i['id'] == receipt['input_id'])
        assert len(item['graph']['nodes']) == receipt['node_count'] == 32
        assert generation['byte_cell_count'] == 8 * receipt['node_count']
        assert report['assumptions_audited_goals'] == 1
        assert not report['unexpected_assumptions']
        stages = {s['stage']: s for s in report['stages']}
        assert stages['kernel_replay']['exit_code'] == 0
        assert read(suffix / 'independent-check-result.json')['exit_code'] == 0
        assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', (suffix / 'Candidate.v').read_text())
    full = expansion / 'evidence/list-guarded-all-bindings32-20261013'
    if full.exists():
        import gzip
        import hashlib
        receipt = read(full / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        for name, digest in receipt['files'].items():
            assert sha(full / name) == digest
        runs = read(full / 'report.json')['runs']
        assert len(runs) == 12
        assert len({(r['case'], r['variant']) for r in runs}) == 12
        totals = dict.fromkeys(['PASS', 'FAIL', 'UNKNOWN', 'ERROR'], 0)
        for row in runs:
            raw = gzip.decompress((full / (row['report_path'] + '.gz')).read_bytes())
            assert hashlib.sha256(raw).hexdigest() == row['report_sha256']
            summary = json.loads(raw)['summary']
            assert summary['total'] == row['expected_input_count'] == 128
            for verdict in totals:
                assert summary[verdict] == row['counts'][verdict]
                totals[verdict] += summary[verdict]
        assert totals == receipt['counts']
        assert sum(totals.values()) == receipt['variant_calls'] == 1536
    guarded = expansion / 'evidence/list-unfold-guard32-20261013'
    if guarded.exists():
        receipt = read(guarded / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        assert receipt['theory_kernel_exit_code'] == 0
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(guarded / name) == digest
        original = (expansion / 'layout-profiles/list32/sll_layout32.strategies').read_text()
        changed = (expansion / 'layout-profiles/list32-guarded/sll_layout32.strategies').read_text()
        assert changed.count('         left_add(p != NULL);\n') == 1
        assert changed.replace('         left_add(p != NULL);\n', '') == original
        profile = read(guarded / 'profile.json')
        assert profile['admission_complete'] is False and profile['input_ids'] == ['input_002']
        assert sha(expansion / profile['suite_path']) == profile['suite_sha256']
        assert sha(expansion / 'layout-profiles/list32-guarded/prepare-profile.py') == profile['generator_sha256']
        for row in profile['sources']:
            assert sha(expansion / row['original_path']) == row['original_sha256']
            assert sha(guarded / (row['variant'] + '.qcp.c')) == row['profile_source_sha256']
        assert list(map(int, (guarded / 'layout-run.log').read_text().split())) == [4, 4, 8, 0, 4]
        case = read(guarded / 'full-certificate/report.json')['results'][0]
        assert case['id'] == 'input_002' and case['status'] == 'PASS' and case['precondition_result'] == 'SAT'
        certificate = read(guarded / 'full-certificate/case_0000/certificate-report.json')
        assert certificate['scope'] == 'complete-original-vc-group'
        assert certificate['proof_status'] == 'VALID' and certificate['kernel_replay_mode'] == 'full'
        assert certificate['assumptions_audited_goals'] == receipt['original_goal_count'] == 10
        assert not certificate['unexpected_assumptions']
        assert sha(guarded / 'full-certificate/case_0000/Candidate.v') == certificate['candidate_sha256']
        assert sha(guarded / 'full-certificate/case_0000/Goal.v') == certificate['original_goal_sha256']
        generated = read(guarded / 'generated-full-certificate/generation.json')
        assert generated['generator_sha256'] == sha(expansion / 'layout-profiles/list32-guarded/prepare-complete-proofs.py')
        assert generated['entry_generator_sha256'] == sha(expansion / 'layout-profiles/list32/prepare-entry-proof.py')
        assert generated['tactics_sha256'] == sha(expansion / 'theory/ListConcreteVCTactics.v')
        assert generated['automatic_report_sha256'] == sha(guarded / 'reference-automatic.json')
        for row in generated['certificates']:
            folder = guarded / 'generated-full-certificate' / row['folder']
            assert sha(folder / 'Candidate.v') == row['candidate_sha256']
            assert sha(folder / 'Goal.v') == row['goal_sha256']
        for candidate in guarded.rglob('Candidate.v'):
            assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', candidate.read_text())
    sparse = expansion / 'evidence/sparse-list-entry32-20261013'
    if sparse.exists():
        receipt = read(sparse / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['included_in_frozen_atp_counts'] is False
        assert receipt['full_execution_vcs_checked'] is False
        assert receipt['kernel_checks'] == {'sparse_byte_witness': 0, 'distinct_address_check': 0}
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(sparse / name) == digest
        for row in receipt['certificates']:
            folder = sparse / row['folder']
            report = read(folder / 'certificate-report.json')
            assert report['proof_status'] == report['vc_status'] == 'VALID'
            assert report['scope'] == 'selected-original-vcs'
            assert report['kernel_replay_mode'] == 'full'
            assert report['assumptions_audited_goals'] == 1 and not report['unexpected_assumptions']
            assert sha(folder / 'Candidate.v') == report['candidate_sha256']
            assert sha(folder / 'Goal.v') == report['original_goal_sha256']
            generation = read(folder / 'generation.json')
            assert generation['input_id'] == row['input_id']
            assert generation['candidate_sha256'] == report['candidate_sha256']
            assert generation['generator_sha256'] == sha(sparse / row['generator_snapshot'])
            assert generation['suite_sha256'] == sha(expansion / row['suite_path'])
            assert generation['report_sha256'] == sha(sparse / row['automatic_report'])
            suite = read(expansion / row['suite_path'])
            item = next(x for x in suite['inputs'] if x['id'] == row['input_id'])
            case = next(x for x in read(sparse / row['automatic_report'])['results']
                        if x['id'] == row['input_id'])
            assert case['arguments'] == item['qcp_bind']['args']
            assert case['bindings'] == item['qcp_bind']['values']
            assert generation['byte_cell_count'] == 8 * len(item['graph']['nodes'])
            assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', (folder / 'Candidate.v').read_text())
    theory = expansion / 'evidence/list-layout-theory32-20261013'
    if theory.exists():
        receipt = read(theory / 'receipt.json')
        assert receipt['admission_complete'] is False
        assert receipt['kernel_checks'] == {'diagnostics': 0, 'model': 0}
        for name, digest in receipt['sources'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['runtime_sources'].items():
            assert sha(HERE.parents[1] / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(theory / name) == digest
    folder = expansion / 'evidence/list-layout-prototype32-20261013'
    if not folder.exists():
        return
    receipt = read(folder / 'receipt.json')
    assert receipt['admission_complete'] is False
    assert receipt['included_in_frozen_atp_counts'] is False
    for name, digest in receipt['files'].items():
        assert sha(folder / name) == digest
    profile = read(folder / 'profile.json')
    assert profile['architecture_bits'] == 32 and profile['admission_complete'] is False
    assert sha(expansion / profile['suite_path']) == profile['suite_sha256']
    assert sha(expansion / 'layout-profiles/list32/prepare-profile.py') == profile['generator_sha256']
    suite = read(expansion / profile['suite_path'])
    selected = [item for item in suite['inputs'] if item['id'] in profile['input_ids']]
    assert read(folder / 'binds.json') == [item['qcp_bind'] for item in selected]
    assert list(map(int, (folder / 'layout-run.log').read_text().split())) == [4, 4, 8, 0, 4]
    for row in profile['sources']:
        assert sha(expansion / row['original_path']) == row['original_sha256']
        assert sha(folder / (row['variant'] + '.qcp.c')) == row['profile_source_sha256']
        def normalized_body(path):
            text = re.sub(r'/\*.*?\*/|//[^\n]*', '', path.read_text(), flags=re.S)
            text = re.sub(r'^\s*#include[^\n]*', '', text, flags=re.M)
            return re.sub(r'\s+', '', text)
        assert normalized_body(expansion / row['original_path']) == normalized_body(
            folder / (row['variant'] + '.qcp.c'))
    for name, digest in profile['profile_dependencies'].items():
        assert sha(folder / name) == sha(expansion / 'layout-profiles/list32' / name) == digest
    for name, count in [('run-certificate', 4), ('survivor-certificate', 5)]:
        report = read(folder / name / 'report.json')
        assert len(report['results']) == 1
        case = report['results'][0]
        assert case['status'] == 'PASS' and case['precondition_result'] == 'SAT'
        certificate = read(folder / name / 'case_0000/certificate-report.json')
        assert certificate['status'] == 'PASS' and certificate['kernel_replay_mode'] == 'full'
        assert certificate['assumptions_audited_goals'] == count
        assert not certificate['unexpected_assumptions']
        assert sha(folder / name / 'case_0000/Candidate.v') == certificate['candidate_sha256']
        assert sha(folder / name / 'case_0000/Goal.v') == certificate['original_goal_sha256']
    negative = read(folder / 'spec-mixed-certificate/certificate-report.json')
    assert negative['proof_status'] == 'VALID' and negative['kernel_replay_mode'] == 'full'
    assert negative['polarity'] == 'negative' and negative['vc_status'] == 'INVALID'
    assert negative['assumptions_audited_goals'] == 4 and not negative['unexpected_assumptions']
    assert sha(folder / 'spec-mixed-certificate/Candidate.v') == negative['candidate_sha256']
    assert sha(folder / 'spec-mixed-certificate/Goal.v') == negative['original_goal_sha256']
    case = read(folder / 'spec-refutation-run/report.json')['results'][0]
    assert case['status'] == 'UNKNOWN' and case['reason'] == 'vc_refuted_reachability_not_established'
    assert any(vc['status'] == 'INVALID' for vc in case['vc_results'])
    for candidate in folder.rglob('Candidate.v'):
        assert not re.search(r'\b(Admitted|Abort|Axiom|admit)\b', candidate.read_text())


def main():
    manifest = read(HERE / "manifest.json")
    validate_expansion_catalog(manifest)
    expansion = HERE / "expansion80"
    validate_list_layout_evidence(expansion)
    active_rows = {p['id']: p for p in read(expansion / 'catalog.json')['programs']}
    active = set(active_rows)
    for suite_path in (expansion / 'suites').glob('*/suite.json'):
        suite = read(suite_path)
        assert suite['id'] in active
        inputs = suite['inputs']
        assert len(inputs) == suite['input_count']
        assert len({json.dumps([i['args'], i['qcp_bind']['values']], sort_keys=True) for i in inputs}) == len(inputs)
        assert suite['domain_complete'] or len(inputs) >= 128
        for name, digest in suite['files'].items():
            assert sha(suite_path.parent / name) == digest
        entry = active_rows[suite['id']]
        draft = (expansion / entry['paired_translation_path'] if entry.get('paired_translation_path')
                 else HERE / entry['case_path'] if entry['status'] == 'paired_replayed'
                 else expansion / 'paired-drafts' / suite['id'])
        for language in ('cn', 'qcp'):
            assert sha(draft / f'subject.{language}.c') == suite[f'reviewed_{language}_sha256']
            reference = suite_path.parent / f'reference.{language}.c'
            transform = suite.get('cn_reference_transform') if language == 'cn' else None
            if transform:
                assert transform['kind'] == 'proved-annotation-replacement'
                source = (draft / 'subject.cn.c').read_text()
                assert source.count(transform['old']) == 1
                assert reference.read_text() == source.replace(transform['old'], transform['new'])
                assert c_body(reference.read_text()) == c_body(source)
                assert sha(HERE.parents[1] / transform['proof_path']) == transform['proof_sha256']
            else:
                assert (draft / f'subject.{language}.c').read_bytes() == reference.read_bytes()
        generator = suite.get('generator_path', 'prepare-scalar.py')
        assert generator in ('prepare-scalar.py', 'prepare-arrays.py', 'prepare-cells.py', 'prepare-strings.py', 'prepare-array-queries.py', 'prepare-more-scalars.py', 'prepare-memory.py', 'prepare-algorithms.py', 'prepare-struct-majority.py', 'prepare-interfaces.py', 'prepare-existing-simple.py', 'prepare-search-root.py', 'prepare-lists.py', 'prepare-weak-call.py', 'prepare-trees.py', 'prepare-power.py')
        assert sha(expansion / generator) == suite['generator_sha256']
        for name, digest in suite.get('generator_dependencies', {}).items():
            assert sha(expansion / name) == digest
        for language in ('cn', 'qcp'):
            reference = (suite_path.parent / f'reference.{language}.c').read_text()
            spec_mutant = (suite_path.parent / f'spec_mutation.{language}.c').read_text()
            impl_mutant = (suite_path.parent / f'impl_mutation.{language}.c').read_text()
            assert c_body(reference) == c_body(spec_mutant)
            assert c_body(reference) != c_body(impl_mutant)
            annotations = lambda text: re.findall(r'/\*@.*?\*/', text, re.S)
            assert annotations(reference) == annotations(impl_mutant)
        for variant in ('reference', 'spec_mutation', 'impl_mutation'):
            assert c_body((suite_path.parent / f'{variant}.cn.c').read_text()) == c_body(
                (suite_path.parent / f'{variant}.qcp.c').read_text())
        for kind in ('spec', 'impl'):
            assert any(i[kind + '_mutation_violated'] for i in inputs)
        if suite['id'] == 'qcp_chars_initialize':
            assert all(any(i['args']['m'] == m and i['args']['n'] == n for i in inputs)
                       for m in (-128, 127) for n in (0, 1, 16))
        if suite['id'] == 'control_weak_call':
            assert suite['domain_complete']
            assert {i['cells']['p'] for i in inputs} == set(range(98))
        if suite['id'] == 'control_unbounded_root':
            assert suite['domain_complete']
            assert {i['cells']['p'] for i in inputs} == set(range(101))
        for item in inputs:
            assert item['args'] == item['qcp_bind']['args']
            assert item['id'] == item['qcp_bind']['id']
            if suite.get('return_contract', {}).get('kind') == 'search_index':
                contract = suite['return_contract']
                array = item['arrays'][contract['array']]
                target = item['args'][contract['target']]
                for value in (item['expected_return'], item['native_reference_return']):
                    assert (target not in array if value == -1
                            else 0 <= value < len(array) and array[value] == target)
            else:
                assert item['expected_return'] == item['native_reference_return']
            for name, (lower, upper) in suite.get('domain_ranges', {}).items():
                value = item.get('cells', {}).get(name, item['args'][name])
                assert lower <= value <= upper, (suite['id'], item['id'], name)
            if suite['id'] == 'cav_simple_power':
                x, n = item['args']['x'], item['args']['n']
                assert 1 <= x <= 2147483647 and 1 <= n <= 2147483647
                assert x * n <= 2147483647
                assert item['qcp_bind']['values'] == {}
                candidate = x
                if n > 1:
                    while candidate % n == 0:
                        candidate //= n
                is_power = candidate == 1
                assert item['expected_return'] == int(is_power)
                assert item['native_mutant_return'] == 0
                assert item['impl_mutation_violated'] == is_power
                assert item['spec_mutation_violated']
                assert suite['contract_translation_receipt'] == entry['paired_translation_receipt']
            if 'graph' in item:
                if suite['id'] == 'control_tree_size':
                    validate_tree_input(suite, item)
                else:
                    validate_list_input(suite, item)
            if 'structs' in item:
                assert item['expected_heap'] == item['native_reference_heap']
                assert set(item['structs']) == set(suite['struct_types'])
                assert item['qcp_bind']['values'] == {logical: item['structs'][pointer][field]
                    for pointer, fields in suite['struct_logical_values'].items()
                    for field, logical in fields.items()}
                for pointer, fields in item['structs'].items():
                    assert set(fields) == set(suite['struct_field_order'][pointer])
                    lower, upper = {'int': (-2147483648, 2147483647),
                                    'unsigned int': (0, 4294967295)}[suite.get('element_c_type', 'int')]
                    assert all(lower <= value <= upper for value in fields.values())
                if suite['id'] == 'cn_transpose':
                    assert item['expected_heap']['p'] == {'x': item['structs']['p']['y'],
                                                          'y': item['structs']['p']['x']}
                if suite['id'] == 'qcp_swap_int_pair':
                    assert item['expected_heap']['p'] == {'a': item['structs']['p']['b'],
                                                          'b': item['structs']['p']['a']}
            if 'cells' in item:
                assert item['expected_heap'] == item['native_reference_heap']
                cell_lower, cell_upper = {'int': (-2147483648, 2147483647),
                                          'unsigned int': (0, 4294967295)}[suite.get('element_c_type', 'int')]
                assert all(cell_lower <= value <= cell_upper for value in item['cells'].values())
                expected_values = {logical: item['cells'][pointer]
                    for pointer, logical in suite['cell_logical_values'].items() if logical is not None}
                expected_values.update({logical: item['arrays'][pointer]
                    for pointer, logical in suite.get('pointer_lists', {}).items() if logical is not None})
                assert item['qcp_bind']['values'] == expected_values
                for pointer, target in suite['pointer_aliases'].items():
                    assert item['args'][pointer] == item['args'][target]
                owned = suite['cell_logical_values']
                assert len({item['args'][p] for p in owned}) == len(owned)
                if suite['id'] == 'control_weak_call':
                    v = item['cells']['p']
                    assert 0 <= v <= 97
                    assert item['expected_return'] is None
                    assert item['expected_heap'] == {'p': v + 3}
                    assert item['native_mutant_return'] is None
                    assert item['native_mutant_heap'] == {'p': v}
                    assert item['spec_mutation_violated'] and item['impl_mutation_violated']
                if suite['id'] == 'cn_swap':
                    assert item['expected_heap'] == {'p': item['cells']['q'], 'q': item['cells']['p']}
                if suite['id'] == 'cn_add_read':
                    assert sum(item['cells'].values()) <= 4294967295
                if suite['id'] == 'cn_slf0_basic_incr':
                    assert item['cells']['p'] < 4294967295
                if suite['id'] == 'control_unbounded_root':
                    import math
                    n = item['cells']['p']; root = math.isqrt(n)
                    root += int(root * root < n)
                    assert item['expected_return'] == root
                    assert item['expected_heap'] == {'p': root}
                if suite['id'] == 'cn_double_it':
                    assert item['cells']['p'] * 2 <= 4294967295
                if suite['id'] == 'cn_slf3_basic_inplace_double':
                    assert item['cells']['p'] * 2 <= 4294967295
            if suite.get('heap_shape') == 'null_terminated_strings':
                assert item['expected_heap'] == item['native_reference_heap']
                assert item['qcp_bind']['values'] == {name: value
                    for name, value in item['logical_values'].items()
                    if name not in suite['parameter_order']}
                arrays = item['arrays']
                assert all(-128 <= v <= 127 for a in arrays.values() for v in a)
                assert len({item['args'][p] for p in arrays}) == len(arrays)
                for pointer, a in arrays.items():
                    if pointer == 'dst':
                        assert len(a) == item['logical_values']['n'] + 1
                        continue
                    assert a[-1] == 0 and all(v != 0 for v in a[:-1])
                    if suite['id'] == 'cav_string_equal':
                        length = 'na' if pointer == 'a' else 'nb'
                        logical = 'la' if pointer == 'a' else 'lb'
                    else:
                        length, logical = 'n', 'l'
                    assert len(a) == item['logical_values'][length] + 1
                    assert a[:-1] == item['logical_values'][logical]
                if suite['id'] in ('cav_string_first_char', 'cav_string_last_char'):
                    assert item['logical_values']['n'] >= 1
                if suite['id'] == 'cav_string_reverse_copy':
                    assert item['args']['n'] == item['logical_values']['n']
                    assert arrays['dst'] == item['logical_values']['d']
                assert all(name in item['logical_values'] for name in suite['cn_ghost_parameters'])
            elif 'arrays' in item:
                assert item['expected_heap'] == item['native_reference_heap']
                length_terms = suite.get('array_lengths', {p: ['n'] for p in item['arrays']})
                assert set(length_terms) == set(item['arrays'])
                assert all(len(a) == sum(item['args'][name] for name in length_terms[p])
                           for p, a in item['arrays'].items())
                length_parameter = suite.get('array_length_parameter', 'n')
                assert item['args'][length_parameter] >= suite.get('minimum_array_length', 0)
                element_bounds = {'int': (-2147483648, 2147483647),
                                  'unsigned int': (0, 4294967295), 'char': (-128, 127)}
                lower, upper = element_bounds[suite.get('element_c_type', 'int')]
                assert all(lower <= v <= upper for a in item['arrays'].values() for v in a)
                if 'i' in item['args']:
                    assert 0 <= item['args']['i'] < item['args']['n']
                if suite['id'] == 'cn_array_read_two':
                    i, j = item['args']['i'], item['args']['j']
                    assert 0 <= j < item['args']['n'] and i != j
                    assert item['arrays']['p'][i] + item['arrays']['p'][j] <= 4294967295
                if suite['id'] == 'cav_binary_search':
                    assert item['arrays']['a'] == sorted(item['arrays']['a'])
                    assert item['expected_heap'] == item['arrays']
                if suite['id'] == 'cav_array_reverse':
                    assert item['expected_heap']['a'] == list(reversed(item['arrays']['a']))
                if suite['id'] == 'cn_array_swap':
                    i, j = item['args']['i'], item['args']['j']
                    assert 0 <= j < item['args']['n'] and i != j
                    expected = list(item['arrays']['p'])
                    expected[i], expected[j] = expected[j], expected[i]
                    assert item['expected_heap']['p'] == expected
                if suite['id'] in ('qcp_array_sum', 'qcp_array_sum_zero'):
                    assert 0 < item['args']['n'] < 100
                    assert all(0 <= value < 100 for value in item['arrays']['a'])
                    assert item['expected_return'] == sum(item['arrays']['a'])
                    assert item['expected_heap']['a'] == (item['arrays']['a'] if suite['id'] == 'qcp_array_sum'
                                                         else [0] * item['args']['n'])
                if suite['id'] == 'qcp_sortArray':
                    assert suite['return_pointer_parameter'] == 'nums'
                    assert suite['uninitialized_cells'] == ['returnSize']
                    assert 1 <= item['args']['numsSize'] <= 50000
                    assert item['expected_return'] == item['args']['nums']
                    assert item['expected_heap']['nums'] == sorted(item['arrays']['nums'])
                    assert item['expected_heap']['returnSize'] == item['args']['numsSize']
                if suite['id'] == 'qcp_majorityElement':
                    from collections import Counter
                    counts = Counter(item['arrays']['nums'])
                    assert 1 <= item['args']['numsSize'] <= 50000
                    assert 2 * counts[item['expected_return']] > item['args']['numsSize']
                    assert item['expected_heap'] == item['arrays']
                if suite['id'] == 'cav_array_sum':
                    assert 0 <= item['args']['n'] <= 10000
                    assert all(-10000 <= v <= 10000 for v in item['arrays']['a'])
                    assert item['expected_return'] == sum(item['arrays']['a'])
                    assert item['expected_heap'] == item['arrays']
                if suite['id'] == 'cav_insertion_sort':
                    assert item['expected_heap']['a'] == sorted(item['arrays']['a'])
                if suite['id'] == 'cav_merge_sorted_arrays':
                    assert 0 <= item['args']['m'] and item['args']['n'] + item['args']['m'] <= 2147483647
                    assert item['arrays']['a'] == sorted(item['arrays']['a'])
                    assert item['arrays']['b'] == sorted(item['arrays']['b'])
                    assert item['expected_heap']['a'] == item['arrays']['a']
                    assert item['expected_heap']['b'] == item['arrays']['b']
                    assert item['expected_heap']['out'] == sorted(item['arrays']['a'] + item['arrays']['b'])
                if suite['id'] == 'qcp_chars_initialize':
                    assert suite['uninitialized_pointer_blocks'] == ['a']
                    assert item['qcp_bind']['values'] == {}
                    assert -128 <= item['args']['m'] <= 127
                    assert item['expected_heap']['a'] == [item['args']['m']] * item['args']['n']
                assert len(set(item['args'][p] for p in suite['pointer_lists'])) == len(suite['pointer_lists'])
                expected_values = {logical: item['arrays'][pointer]
                    for pointer, logical in suite['pointer_lists'].items() if logical is not None}
                expected_values.update({logical: item['cells'][pointer]
                    for pointer, logical in suite.get('cell_logical_values', {}).items() if logical is not None})
                assert item['qcp_bind']['values'] == expected_values
                owned_pointers = set(item['arrays']) | set(item.get('cells', {}))
                assert len({item['args'][p] for p in owned_pointers}) == len(owned_pointers)
                if suite['id'] in ('cav_array_first', 'cav_array_last', 'cav_rotate_left_by_one'):
                    assert item['args']['n'] >= 1
                if suite['id'] == 'cav_array_increment':
                    assert all(v < 2147483647 for v in item['arrays']['a'])
                if suite['id'] == 'cav_array_negate':
                    assert all(v > -2147483648 for v in item['arrays']['a'])
    for migration_folder in (expansion / 'evidence/pkvm-cn-migration-20261013',
                             expansion / 'evidence/pkvm-cn-migration-enum-20261013'):
        if migration_folder.exists():
            import hashlib
            import importlib.util
            receipt = read(migration_folder / 'receipt.json')
            assert receipt['exit_code'] == 1 and receipt['status'] == 'TYPECHECK_ERROR'
            assert receipt['execution_started'] is False
            assert receipt['contract_equivalence_verified'] is False
            assert receipt['paired_admission_verified'] is False
            assert sha(expansion / receipt['generator_path']) == receipt['generator_sha256']
            for name, digest in receipt['files'].items():
                assert sha(migration_folder / name) == digest
            spec = importlib.util.spec_from_file_location('industrial_cn_migration', expansion / receipt['generator_path'])
            migration = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(migration)
            rows = read(migration_folder / 'migration.json')['files']
            assert len(rows) == 25 and len({r['file'] for r in rows}) == 25
            for row in rows:
                source = expansion / 'source-snapshots/fulminate/pkvm-buddy' / row['file']
                assert sha(source) == row['original_sha256']
                text = source.read_text()
                normalized = text
                if source.suffix in ('.c', '.h'):
                    normalized = re.sub(r'/\*@.*?\*/', migration.adapt_annotation, text, flags=re.S)
                    if source.name in ('defs.h', 'bug1.defs.h'):
                        normalized = normalized.replace('/*@', '/*@' + migration.ALIASES, 1)
                    normalized, groups = migration.merge_contracts(normalized)
                    assert groups == row['merged_comment_groups']
                assert migration.c_tokens(text) == migration.c_tokens(normalized)
                assert hashlib.sha256(normalized.encode()).hexdigest() == row['normalized_sha256']
                assert hashlib.sha256(migration.c_tokens(text).encode()).hexdigest() == row['c_tokens_sha256']
    cast_theory = expansion / 'evidence/pkvm-integer-cast-theory-20261013'
    if cast_theory.exists():
        receipt = read(cast_theory / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['files'].items():
            assert sha(cast_theory / name) == digest
        assert re.search(r'#define\s+PAGE_SHIFT\s+12\b',
            (expansion / 'source-snapshots/fulminate/pkvm-buddy/page_alloc.c').read_text())
    industrial_probe = expansion / 'evidence/pkvm-fulminate-original-probe-20261013'
    if industrial_probe.exists():
        receipt = read(industrial_probe / 'receipt.json')
        assert receipt['exit_code'] == 2 and receipt['status'] == 'INSTRUMENTATION_ERROR'
        assert receipt['execution_started'] is False
        for name, digest in receipt['source_files'].items():
            assert sha(expansion / 'source-snapshots/fulminate/pkvm-buddy' / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(industrial_probe / name) == digest
    objects_folder = expansion / 'evidence/pkvm-objects32-20261013'
    if objects_folder.exists():
        receipt = read(objects_folder / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['full_original_resource_translation_proved'] is False
        assert receipt['pool_padding_preserved'] == [105, 108]
        assert receipt['assumptions'] == ['FunctionalExtensionality.functional_extensionality_dep']
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(objects_folder / name) == digest
        layout = read(expansion / 'evidence/pkvm-layout-20261013/report.json')
        native32 = next(row for row in layout['runs'] if row['abi'] == 32)
        assert native32['structs'] == receipt['compiler_layout']
    guarded_folder = expansion / 'evidence/pkvm-guarded-pages32-20261013'
    if guarded_folder.exists():
        receipt = read(guarded_folder / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['full_original_resource_translation_proved'] is False
        assert receipt['guard_false_requires_page_resources'] is False
        assert receipt['original_u64_length_and_subtraction_retained'] is True
        assert receipt['assumptions'] == ['FunctionalExtensionality.functional_extensionality_dep',
                                         'PropExtensionality.propositional_extensionality']
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(guarded_folder / name) == digest
    layout_folder = expansion / 'evidence/pkvm-layout-20261013'
    if layout_folder.exists():
        report = read(layout_folder / 'report.json')
        assert sha(expansion / 'industrial/pkvm-buddy/probe-layout.py') == report['generator_sha256']
        for name, digest in report['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in report['source_files'].items():
            assert sha(expansion / 'source-snapshots/fulminate/pkvm-buddy' / name) == digest
        for name, digest in report['files'].items():
            assert sha(layout_folder / name) == digest
        assert {row['abi'] for row in report['runs']} == {32, 64}
        for row in report['runs']:
            assert row['build_returncode'] == row['run_returncode'] == 0
            for struct_name, struct in row['structs'].items():
                assert f"{struct_name} size {struct['size']} align {struct['alignment']}" in (layout_folder / f"run{row['abi']}.log").read_text().splitlines()
                covered = set()
                for name, field in struct['fields'].items():
                    assert f"{struct_name} {name} {field['offset']} {field['size']}" in (layout_folder / f"run{row['abi']}.log").read_text().splitlines()
                    region = set(range(field['offset'], field['offset'] + field['size']))
                    assert covered.isdisjoint(region)
                    covered.update(region)
                padding = set()
                for start, end in struct['padding_intervals']:
                    assert 0 <= start < end <= struct['size']
                    assert padding.isdisjoint(range(start, end))
                    padding.update(range(start, end))
                assert covered.isdisjoint(padding)
                assert covered | padding == set(range(struct['size']))
            head = row['structs']['list_head']
            assert head['fields']['next'] == {'offset': 0, 'size': row['abi'] // 8}
            assert head['fields']['prev'] == {'offset': row['abi'] // 8, 'size': row['abi'] // 8}
        assert report['full_qcp_field_address_correspondence_proved'] is False
    domain_folder = expansion / 'evidence/pkvm-page-domain32-20261013'
    if domain_folder.exists():
        receipt = read(domain_folder / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        assert receipt['admitted_orders'] == [0, 10]
        assert receipt['full_original_resource_translation_proved'] is False
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['runtime_dependencies'].items():
            assert sha(HERE.parents[1] / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(domain_folder / name) == digest
    typed_folder = expansion / 'evidence/pkvm-typed-page32-20261013'
    if typed_folder.exists():
        receipt = read(typed_folder / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['full_original_resource_translation_proved'] is False
        assert receipt['remainder_keeps_typed_resources'] is True
        assert receipt['list_field_order'] == ['next', 'prev']
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        assert receipt['assumptions'] == ['FunctionalExtensionality.functional_extensionality_dep',
                                         'PropExtensionality.propositional_extensionality']
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(typed_folder / name) == digest
    page_folder = expansion / 'evidence/pkvm-page-resources32-20261013'
    if page_folder.exists():
        receipt = read(page_folder / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['full_original_resource_translation_proved'] is False
        assert receipt['remainder_preserved'] is True
        assert receipt['assumptions'] == ['FunctionalExtensionality.functional_extensionality_dep',
                                         'PropExtensionality.propositional_extensionality']
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(page_folder / name) == digest
    methodology_folder = expansion / 'evidence/pkvm-upstream-methodology-20261013'
    if methodology_folder.exists():
        report = read(methodology_folder / 'report.json')
        for name, digest in report['source_files'].items():
            assert sha(expansion / 'source-snapshots/fulminate/pkvm-buddy' / name) == digest
        for name, digest in report['files'].items():
            assert sha(methodology_folder / name) == digest
        script = (methodology_folder / 'run.sh').read_text()
        assert report['upstream_instrumentation']['command'] in script
        assert '--with-ownership-checking' in script and '--without-lemma-checks' not in script
        assert report['comparison_policy']['disable_lemma_diagnostic_in_primary_counts'] is False
        assert report['comparison_policy']['instrumentation_or_build_error_is_semantic_FAIL'] is False
    header_folder = expansion / 'evidence/pkvm-header-resources32-20261013'
    if header_folder.exists():
        receipt = read(header_folder / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['pointer_bytes'] == 4 and receipt['header_bytes'] == 8
        assert receipt['full_original_resource_translation_proved'] is False
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        assert receipt['assumptions'] == ['FunctionalExtensionality.functional_extensionality_dep']
        for name, digest in receipt['runtime_dependencies'].items():
            assert sha(HERE.parents[1] / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(header_folder / name) == digest
    abi_folder = expansion / 'evidence/pkvm-qcp-abi-20261013'
    if abi_folder.exists():
        report = read(abi_folder / 'report.json')
        assert sha(HERE.parents[1] / report['model_path']) == report['model_sha256']
        generator = expansion / 'industrial/pkvm-buddy/audit-qcp-abi.py'
        assert sha(generator) == report['generator_sha256']
        import importlib.util
        module_spec = importlib.util.spec_from_file_location('industrial_qcp_abi', generator)
        abi_module = importlib.util.module_from_spec(module_spec)
        module_spec.loader.exec_module(abi_module)
        assert abi_module.model_facts() == report['qcp']
        for name, digest in report['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in report['files'].items():
            assert sha(abi_folder / name) == digest
        assert {row['abi'] for row in report['native']} == {32, 64}
        for row in report['native']:
            values = list(map(int, (abi_folder / f"run{row['abi']}.log").read_text().split()))
            assert values[:2] == [row['pointer_bytes'], row['list_head_bytes']]
            assert values[2:] == row['encoded_uint32_01020304']
            assert row['pointer_bytes'] == row['abi'] // 8
            assert row['list_head_bytes'] == 2 * row['pointer_bytes']
            assert row['pointer_width_matches_qcp'] == (row['pointer_bytes'] == report['qcp']['pointer_bytes'])
            assert row['header_size_matches_qcp'] == (row['list_head_bytes'] == report['qcp']['list_head_bytes'])
            assert row['byte_order'] == ('big' if values[2:] == [1, 2, 3, 4] else 'little')
            assert values[2:] in ([1, 2, 3, 4], [4, 3, 2, 1])
            assert row['byte_order_matches_qcp'] == (row['byte_order'] == report['qcp']['byte_order'])
            assert row['full_resource_correspondence_proved'] is False
    power_shift = expansion / 'evidence/pkvm-power-shift-theory-20261013'
    if power_shift.exists():
        receipt = read(power_shift / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(power_shift / name) == digest
    original_lemmas = expansion / 'evidence/pkvm-original-coq-20261013'
    if original_lemmas.exists():
        receipt = read(original_lemmas / 'receipt.json')
        assert len(receipt['compile_stages']) == 5
        assert all(stage['exit_code'] == 0 for stage in receipt['compile_stages'])
        assert receipt['coqchk_exit_code'] == receipt['assumption_audit_exit_code'] == 0
        assert receipt['assumptions'] == [] and len(receipt['checked_lemmas']) == 12
        assert receipt['full_generated_vc_coverage'] is False
        assert receipt['paired_admission_verified'] is False
        assert sha(expansion / receipt['audit_source_path']) == receipt['audit_source_sha256']
        provenance_path = expansion / receipt['provenance_path']
        assert sha(provenance_path) == receipt['provenance_sha256']
        provenance = read(provenance_path)
        assert provenance['revision'] == '66afeefe9556bc32b8b027d5b7f62bc3a7069703'
        assert len(provenance['files']) == 5
        for row in provenance['files']:
            assert sha(provenance_path.parent / row['path']) == row['sha256']
        for name, digest in receipt['files'].items():
            assert sha(original_lemmas / name) == digest
    bv_builtins = expansion / 'evidence/pkvm-cn-bv-builtins-20261013'
    if bv_builtins.exists():
        import importlib.util
        receipt = read(bv_builtins / 'receipt.json')
        assert receipt['full_profile_exit_code'] == 1
        assert receipt['full_profile_execution_started'] is True
        assert receipt['full_profile_reference_completed'] is False
        assert receipt['no_lemma_diagnostic_exit_code'] == 0
        assert receipt['diagnostic_included_in_benchmark_counts'] is False
        assert receipt['paired_admission_verified'] is False
        assert (expansion / receipt['power_shift_receipt']).is_file()
        assert sha(expansion / receipt['generator_path']) == receipt['generator_sha256']
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(bv_builtins / name) == digest
        spec = importlib.util.spec_from_file_location('bv_builtin_candidate', expansion / receipt['generator_path'])
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        migration = read(bv_builtins / 'migration.json')
        assert migration['generator_sha256'] == receipt['generator_sha256']
        assert len(migration['files']) == 25
        for row in migration['files']:
            source = expansion / 'source-snapshots/fulminate/pkvm-buddy' / row['file']
            assert sha(source) == row['original_sha256']
            candidate, groups = module.candidate_text(source.read_text(), source.suffix, source.name)
            assert hashlib.sha256(candidate.encode()).hexdigest() == row['candidate_sha256']
            assert groups == row['merged_comment_groups']
    september_bv = expansion / 'evidence/pkvm-cn-bv-september-20261013'
    if september_bv.exists():
        receipt = read(september_bv / 'receipt.json')
        assert receipt['dependency_build_exit_code'] == receipt['cn_build_exit_code'] == 0
        assert receipt['exit_code'] == 2 and receipt['status'] == 'INSTRUMENTATION_ERROR'
        assert receipt['execution_started'] is False and receipt['paired_admission_verified'] is False
        assert (expansion / receipt['candidate_receipt']).is_file()
        for name, digest in receipt['files'].items():
            assert sha(september_bv / name) == digest
    bv_folder = expansion / 'evidence/pkvm-cn-bv-compatibility-20261013'
    if bv_folder.exists():
        import importlib.util
        receipt = read(bv_folder / 'receipt.json')
        assert receipt['original_numeric_types_and_casts_retained'] is True
        assert receipt['allocator_c_tokens_unchanged'] is True
        assert receipt['parse_typecheck_and_generation_completed'] is True
        assert receipt['status'] == 'GENERATED_C_COMPILE_ERROR' and receipt['exit_code'] == 1
        assert receipt['execution_started'] is False
        assert receipt['full_contract_equivalence_verified'] is False
        assert receipt['paired_admission_verified'] is False
        assert sha(expansion / receipt['generator_path']) == receipt['generator_sha256']
        assert sha(expansion / receipt['dependency_path']) == receipt['dependency_sha256']
        for name, digest in receipt['files'].items():
            assert sha(bv_folder / name) == digest
        spec = importlib.util.spec_from_file_location('bv_candidate', expansion / receipt['generator_path'])
        bv = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(bv)
        migration = read(bv_folder / 'migration.json')
        assert migration['generator_sha256'] == receipt['generator_sha256']
        assert migration['dependency_sha256'] == receipt['dependency_sha256']
        assert len(migration['files']) == 25
        for row in migration['files']:
            original = expansion / 'source-snapshots/fulminate/pkvm-buddy' / row['file']
            assert sha(original) == row['original_sha256']
            candidate = original.read_text()
            groups = 0
            if original.suffix in ('.c', '.h'):
                candidate = re.sub(r'/\*@.*?\*/', bv.adapt, candidate, flags=re.S)
                candidate, groups = bv.syntax.merge_contracts(candidate)
            assert bv.syntax.c_tokens(candidate) == bv.syntax.c_tokens(original.read_text())
            assert hashlib.sha256(candidate.encode()).hexdigest() == row['candidate_sha256']
            assert groups == row['merged_comment_groups']
    address_theory = expansion / 'evidence/pkvm-address-theory-20261013'
    if address_theory.exists():
        receipt = read(address_theory / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['source_files'].items():
            assert sha(expansion / 'source-snapshots/fulminate/pkvm-buddy' / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(address_theory / name) == digest
        assert len(receipt['verified_lemmas']) == 8
    address_probe = expansion / 'evidence/pkvm-address-cn-probe-20261013'
    if address_probe.exists():
        receipt = read(address_probe / 'receipt.json')
        assert receipt['status'] == 'RUNTIME_ERROR' and receipt['runtime_exit_code'] == -8
        assert receipt['signal'] == 'SIGFPE'
        assert receipt['strong_negative_result'] is False
        assert receipt['instrumentation_and_compilation_completed'] is True
        assert receipt['full_contract_equivalence_verified'] is False
        assert receipt['paired_admission_verified'] is False
        for name, digest in receipt['source_paths'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(address_probe / name) == digest
        assert (expansion / receipt['arithmetic_proof_receipt']).is_file()
        probe = (expansion / 'industrial/pkvm-buddy/address-arithmetic-probe.cn.c').read_text()
        assert 'int main(void) { return address_arithmetic_check(); }' in probe
        assert 'pkvm_u64(-1) == 18446744073709551615' in probe
    ownership_folder = expansion / 'evidence/pkvm-ownership-witness-20261013'
    if ownership_folder.exists():
        import gzip
        receipt = read(ownership_folder / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        assert receipt['qcp_translation_complete'] is False
        assert receipt['original_contract_tool_verdict_checked'] is False
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['files'].items():
            assert sha(ownership_folder / name) == digest
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['source_files'].items():
            assert sha(expansion / 'source-snapshots/fulminate/pkvm-buddy' / name) == digest
        with gzip.open(ownership_folder / 'report.json.gz', 'rt') as f:
            report = json.load(f)
        assert sha(expansion / 'industrial/pkvm-buddy/prepare-ownership-witnesses.py') == report['generator_sha256']
        assert sha(expansion / report['native_report_path']) == report['native_report_sha256']
        with gzip.open(expansion / report['native_report_path'], 'rt') as f:
            native_report = json.load(f)
        traces = {t['id']: t for t in read(expansion / 'industrial/pkvm-buddy/model-traces.json')['traces']}
        assert len(report['runs']) == 2 and {r['abi'] for r in report['runs']} == {32, 64}
        for row in report['runs']:
            bits = row['abi']
            layout = row['compiler_layout']
            assert layout['pointer_bytes'] == bits // 8
            assert layout['list_head_bytes'] == 2 * layout['pointer_bytes']
            with gzip.open(ownership_folder / f'layout{bits}.log.gz', 'rt') as f:
                assert list(map(int, f.read().split())) == [layout[k] for k in
                    ('pointer_bytes','list_head_bytes','hyp_page_bytes','hyp_pool_bytes')]
            reference = next(r for r in native_report['runs'] if r['abi'] == bits and r['variant'] == 'reference')
            originals = {r['id']: r for r in reference['results']}
            assert row['build_returncode'] == 0
            assert len(row['results']) == 128 and {r['id'] for r in row['results']} == set(traces)
            total = 0
            for result in row['results']:
                initial = result['initial_native_state']
                assert originals[result['id']]['status'] == result['native_reference_status'] == 'PASS'
                assert initial == originals[result['id']]['native_states'][0]
                assert result['original_guard_spec_mutation_witnessed']
                base = traces[result['id']]['initial_state']['model_start_pfn'] * 4096
                header = layout['list_head_bytes']
                expected = []
                for root, order in initial['free']:
                    assert initial['meta'][root][:2] == [0, order]
                    for child in range(root + 1, root + (1 << order)):
                        assert initial['meta'][child][:2] == [0, 255]
                        address = base + child * 4096
                        expected.append({'root_page':root,'root_order':order,'child_page':child,
                            'root_zero_part':[base+root*4096+header,base+(root+(1<<order))*4096],
                            'child_owned_header':[address,address+header],
                            'shared_owned_byte':address,'child_metadata':initial['meta'][child],
                            'original_child_guard':False,'mutated_child_guard':True})
                assert expected and result['overlap_witnesses'] == expected
                for witness in expected:
                    byte = witness['shared_owned_byte']
                    assert witness['root_zero_part'][0] <= byte < witness['root_zero_part'][1]
                    assert witness['child_owned_header'][0] <= byte < witness['child_owned_header'][1]
                total += len(expected)
            assert row['summary'] == {'traces':128,'traces_with_overlap_witness':128,
                                      'overlapping_child_headers':total}
            assert total == receipt['overlapping_child_headers_per_abi'] == 629
    extraction_folder = expansion / 'evidence/pkvm-extraction-witness-20261013'
    if extraction_folder.exists():
        import gzip
        import importlib.util
        receipt = read(extraction_folder / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        assert receipt['qcp_translation_complete'] is False
        assert receipt['original_contract_tool_verdict_checked'] is False
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['files'].items():
            assert sha(extraction_folder / name) == digest
        for name, digest in receipt['source_fragments'].items():
            assert sha(expansion / 'source-snapshots/fulminate/pkvm-buddy' / name) == digest
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        native_folder = expansion / 'industrial/pkvm-buddy'
        spec = importlib.util.spec_from_file_location('extraction_capture', native_folder / 'capture-extraction.py')
        capture = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(capture)
        with gzip.open(extraction_folder / 'report.json.gz', 'rt') as f:
            report = json.load(f)
        for name, digest in report['dependencies'].items():
            assert sha(native_folder / name) == digest
        traces = {t['id']: t for t in read(native_folder / 'model-traces.json')['traces']}
        assert len(report['runs']) == 2 and {r['abi'] for r in report['runs']} == {32, 64}
        for row in report['runs']:
            assert row['build_returncode'] == 0
            assert '-finstrument-functions' in row['build_command']
            assert row['summary'] == {'reference_pass': 128,
                'traces_with_spec_mutation_witness': 128, 'helper_post_witnesses': 1311}
            assert len(row['results']) == 128
            assert {r['id'] for r in row['results']} == set(traces)
            for result in row['results']:
                trace = traces[result['id']]
                states = result['native_states']
                assert capture.native.replay(trace, states)['status'] == 'PASS'
                assert result['native_reference_status'] == 'PASS' and result['native_returncode'] == 0
                assert result['original_spec_mutation_witnessed']
                successful = [i for i, (op, state) in enumerate(zip(trace['operations'], states[1:]))
                              if op['op'] == 'alloc' and state['result'] >= 0]
                assert result['successful_allocations'] == len(successful)
                assert [w['step'] for w in result['witnesses']] == successful
                for witness in result['witnesses']:
                    step = witness['step']
                    before = witness['pre_native_state']
                    after = witness['post_native_fields']
                    root, order = after['root'], after['order']
                    base = trace['initial_state']['model_start_pfn']
                    assert before == states[step]
                    assert states[step + 1]['result'] == root
                    assert order == trace['operations'][step]['order'] and 0 <= order <= 3
                    assert after['refcount'] == after['prev'] == after['next'] == 0
                    assert after['pool_start'] == base * 4096
                    assert after['pool_end'] == (base + 8) * 4096
                    assert after['header'] > 0 and 0 <= root < 8
                    available = [(start, level) for start, level in before['free'] if level >= order]
                    assert available and available[0][0] == root
                    assert before['meta'][root][0] == 0 and before['meta'][root][1] >= order
                    assert witness['mutant_link_necessary_condition'] is False
                    assert after['prev'] != after['header']
                    assert not after['pool_start'] <= after['prev'] < after['pool_end']
    industrial_native = expansion / 'evidence/pkvm-native-20261013'
    if industrial_native.exists():
        import gzip
        import importlib.util
        receipt = read(industrial_native / 'receipt.json')
        assert receipt['original_spec_mutants_checked'] is False
        assert receipt['qcp_translation_complete'] is False
        for name, digest in receipt['dependencies'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(industrial_native / name) == digest
        with gzip.open(industrial_native / 'report.json.gz', 'rt') as f:
            report = json.load(f)
        native_folder = expansion / 'industrial/pkvm-buddy'
        assert sha(native_folder / 'native-adapter.c') == report['driver_sha256']
        assert sha(native_folder / 'run-native.py') == report['runner_sha256']
        assert sha(native_folder / 'prepare-traces.py') == report['model_generator_sha256']
        assert sha(native_folder / 'model-traces.json') == report['input_sha256']
        snapshot = expansion / 'source-snapshots/fulminate/pkvm-buddy'
        for name, digest in report['source_files'].items():
            assert sha(snapshot / name) == digest
        traces = {t['id']: t for t in read(native_folder / 'model-traces.json')['traces']}
        assert len(traces) == 128
        spec = importlib.util.spec_from_file_location('industrial_native_replay', native_folder / 'run-native.py')
        replay = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(replay)
        assert len(report['runs']) == 4
        assert {(r['variant'], r['abi']) for r in report['runs']} == {
            (variant, bits) for variant in ('reference', 'impl_coalescing_alignment') for bits in (32, 64)}
        for row in report['runs']:
            assert row['build_returncode'] == 0
            assert len(row['results']) == len(traces)
            assert {r['id'] for r in row['results']} == set(traces)
            expected = 'PASS' if row['variant'] == 'reference' else 'FAIL'
            assert row['summary'] == {expected: 128}
            for result in row['results']:
                trace = traces[result['id']]
                audited = replay.replay(trace, result['native_states'],
                                        complete=result['native_returncode'] == 0)
                assert audited['status'] == result['status'] == expected
                assert audited['checked'] == result['checked']
                if expected == 'PASS':
                    assert result['native_returncode'] == 0
                else:
                    assert result['category'] == audited['category'] == 'owned_state'
                    assert result['first_bad_step'] == audited['first_bad_step'] == -1
                    base = trace['initial_state']['model_start_pfn']
                    free = result['native_states'][0]['free']
                    assert any(start < 0 or start + (1 << order) > 8 or
                               (base + start) % (1 << order) != 0 for start, order in free)
    list_controls = expansion / 'suites/list-native-control-evidence.json'
    if list_controls.exists():
        import gzip
        report = read(list_controls)
        expected_keys = {(ident, variant, tool)
            for ident in ('qcp_list_length', 'qcp_list_reverse', 'qcp_list_append')
            for variant, tool in [('reference', 'native32'), ('reference', 'native64'),
                                  ('reference', 'fulminate'), ('spec_mutation', 'fulminate'),
                                  ('impl_mutation', 'fulminate')]}
        assert len(report['runs']) == len(expected_keys)
        assert {(r['case'], r['variant'], r['tool']) for r in report['runs']} == expected_keys
        for name, digest in report['portable_files'].items():
            assert sha(expansion / name) == digest
        for row in report['runs']:
            suite_path = expansion / 'suites' / row['case'] / 'suite.json'
            assert sha(suite_path) == row['input_suite_sha256']
            suite = read(suite_path)
            inputs = {i['id']: i for i in suite['inputs']}
            assert len(row['results']) == len(inputs)
            assert {r['id'] for r in row['results']} == set(inputs)
            logs = None
            if row['tool'] == 'fulminate':
                with gzip.open(expansion / row['portable_logs'], 'rt') as f:
                    logs = json.load(f)
                assert set(logs) == set(inputs)
            for result in row['results']:
                item = inputs[result['id']]
                expected = ('FAIL' if row['variant'] != 'reference' and
                            item[row['variant'] + '_violated'] else 'PASS')
                assert result['status'] == result['expected'] == expected
                if expected == 'PASS':
                    assert result['returncode'] == 0
                else:
                    assert logs is not None and result['returncode'] != 0
                    assert ('Failed at' in logs[result['id']] or
                            'CN assertion failed' in logs[result['id']])
            assert row['false_pass'] == row['missing_results'] == row['expected_result_mismatches'] == 0
    theory_archive = expansion / 'evidence/algorithm-contract-theory-20261013'
    if theory_archive.exists():
        receipt = read(theory_archive / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        for name, digest in receipt['definitions'].items():
            assert sha(expansion / name) == digest
        for name, digest in receipt['files'].items():
            assert sha(theory_archive / name) == digest
    normalization = expansion / 'evidence/struct-majority-suite-20261013/normalization-receipt.json'
    if normalization.exists():
        receipt = read(normalization)
        assert receipt['same_shared_inputs'] == 128
        assert receipt['fulminate_tool_modified'] is False
        assert all(receipt[f'{state}_native{bits}_pass'] == 128
                   for state in ('initial', 'normalized') for bits in (32, 64))
        for name, digest in receipt['runtime_contract_dependencies'].items():
            assert sha(HERE.parents[1] / name) == digest
    gcd_archive = expansion / 'evidence/gcd-definition-20261013'
    if gcd_archive.exists():
        receipt = read(gcd_archive / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        assert sha(expansion / receipt['definition_path']) == receipt['definition_sha256']
        assert sha(expansion / receipt['theory_path']) == receipt['theory_sha256']
        for name, digest in receipt['files'].items():
            assert sha(gcd_archive / name) == digest
    root_archive = expansion / 'evidence/root-finite-domain-20261013'
    if root_archive.exists():
        receipt = read(root_archive / 'receipt.json')
        assert receipt['coqc_exit_code'] == receipt['coqchk_exit_code'] == 0
        assert receipt['assumptions'] == []
        assert sha(HERE.parents[1] / receipt['proof_path']) == receipt['proof_sha256']
        for name, digest in receipt['files'].items():
            assert sha(root_archive / name) == digest
    prepared = [read(p) for p in (expansion / 'suites').glob('*/suite.json')]
    catalog = read(expansion / 'catalog.json')
    assert catalog['prepared_suite_subjects'] == len(prepared)
    assert catalog['prepared_positive_inputs'] == sum(s['input_count'] for s in prepared)
    model_trace = expansion / 'industrial/pkvm-buddy/model-traces.json'
    if model_trace.exists():
        industrial = read(model_trace)
        assert sha(model_trace.parent / 'prepare-traces.py') == industrial['generator_sha256']
        traces = industrial['traces']
        assert len(traces) == industrial['trace_count'] >= 128
        assert len({json.dumps([t['initial_state'], t['operations']], sort_keys=True)
            for t in traces}) == len(traces)
        assert {t['initial_state']['start_alignment_pages_mod8'] for t in traces} == set(range(8))
        assert industrial['production_admission_checked'] is False
        for trace in traces:
            assert trace['cn_qcp_replay_checked'] is False
            assert len(trace['operations']) == len(trace['independent_model_states'])
            base = trace['initial_state']['model_start_pfn']
            for i, state in enumerate(trace['independent_model_states']):
                assert state['step'] == i and state['operation'] == trace['operations'][i]
                seen = set()
                heap = state['model_state']
                blocks = [(start, int(order)) for order, roots in heap['free_blocks'].items()
                    for start in roots]
                blocks += [(b['start_page'], b['order']) for b in heap['live'].values()]
                assert all(0 < b['refs'] <= 65535 for b in heap['live'].values())
                for start, order in blocks:
                    assert (base + start) % (1 << order) == 0
                    pages = set(range(start, start + (1 << order)))
                    assert pages <= set(range(8)) and not seen & pages
                    seen |= pages
                assert seen == set(range(8))
            final = trace['independent_model_states'][-1]['model_state']
            assert final['live'] == {}
            assert final['free_blocks'] == trace['expected_final_free_blocks']
    empty_proof = expansion / 'evidence/list-empty-vc-proof-20261013'
    if empty_proof.exists():
        import gzip
        receipt = read(empty_proof / 'receipt.json')
        for name, digest in receipt['files'].items():
            assert sha(empty_proof / name) == digest
        assert sha(expansion / 'suites/qcp_list_reverse/suite.json') == receipt['reference_suite_sha256']
        assert sha(expansion / receipt['automatic_report']) == receipt['automatic_report_sha256']
        with gzip.open(expansion / receipt['automatic_report'], 'rt') as f:
            automatic = json.load(f)
        case = next(r for r in automatic['results'] if r['id'] == receipt['input_id'])
        assert case['arguments'] == {'p': 0} and case['bindings'] == {'xs': []}
        assert case['execution_completed'] is True and case['status'] == 'UNKNOWN'
        assert sha(empty_proof / 'Goal.v') == case['vc']['immutable_sha256']['goal'] == receipt['original_goal_sha256']
        proof = read(empty_proof / 'certificate-report.json')
        assert proof['status'] == receipt['certificate_status'] == 'PASS'
        assert proof['proof_status'] == receipt['proof_status'] == 'VALID'
        assert proof['scope'] == 'complete-original-vc-group'
        assert proof['unexpected_assumptions'] == []
        assert proof['assumptions'] == receipt['assumptions'] == ['CNotation.eval_addr_expr']
        assert proof['candidate_sha256'] == receipt['candidate_sha256'] == sha(empty_proof / 'Candidate.v')
        assert proof['assumptions_audited_goals'] == receipt['checked_goals']
        assert receipt['checked_goals'] == 3
        assert all(stage['exit_code'] == 0 for stage in proof['stages'])
        assert proof['stages'][-1]['stage'] == 'kernel_replay'
        with gzip.open(empty_proof / 'selected-automatic.json.gz', 'rt') as f:
            selected = json.load(f)
        assert selected['results'] == [case]
        with gzip.open(empty_proof / 'run-report.json.gz', 'rt') as f:
            completed = json.load(f)
        assert len(completed['results']) == 1
        final = completed['results'][0]
        assert final['id'] == case['id'] and final['execution_completed'] is True
        assert final['generated_source_sha256'] == case['generated_source_sha256']
        assert final['status'] == receipt['run_certificate_status'] == 'PASS'
        assert final['precondition_result'] == receipt['run_precondition_result'] == 'SAT'
        assert completed['proof_completion']['status'] == 'CHECKED'
        checked = completed['proof_completion']['certificates']
        assert len(checked) == 1
        assert checked[0]['certificate']['original_goal_sha256'] == receipt['original_goal_sha256']
        assert checked[0]['certificate']['candidate_sha256'] == receipt['candidate_sha256']
        assert checked[0]['certificate']['status'] == 'PASS'

    loop_pilot = expansion / 'evidence/sum-loop-limit-pilot-20261013'
    if loop_pilot.exists():
        import gzip
        receipt = read(loop_pilot / 'receipt.json')
        for name, digest in receipt['files'].items():
            assert sha(loop_pilot / name) == digest
        assert sha(expansion / receipt['source_path']) == receipt['source_sha256']
        assert sha(expansion / 'suites/cav_sum_to_n/suite.json') == receipt['input_suite_sha256']
        with gzip.open(expansion / receipt['original_automatic_report'], 'rt') as f:
            old = json.load(f)
        with gzip.open(loop_pilot / 'report.json.gz', 'rt') as f:
            new = json.load(f)
        old_case = next(r for r in old['results'] if r['id'] == receipt['input_id'])
        assert len(new['results']) == 1
        new_case = new['results'][0]
        assert new_case['id'] == old_case['id']
        assert new_case['arguments'] == old_case['arguments'] == receipt['arguments']
        assert old['provenance']['source_sha256'] == new['provenance']['source_sha256'] == receipt['source_sha256']
        assert old['provenance']['binary_sha256'] == new['provenance']['binary_sha256']
        assert old_case['status'] == receipt['old_status'] == 'UNKNOWN'
        assert old_case['reason'] == receipt['old_reason'] == 'loop_unroll_limit'
        assert old_case['execution_completed'] is False
        assert new_case['status'] == receipt['new_status'] == 'PASS'
        assert new_case['precondition_result'] == receipt['new_precondition'] == 'SAT'
        assert new_case['execution_completed'] == receipt['execution_completed'] is True
        assert old['vc_policy']['loop_unroll_limit'] == receipt['old_limit'] == 128
        assert new['vc_policy']['loop_unroll_limit'] == receipt['new_limit'] == 256
    diagnostics_path = expansion / 'residual-diagnostics.json'
    if diagnostics_path.exists():
        import importlib.util
        diagnostics = read(diagnostics_path)
        assert sha(expansion / 'diagnose-residuals.py') == diagnostics['generator_sha256']
        for name, digest in diagnostics['sources'].items():
            assert sha(expansion / name) == digest
        spec = importlib.util.spec_from_file_location('residual_diagnostics', expansion / 'diagnose-residuals.py')
        diagnostic_module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(diagnostic_module)
        assert diagnostic_module.diagnose() == diagnostics
        assert diagnostics['tool_groups'] == 3 * diagnostics['subjects']
        assert diagnostics['counts']['actual_UNKNOWN'] == sum(diagnostics['unknown_reason_counts'].values())
    coverage_path = expansion / 'coverage-status.json'
    if coverage_path.exists():
        coverage = read(coverage_path)
        assert coverage['full_goal_complete'] is False
        assert len(coverage['programs']) == 80
        coverage_rows = {row['id']: row for row in coverage['programs']}
        assert len(coverage_rows) == 80
        counts = {kind: {'witnessed_violations': 0, 'satisfying_survivors': 0}
                  for kind in ('spec', 'impl')}
        for entry in catalog['programs']:
            row = coverage_rows[entry['id']]
            suite_path = expansion / 'suites' / entry['id'] / 'suite.json'
            if not suite_path.exists():
                assert row['mutation_input_counts'] is None
                continue
            suite = read(suite_path)
            assert row['prepared_positive_inputs'] == len(suite['inputs'])
            expected_counts = {}
            for kind in ('spec', 'impl'):
                flags = [item[kind + '_mutation_violated'] for item in suite['inputs']]
                assert all(type(flag) is bool for flag in flags)
                expected_counts[kind] = {'witnessed_violations': sum(flags),
                    'satisfying_survivors': len(flags) - sum(flags)}
                for label, value in expected_counts[kind].items():
                    counts[kind][label] += value
            assert row['mutation_input_counts'] == expected_counts
        assert coverage['mutation_input_counts'] == counts
    for report_path in ('replay-evidence.json', 'array-replay-evidence.json', 'cell-replay-evidence.json', 'string-replay-evidence.json', 'array-query-replay-evidence.json', 'more-scalar-replay-evidence.json', 'memory-replay-evidence.json', 'algorithm-replay-evidence.json', 'struct-majority-replay-evidence.json', 'interface-replay-evidence.json', 'existing-simple-replay-evidence.json', 'search-root-replay-evidence.json', 'weak-call-replay-evidence.json', 'power-replay-evidence.json', 'list-length-replay-evidence.json', 'list-reverse-replay-evidence.json', 'list-append-replay-evidence.json', 'tree-atp-evidence.json'):
        if not (expansion / 'suites' / report_path).exists():
            continue
        report = read(expansion / 'suites' / report_path)
        keys = set()
        mismatches = false_pass = missing = 0
        for row in report['runs']:
            key = (row['case'], row['variant'], row['tool'])
            assert key not in keys, key
            keys.add(key)
            suite = read(expansion / 'suites' / row['case'] / 'suite.json')
            expected = {i['id']: ('FAIL' if row['variant'] != 'reference' and
                i[row['variant'] + '_violated'] else 'PASS') for i in suite['inputs']}
            assert len({r['id'] for r in row['results']}) == len(row['results'])
            for result in row['results']:
                assert result['id'] in expected
                assert result['expected'] == expected[result['id']]
            nmiss = len(expected) - len(row['results'])
            nwrong = sum(r['status'] != r['expected'] for r in row['results'])
            nfalse = sum(r['status'] == 'PASS' and r['expected'] == 'FAIL' for r in row['results'])
            assert (nmiss, nwrong, nfalse) == (row['missing_results'],
                row['expected_result_mismatches'], row['false_pass'])
            missing += nmiss
            mismatches += nwrong
            false_pass += nfalse
        assert (missing, mismatches, false_pass) == (report['summary']['missing_results'],
            report['summary']['strong_result_mismatches'], report['summary']['false_pass'])
        for name, digest in report.get('portable_files', {}).items():
            target = (expansion / name).resolve()
            assert target.is_relative_to(expansion.resolve())
            assert sha(target) == digest
    cases = manifest["cases"] + manifest.get("expressibility_items", [])
    count = 0
    paired = 0
    for entry in cases:
        folder = HERE / entry["path"]
        case = read(folder / "case.json")
        assert case["id"] == entry["id"]
        assert len(case["inputs"]) == 4
        assert len({x["id"] for x in case["inputs"]}) == 4
        for original in case["sources"]:
            assert sha(HERE / original["path"]) == original["sha256"], original
        for variant in ["subject", "wrong_post"]:
            qp = folder / f"{variant}.qcp.c"
            assert qp.is_file()
            q = qp.read_text()
            assert "Require" in q and "Ensure" in q
            assert c_body(q) == c_body((folder / "subject.qcp.c").read_text())
            cp = folder / f"{variant}.cn.c"
            if cp.exists():
                c = cp.read_text()
                assert c_body(c) == c_body(q), str(cp)
                assert re.search(r"/\*@\s*requires\b.*?ensures\b.*?@\*/", c, re.S), str(
                    cp
                )
                assert all(
                    m[0].endswith("@*/") for m in re.finditer(r"/\*@.*?\*/", c, re.S)
                ), str(cp)
        if (folder / "subject.cn.c").exists():
            paired += 1
            for lang in ["cn", "qcp"]:
                a, b = case["mutations"][lang]
                reference = (folder / f"subject.{lang}.c").read_text()
                assert reference.count(a) == 1, (case["id"], lang)
                assert (
                    reference.replace(a, b)
                    == (folder / f"wrong_post.{lang}.c").read_text()
                ), (case["id"], lang)
        for test in case["inputs"]:
            assert re.fullmatch(r"[A-Za-z_][A-Za-z_0-9]*", test["id"])
            assert test["id"] == test["qcp_bind"]["id"]
            assert isinstance(test["wrong_post_violated"], bool)
            assert "return 1" not in test["native_setup"], (case["id"], test["id"])
            assert not any(
                isinstance(v, str) and v.startswith("[")
                for v in test["qcp_bind"]["values"].values()
            )
            count += 1
        proofs = folder / "proofs"
        if proofs.exists():
            for receipt in proofs.glob("*/target.json"):
                target = read(receipt)
                assert sha(receipt.parent / "Candidate.v") == target["candidate_sha256"]
                assert not re.search(
                    r"\b(Admitted|Abort|Axiom|admit)\b",
                    (receipt.parent / "Candidate.v").read_text(),
                )
    sums = HERE / "SHA256SUMS"
    if sums.exists():
        for line in sums.read_text().splitlines():
            digest, path = line.split("  ", 1)
            assert sha(HERE / path) == digest, path
    print(
        json.dumps(
            {
                "subjects": len(cases),
                "paired": paired,
                "inputs": count,
                "expansion_subjects": 80,
                "expansion_unverified_pairs": 63,
                "industrial_translation_pending": 1,
                "prepared_suite_subjects": len(prepared),
                "prepared_positive_inputs": sum(s['input_count'] for s in prepared),
                "industrial_model_traces": catalog.get('industrial_model_traces_prepared', 0),
                "full_benchmark_complete": catalog['full_80_tool_admission_complete'],
                "scope": "artifact integrity and input consistency; not complete tool performance",
                "status": "PASS",
            }
        )
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
