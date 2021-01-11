SELECT DISTINCT 
ISNULL(d.ClientValue, 'No Client') AS Client,
e.COUNT_Type1 AS "Count Type 1",
f.COUNT_Type2 AS "Count Type 2",
g.COUNT_Type3 AS "Count Type 3",
h.COUNT_Type4 AS "Count Type 4",
i.COUNT_Type5 AS "Count Type 5",
j.COUNT_Type6 AS "Count Type 6"

FROM vw_InfoClients d

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_Type1
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
GROUP BY a.Client
) e ON ISNULL(d.ClientValue, 'No Client') = e.Client 

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_Type2
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
GROUP BY a.Client
) f ON ISNULL(d.ClientValue, 'No Client') = f.Client

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_Type3
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
GROUP BY a.Client
) g ON ISNULL(d.ClientValue, 'No Client') = g.Client

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_Type4
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
GROUP BY a.Client
) h ON ISNULL(d.ClientValue, 'No Client') = h.Client

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_Type5
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
GROUP BY a.Client
) i ON ISNULL(d.ClientValue, 'No Client') = i.Client

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_Type6
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
GROUP BY a.Client
) j ON ISNULL(d.ClientValue, 'No Client') = j.Client

WHERE COUNT_Type1 is not null 
OR COUNT_Type2 is not null
OR COUNT_Type3 is not null
OR COUNT_Type4 is not null
OR COUNT_Type5 is not null
OR COUNT_Type6 is not null
ORDER BY Client ASC;
