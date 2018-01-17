Set pagesize 0;
set linesize 8000;
set feedBack off;
set heading off;
set HEADS off;
set echo off;
set VERIFY OFF;
spool "d:\\export.sql";
select 
'
select ZhuanYeBianMa as 专业编码, XueKeBianMa as 学科编码, XueKeMingCheng as 学科名称, ShiJuanMingCheng as 试卷名称,
       ShiJuanBianMa as 试卷编码, ShiJuanShiTiXuHao as 试卷试题序号, ShiTiBianMa as 试题编码, NanDuBianMa as 难度编码, NanDuMingCheng as 难度名称, ZhiShiDianBianMa as 知识点编码,
       ZhiShiDianMingCheng as 知识点名称, KaoShiYaoQiuBianMa as 考试要求编码, KaoShiYaoQiuMingCheng as 考试要求名称, TiXingBianMa as 题型编码, TiXingMingCheng as 题型名称
  from (
    select p.parentcode as ZhuanYeBianMa, p.subjectcode as XueKeBianMa, p.subjectname as XueKeMingCheng, p.name as ShiJuanMingCheng, p.papercode as ShiJuanBianMa,
           row_number() over(Partition By p.paperid order by instr(p.papercontent, pq.paperquestionid, 1, 1)) as ShiJuanShiTiXuHao, q.questioncode as ShiTiBianMa,
           q.Difficultycode as NanDuBianMa, Q.Difficultyname as NanDuMingCheng, q.knowledgecode as ZhiShiDianBianMa, q.knowledgecontent as ZhiShiDianMingCheng, q.abilitycode as KaoShiYaoQiuBianMa,
           q.abilityname as KaoShiYaoQiuMingCheng, q.sectioncode as TiXingBianMa, q.sectionname as TiXingMingCheng, pq.sectioncode, pq.createtime
      from ibm_paper p
     inner join ibm_paperquestion pq on p.paperid = pq.paperid
     inner join ibm_formalquestion q on pq.formalquestionid = q.formalquestionid
     where p.subjectcode = ''' || ibm_major.majorcode || '''
  )
 order by ZhuanYeBianMa, XueKeBianMa, ShiJuanMingCheng, ShiJuanBianMa, ShiJuanShiTiXuHao' || ';' || '-' || '-'
|| '第' || to_char(rownum) || '条数据：' || ibm_major.majorname || 
(case when mod(rownum, 10) = 0 then '
' || '
' || '
' || '
' || '
' || '
' || '
' || '
' || '
' || '' else '' end) as text
from ibm_major
where majorcode in (select subjectcode from ibm_paper where status > 1);
spool off;