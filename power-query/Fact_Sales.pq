let
    Source = Table.Combine({D2C, DCart, Nile}),
    #"Inserted Year" = Table.AddColumn(Source, "Year", each Date.Year([Sales_Date]), Int64.Type),
    #"Inserted Month" = Table.AddColumn(#"Inserted Year", "Month", each Date.Month([Sales_Date]), Int64.Type),
    #"Inserted Week of Year" = Table.AddColumn(#"Inserted Month", "Week of Year", each Date.WeekOfYear([Sales_Date]), Int64.Type),
    #"Added Custom" = Table.AddColumn(#"Inserted Week of Year", "Duration_Days", each [Delivery_Date]-[Sales_Date]),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Custom",{{"Duration_Days", Int64.Type}}),
    #"Added Custom1" = Table.AddColumn(#"Changed Type", "Channel_Key", each [Channel] & "|" & [Sub_Channel] & "|" & [Delivery_Type]),
    #"Merged Queries" = Table.NestedJoin(#"Added Custom1", {"SKU_Code"}, Dim_CostRates, {"SKU_Code"}, "Dim_CostRates", JoinKind.LeftOuter),
    #"Added Custom2" = Table.AddColumn(#"Merged Queries", "Matched_Agreement", each Table.SelectRows([Dim_CostRates], (r) => [Sales_Date] >= r[Start_Date] and [Sales_Date] <= r[End_Date])),
    #"Expanded Matched_Agreement" = Table.ExpandTableColumn(#"Added Custom2", "Matched_Agreement", {"Agreement Code", "Start_Date", "End_Date", "Unit_Cost"}, {"Agreement Code", "Start_Date", "End_Date", "Unit_Cost"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded Matched_Agreement",{"Dim_CostRates"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Removed Columns",{{"Unit_Cost", type number}, {"Start_Date", type date}, {"End_Date", type date}})
in
    #"Changed Type1"
