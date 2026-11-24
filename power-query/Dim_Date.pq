let
    Source = List.Dates(#date(2025,1,1), 212, #duration(1,0,0,0)),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Date"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    #"Inserted Year" = Table.AddColumn(#"Changed Type", "Year", each Date.Year([Date]), Int64.Type),
    #"Inserted Month" = Table.AddColumn(#"Inserted Year", "Month", each Date.Month([Date]), Int64.Type),
    #"Inserted Month Name" = Table.AddColumn(#"Inserted Month", "Month Name", each Date.MonthName([Date]), type text),
    #"Inserted Week of Year" = Table.AddColumn(#"Inserted Month Name", "Week of Year", each Date.WeekOfYear([Date]), Int64.Type),
    #"Inserted Quarter" = Table.AddColumn(#"Inserted Week of Year", "Quarter", each Date.QuarterOfYear([Date]), Int64.Type),
    #"Inserted Day Name" = Table.AddColumn(#"Inserted Quarter", "Day Name", each Date.DayOfWeekName([Date]), type text),
    #"Reordered Columns" = Table.ReorderColumns(#"Inserted Day Name",{"Date", "Year", "Month", "Month Name", "Week of Year", "Day Name", "Quarter"})
in
    #"Reordered Columns"
