SELECT DISTINCT 
ISNULL(d.ClientValue, 'No Client Selected') AS Client,
e.COUNT_ReqRcvd,
f.COUNT_ReqClosed,
g.COUNT_Touched,
h.COUNT_DetailRcvd,
i.COUNT_DtlReqDue,
j.COUNT_DtlReqComplete

FROM vw_InfoClients d

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client Selected') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_ReqRcvd
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
WHERE a.ReqStatus <> 'Cancelled'
AND b.ReqDateReceived between 'yyyy-MM-dd' and 'yyyy-MM-dd'
GROUP BY a.Client
) e ON ISNULL(d.ClientValue, 'No Client Selected') = e.Client 

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client Selected') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_ReqClosed
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
WHERE a.ReqStatus <> 'Cancelled'
AND b.ReqClosedDate between 'yyyy-MM-dd' and 'yyyy-MM-dd'
GROUP BY a.Client
) f ON ISNULL(d.ClientValue, 'No Client Selected') = f.Client

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client Selected') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_Touched
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
WHERE a.ReqStatus <> 'Cancelled'
AND (b.ReqDateReceived between 'yyyy-MM-dd' and 'yyyy-MM-dd'
OR b.ReqClosedDate between 'yyyy-MM-dd' and 'yyyy-MM-dd'
OR b.ReqDateReceived between 'yyyy-MM-dd' and 'yyyy-MM-dd'
OR c.ReceivedDate between 'yyyy-MM-dd' and 'yyyy-MM-dd'
OR c.CompletedDate between 'yyyy-MM-dd' and 'yyyy-MM-dd')
GROUP BY a.Client
) g ON ISNULL(d.ClientValue, 'No Client Selected') = g.Client

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client Selected') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_DetailRcvd
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
WHERE a.ReqStatus <> 'Cancelled'
AND c.ReceivedDate between 'yyyy-MM-dd' and 'yyyy-MM-dd'
GROUP BY a.Client
) h ON ISNULL(d.ClientValue, 'No Client Selected') = h.Client

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client Selected') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_DtlReqDue
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
WHERE a.ReqStatus <> 'Cancelled'
AND c.DueDate between 'yyyy-MM-dd' and 'yyyy-MM-dd'
GROUP BY a.Client
) i ON ISNULL(d.ClientValue, 'No Client Selected') = i.Client

LEFT JOIN (
SELECT ISNULL(a.Client,'No Client Selected') AS Client, COUNT(DISTINCT a.REQID) AS COUNT_DtlReqComplete
FROM dbo.vw_ReqSearchResult a
LEFT JOIN dbo.vw_Requests b ON b.ReqID = a.REQID
LEFT JOIN dbo.vw_DetailReq c ON c.ReqID = a.REQID
WHERE a.ReqStatus <> 'Cancelled'
AND c.CompletedDate between 'yyyy-MM-dd' and 'yyyy-MM-dd'
GROUP BY a.Client
) j ON ISNULL(d.ClientValue, 'No Client Selected') = j.Client

WHERE COUNT_ReqRcvd is not null 
OR COUNT_ReqClosed is not null
OR COUNT_Touched is not null
OR COUNT_DetailRcvd is not null
OR COUNT_DtlReqDue is not null
OR COUNT_DtlReqComplete is not null
ORDER BY Client ASC;
