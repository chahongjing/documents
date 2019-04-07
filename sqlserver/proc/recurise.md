~~~ sql
WITH    myDepartments1
          AS ( SELECT   BUGUID ,
                        BUName ,
                        1 AS mylevel
               FROM     dbo.myBusinessUnit
               WHERE    BUName LIKE '%战略客户开发与支持部'
               UNION ALL
               SELECT   a.BUGUID ,
                        a.BUName ,
                        b.mylevel + 1
               FROM     dbo.myBusinessUnit AS a
                        INNER JOIN myDepartments1 AS b ON a.ParentGUID = b.BUGUID
             ),
        myDepartments2
          AS ( SELECT   BUGUID ,
                        BUName ,
                        100 AS mylevel
               FROM     dbo.myBusinessUnit
               WHERE    BUName LIKE '%项目开发部'
               UNION ALL
               SELECT   a.BUGUID ,
                        a.BUName ,
                        b.mylevel + 1
               FROM     dbo.myBusinessUnit AS a
                        INNER JOIN myDepartments2 AS b ON a.ParentGUID = b.BUGUID
             ),
        myDepartments3
          AS ( SELECT   BUGUID ,
                        BUName ,
                        200 AS mylevel
               FROM     dbo.myBusinessUnit
               WHERE    BUName LIKE '%武汉信息管理部'
               UNION ALL
               SELECT   a.BUGUID ,
                        a.BUName ,
                        b.mylevel + 1
               FROM     dbo.myBusinessUnit AS a
                        INNER JOIN myDepartments3 AS b ON a.ParentGUID = b.BUGUID
             )
    SELECT  *
    FROM    myDepartments1
    UNION ALL
    SELECT  *
    FROM    myDepartments2
    UNION ALL
    SELECT  *
    FROM    myDepartments3
    ORDER BY mylevel ,

            BUName ;
~~~