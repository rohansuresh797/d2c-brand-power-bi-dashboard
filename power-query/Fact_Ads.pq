let
    Source = Csv.Document(File.Contents("C:\Users\USER\Desktop\Project\Case Data\Additional Information\Ad_Campaign_Data.csv"),[Delimiter=",", Columns=6, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}}),
    #"Removed Top Rows" = Table.Skip(#"Changed Type",3),
    #"Promoted Headers" = Table.PromoteHeaders(#"Removed Top Rows", [PromoteAllScalars=true]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Promoted Headers",{{"Medium", type text}, {"Ad_Descriptor", type text}, {"CPC", type number}, {"Impression", Int64.Type}, {"Clicks", Int64.Type}, {"Add_to_Cart", Int64.Type}}),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Changed Type1", "Ad_Descriptor", Splitter.SplitTextByDelimiter("_", QuoteStyle.Csv), {"Ad_Descriptor.1", "Ad_Descriptor.2", "Ad_Descriptor.3", "Ad_Descriptor.4"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Ad_Descriptor.1", type text}, {"Ad_Descriptor.2", type text}, {"Ad_Descriptor.3", type text}, {"Ad_Descriptor.4", type date}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type2",{{"Ad_Descriptor.1", "Ad_Channel"}, {"Ad_Descriptor.2", "Category"}, {"Ad_Descriptor.3", "Campaign"}, {"Ad_Descriptor.4", "Month_Text"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "Ad_Spend", each [CPC] * [Clicks]),
    #"Changed Type3" = Table.TransformColumnTypes(#"Added Custom",{{"Ad_Spend", type number}}),
    #"Renamed Columns1" = Table.RenameColumns(#"Changed Type3",{{"Month_Text", "Month_Start"}})
in
    #"Renamed Columns1"
