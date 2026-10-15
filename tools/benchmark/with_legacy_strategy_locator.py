#!/usr/bin/env python3
"""Run a frozen QCP source with temporary legacy strategy path compatibility."""
import argparse,hashlib,json,os,re,signal,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--source',type=Path,required=True);p.add_argument('command',nargs=argparse.REMAINDER);a=p.parse_args();source=a.source.resolve();manifest=source.parent.parent/'manifest.json';m=json.loads(manifest.read_text());assert ROOT/m['files']['qcp']['path']==source and digest(source)==m['files']['qcp']['sha256'];cmd=a.command[1:] if a.command[:1]==['--'] else a.command;assert cmd
 legacy=(ROOT/'benchmark/selection').resolve();created=[];dirs=[];records=[];proc=None
 def stopped(sig,frame):raise SystemExit(128+sig)
 signal.signal(signal.SIGTERM,stopped);signal.signal(signal.SIGINT,stopped)
 try:
  for raw in re.findall(r'include\s+strategies\s+"([^"]+)"',source.read_text()):
   target=Path(raw)
   if not target.is_absolute():continue
   target=target.resolve();assert target.is_relative_to(legacy),'Only the old benchmark/selection locator is supported'
   origin=next((ROOT/inc/target.name for inc in m['files']['qcp'].get('include_dirs',[]) if (ROOT/inc/target.name).is_file()),None);assert origin is not None,'No archived byte-identical strategy dependency'
   canonical=source.parent.parent/'dependencies'/target.name;canonical.parent.mkdir(exist_ok=True)
   if canonical.exists():assert digest(canonical)==digest(origin)
   else:canonical.write_bytes(origin.read_bytes())
   if target.exists():assert digest(target)==digest(origin),'Never replace a pre-existing different strategy file'
   else:
    pending=[];folder=target.parent
    while not folder.exists():assert folder.is_relative_to(legacy);pending.append(folder);folder=folder.parent
    for folder in reversed(pending):folder.mkdir();dirs.append(folder)
    with target.open('xb') as f:f.write(origin.read_bytes())
    created.append((target,digest(origin)))
   records.append({'legacy_locator':str(target),'canonical_dependency':str(canonical.relative_to(ROOT)),'archived_origin':str(origin.relative_to(ROOT)),'sha256':digest(origin),'policy':'Frozen source and strategy bytes unchanged; only a temporary lookup alias is materialized and cleaned.'})
  print(json.dumps({'strategy_locator_compatibility':records}),flush=True)
  proc=subprocess.Popen(cmd,cwd=ROOT,start_new_session=True);return proc.wait()
 finally:
  if proc is not None and proc.poll() is None:
   os.killpg(proc.pid,signal.SIGTERM)
   try:proc.wait(timeout=5)
   except subprocess.TimeoutExpired:os.killpg(proc.pid,signal.SIGKILL);proc.wait()
  for target,sha in reversed(created):
   assert target.resolve().is_relative_to(legacy) and digest(target)==sha;target.unlink()
  for folder in reversed(dirs):
   try:folder.rmdir()
   except OSError:pass
if __name__=='__main__':raise SystemExit(main())
