from pathlib import Path
extra=['read.c','read2.c','read.broken.c','slf0_basic_incr.c','slf0_basic_incr.signed.c','slf0_basic_incr.signed.broken.c','slf0_incr.broken.c','slf3_basic_inplace_double.c','slf1_basic_example_let.c','slf1_basic_example_let.signed.c','slf2_basic_quadruple.c','slf2_basic_quadruple.signed.c']
def build_extra(source):
 if source.startswith('read'):
  sig='int read(int *p)';body='{ return *p; }'
  cn='requires take old = Owned<int>(p); ensures take v = Owned<int>(p); v == old; return == old;'
  q='With old Require data_at(p,int,old) Ensure __return == old && data_at(p,int,old)'
  return [(sig,cn,q,body,'Correct non-consuming read',{'initial':7,'expected':7}),
   (sig,cn.replace('return == old','return == 0i32'),q.replace('__return == old','__return == 0'),body,'Wrong returned value',{'initial':7,'actual':7,'claimed':0}),
   (sig,'requires true; ensures true;','Require emp Ensure emp',body,'Missing read ownership',{'pointer':'NULL','actual':'invalid read'}),
   (sig,'requires take old = Owned<int>(p); ensures return == old;','With old Require data_at(p,int,old) Ensure __return == old && emp',body,'Input ownership omitted from postcondition',{'initial':7,'actual':'cell remains allocated','claimed':'empty heap'}),
   (sig,cn,q,'{ return 0; }','Constant returned instead of contents',{'initial':7,'actual':0,'expected':7}),
   (sig,cn,q,'{ return -*p; }','Returned value negated',{'initial':7,'actual':-7,'expected':7}),
   (sig,cn,q,'{ *p = 0; return *p; }','Read corrupts the cell',{'initial':7,'actual':0,'expected':7})]
 if source.startswith('slf0') or source=='slf3_basic_inplace_double.c':
  unsigned=source in ['slf0_basic_incr.c','slf0_incr.broken.c'];double=source=='slf3_basic_inplace_double.c'
  ty='unsigned int' if unsigned else 'int';ct='u32' if unsigned else 'i32'
  name='inplace_double' if double else 'incr';sig='void '+name+'('+ty+' *p)'
  op='old + old' if double else 'old + 1'+ct
  bound='' if unsigned else ('-1073741824i32 <= old; old <= 1073741823i32; ' if double else 'old < MAXi32(); ')
  cn='requires take old = Owned<'+ty+'>(p); '+bound+'ensures take v = Owned<'+ty+'>(p); v == '+op+';'
  qbound='0 <= old && old <= 4294967295 && ' if unsigned else ('-1073741824 <= old && old <= 1073741823 && ' if double else 'old < 2147483647 && ')
  qvalue='(old+1) % 4294967296' if unsigned else ('2*old' if double else 'old+1')
  q='With old Require '+qbound+'data_at(p,'+ty+',old) Ensure data_at(p,'+ty+','+qvalue+')'
  body='{ '+ty+' n = *p; '+ty+' m = '+('n+n' if double else 'n+1')+'; *p = m; }'
  nocn='requires true; ensures true;';noq='Require emp Ensure emp'
  postcn='requires take old = Owned<'+ty+'>(p); '+bound+'ensures true;'
  postq='With old Require '+qbound+'data_at(p,'+ty+',old) Ensure emp'
  return [(sig,cn,q,body,'Correct initialized update; broken source repaired explicitly',{'initial':5,'expected':10 if double else 6}),
   (sig,cn.replace('v == '+op,'v == old'),q.replace('Ensure data_at(p,'+ty+','+qvalue+')','Ensure data_at(p,'+ty+',old)'),body,'Incorrect claim that contents are preserved',{'initial':5,'actual':10 if double else 6,'claimed':5}),
   (sig,nocn,noq,body,'Read/write permission omitted',{'pointer':'NULL','actual':'invalid access'}),
   (sig,postcn,postq,body,'Updated cell ownership omitted at exit',{'initial':5,'actual':'cell remains','claimed':'empty heap'}),
   (sig,cn,q,'{ *p = *p + 2; }','Wrong update expression',{'initial':5,'actual':7,'expected':10 if double else 6}),
   (sig,cn,q,'{ }','Missing update',{'initial':5,'actual':5,'expected':10 if double else 6}),
   (sig,cn,q,'{ *p = 0; }','Overwrites computed value with zero',{'initial':5,'actual':0,'expected':10 if double else 6})]
 unsigned=not '.signed.' in source;quad='quadruple' in source;k=4 if quad else 2
 name='quadruple' if quad else ('example_let' if unsigned else 'doubled');ty='unsigned int' if unsigned else 'int';ct='u32' if unsigned else 'i32'
 sig=ty+' '+name+'('+ty+' n)'
 body='{ '+ty+' m = n+n; return m+m; }' if quad else '{ '+ty+' a = n+1; '+ty+' b = n-1; return a+b; }'
 lo=-536870912 if quad else -1073741824;hi=536870911 if quad else 1073741823
 pre='true' if unsigned else str(lo)+'i32 <= n; n <= '+str(hi)+'i32'
 qpre='0 <= n && n <= 4294967295' if unsigned else str(lo)+' <= n && n <= '+str(hi)
 cn='requires '+pre+'; ensures return == '+str(k)+ct+' * n;'
 val='('+str(k)+'*n) % 4294967296' if unsigned else str(k)+'*n'
 q='Require '+qpre+' && emp Ensure __return == '+val+' && emp'
 # Three distinct invalid result claims; each has a concrete non-overflow witness.
 specs=[('n','n','Incorrect identity result',{'n':2,'actual':k*2,'claimed':2}),('0'+ct,'0','Incorrect constant result',{'n':2,'actual':k*2,'claimed':0}),('('+str(k)+ct+' * n) + 1'+ct,val+'+1','Off-by-one postcondition',{'n':2,'actual':k*2,'claimed':k*2+1})]
 vs=[(sig,cn,q,body,'Correct modular/scaled arithmetic',{'n':2,'expected':k*2})]
 for c,v,note,wit in specs:vs.append((sig,'requires '+pre+'; ensures return == '+c+';','Require '+qpre+' && emp Ensure __return == '+v+' && emp',body,note,wit))
 for impl,value,note in [('{ return n; }',2,'Missing scaling'),('{ return 0; }',0,'Constant replaces computation'),('{ return n+n+n; }',6,'Wrong multiplication factor')]:vs.append((sig,cn,q,impl,note,{'n':2,'actual':value,'expected':k*2}))
 return vs
