select substr(inlist, instr(inlist, ',', 1, level) + 1,
       instr(inlist, ',', 1, level + 1) - instr(inlist, ',', 1, level) - 1) as value_str
  from (select ',' || 'ab,cd,efg' || ',' as inlist from dual)
connect by level <= length('ab,cd,efg') - length(replace('ab,cd,efg', ',', '')) + 1;

select regexp_substr('ab,cd,efg,hi', '[^,]+', 1, level) as value_str
  from dual
connect by level <= length('ab,cd,efg.hi') - length(replace('ab,cd,efg.hi', ',', '')) + 1;