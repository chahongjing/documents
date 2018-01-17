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
select ZhuanYeBianMa as רҵ����, XueKeBianMa as ѧ�Ʊ���, XueKeMingCheng as ѧ������, ShiJuanMingCheng as �Ծ�����,
       ShiJuanBianMa as �Ծ����, ShiJuanShiTiXuHao as �Ծ��������, ShiTiBianMa as �������, NanDuBianMa as �Ѷȱ���, NanDuMingCheng as �Ѷ�����, ZhiShiDianBianMa as ֪ʶ�����,
       ZhiShiDianMingCheng as ֪ʶ������, KaoShiYaoQiuBianMa as ����Ҫ�����, KaoShiYaoQiuMingCheng as ����Ҫ������, TiXingBianMa as ���ͱ���, TiXingMingCheng as ��������
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
|| '��' || to_char(rownum) || '�����ݣ�' || ibm_major.majorname || 
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