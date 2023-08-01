DECLARE @start DATE = '2018-01-01'
DECLARE @end Date = '2100-01-01'

WHILE @start <= @end
BEGIN

    INSERT INTO [dbo].[Date_dim]
        (
        [date_key], [full_date], [month], [year], [month_num], [week_num], [week_day], [week_day_num])
    SELECT DATEPART(yy, @start)*10000+DATEPART(mm, @start)*100+DATEPART(dd, @start) as [date_key],
    @start as [full_date],
    SUBSTRING(DATENAME(mm, @start), 1, 3) as [month],
    DATEPART(yy, @start) as [year],
    DATEPART(mm, @start) as [month_num],
    DATEPART(ww, @start) as [week_num],
    DATEPART(dw, @start) as [week_day],
    DATEPART(dw, @start) as [week_day_num]
    SET @start = DATEADD(dd, 1, @start)
    
END
GO

