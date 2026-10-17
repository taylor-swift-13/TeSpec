from pathlib import Path
import sys,json
R=Path(__file__).resolve().parents[4];O=Path(__file__).resolve().parent
sys.path.insert(0,str(R/'tools/benchmark'))
from cn_toolchain import CN, ENV, installed_identity
from test_read_variants import measure,save
identity=installed_identity();assert identity==json.loads((O/'toolchain.json').read_text())
source=R/'benchmark/programs/Dbl_Linked_List__singleton/variants/cn_original_Dbl_Linked_List__singleton/cn/singleton.c'
inc=R/'benchmark/programs/Dbl_Linked_List__singleton/compat/cn-5.2/Dbl_Linked_List'
m=measure([CN,'verify','-I'+str(inc),source],O/'attempt-2-cn',timeout=60)
save(O/'attempt-2-cn-receipt.json',m);print(json.dumps(m));print((R/m['stdout']).read_text());print((R/m['stderr']).read_text())
