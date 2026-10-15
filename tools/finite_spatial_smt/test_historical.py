"""Frozen historical VC regression tests; only the independent module is called."""
import json
from pathlib import Path
import unittest
from finite_spatial_smt import check, Unsupported
from qcp_import import import_record
from concrete_oracle import judge


class HistoricalUnknownTests(unittest.TestCase):pass
class HistoricalUnsupportedTests(unittest.TestCase):pass

fixture=Path(__file__).parent/'fixtures'/'historical.json'
if fixture.exists():
    data=json.loads(fixture.read_text())
    for item in data['supported']:
        def test(self,item=item):
            vc=import_record(item['record'])
            self.assertEqual(judge(vc),item['expected'],'Independent historical oracle changed')
            result=check(vc)
            self.assertEqual(result['status'],item['expected'],result)
            self.assertFalse(result.get('vacuous',False))
        setattr(HistoricalUnknownTests,'test_'+item['id'],test)
    for item in data['unsupported']:
        def test(self,item=item):
            with self.assertRaises(Unsupported):import_record(item['record'])
        setattr(HistoricalUnsupportedTests,'test_'+item['id'],test)
else:
    def missing(self):self.fail('Frozen historical corpus fixture is missing')
    HistoricalUnknownTests.test_fixture_required=missing


if __name__=='__main__':unittest.main()
