"""Independent expected statuses, including narrowly guarded execution errors."""
import json
from test_read_variants import ROOT

def expected(row,tool):
    case=row.get('plan_case',row)
    return case.get('expected_by_tool',{}).get(tool,case.get('expected',row.get('expected_result')))

def matches(row,tool,status=None,measurement=None):
    m=measurement if measurement is not None else row[tool]
    status=status or m.get('final_status') or m.get('status')
    if status!=expected(row,tool):return False
    guard=row.get('plan_case',row).get('expected_executor_error_contains')
    if status=='ERROR' and tool.startswith('tespec') and guard:
        if not m.get('report') or not(ROOT/m['report']).exists():return False
        report=json.loads((ROOT/m['report']).read_text());rs=report.get('results',[])
        if len(rs)!=1 or rs[0].get('reason')!='qcp_execution_error':return False
        return guard in json.dumps(rs[0].get('executor_error',{})) and rs[0].get('precondition_result')=='SAT'
    return True
