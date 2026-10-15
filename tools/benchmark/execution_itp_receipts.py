"""Dispatch validation by explicit original finite proof kind."""
import json
from attach_cell_leak_itp import validate_receipt as negative_receipt,mode_costs,statistics_for_off
from attach_positive_execution_itp import validate_receipt as positive_receipt

def validate_receipt(path,row,mode):
 data=json.loads(path.read_text())
 if data['binding'].get('proof_kind')=='POSITIVE_ORIGINAL_RESIDUAL_VCS':return positive_receipt(path,row,mode)
 return negative_receipt(path,row,mode)
