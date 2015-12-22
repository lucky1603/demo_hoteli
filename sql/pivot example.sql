SELECT *
FROM crosstab(
  'select rowid, attribute, value
   from ct
   where attribute = ''visina'' or attribute = ''tezina'' or attribute = ''godine'' or attribute = ''pol''
   order by 1')
AS ct(row_name text, visina text, tezina text, godine text, pol text);