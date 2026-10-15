"""Run this module's unit tests and save machine-readable verification evidence."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import resource
import sys
import time
import unittest


class Recorded(unittest.TextTestResult):
    def __init__(self,*args,**kwargs):
        super().__init__(*args,**kwargs);self.records=[]
    def startTest(self,test):self.start=time.monotonic();super().startTest(test)
    def record(self,test,status):self.records.append({'id':test.id(),'status':status,'seconds':time.monotonic()-self.start})
    def addSuccess(self,test):super().addSuccess(test);self.record(test,'PASS')
    def addFailure(self,test,err):super().addFailure(test,err);self.record(test,'FAIL')
    def addError(self,test,err):super().addError(test,err);self.record(test,'ERROR')
    def addSkip(self,test,reason):super().addSkip(test,reason);self.record(test,'SKIP')


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    suite=unittest.defaultTestLoader.discover(str(Path(__file__).parent),pattern='test_*.py')
    start=time.monotonic();result=unittest.TextTestRunner(verbosity=1,resultclass=Recorded).run(suite)
    data={'schema':'finite-spatial-unit-tests/v1','tests_run':result.testsRun,
          'statuses':dict(collections.Counter(r['status'] for r in result.records)),
          'classes':dict(collections.Counter(r['id'].rsplit('.',1)[0] for r in result.records)),
          'wall_seconds':time.monotonic()-start,'process_peak_rss_kib':resource.getrusage(resource.RUSAGE_SELF).ru_maxrss,
          'source_sha256':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in Path(__file__).parent.glob('*.py')},
          'failures':result.failures,'errors':result.errors,'executor_runs':0,'itp_runs':0,'records':result.records}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(data,indent=2,default=str)+'\n')
    return 0 if result.wasSuccessful() else 1


if __name__=='__main__':raise SystemExit(main())
