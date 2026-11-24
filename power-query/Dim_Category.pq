let
    Source = Dim_Product,
    #"Removed Other Columns" = Table.SelectColumns(Source,{"Category"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns")
in
    #"Removed Duplicates"
