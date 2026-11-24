let
    Source = Excel.Workbook(File.Contents("C:\Users\USER\Desktop\Project\Case Data\Additional Information\Performance Marketing Ad Spends Budget.xlsx"), null, true),
    Sheet2_Sheet = Source{[Item="Sheet2",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet2_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Category Wise Advertising Spends Budget", type text}, {"Column2", type any}, {"Column3", type any}, {"Column4", type any}, {"Column5", type any}, {"Column6", type any}, {"Column7", type any}, {"Column8", type any}, {"Column9", type any}}),
    #"Removed Top Rows" = Table.Skip(#"Changed Type",1),
    #"Promoted Headers1" = Table.PromoteHeaders(#"Removed Top Rows", [PromoteAllScalars=true]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Promoted Headers1",{{"Category", type text}, {"2025-01", type number}, {"2025-02", type number}, {"2025-03", type number}, {"2025-04", type number}, {"2025-05", type number}, {"2025-06", type number}, {"2025-07", type number}, {"Grand Total", type number}}),
    #"Removed Bottom Rows" = Table.RemoveLastN(#"Changed Type1",3),
    #"Removed Columns" = Table.RemoveColumns(#"Removed Bottom Rows",{"Grand Total"}),
    #"Unpivoted Other Columns" = Table.UnpivotOtherColumns(#"Removed Columns", {"Category"}, "Attribute", "Value"),
    #"Renamed Columns" = Table.RenameColumns(#"Unpivoted Other Columns",{{"Attribute", "Month_Text"}, {"Value", "Budget"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "Month_Start", each Date.FromText([Month_Text] & "-01")),
    #"Changed Type2" = Table.TransformColumnTypes(#"Added Custom",{{"Month_Start", type date}})
in
    #"Changed Type2"
