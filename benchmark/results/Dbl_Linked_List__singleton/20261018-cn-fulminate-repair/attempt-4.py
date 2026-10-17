from pathlib import Path
import sys,json,shutil
R=Path(__file__).resolve().parents[4];O=Path(__file__).resolve().parent
sys.path.insert(0,str(R/'tools/benchmark'))
from cn_toolchain import CN,installed_identity
from test_read_variants import measure,save,sha
assert installed_identity()==json.loads((O/'toolchain.json').read_text())
C=R/'benchmark/programs/Dbl_Linked_List__singleton/compat/cn-5.2'
out=O/'attempt-4-fulminate-output';out.mkdir(exist_ok=False)
m=measure([CN,'instrument','--run','--cc='+str(C/'gcc-with-runtime.sh'),'--output-dir='+str(out),'-I'+str(C/'Dbl_Linked_List'),O/'pilot-input.c'],O/'attempt-4-fulminate',timeout=90)
save(O/'attempt-4-fulminate-receipt.json',m);print(json.dumps(m));print((R/m['stdout']).read_text()[:3000]);print((R/m['stderr']).read_text()[:7000])
